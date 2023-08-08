// package: views_count
// file: views_count.proto

/* tslint:disable */
/* eslint-disable */

import * as jspb from "google-protobuf";

export class IncrementStoryViewRequest extends jspb.Message { 
    getHashid(): string;
    setHashid(value: string): IncrementStoryViewRequest;

    getFingerprint(): string;
    setFingerprint(value: string): IncrementStoryViewRequest;


    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): IncrementStoryViewRequest.AsObject;
    static toObject(includeInstance: boolean, msg: IncrementStoryViewRequest): IncrementStoryViewRequest.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: IncrementStoryViewRequest, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): IncrementStoryViewRequest;
    static deserializeBinaryFromReader(message: IncrementStoryViewRequest, reader: jspb.BinaryReader): IncrementStoryViewRequest;
}

export namespace IncrementStoryViewRequest {
    export type AsObject = {
        hashid: string,
        fingerprint: string,
    }
}

export class Empty extends jspb.Message { 

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): Empty.AsObject;
    static toObject(includeInstance: boolean, msg: Empty): Empty.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: Empty, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): Empty;
    static deserializeBinaryFromReader(message: Empty, reader: jspb.BinaryReader): Empty;
}

export namespace Empty {
    export type AsObject = {
    }
}

export class StatusResponse extends jspb.Message { 
    getSuccess(): boolean;
    setSuccess(value: boolean): StatusResponse;


    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): StatusResponse.AsObject;
    static toObject(includeInstance: boolean, msg: StatusResponse): StatusResponse.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: StatusResponse, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): StatusResponse;
    static deserializeBinaryFromReader(message: StatusResponse, reader: jspb.BinaryReader): StatusResponse;
}

export namespace StatusResponse {
    export type AsObject = {
        success: boolean,
    }
}
