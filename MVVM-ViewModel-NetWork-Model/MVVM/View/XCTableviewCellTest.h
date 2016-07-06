//
//  XCTableviewCellTest.h
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

@interface XCTableviewCellTest : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *data1;
@property (weak, nonatomic) IBOutlet UILabel *data2;
@property (weak, nonatomic) IBOutlet UILabel *data3;

- (void)bindModel:(TestModel *)model;

@end
