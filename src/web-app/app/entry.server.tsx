import type { EntryContext } from '@remix-run/cloudflare';
import { renderToString } from 'react-dom/server';
import { RemixServer } from '@remix-run/react';
import { injectStyles, createStylesServer } from '@mantine/remix';
import { ApolloClient, ApolloProvider, createHttpLink, InMemoryCache } from '@apollo/client';
import { getDataFromTree } from '@apollo/client/react/ssr';

const server = createStylesServer();

export default function handleRequest(
  request: Request,
  responseStatusCode: number,
  responseHeaders: Headers,
  remixContext: EntryContext
) {
  const link = createHttpLink({
    uri: 'http://hasura/v1/graphql',
    headers: {
      Cookie: request.headers.get('cookie') || '',
    },
  });
  const client = new ApolloClient({
    link,
    ssrMode: true,
    cache: new InMemoryCache(),
  });

  const App = (
    <ApolloProvider client={client}>
      <RemixServer context={remixContext} url={request.url} />
    </ApolloProvider>
  );

  return getDataFromTree(App).then(() => {
    // Extract the entirety of the Apollo Client cache's current state
    const initialState = client.extract();

    const markup = renderToString(
      <>
        {App}
        <script
          dangerouslySetInnerHTML={{
            __html: `window.__APOLLO_STATE__=${JSON.stringify(
              initialState
            ).replace(/</g, "\\u003c")}`, // The replace call escapes the < character to prevent cross-site scripting attacks that are possible via the presence of </script> in a string literal
          }}
        />
      </>
    );

    responseHeaders.set("Content-Type", "text/html");

    return new Response("<!DOCTYPE html>" + injectStyles(markup, server), {
      status: responseStatusCode,
      headers: responseHeaders,
    });
  });
}
