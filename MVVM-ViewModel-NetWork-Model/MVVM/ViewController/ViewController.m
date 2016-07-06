//
//  ViewController.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/6/17.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "ViewController.h"
#import "TestViewModel.h"
#import "XCTableviewCellTest.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet TestViewModel *viewModel;
#pragma clang diagnostic pop

@property (nonatomic,strong)NSArray* models;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    [self.viewModel.testCommand execute:nil];
    [RACObserve(self.viewModel, tests) subscribeNext:^(NSArray* x) {
        @strongify(self)
        self.models = x;
        [self.tableview reloadData];
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate / datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"cell";
    XCTableviewCellTest* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    [cell bindModel:self.models[indexPath.row]];
    return cell;
}


@end
