import type { LoaderFunction, MetaFunction } from "@remix-run/cloudflare";

import { createEmotionCache, Global, MantineProvider } from "@mantine/core";
import { Outlet, useLoaderData } from "@remix-run/react";
import Document from "./components/document";
import { AppContext } from "./contexts/app";
import { useEffect, useState } from "react";
import { useAuthUserQuery } from "graphql/generated/schema";

createEmotionCache({ key: 'mantine' });

export const meta: MetaFunction = () => ({
  charset: "utf-8",
  viewport: "width=device-width,initial-scale=1",
  title: "Viblo CE",
  description: "Technology Articles Platform from Asia, filled with latest information on Programming Languages and Frameworks. Ruby on Rails / PHP / Swift / Unity / Java /.Net",
  keywords: "Programmer, Knowledge Share, Programming, Document Management",
});

export const loader: LoaderFunction = ({ request }) => {
  const env: EnvBag = {
    GOOGLE_ANALYTICS_ID,
    GRAPHQL_API_HOST,
  };

  const cookie = request.headers.get('cookie') || '';
  const isAuthUser = /hasura_auth=.+/.test(cookie);
  const authUser = isAuthUser ? {} : null;

  return { authUser, env, isAuthUser };
};

// never reloading the root
// export const unstable_shouldReload = () => false;
export const shouldRevalidate = () => false;

export default function App() {
  const { authUser, env, isAuthUser } = useLoaderData();
  const [appState, setAppState] = useState<AppState>({ authUser, env, isAuthUser });

  if (isAuthUser) {
    // eslint-disable-next-line react-hooks/rules-of-hooks
    const { data } = useAuthUserQuery({
      context: {
        headers: {
          'x-hasura-role': 'author'
        }
      }
    });

    // eslint-disable-next-line react-hooks/rules-of-hooks
    useEffect(() => {
      if ((data?.accounts?.accounts.length || 0) > 0) {
        setAppState({
          env,
          authUser: data?.accounts?.accounts[0] as AuthUser,
          isAuthUser,
        })
      }
    }, [isAuthUser, env, data?.accounts?.accounts])
  }

  return (
    <AppContext.Provider value={appState}>
      <MantineProvider withCSSVariables>
        <AppGlobalStyles />
          <Document>
            <Outlet />

            <script
              async
              dangerouslySetInnerHTML={{
                __html: `window.__ENV__ = ${JSON.stringify(appState.env)}`,
              }}
            />

            {appState.env.GOOGLE_ANALYTICS_ID && (
              <>
                <script async src={`https://www.googletagmanager.com/gtag/js?id=${appState.env.GOOGLE_ANALYTICS_ID}`}></script>
                <script defer dangerouslySetInnerHTML={{
                  __html: `
                  window.dataLayer = window.dataLayer || [];
                  function gtag(){dataLayer.push(arguments);}
                  gtag('js', new Date());

                  gtag('config', '${appState.env.GOOGLE_ANALYTICS_ID}');`
                }} />
              </>
            )}
          </Document>
      </MantineProvider>
    </AppContext.Provider>
  );
};

const AppGlobalStyles = () => (
  <Global styles={{
    '::-webkit-scrollbar': {
      width: '20px',
    },
    '::-webkit-scrollbar-track': {
      backgroundColor: 'transparent',
    },
    '::-webkit-scrollbar-thumb': {
      backgroundColor: 'hsl(0,0%,43%)',
      borderRadius: '20px',
      border: '6px solid transparent',
      backgroundClip: 'content-box',
    },
    '::-webkit-scrollbar-thumb:hover': {
      backgroundColor: 'hsl(0,0%,60%)',
    },
    '*': {
      fontFamily: '-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica,Arial,sans-serif,Apple Color Emoji,Segoe UI Emoji',
    }
  }} />
);
