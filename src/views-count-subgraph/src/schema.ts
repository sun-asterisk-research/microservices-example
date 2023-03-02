export const typeDefs = `#graphql
  type Query {
    healthcheck: String!
  }

  type Mutation {
    # Increment view count of the story
    incrementStoryView(hashid: String!): StatusResponse
  }

  type StatusResponse {
    success: Boolean!
  }
`;
