// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('grpc');
var views_count_pb = require('./views_count_pb.js');

function serialize_views_count_IncrementStoryViewRequest(arg) {
  if (!(arg instanceof views_count_pb.IncrementStoryViewRequest)) {
    throw new Error('Expected argument of type views_count.IncrementStoryViewRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_views_count_IncrementStoryViewRequest(buffer_arg) {
  return views_count_pb.IncrementStoryViewRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_views_count_StatusResponse(arg) {
  if (!(arg instanceof views_count_pb.StatusResponse)) {
    throw new Error('Expected argument of type views_count.StatusResponse');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_views_count_StatusResponse(buffer_arg) {
  return views_count_pb.StatusResponse.deserializeBinary(new Uint8Array(buffer_arg));
}


var ViewsCountService = exports.ViewsCountService = {
  incrementStoryView: {
    path: '/views_count.ViewsCount/IncrementStoryView',
    requestStream: false,
    responseStream: false,
    requestType: views_count_pb.IncrementStoryViewRequest,
    responseType: views_count_pb.StatusResponse,
    requestSerialize: serialize_views_count_IncrementStoryViewRequest,
    requestDeserialize: deserialize_views_count_IncrementStoryViewRequest,
    responseSerialize: serialize_views_count_StatusResponse,
    responseDeserialize: deserialize_views_count_StatusResponse,
  },
};

exports.ViewsCountClient = grpc.makeGenericClientConstructor(ViewsCountService);
