/// <reference types="@remix-run/dev" />
/// <reference types="@remix-run/cloudflare/globals" />
/// <reference types="@cloudflare/workers-types" />

interface Window {
  __ENV__: any;
  __APOLLO_STATE__: any
}
