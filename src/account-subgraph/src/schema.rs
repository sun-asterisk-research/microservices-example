use async_graphql::{Object, Schema, EmptySubscription, Result, Context};
use hyper::header::SET_COOKIE;
use tonic::transport::Channel;

use crate::{account::{account_client::AccountClient, SignUpResponse, SignUpRequest, GetTokenRequest, GetTokenResponse}, error::GraphQLError};

pub struct QueryRoot;
pub struct Mutation;

pub type AccountSchema = Schema<QueryRoot, Mutation, EmptySubscription>;

#[Object]
impl QueryRoot {
    async fn say_hello(&self, name: String) -> String {
        format!("Hello {}", name)
    }
}

#[Object]
impl Mutation {
    async fn sign_up(&self, ctx: &Context<'_>, input: SignUpRequest) -> Result<SignUpResponse> {
        let mut account_svc = ctx.data::<AccountClient<Channel>>().unwrap().clone();
        let request = tonic::Request::new(input);

        account_svc.sign_up(request).await
            .map(|r| r.into_inner())
            .map_err(|s| s.to_graphql_error())
    }

    async fn get_token(&self, ctx: &Context<'_>, input: GetTokenRequest) -> Result<GetTokenResponse> {
        let mut account_svc = ctx.data::<AccountClient<Channel>>().unwrap().clone();
        let request = tonic::Request::new(input);

        account_svc.get_token(request).await
            .map(|r| {
                let data = r.into_inner();
                ctx.append_http_header(SET_COOKIE, format!("hasura_auth={}; Domain=.blog.local; Path=/; HttpOnly", data.access_token));
                return data;
            })
            .map_err(|s| s.to_graphql_error())
    }
}
