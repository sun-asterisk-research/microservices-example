import { IconBookmark, IconHeart, IconShare } from '@tabler/icons';
import {
  Card,
  Image,
  Text,
  ActionIcon,
  Badge,
  Group,
  Center,
  Avatar,
  createStyles,
  Title,
  Anchor,
} from '@mantine/core';
import { Link } from '@remix-run/react';

const useStyles = createStyles((theme) => ({
  card: {
    position: 'relative',
    backgroundColor: theme.colorScheme === 'dark' ? theme.colors.dark[7] : theme.white,
  },

  rating: {
    position: 'absolute',
    top: theme.spacing.xs,
    right: theme.spacing.xs + 2,
    pointerEvents: 'none',
  },

  title: {
    display: 'block',
    fontSize: '1.125rem',
    color: 'black',
    marginTop: theme.spacing.md,
    marginBottom: theme.spacing.xs / 2,
    [theme.fn.smallerThan('sm')]: {
      fontSize: '1.375rem',
      fontWeight: 500,
      marginBottom: theme.spacing.xs,
    }
  },

  action: {
    backgroundColor: theme.colorScheme === 'dark' ? theme.colors.dark[6] : theme.colors.gray[0],
    ...theme.fn.hover({
      backgroundColor: theme.colorScheme === 'dark' ? theme.colors.dark[5] : theme.colors.gray[1],
    }),
  },

  footer: {
    marginTop: theme.spacing.md,
  },
}));

interface ArticleCardProps {
  story: any;
  rating?: string;
}

export default function ArticleCard({
  className,
  story,
  rating,
  ...others
}: ArticleCardProps & Omit<React.ComponentPropsWithoutRef<'div'>, keyof ArticleCardProps>) {
  const { classes, cx, theme } = useStyles();

  const avatarURL = story.author?.avatar
    ? `https://images.viblo.asia/64/${story.author?.avatar}`
    : null

  return (
    <Card radius={0} className={cx(classes.card, className)} {...others}>
      <Card.Section>
        <Link to={`/p/${story.hashid}`} prefetch="intent">
          <Image src={story.previewImage || 'https://viblo.asia/og-facebook-3.png'} height={180} />
        </Link>
      </Card.Section>

      {
        rating && (
          <Badge className={classes.rating} variant="gradient" gradient={{ from: 'yellow', to: 'red' }}>
            {rating}
          </Badge>
        )
      }

      <Anchor component={Link} to={`/p/${story.hashid}`} prefetch="intent" underline={false}>
        <Title order={2} className={classes.title} weight="bold">
          {story.title}
        </Title>
      </Anchor>

      <Text size="sm" color="#292929" lineClamp={4}>
        {story.previewContent}
      </Text>

      <Group position="apart" className={classes.footer}>
        <Anchor component={Link} to={`/u/${story.author?.username}`} prefetch="intent" underline={false}>
          <Center>
            <Avatar src={avatarURL} size={24} radius="xl" mr="xs" />
            <Text size="sm" inline color={"black"}>
              {story.author?.fullname}
            </Text>
          </Center>
        </Anchor>

        <Group spacing={8} mr={0}>
          <ActionIcon className={classes.action}>
            <IconHeart size={16} color={theme.colors.red[6]} />
          </ActionIcon>
          <ActionIcon className={classes.action}>
            <IconBookmark size={16} color={theme.colors.yellow[7]} />
          </ActionIcon>
          <ActionIcon className={classes.action}>
            <IconShare size={16} />
          </ActionIcon>
        </Group>
      </Group>
    </Card>
  );
}
