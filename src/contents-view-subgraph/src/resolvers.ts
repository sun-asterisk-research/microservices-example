import { markdown } from "./markdown";

export const resolvers = {
  Query: {
    contentsView: (_, { contents }) => {
      return markdown.render(contents);
    },
  },
};
