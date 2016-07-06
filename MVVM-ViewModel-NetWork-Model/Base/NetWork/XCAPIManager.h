//
//  XCAPIManager.h
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCBaseModel.h"

static const NSUInteger kXCAPITimeout = 5;

typedef NS_ENUM(NSUInteger,XCAPIError){
    kXCAPIErrorUnKnow = 200, /**< 客户端请求成功>*/
    
    
};

@interface XCAPIManager : XCBaseModel

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters;

@end

@interface XCAPIManager (Restful)

- (RACSignal *)rac_MappingForClass:(Class)class dictionary:(NSDictionary *)dictionary;
- (RACSignal *)rac_MappingForClass:(Class)class array:(NSArray *)array;

@end
