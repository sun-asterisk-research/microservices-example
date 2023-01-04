import { FastifyInstance } from 'fastify'
import * as controllers from '#controllers/hello.controller'

async function helloRouter(fastify: FastifyInstance) {
  fastify.route({
    method: 'GET',
    url: '/hello',
    handler: controllers.sayHello
  })
}

export default helloRouter
