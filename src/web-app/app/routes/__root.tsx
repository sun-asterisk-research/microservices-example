import { Outlet, useCatch } from "@remix-run/react";
import { Group } from "@mantine/core";

import DefaultLayout from "~/components/layout/default";
import { PageNotFound } from "~/components/layout/error";

// never reloading the root
export const unstable_shouldReload = () => false;

export default function Root() {
  return (
    <DefaultLayout>
      <Outlet />
    </DefaultLayout>
  )
};

export function CatchBoundary() {
  const caught = useCatch();

  return (
    <Group position="center" sx={{minHeight: '100vh'}}>
      {caught.status === 404 && <PageNotFound />}
      {caught.status !== 404 && (
        <h1>
          {caught.status} {caught.statusText}
        </h1>
      )}
    </Group>
  );
};
