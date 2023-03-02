use redis::RedisError;
use tonic::{Status, Code};

pub trait FromRedisError {
    fn to_grpc_status(&self) -> Status;
}

impl FromRedisError for RedisError {
    fn to_grpc_status(&self) -> Status {
        Status::new(Code::Unknown, "Redis error")
    }
}
