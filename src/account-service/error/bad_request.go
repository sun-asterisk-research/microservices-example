package error

import (
	"google.golang.org/genproto/googleapis/rpc/errdetails"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func BadRequest(fields []*errdetails.BadRequest_FieldViolation) error {
	err := status.New(codes.InvalidArgument, "There were some problems with your input")
	err, _ = err.WithDetails(&errdetails.BadRequest{
		FieldViolations: fields,
	})

	return err.Err()
}
