import type { SignUpRequest} from 'graphql/generated/schema';
import type { CSSProperties } from 'react';
import { useSignUpMutation } from 'graphql/generated/schema';
import { useForm } from '@mantine/form';
import { IconLock, IconAt, IconAlertCircle } from '@tabler/icons-react';
import {
  TextInput,
  PasswordInput,
  Group,
  Checkbox,
  Button,
  Paper,
  Text,
  LoadingOverlay,
  Anchor,
  useMantineTheme,
  Alert,
} from '@mantine/core';
import { faker } from '@faker-js/faker';
import { Link } from '@remix-run/react';

export interface SignUpFormProps {
  noShadow?: boolean;
  noPadding?: boolean;
  style?: CSSProperties;
}

export function SignUpForm({
  noShadow,
  noPadding,
  style,
}: SignUpFormProps) {
  const [signUp, { data, loading, error }] = useSignUpMutation();
  const theme = useMantineTheme();
  const form = useForm<SignUpRequest>({
    initialValues: {
      fullname: faker.name.fullName(),
      username: faker.internet.userName(),
      email: faker.internet.email(),
      password: '12345678',
      confirmPassword: '12345678',
      termsOfService: true,
    },
    validate: (values) => ({
      name: !values.fullname
        ? 'Name is required'
        : values.fullname.length < 5
        ? 'Too short fullname'
        : values.fullname.length > 255
        ? 'Too long fullname'
        : null,
      username: !values.username
        ? 'Age is required'
        : values.username.length >= 30
        ? 'Your username must be less than 30'
        : null,
      password: !values.password
        ? 'Password is required'
        : null,
      confirmPassword: !values.confirmPassword
        ? 'Password Confirmation is required'
        : values.password !== values.confirmPassword
        ? 'Password Confirmation does not match'
        : null,
      termsOfService: !values.termsOfService
        ? 'You must accept our Terms of Service'
        : null,
    }),
  });

  return (
    <Paper
      p={noPadding ? 0 : 'lg'}
      shadow={noShadow ? undefined : 'sm'}
      style={style}
      sx={{
        position: 'relative',
        backgroundColor: theme.colorScheme === 'dark' ? theme.colors.dark[7] : theme.white,
      }}
    >
      <form onSubmit={form.onSubmit((input) => signUp({ variables: {input}}))}>
        <LoadingOverlay visible={loading} />

        <TextInput
          required
          placeholder="Your email"
          label="Email"
          icon={<IconAt size={16} stroke={1.5} />}
          {...form.getInputProps('email')}
        />

        <Group grow mt="md">
          <TextInput
            data-autofocus
            required
            placeholder="Your full name"
            label="Full name"
            {...form.getInputProps('fullname')}
          />

          <TextInput
            required
            placeholder="Username"
            label="Username"
            {...form.getInputProps('username')}
          />
        </Group>

        <PasswordInput
          mt="md"
          required
          placeholder="Password"
          label="Password"
          icon={<IconLock size={16} stroke={1.5} />}
          {...form.getInputProps('password')}
        />

        <PasswordInput
          mt="md"
          required
          label="Confirm Password"
          placeholder="Confirm password"
          icon={<IconLock size={16} stroke={1.5} />}
          {...form.getInputProps('confirmPassword')}
        />

        <Checkbox
          mt="xl"
          label="I agree to sell my soul and privacy to this corporation"
          {...form.getInputProps('termsOfService', { type: 'checkbox' })}
        />

        {error && (
          <Text color="red" size="sm" mt="sm">
            {error}
          </Text>
        )}

        {!data?.account_service?.signUp.success && (
          <Group position="apart" mt="xl">
            <Anchor
              component={Link}
              type="button"
              color="dimmed"
              size="sm"
              to="/signin"
              prefetch="intent"
            >
              Have an account? Login
            </Anchor>

            <Button color="blue" type="submit">
              Register
            </Button>
          </Group>
        )}

        {!data?.account_service?.signUp.success && (
          <Group position="apart" mt="xl">
            <Alert
              mt="xl"
              icon={<IconAlertCircle size="1rem" />}
              title="Registration successfully!"
              color="green"
            >
              Now you can sign in to the website with your account: <strong>{form.values.username}</strong>
            </Alert>
          </Group>
        )}
      </form>
    </Paper>
  );
}
