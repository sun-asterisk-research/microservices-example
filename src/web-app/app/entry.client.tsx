import { RemixBrowser } from '@remix-run/react';
import { hydrate } from 'react-dom';
import { ApolloClient, InMemoryCache, ApolloProvider, createHttpLink } from '@apollo/client';
import { ClientProvider } from '@mantine/remix';

function Client() {
  const link = createHttpLink({
    uri: window.__ENV__.GRAPHQL_API_HOST,
    credentials: 'include',
  });

  const client = new ApolloClient({
    link,
    cache: new InMemoryCache({
      typePolicies: {
        Stories: {
          keyFields: ['hashid']
        },
        Accounts: {
          keyFields: ['username']
        },
      }
    })
      .restore(window.__APOLLO_STATE__),
  });

  return (
    <ApolloProvider client={client}>
      <ClientProvider>
        <RemixBrowser />
      </ClientProvider>
    </ApolloProvider>
  );
}

hydrate(<Client />, document);
