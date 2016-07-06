//
//  XCAPIManager+test.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCAPIManager+test.h"
#import "XCAPIManager+Analysis.h"
#import "TestModel.h"

@implementation XCAPIManager (test)

- (RACSignal *)test
{
    //此处使用的mac自带的模拟服务器
    return [[[[[self rac_GET:@"http://localhost/a.json" parameters:@{}] map:^id(id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]){
            return [RACSignal return:value];
        }
        return [self rac_MappingForClass:[TestModel class] array:value[@"topic_infos"]];
    }] logError] replayLazily];
}

@end
