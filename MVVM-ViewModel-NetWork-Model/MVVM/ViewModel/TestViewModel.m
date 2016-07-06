//
//  TestViewModel.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "TestViewModel.h"
#import "XCAPIManager+test.h"

@interface TestViewModel ()

@property (nonatomic,strong,readwrite) RACCommand* testCommand;
@property (nonatomic,strong,readwrite) NSArray* tests;

@end

@implementation TestViewModel

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (RACCommand *)testCommand
{
    if (!_testCommand) {
        @weakify(self)
        _testCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [self.apiManager test];
        }];
        
        [[_testCommand.executionSignals concat] subscribeNext:^(NSArray* x) {
            @strongify(self)
            self.tests = x;
            NSLog(@"%@",x);
        }];
//        XPViewModelShortHand(_testCommand)
    }
    return _testCommand;
}

@end
