//
//  XCAPIManager.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCAPIManager.h"
#import <JSONModel/JSONModel.h>
#import <JSONModel-RACExtensions/RACJSONModel.h>
#import <AFNetworking-RACExtensions/RACAFNetworking.h>

@implementation XCAPIManager

- (AFHTTPRequestOperationManager *)manager
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/plain",@"application/json", nil];
    manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = kXCAPITimeout;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    manager.responseSerializer.acceptableStatusCodes = nil;
    manager.securityPolicy.allowInvalidCertificates = YES;
    return manager;
}

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters
{
    AFHTTPRequestOperationManager* manager = [self manager];
    return [[[manager rac_GET:path parameters:parameters] reduceEach:^id (NSDictionary* dictionary,NSHTTPURLResponse* response){
        return dictionary;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal return:error];
    }];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters
{
    AFHTTPRequestOperationManager* manager = [self manager];
    return [[[manager rac_POST:path parameters:parameters] reduceEach:^id (NSDictionary* dictionary,NSHTTPURLResponse* response){
        return dictionary;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal return:error];
    }];
}

@end

@implementation XCAPIManager(Restful)

- (RACSignal *)rac_MappingForClass:(Class)class dictionary:(NSDictionary *)dictionary
{
    return [class parseSignalForDictionary:dictionary];
}

- (RACSignal *)rac_MappingForClass:(Class)class array:(NSArray *)array
{
    return [class parseSignalForArray:array];
}

@end


