package api

import (
	"account/pb"

	"github.com/sirupsen/logrus"
	healthpb "google.golang.org/grpc/health/grpc_health_v1"
	"gorm.io/gorm"
)

// AccountService implements account.proto.
type AccountService struct {
	pb.UnimplementedAccountServer
	healthpb.UnimplementedHealthServer
	db  *gorm.DB
	log *logrus.Logger
}

func InitAccountService(db *gorm.DB, log *logrus.Logger) *AccountService {
	return &AccountService{
		db:  db,
		log: log,
	}
}
