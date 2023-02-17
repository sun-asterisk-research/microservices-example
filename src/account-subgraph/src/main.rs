use async_graphql::{
    http::{playground_source, GraphQLPlaygroundConfig},
    EmptySubscription
};
use async_graphql_axum::{GraphQLRequest, GraphQLResponse};
use axum::{
    extract::{Extension},
    response::{Html, IntoResponse},
    routing::get,
    Router, Server,
};
use schema::{QueryRoot, AccountSchema, Mutation};
use std::env;

use crate::account::account_client::AccountClient;

mod schema;
mod account;
mod error;

async fn graphql_playground() -> impl IntoResponse {
    Html(playground_source(
        GraphQLPlaygroundConfig::new("/"),
    ))
}

async fn graphql_handler(
    Extension(schema): Extension<AccountSchema>,
    req: GraphQLRequest,
) -> GraphQLResponse {
    schema.execute(req.into_inner()).await.into()
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("Starting GraphQL server...");

    let account_host = &env::var("ACCOUNT_SERVICE_HOST").unwrap_or("http://account-service:50051".to_owned());
    let client = AccountClient::connect(account_host.to_string()).await?;
    let schema = AccountSchema::build(QueryRoot, Mutation, EmptySubscription)
        .data(client)
        .finish();

    let app = Router::new()
        .route("/", get(graphql_playground).post(graphql_handler))
        .layer(Extension(schema));

    println!("Playground: http://localhost:8000");

    Server::bind(&"0.0.0.0:8000".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();

    Ok(())
}
