import { Box, Flex, Title } from "@mantine/core";
import { SignInForm } from "~/components/forms/SignInForm";

export default function SignInPage() {
  return (
    <Flex align="center" direction="column">
      <Box p="lg" maw={600}>
        <Title size="h2" align="center" mb="xl">Sign In</Title>
        <SignInForm />
      </Box>
    </Flex>
  );
}
