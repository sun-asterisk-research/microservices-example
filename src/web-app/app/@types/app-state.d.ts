export {};

declare global {
  interface EnvBag {
    GOOGLE_ANALYTICS_ID: string;
    GRAPHQL_API_HOST: string;
  }

  interface AuthUser {
    id: number;
    fullname: string;
    username: string;
    avatar?: string | null;
  }

  interface AppState {
    authUser: AuthUser | null;
    env: EnvBag;
    isAuthUser: boolean;
  }
}
