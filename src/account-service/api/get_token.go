package api

import (
	"account/auth"
	"account/db"
	"account/pb"
	"context"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

// Register a new account
func (s *AccountService) GetToken(ctx context.Context, req *pb.GetTokenRequest) (*pb.GetTokenResponse, error) {
	var account db.Account

	res := s.db.First(&account, "username = ? or email = ?", req.Username, req.Username)
	if res.RowsAffected <= 0 {
		return nil, status.New(codes.InvalidArgument, "The credentials do not match our records").Err()
	}

	jwt, err := auth.NewJWT()
	if err != nil {
		s.log.Debugf("failed to init JWT: %s", err)
		return nil, status.New(codes.Unknown, "Auth server configuration error").Err()
	}

	accessToken, err := jwt.IssueToken(&account)
	if err != nil {
		s.log.Debugf("failed to issue token: %s", err)
		return nil, status.New(codes.Unknown, "Can not issue the access token").Err()
	}

	return &pb.GetTokenResponse{
		Success:     true,
		AccessToken: accessToken,
	}, nil
}
