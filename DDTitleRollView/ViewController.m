//
//  ViewController.m
//  DDTitleRollView
//
//  Created by DD on 2018/9/13.
//  Copyright © 2018年 DD. All rights reserved.
//

#import "ViewController.h"
#import "HomeTitleRollView.h"

@interface ViewController ()
@property (nonatomic, strong) HomeTitleRollView *rollView;
@end

@implementation ViewController
- (HomeTitleRollView *)rollView{

    if (!_rollView) {
        HomeTitleRollView *rollView =[[HomeTitleRollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 30) withTitle:@[@"1.我报备客户数",@"2.下线报备客户数",@"3.我邀请经纪人数",@"4.已成交客户数",@"5.下线已成交数",@"6.下线邀请经纪人数"]];
        rollView.titleFont = PX_OR_PT(14);
        __weak HomeTitleRollView *roll = rollView;
        rollView.handlerTitleClickCallBack = ^(NSInteger index){

            NSLog(@"%@----%zd",roll.titleArr[index-1],index);
        };
        _rollView = rollView;
    }
    return _rollView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.rollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
