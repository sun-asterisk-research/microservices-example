import { markdown } from "./markdown";

export const resolvers = {
  Query: {
    contentsView: (_: any, { contents }: any) => {
      return markdown.render(contents);
    },
  },
};
