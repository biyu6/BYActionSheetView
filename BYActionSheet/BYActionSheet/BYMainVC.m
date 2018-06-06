//
//  BYMainVC.m
//  BYActionSheet
//
//  Created by 胡忠诚 on 2018/6/6.
//  Copyright © 2018年 biyu6. All rights reserved.
//自定义actionSheetView

#import "BYMainVC.h"
#import "BYActionSheetView.h"//自定义actionSheetView

@interface BYMainVC ()

@end
@implementation BYMainVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
- (void)clickBtn{
    BYActionSheetView *alertView = [[BYActionSheetView alloc]initWithPopoverView];
    [alertView showWithSheetTitleArr:@[@[@"拍照",@"相册",@"男",@"女"],@[@"取消"]] action:^(NSIndexPath *indexPath) {
        NSLog(@"点击了：%zd====%zd",indexPath.section,indexPath.row);
    }];
}


@end
