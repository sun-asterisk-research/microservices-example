import type { CSSProperties } from "react";
import type { GetTokenRequest } from "graphql/generated/schema";
import { useSignInMutation } from "graphql/generated/schema";
import { useForm } from "@mantine/form";
import { IconLock, IconAt } from "@tabler/icons-react";
import {
  TextInput,
  PasswordInput,
  Group,
  Button,
  Paper,
  Text,
  LoadingOverlay,
  Anchor,
  useMantineTheme,
} from "@mantine/core";
import { Link } from "@remix-run/react";

export interface SignInProps {
  noShadow?: boolean;
  noPadding?: boolean;
  style?: CSSProperties;
}

export function SignInForm({
  noShadow,
  noPadding,
  style,
}: SignInProps) {
  const theme = useMantineTheme();
  const [signIn, { loading, error }] = useSignInMutation();
  const form = useForm<GetTokenRequest>({
    initialValues: {
      username: "kimyvgy",
      password: "secret",
    },
    validate: (values) => {
      return {
        username: !values.username ? "Username is required" : null,
        password: !values.password ? "Password is required" : null,
      };
    },
  });

  const onSubmit = form.onSubmit((input) => {
    signIn({ variables: { input } }).then(({ data }) => {
      if (data?.account_service?.getToken.success) {
        window.location.href = "/"
      }
    })
  })

  return (
    <Paper
      p={noPadding ? 0 : "lg"}
      shadow={noShadow ? undefined : "sm"}
      style={style}
      sx={{
        position: "relative",
        backgroundColor:
          theme.colorScheme === "dark" ? theme.colors.dark[7] : theme.white,
      }}
    >
      <form onSubmit={onSubmit}>
        <LoadingOverlay visible={loading} />

        <TextInput
          required
          placeholder="Your email / username"
          label="Username"
          icon={<IconAt size={16} stroke={1.5} />}
          {...form.getInputProps("username")}
        />

        <PasswordInput
          mt="md"
          required
          placeholder="Password"
          label="Password"
          icon={<IconLock size={16} stroke={1.5} />}
          {...form.getInputProps("password")}
        />

        {error && (
          <Text color="red" size="sm" mt="sm">
            {error.message}
          </Text>
        )}

        <Group position="apart" mt="xl">
          <Anchor
            component={Link}
            color="dimmed"
            size="sm"
            to="/signup"
            prefetch="intent"
          >
            Don't have an account? Register
          </Anchor>

          <Button
            color="blue"
            type="submit"
          >
            Login
          </Button>
        </Group>
      </form>
    </Paper>
  );
}
