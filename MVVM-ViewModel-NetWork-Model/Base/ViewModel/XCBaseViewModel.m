//
//  XCBaseViewModel.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCBaseViewModel.h"

@implementation XCBaseViewModel

- (id)init
{
    if((self = [super init])) {
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            //            XPLog(@"%@ is active", x);
        }];
        [self.didBecomeInactiveSignal subscribeNext:^(id x) {
            //            XPLog(@"%@ is inactive", x);
        }];
        self.apiManager = [[XCAPIManager alloc] init];
    }
    
    return self;
}

@synthesize didBecomeActiveSignal = _didBecomeActiveSignal;
@synthesize didBecomeInactiveSignal = _didBecomeInactiveSignal;

- (void)setActive:(BOOL)active
{
    if(active == _active) {
        return;
    }
    
    [self willChangeValueForKey:@keypath(self.active)];
    _active = active;
    [self didChangeValueForKey:@keypath(self.active)];
}

- (RACSignal *)didBecomeActiveSignal
{
    if(_didBecomeActiveSignal == nil) {
        @weakify(self);
        
        _didBecomeActiveSignal = [[[RACObserve(self, active)
                                    filter:^(NSNumber *active) {
                                        return active.boolValue;
                                    }]
                                   map:^(id _) {
                                       @strongify(self);
                                       return self;
                                   }]
                                  setNameWithFormat:@"%@ -didBecomeActiveSignal", self];
    }
    
    return _didBecomeActiveSignal;
}

- (RACSignal *)didBecomeInactiveSignal
{
    if(_didBecomeInactiveSignal == nil) {
        @weakify(self);
        
        _didBecomeInactiveSignal = [[[RACObserve(self, active)
                                      filter:^BOOL (NSNumber *active) {
                                          return !active.boolValue;
                                      }]
                                     map:^(id _) {
                                         @strongify(self);
                                         return self;
                                     }]
                                    setNameWithFormat:@"%@ -didBecomeInactiveSignal", self];
    }
    
    return _didBecomeInactiveSignal;
}

#pragma mark - Activation
- (RACSignal *)forwardSignalWhileActive:(RACSignal *)signal
{
    NSParameterAssert(signal != nil);
    
    RACSignal *activeSignal = RACObserve(self, active);
    
    return [[RACSignal
             createSignal:^(id < RACSubscriber > subscriber) {
                 RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
                 
                 __block RACDisposable *signalDisposable = nil;
                 
                 RACDisposable *activeDisposable = [activeSignal subscribeNext:^(NSNumber *active) {
                     if(active.boolValue) {
                         signalDisposable = [signal subscribeNext:^(id value) {
                             [subscriber sendNext:value];
                         }
                                                            error:^(NSError *error) {
                                                                [subscriber sendError:error];
                                                            }];
                         if(signalDisposable != nil) {
                             [disposable addDisposable:signalDisposable];
                         }
                     } else {
                         [signalDisposable dispose];
                         [disposable removeDisposable:signalDisposable];
                         signalDisposable = nil;
                     }
                 }
                                                                         error:^(NSError *error) {
                                                                             [subscriber sendError:error];
                                                                         }
                                                                     completed:^{
                                                                         [subscriber sendCompleted];
                                                                     }];
                 if(activeDisposable != nil) {
                     [disposable addDisposable:activeDisposable];
                 }
                 
                 return disposable;
             }]
            setNameWithFormat:@"%@ -forwardSignalWhileActive: %@", self, signal];
}

- (RACSignal *)throttleSignalWhileInactive:(RACSignal *)signal
{
    NSParameterAssert(signal != nil);
    
    signal = [signal replayLast];
    
    return [[[[[RACObserve(self, active)
                takeUntil:[signal ignoreValues]]
               combineLatestWith:signal]
              throttle:1 valuesPassingTest:^BOOL (RACTuple *xs) {
                  BOOL active = [xs.first boolValue];
                  return !active;
              }]
             reduceEach:^(NSNumber *active, id value) {
                 return value;
             }]
            setNameWithFormat:@"%@ -throttleSignalWhileInactive: %@", self, signal];
}

#pragma mark - NSKeyValueObserving
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    // We'll generate notifications for this property manually.
    if([key isEqual:@keypath(XCBaseViewModel.new, active)]) {
        return NO;
    }
    
    return [super automaticallyNotifiesObserversForKey:key];
}


@end
