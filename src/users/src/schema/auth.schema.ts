import S from 'fluent-json-schema'

const LoginInputSchema = S.object()
  .prop('username', S.string().required())
  .prop('password', S.string().required())

export const LoginRequestSchema = {
  body: S.object()
    .prop('session_variables', S.object().required())
    .prop('input', S.object().prop('credentials', LoginInputSchema).required()),
  queryString: S.object(),
  params: S.object(),
  headers: S.object(),
}
