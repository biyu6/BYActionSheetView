//
//  BYActionSheetView.m
//  MyTestProject
//
//  Created by 胡忠诚 on 2018/6/5.
//  Copyright © 2018年 biyu6. All rights reserved.
//自定义actionSheetView

#import "BYActionSheetView.h"
#import "BYActionSheetCell.h"

static NSString *kPopoverCellIdentifier = @"kPopoverCellIdentifier";
static float const kPopoverViewCellHeight = 50.f; //cell指定高度
static SheetActionIndex nowSheetSction = nil;//点击的传递

@interface BYActionSheetView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UIWindow *keyWindow; //当前窗口
@property (nonatomic, assign) CGFloat windowWidth; //窗口宽度
@property (nonatomic, assign) CGFloat windowHeight; //窗口高度
@property (nonatomic, strong) UIView *shadeView; //遮罩层
@property (nonatomic, weak) UITapGestureRecognizer *tapGesture; //点击遮罩层的手势
@property (nonatomic, strong) UITableView *tableView;
/**tableView的数据源数组*/
@property (nonatomic, strong)NSArray *dataArr;

@end
@implementation BYActionSheetView
#pragma mark - init初始化
- (instancetype)initWithPopoverView{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0,  0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}
- (void)initialize {
    //keyWindow
    _keyWindow = [UIApplication sharedApplication].keyWindow;
    _windowWidth = CGRectGetWidth(_keyWindow.bounds);
    _windowHeight = CGRectGetHeight(_keyWindow.bounds);
    
    //阴影View
    _shadeView = [[UIView alloc] initWithFrame:_keyWindow.bounds];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [_shadeView addGestureRecognizer:tapGesture];
    _tapGesture = tapGesture;
    
    // tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏下划线
//    [_tableView setSeparatorColor:[UIColor redColor]];//下划线颜色
    _tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableView];
    
    //默认值
    self.alertViewBGColor = [UIColor clearColor];//alertView的背景色
    self.shadeBGColor = [UIColor colorWithRed:68/255 green:68/255 blue:68/255 alpha:0.6];//遮罩层的颜色
}
#pragma mark - 设置属性
- (void)setShadeBGColor:(UIColor *)shadeBGColor{//遮罩层的颜色
    _shadeBGColor = shadeBGColor;
    _shadeView.backgroundColor = _shadeBGColor;
}
- (void)setAlertViewBGColor:(UIColor *)alertViewBGColor{//alertView的背景色
    _alertViewBGColor = alertViewBGColor;
    self.backgroundColor = _alertViewBGColor;
}
- (void)setIsClickShadeHide:(BOOL)isClickShadeHide{//点击遮罩层是否隐藏，默认隐藏
    _isClickShadeHide = isClickShadeHide;
    _tapGesture.enabled = _isClickShadeHide;
}

#pragma mark- 显示弹框
- (void)showWithSheetTitleArr:(NSArray *)titleArr action:(SheetActionIndex)choiceRow{
    nowSheetSction = choiceRow;
    _dataArr = titleArr;
    NSAssert(titleArr.count > 0, @"警告：至少需要有一个Action!");
    // 遮罩层
    _shadeView.alpha = 0.f;
    [_keyWindow addSubview:_shadeView];
    [_tableView reloadData];
    CGFloat currentH;
    currentH = _tableView.contentSize.height;
    //限制弹框的最大高度，超出屏幕允许滚动
    if (currentH > _windowHeight) {
        currentH = _windowHeight;
        _tableView.scrollEnabled = YES;
    }
    self.frame = CGRectMake(0, _windowHeight, _windowWidth, currentH);
    [_keyWindow addSubview:self];
    [UIView animateWithDuration:0.25f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{//弹出弹框
        CGFloat botH = 0;
        if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {//iPhone X
            botH = 34;
        }
        self.frame = CGRectMake(0, self.windowHeight - currentH - botH, self.windowWidth, currentH);
        self.shadeView.alpha = 1.f;
    } completion:nil];
}

#pragma mark- 隐藏弹框
- (void)hide {
    [UIView animateWithDuration:0.25f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.f;
        self.shadeView.alpha = 0.f;
        self.frame = CGRectMake(0, self.windowHeight, self.windowWidth, self.tableView.contentSize.height);
    } completion:^(BOOL finished) {
        [self.shadeView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark- tableView的代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{//分两组：第一组是选项、第二组是取消
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kPopoverViewCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:kPopoverCellIdentifier];
    if (!cell) {
        cell = [[BYActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPopoverCellIdentifier];
    }
    //第一组，且不是最后一行,显示下划线
    cell.lineView.hidden = !(indexPath.section == 0 && (indexPath.row != ([_dataArr[0] count] - 1)));
    [cell setTitleStr:_dataArr[indexPath.section][indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0.f;
        self.shadeView.alpha = 0.f;
    } completion:^(BOOL finished) {
        if (nowSheetSction) {
            nowSheetSction(indexPath);
        }
        nowSheetSction = nil;
        [self.shadeView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


@end
