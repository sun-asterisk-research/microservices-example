use tonic::{transport::Server, Request, Response, Status};
use redis::{Commands, RedisError};
use views_count::views_count_server::{ViewsCount, ViewsCountServer};
use views_count::{IncrementStoryViewRequest, Empty};
use error::FromRedisError;

mod views_count;
mod store;
mod error;

#[derive(Default)]
pub struct ViewsCountService {}

#[tonic::async_trait]
impl ViewsCount for ViewsCountService {
    async fn increment_story_view(
        &self,
        request: Request<IncrementStoryViewRequest>,
    ) -> Result<Response<Empty>, Status> {
        println!("Got a request from {:?}", request.remote_addr());

        let mut conn = store::connect();
        let a: Result<i32, RedisError> = conn.set("key", "value");

        match a {
            Ok(_) => Ok(Response::new(Empty{})),
            Err(err) => {
                Err(err.to_grpc_status())
            }
        }
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "[::1]:50052".parse().unwrap();
    let svc = ViewsCountService::default();

    println!("ViewsCountServer listening on {}", addr);

    Server::builder()
        .add_service(ViewsCountServer::new(svc))
        .serve(addr)
        .await?;

    Ok(())
}
