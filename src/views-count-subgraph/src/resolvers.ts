import { ServerContext } from ".";

export const resolvers = {
  Query: {
    healthcheck: () => 'OK',
  },

  Mutation: {
    incrementStoryView: (_, { hashid }, { fingerprint }: ServerContext) => {
      console.log({ countKey: `increment/story/${hashid}/${fingerprint}` })
      return {
        success: true,
      }
    },
  },
};
