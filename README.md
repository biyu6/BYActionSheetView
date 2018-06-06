# 解决问题

#### 1.仿照系统做一个简单的自定义ActionSheet
### 主要代码如下：
```
BYActionSheetView *alertView = [[BYActionSheetView alloc]initWithPopoverView];
    [alertView showWithSheetTitleArr:@[@[@"拍照",@"相册",@"男",@"女"],@[@"取消"]] action:^(NSIndexPath *indexPath) {
        NSLog(@"点击了：%zd====%zd",indexPath.section,indexPath.row);
    }];
```


![image](https://github.com/biyu6/BYActionSheetView/blob/master/actionSheetImg.png)
