import { Box } from "@mantine/core";
import { useParams } from "@remix-run/react";

export default function ProfilePage() {
  const params = useParams<{ user: string }>()

  return (
    <Box p="md">
      <h1>
        Profile page: {params.user}
      </h1>
    </Box>
  );
}
