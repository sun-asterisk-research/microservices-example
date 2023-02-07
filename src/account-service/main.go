package main

import (
	"fmt"
	"net"

	"account/api"
	"account/config"
	"account/db"
	"account/logger"
	"account/pb"

	grpc_validator "github.com/grpc-ecosystem/go-grpc-middleware/validator"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	healthpb "google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/reflection"
	"gorm.io/gorm"
)

var log *logrus.Logger
var DB *gorm.DB
var err error

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

	// see: https://github.com/grpc-ecosystem/go-grpc-middleware
	svc := api.InitAccountService(DB, log)
	server := grpc.NewServer(
		grpc.UnaryInterceptor(
			grpc_validator.UnaryServerInterceptor(),
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
