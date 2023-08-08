use std::env;
use redis::{Client, Connection};

pub fn connect() -> Connection {
    let host = env::var("REDIS_HOST").unwrap_or("redis:6379".to_owned());
    let password = env::var("REDIS_PASSWORD").unwrap_or_default();
    let redis_conn_url = format!("redis://:{}@{}", password, host);

    Client::open(redis_conn_url)
        .expect("Invalid connection URL")
        .get_connection()
        .expect("failed to connect to Redis")
}
