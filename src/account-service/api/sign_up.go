package api

import (
	"account/db"
	accountError "account/error"
	"account/pb"
	"account/validator"
	"context"
	"errors"
	"time"
)

// Register a new account
func (s *AccountService) SignUp(ctx context.Context, req *pb.SignUpRequest) (*pb.SignUpResponse, error) {
	if err := validator.ValidateSignUpRequest(req, s.db); err != nil {
		return nil, accountError.BadRequest(err)
	}

	res := s.db.Create(&db.Account{
		Username:        req.Username,
		Email:           req.Email,
		EmailVerifiedAt: time.Now(),
		Fullname:        req.Fullname,
		PasswordHash:    req.Password,
	})
	if res.RowsAffected == 0 {
		return &pb.SignUpResponse{Success: false}, errors.New("sorry, something went wrong")
	}

	return &pb.SignUpResponse{Success: true}, nil
}
