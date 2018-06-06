//
//  BYActionSheetCell.h
//  MyTestProject
//
//  Created by 胡忠诚 on 2018/6/5.
//  Copyright © 2018年 biyu6. All rights reserved.
//自定义actionSheet的cell

#import <UIKit/UIKit.h>

@interface BYActionSheetCell : UITableViewCell
/**下划线*/
@property (nonatomic, strong)UIView *lineView;

//赋值操作
- (void)setTitleStr:(NSString *)titleStr;


@end
