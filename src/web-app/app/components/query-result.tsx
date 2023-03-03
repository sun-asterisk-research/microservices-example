import type { ApolloError } from '@apollo/client';
import { Flex, LoadingOverlay } from '@mantine/core';
import { isEmpty } from 'lodash';

interface QueryResultProps {
  loading: boolean;
  error?: ApolloError | undefined;
  data: any;
  children: any;
};

/**
 * Query Results conditionally renders Apollo useQuery hooks states:
 * loading, error or its children when data is ready
 */
const QueryResult = ({ loading, error, data, children }: QueryResultProps) => {
  if (error) {
    return <p className="text-red2">ERROR: {error.message}</p>;
  }

  const isEmptyData = isEmpty(data);

  if (loading) {
    return (
      <Flex align="center" justify="center" mih="100vh" pos="relative">
        <LoadingOverlay overlayBlur={2} visible />
      </Flex>
    );
  }

  if (isEmptyData) {
    return <p>Nothing to show...</p>;
  }

  return children;
};

export default QueryResult;
