import { ServerContext } from ".";
import { client } from "./grpc"
import { IncrementStoryViewRequest, StatusResponse  } from "../proto/views_count_pb";

export const resolvers = {
  Query: {
    healthcheck: () => 'OK',
  },

  Mutation: {
    incrementStoryView: (_, { hashid }, { fingerprint }: ServerContext) => {
      console.log({ countKey: `increment/story/${hashid}/${fingerprint}` })

      const request = new IncrementStoryViewRequest();
      request.setHashid(hashid)
      request.setFingerprint(fingerprint)

      const something =  new Promise<StatusResponse>((resolve, reject) => {
        client.incrementStoryView(request,  (err, success) => {
          if (success) {
            resolve(success)
          } else reject(err)
        })
      });

      return {
        success: something.then(value => value.getSuccess())
      }
    },
  },
};
