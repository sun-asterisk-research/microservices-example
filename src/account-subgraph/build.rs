fn main() {
    let proto_file = "./proto/account.proto";

    tonic_build::configure()
        .build_server(false)
        .out_dir("./src")
        .type_attribute("SignUpRequest", "#[derive(async_graphql::InputObject, serde::Deserialize, serde::Serialize)]")
        .type_attribute("SignUpResponse", "#[derive(async_graphql::SimpleObject, serde::Deserialize, serde::Serialize)]")
        .type_attribute("GetTokenRequest", "#[derive(async_graphql::InputObject, serde::Deserialize, serde::Serialize)]")
        .type_attribute("GetTokenResponse", "#[derive(async_graphql::SimpleObject, serde::Deserialize, serde::Serialize)]")
        .compile(&[proto_file], &["."])
        .unwrap_or_else(|e| panic!("protobuf compile error: {}", e));

    println!("cargo:rerun-if-changed={}", proto_file);
}
