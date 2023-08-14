// package: views_count
// file: views_count.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "grpc";
import * as views_count_pb from "./views_count_pb";

interface IViewsCountService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    incrementStoryView: IViewsCountService_IIncrementStoryView;
}

interface IViewsCountService_IIncrementStoryView extends grpc.MethodDefinition<views_count_pb.IncrementStoryViewRequest, views_count_pb.StatusResponse> {
    path: "/views_count.ViewsCount/IncrementStoryView";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<views_count_pb.IncrementStoryViewRequest>;
    requestDeserialize: grpc.deserialize<views_count_pb.IncrementStoryViewRequest>;
    responseSerialize: grpc.serialize<views_count_pb.StatusResponse>;
    responseDeserialize: grpc.deserialize<views_count_pb.StatusResponse>;
}

export const ViewsCountService: IViewsCountService;

export interface IViewsCountServer {
    incrementStoryView: grpc.handleUnaryCall<views_count_pb.IncrementStoryViewRequest, views_count_pb.StatusResponse>;
}

export interface IViewsCountClient {
    incrementStoryView(request: views_count_pb.IncrementStoryViewRequest, callback: (error: grpc.ServiceError | null, response: views_count_pb.StatusResponse) => void): grpc.ClientUnaryCall;
    incrementStoryView(request: views_count_pb.IncrementStoryViewRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: views_count_pb.StatusResponse) => void): grpc.ClientUnaryCall;
    incrementStoryView(request: views_count_pb.IncrementStoryViewRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: views_count_pb.StatusResponse) => void): grpc.ClientUnaryCall;
}

export class ViewsCountClient extends grpc.Client implements IViewsCountClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: object);
    public incrementStoryView(request: views_count_pb.IncrementStoryViewRequest, callback: (error: grpc.ServiceError | null, response: views_count_pb.StatusResponse) => void): grpc.ClientUnaryCall;
    public incrementStoryView(request: views_count_pb.IncrementStoryViewRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: views_count_pb.StatusResponse) => void): grpc.ClientUnaryCall;
    public incrementStoryView(request: views_count_pb.IncrementStoryViewRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: views_count_pb.StatusResponse) => void): grpc.ClientUnaryCall;
}
