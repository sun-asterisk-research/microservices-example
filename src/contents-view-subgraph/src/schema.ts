export const typeDefs = `#graphql
  type Query {
    # Get contents in HTML format
    contentsView(id: Int!, type: String!, contents: String!): String
  }
`;
