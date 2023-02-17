use async_graphql::{Error, ErrorExtensions, value, Value};
use tonic::Status;
use tonic_richer_error::WithErrorDetails;

pub trait GraphQLError {
    // Convert gRPC status to JSON
    fn to_graphql_error(&self) -> Error;
}

impl GraphQLError for Status {
    fn to_graphql_error(&self) -> Error {
        let err = Error::new(self.message());
        let err_details = self.get_error_details();
        if let Some(bad_request) = err_details.bad_request {
            let field_violations: Vec<Value> = bad_request.field_violations.into_iter()
                .map(|f| value!({
                    "field": f.field,
                    "description": f.description,
                }))
                .collect();

            return err.extend_with(|_err, e| {
                e.set("code", "BAD_REQUEST");
                e.set("fieldViolations", field_violations);
            });
        }

        err
    }
}
