import { FastifyReply, FastifyRequest } from "fastify"
import { HasuraActionPayload } from 'hasura-node-types'

const ACTION_LOGIN = 'login'

interface LoginInput {
  credentials: {
    username: string
    password: string
  }
}

interface LoginOutput {
  accessToken: string
}

type LoginRequest = FastifyRequest<{
  Body: HasuraActionPayload<LoginInput, typeof ACTION_LOGIN>
}>

export const login = async (request: LoginRequest, _: FastifyReply): Promise<LoginOutput> => {
  const { username, password } = request.body.input.credentials

  return {
    accessToken: `${username}:${password}`,
  }
}
