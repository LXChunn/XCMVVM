//
//  TestViewModel.h
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCBaseViewModel.h"

@interface TestViewModel : XCBaseViewModel

@property (nonatomic,strong,readonly) RACCommand* testCommand;
@property (nonatomic,strong,readonly) NSArray* tests;

@end
