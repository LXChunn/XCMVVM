//
//  XCTableviewCellTest.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCTableviewCellTest.h"

@implementation XCTableviewCellTest

- (void)bindModel:(TestModel *)model
{
    self.data1.text = model.city;
    self.data2.text = model.user_info.user_name;
    self.data3.text = [NSString stringWithFormat:@"%@",model.user_info.user_code];
}

@end
