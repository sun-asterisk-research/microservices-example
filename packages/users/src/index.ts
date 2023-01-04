import 'module-alias/register';

import authRouter from '#routes/auth.router'
import helloRouter from '#routes/hello.router'
import fastify from 'fastify'

const host = process.env.HOST || '0.0.0.0'
const port = Number(process.env.PORT || 8080)

const server = fastify()

server.register(helloRouter)
server.register(authRouter)

server.listen({ host, port }, (err, address) => {
  if (err) {
    console.error(err)
    process.exit(1)
  }
  console.log(`Server listening at ${address}`)
})
