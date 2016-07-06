//
//  TestModel.h
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCBaseModel.h"
#import "userinfoModel.h"

@interface TestModel : XCBaseModel

@property NSString* city;
@property userinfoModel *user_info;

@end
