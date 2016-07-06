//
//  XCBaseViewModel.h
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCAPIManager.h"

#define XPViewModelShortHand(viewModel) \
[viewModel.errors subscribeNext:^(id x) { \
@strongify(self);                          \
self.error = x;                            \
}];                                            \
[viewModel.executing subscribeNext:^(id x) { \
@strongify(self);                                     \
self.executing = x;                                   \
}];

@class RACSignal;

NS_ASSUME_NONNULL_BEGIN

@interface XCBaseViewModel : NSObject

@property (nonatomic,strong) XCAPIManager* apiManager;
@property (nonatomic, strong, nullable) NSError *error; /**< 错误 */
@property (nonatomic, assign, nullable) NSNumber *executing; /**< 是否正在执行 */
@property (nonatomic, assign, getter = isActive) BOOL active; /**< 是否view model正在活动 */
@property (nonatomic, strong, readonly, nonnull) RACSignal *didBecomeActiveSignal; /**< 观察active属性，如果active被改变为YES则会触发 */
@property (nonatomic, strong, readonly, nonnull) RACSignal *didBecomeInactiveSignal; /**< 观察active属性，如果active被改变为NO则会触发 */
- (nonnull RACSignal *)forwardSignalWhileActive:(nonnull RACSignal *)signal;
- (nonnull RACSignal *)throttleSignalWhileInactive:(nonnull RACSignal *)signal;

@end

NS_ASSUME_NONNULL_END