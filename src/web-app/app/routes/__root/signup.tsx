import { Box, Flex, Title } from "@mantine/core";
import { SignUpForm } from "~/components/forms/SignUpForm";

export default function SignUpPage() {
  return (
    <Flex align="center" direction="column">
      <Box p="lg" maw={600}>
        <Title size="h2" align="center" mb="xl">Create Account</Title>
        <SignUpForm />
      </Box>
    </Flex>
  );
}
