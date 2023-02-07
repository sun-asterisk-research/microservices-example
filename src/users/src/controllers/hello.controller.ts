import { FastifyReply, FastifyRequest } from "fastify";

export const sayHello = async (_: FastifyRequest, reply: FastifyReply) => {
  reply.status(200).send({
    message: 'Hello world!',
  })
}
