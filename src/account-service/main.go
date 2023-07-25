package main

import (
	"context"
	"fmt"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/exporters/jaeger"
	"go.opentelemetry.io/otel/propagation"
	"go.opentelemetry.io/otel/sdk/resource"
	tracesdk "go.opentelemetry.io/otel/sdk/trace"
	semconv "go.opentelemetry.io/otel/semconv/v1.12.0"
	"net"
	"time"

	"account/api"
	"account/config"
	"account/db"
	"account/logger"
	"account/pb"
	grpc_validator "github.com/grpc-ecosystem/go-grpc-middleware/validator"
	"github.com/sirupsen/logrus"
	"go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc"
	"google.golang.org/grpc"
	healthpb "google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/reflection"
	"gorm.io/gorm"
)

var (
	name    = "account-service"
	version = "1.0.0"
	log     *logrus.Logger
	DB      *gorm.DB
	err     error
)

func init() {
	config.ReadEnv()
	log = logger.Init()
	DB, err = db.Connect()
	if err != nil {
		log.Fatalf("failed connect to the database: %v", err)
	}
	log.Info("database connection successful")
}

func main() {
	lis, err := net.Listen("tcp", fmt.Sprintf("%s:%d", config.Values.Host, config.Values.Port))
	if err != nil {
		log.Errorf("failed to listen: %v", err)
	}

	if cfg := config.Tracing(); cfg.Enable {
		tp, err := newTracerProvider(name, "a-random-string", cfg.Jaeger.URL)
		if err != nil {
			log.Fatal(err)
		}
		defer func() {
			ctx, cancel := context.WithTimeout(context.Background(), time.Second*5)
			defer cancel()
			if err := tp.Shutdown(ctx); err != nil {
				log.Fatal(err)
			}
		}()
		otel.SetTracerProvider(tp)
		otel.SetTextMapPropagator(propagation.NewCompositeTextMapPropagator(propagation.TraceContext{}, propagation.Baggage{}))
	}

	// see: https://github.com/grpc-ecosystem/go-grpc-middleware
	svc := api.InitAccountService(DB, log)
	server := grpc.NewServer(
		grpc.ChainUnaryInterceptor(
			grpc_validator.UnaryServerInterceptor(),
			otelgrpc.UnaryServerInterceptor(),
		),
	)
	pb.RegisterAccountServer(server, svc)
	healthpb.RegisterHealthServer(server, svc)

	if config.Values.ReflectServer {
		// Register reflection service on gRPC server
		log.Infof("reflection is enabled")
		reflection.Register(server)
	}

	log.Printf("server listening at %v", lis.Addr())
	if err := server.Serve(lis); err != nil {
		log.Errorf("failed to serve: %v", err)
	}
}

func newTracerProvider(serviceName, serviceID, url string) (*tracesdk.TracerProvider, error) {
	// Create the Jaeger exporter
	exp, err := jaeger.New(jaeger.WithCollectorEndpoint(jaeger.WithEndpoint(url)))
	if err != nil {
		return nil, err
	}
	tp := tracesdk.NewTracerProvider(
		tracesdk.WithSampler(tracesdk.AlwaysSample()),
		tracesdk.WithBatcher(exp),
		tracesdk.WithResource(resource.NewWithAttributes(
			semconv.SchemaURL,
			semconv.ServiceNameKey.String(serviceName),
			semconv.ServiceVersionKey.String(version),
			semconv.ServiceInstanceIDKey.String(serviceID),
		)),
	)
	return tp, nil
}
