import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { resolvers } from './resolvers';
import { typeDefs } from './schema';
import { tracingSdk } from './tracing';

// Start tracing sdk
tracingSdk.start()

export interface ServerContext {
  /** The hash code from User-Agent, Real-Client-IP, Location... */
  fingerprint: string;
}

const server = new ApolloServer<ServerContext>({
  typeDefs,
  resolvers,
});

export async function start() {
  const { url } = await startStandaloneServer(server, {
    listen: { port: 4000 },
    context: async ({ req }) => {
      return {
        fingerprint: String(req.headers['x-real-ip']) || 'anonymous',
      }
    }
  });

  console.log(`🚀  Server ready at: ${url}`);
}

start()
