import { ViewsCountClient } from "../proto/views_count_grpc_pb"
import { credentials } from "grpc"

const port = 50052;

export const client = new ViewsCountClient(
  `views-count-service:${port}`,
  credentials.createInsecure()
)

export const noop = () => {};
