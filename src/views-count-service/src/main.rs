use tonic::{transport::Server, Request, Response, Status};
use redis::{Commands, RedisError};
use views_count::views_count_server::{ViewsCount, ViewsCountServer};
use views_count::{IncrementStoryViewRequest, StatusResponse};
// use error::FromRedisError;
use opentelemetry::{sdk::{trace::{self, RandomIdGenerator, Sampler}, Resource}, global, KeyValue};
use tracing_subscriber::prelude::*;
use tracing_opentelemetry;

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
    ) -> Result<Response<StatusResponse>, Status> {
        println!("Got a request from {:?}", request.remote_addr());
        let body = request.into_inner();

        let mut conn = store::connect();

        let exists: Result<bool, RedisError> = conn.exists(format!("{}/{}", body.hashid, body.fingerprint));

        match exists {
            Ok(exists) => {
                if exists {
                    println!("Key '{}' exists in Redis.", format!("{}/{}", body.hashid, body.fingerprint));
                    return Ok(Response::new(StatusResponse{ success: false }));
                } else {
                    println!("Key '{}' does not exist in Redis.", format!("{}/{}", body.hashid, body.fingerprint));
                }
            }
            Err(err) => {
                eprintln!("Error checking key existence: {}", err);
            }
        }

        let a: Result<String, RedisError> = conn.set_ex(
            format!("{}/{}", body.hashid, body.fingerprint),
            "value",
            60
        );

        match a {
            Ok(_) => {
                Ok(Response::new(StatusResponse{ success: true }))
            }
            Err(_) => {
                Ok(Response::new(StatusResponse{ success: false }))
            }
        }
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    global::set_text_map_propagator(opentelemetry_jaeger::Propagator::new());
    let tracer = opentelemetry_jaeger::new_collector_pipeline()
        .with_endpoint("http://localhost:14268/api/traces")
        .with_service_name("views_count_service")
        .with_instrumentation_library_tags(false)
        .with_trace_config(
            trace::config()
                .with_sampler(Sampler::AlwaysOn)
                .with_id_generator(RandomIdGenerator::default())
                .with_max_events_per_span(64)
                .with_max_attributes_per_span(16)
                .with_max_events_per_span(16)
                // resources will translated to tags in jaeger spans
                .with_resource(Resource::new(vec![KeyValue::new("key", "value"),
                          KeyValue::new("process_key", "process_value")])),
        )
        .with_isahc()
        .install_batch(opentelemetry::runtime::Tokio)?;
    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::new("INFO"))
        .with(tracing_opentelemetry::layer().with_tracer(tracer))
        .try_init()?;

    let addr = "0.0.0.0:50052".parse().unwrap();
    let svc = ViewsCountService::default();

    println!("ViewsCountServer listening on {}", addr);

    Server::builder()
        .add_service(ViewsCountServer::new(svc))
        .serve(addr)
        .await?;

    opentelemetry::global::shutdown_tracer_provider();

    Ok(())
}
