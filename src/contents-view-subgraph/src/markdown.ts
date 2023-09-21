import { createRenderer } from "viblo-sdk/markdown";

export const markdown = createRenderer({
  baseURL: "https://viblo.asia",
  katex: {
    maxSize: 500,
    maxExpand: 100,
    maxCharacter: 1000,
  },
  // TODO: Why need clipboard???
  clipboard: {
    successTextDelay: 2000,
    maxStringLengthShortcut: 300,
  },
});
