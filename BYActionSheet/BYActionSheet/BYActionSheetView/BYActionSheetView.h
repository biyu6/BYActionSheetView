//
//  BYActionSheetView.h
//  MyTestProject
//
//  Created by 胡忠诚 on 2018/6/5.
//  Copyright © 2018年 biyu6. All rights reserved.
//自定义actionSheetView

#import <UIKit/UIKit.h>

typedef void(^SheetActionIndex)(NSIndexPath *indexPath);
@interface BYActionSheetView : UIView
/**alertView的背景颜色，默认为透明*/
@property (nonatomic, assign)UIColor *alertViewBGColor;
/**遮罩层的颜色，默认半透明*/
@property (nonatomic, assign) UIColor *shadeBGColor;
/**点击遮罩层是否隐藏，默认隐藏*/
@property (nonatomic, assign)BOOL isClickShadeHide;

//添加弹框
- (instancetype)initWithPopoverView;
//显示弹框
- (void)showWithSheetTitleArr:(NSArray *)titleArr action:(SheetActionIndex)choiceRow;


@end
