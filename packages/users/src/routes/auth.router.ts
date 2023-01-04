import { FastifyInstance } from 'fastify'
import { LoginRequestSchema } from '#schema/auth.schema'
import * as controllers from '#controllers/auth.controller'

async function authRouter(fastify: FastifyInstance) {
  fastify.route({
    method: 'POST',
    url: '/login',
    schema: LoginRequestSchema,
    handler: controllers.login
  })
}

export default authRouter
