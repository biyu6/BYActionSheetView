//
//  BYActionSheetCell.m
//  MyTestProject
//
//  Created by 胡忠诚 on 2018/6/5.
//  Copyright © 2018年 biyu6. All rights reserved.
//自定义actionSheet的cell

#import "BYActionSheetCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface BYActionSheetCell()
/**title*/
@property (nonatomic, strong)UILabel *titleLabel;

@end
@implementation BYActionSheetCell
#pragma mark- init初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.backgroundColor = [UIColor blackColor];
    self.contentView.backgroundColor = self.backgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSheetCellSubView];
    return self;
}
- (void)addSheetCellSubView {
    //title
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 20)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    
    //下划线
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    _lineView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_lineView];
}

#pragma mark- 数据处理
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}


@end
