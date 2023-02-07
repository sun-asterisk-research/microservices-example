package validator

import (
	"account/db"
	"account/pb"

	"google.golang.org/genproto/googleapis/rpc/errdetails"
	"gorm.io/gorm"
)

func ValidateSignUpRequest(req *pb.SignUpRequest, DB *gorm.DB) []*errdetails.BadRequest_FieldViolation {
	var fieldViolations []*errdetails.BadRequest_FieldViolation

	if !req.TermsOfService {
		fieldViolations = append(fieldViolations, &errdetails.BadRequest_FieldViolation{
			Field:       "TermsOfService",
			Description: "Please agree to our Terms of Service",
		})
	}

	if req.Password != req.ConfirmPassword {
		fieldViolations = append(fieldViolations, &errdetails.BadRequest_FieldViolation{
			Field:       "ConfirmPassword",
			Description: "The `password` confirmation does not match",
		})
	}

	res := DB.Find(&db.Account{}, "username = ?", req.Username)
	if res.RowsAffected > 0 {
		fieldViolations = append(fieldViolations, &errdetails.BadRequest_FieldViolation{
			Field:       "Username",
			Description: "The `username` has already been taken",
		})
	}

	res = DB.Find(&db.Account{}, "email = ?", req.Email)
	if res.RowsAffected > 0 {
		fieldViolations = append(fieldViolations, &errdetails.BadRequest_FieldViolation{
			Field:       "Email",
			Description: "The `email` has already been taken",
		})
	}

	return fieldViolations
}
