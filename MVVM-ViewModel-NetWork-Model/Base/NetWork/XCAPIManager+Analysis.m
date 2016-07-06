//
//  XCAPIManager+Analysis.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCAPIManager+Analysis.h"

@implementation XCAPIManager (Analysis)

- (id)analysisRequest:(id)value
{
    if (![value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    
    NSInteger statusCode = [[(NSDictionary*)value objectForKey:@"status_code"] integerValue];
    if (kXCAPIErrorUnKnow == statusCode) {
        return value[@"data"];
    }
    
    return [NSError errorWithDomain:@"XCError" code:statusCode userInfo:@{NSLocalizedDescriptionKey:value[@"msg"]}];
}

@end
