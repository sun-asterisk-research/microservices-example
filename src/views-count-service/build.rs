use std::path::PathBuf;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let proto_file = "./proto/views_count.proto";
    let out_dir = PathBuf::from("./src");

    tonic_build::configure()
        .build_server(true)
        .build_client(false)
        .out_dir(out_dir.as_path())
        // .file_descriptor_set_path(out_dir.join("views_count_descriptor.bin"))
        .compile(&[proto_file], &["."])
        .unwrap_or_else(|e| panic!("protobuf compile error: {}", e));

    println!("cargo:rerun-if-changed={}", proto_file);

    Ok(())
}
