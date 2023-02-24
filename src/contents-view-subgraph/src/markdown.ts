import { createRenderer } from "viblo-sdk/markdown";

export const markdown = createRenderer({
  baseURL: 'https://viblo.asia',
  katex: {
    maxSize: 500,
    maxExpand: 100,
    maxCharacter: 1000,
  },
});
