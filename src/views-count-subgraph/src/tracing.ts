import dotenv from "dotenv"

import * as opentelemetry from "@opentelemetry/sdk-node";
import {
  getNodeAutoInstrumentations,
} from "@opentelemetry/auto-instrumentations-node";
import {
  OTLPTraceExporter,
} from "@opentelemetry/exporter-trace-otlp-proto";

dotenv.config()

export const tracingSdk = new opentelemetry.NodeSDK({
  traceExporter: new OTLPTraceExporter({
    // optional - default url is http://localhost:4318/v1/traces
    url: process.env.JAEGER_TRACING_URL,
    // optional - collection of custom headers to be sent with each request, empty by default
    headers: {},
  }),
  instrumentations: [getNodeAutoInstrumentations()],
});
