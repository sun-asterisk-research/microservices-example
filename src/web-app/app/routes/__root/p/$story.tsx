import { Box, createStyles, Paper, Title } from "@mantine/core";
import { useParams } from "@remix-run/react";
import { useIncrementStoryViewMutation, useStoryViewQuery } from "graphql/generated/schema";
import { useEffect } from "react";
import QueryResult from "~/components/query-result";

const useStyles = createStyles((theme) => ({
  card: {
    position: 'relative',
    cursor: 'pointer',
    overflow: 'hidden',
    transition: 'transform 150ms ease, box-shadow 100ms ease',
    padding: theme.spacing.xl,
    paddingLeft: `calc(${theme.spacing.xl} * 2)`,
  },
  article: {
    "code[class*=language-],\npre[class*=language-]": {
      color: "#24292e",
      fontFamily:
        '"SFMono-Regular", Consolas, "Liberation Mono", Menlo, Courier, monospace',
      direction: "ltr",
      textAlign: "left",
      whiteSpace: "pre",
      wordSpacing: "normal",
      wordBreak: "normal",
      lineHeight: 1.45,
      tabSize: 4,
      hyphens: "none"
    },
    "pre[class*=language-]::-moz-selection,\npre[class*=language-] ::-moz-selection,\ncode[class*=language-]::-moz-selection,\ncode[class*=language-] ::-moz-selection": {
      background: "#b3d4fc"
    },
    "pre[class*=language-]::selection,\npre[class*=language-] ::selection,\ncode[class*=language-]::selection,\ncode[class*=language-] ::selection": {
      background: "#b3d4fc"
    },
    "pre[class*=language-]": {
      padding: "1em",
      overflow: "auto",
      backgroundColor: "#f6f8fa",
      borderRadius: "3px"
    },
    ".token.delimiter, .token.entity, .token.url, .token.variable, .token.constant": {
      color: "#24292e"
    },
    ".token.atrule, .token.namespace, .token.operator, .token.keyword": {
      color: "#d73a49"
    },
    ".token.package, .token.number, .token.boolean, .token.symbol": {
      color: "#005cc5"
    },
    ".token.tag, .token.selector": { color: "#22863a" },
    ".token.function, .token.class-name, .token.attr-name": { color: "#6f42c1" },
    ".token.string, .token.attr-value, .token.property, .token.regex": {
      color: "#032f62"
    },
    ".token.comment, .token.prolog, .token.doctype, .token.cdata": {
      color: "#6a737d"
    },
    ".token.bold": { fontWeight: "bold" },
    ".token.italic": { fontStyle: "italic" },
    ".language-diff .token.inserted": {
      color: "#22863a",
      backgroundColor: "#f0fff4"
    },
    ".language-diff .token.deleted": {
      color: "#b31d28",
      backgroundColor: "#ffeef0"
    },
    ".language-diff .token.important": {
      color: "#e36209",
      backgroundColor: "#ffebda"
    }
  }
}));

export default function ViewStoryPage() {
  const params = useParams<{ story: string }>();
  const { classes } = useStyles();
  const queryResult = useStoryViewQuery({
    variables: {
      hashid: params.story as string,
    }
  });
  const [increment] = useIncrementStoryViewMutation({
    variables: {
      hashid: params.story as string,
    }
  });

  useEffect(() => {
    increment().then(({ data }) => {
      if (data?.views_count?.incrementStoryView?.success) {
        console.info('send request increment story view successfully!');
      }
    })
  }, []);

  return (
    <Box p="md">
      <QueryResult {...queryResult}>
        {queryResult.data?.stories?.stories.map((story: any, index: number) => (
          <Paper key={index} radius="md" className={classes.card}>
            <Title order={1}>{story.title}</Title>

            <div className={classes.article} dangerouslySetInnerHTML={{__html: story.contentsHTML}} />
          </Paper>
        ))}
      </QueryResult>
    </Box>
  );
}
