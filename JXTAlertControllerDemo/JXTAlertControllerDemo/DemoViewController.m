//
//  DemoViewController.m
//  JXTAlertControllerDemo
//
//  Created by JXT on 2018/6/22.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import "DemoViewController.h"

#import "JXTAlertController.h"

static NSString *const kDemoListCellId = @"DemoListCellId";

@interface DemoViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation DemoViewController

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"JXTAlertManager";

    self.dataArray = @[
                       @"1.常规alertController-Alert",
                       @"2.常规alertController-ActionSheet",
                       @"3.无按钮alert-toast",
                       @"4.无按钮actionSheet-toast",
                       @"5.带输入框的alertController-Alert",
                       ];
    [self.view addSubview:self.tableView];
    
    
#warning - 一种全局改变alert按钮titleColor的方式
//    [[UIView appearance] setTintColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Lazy Load
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kDemoListCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDemoListCellId];
    }
    cell.backgroundColor = [self randomColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark alert使用示例
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self jxt_showAlertWithTitle:@"常规alertController-Alert" message:@"基于系统UIAlertController封装，按钮以链式语法模式快捷添加，可根据按钮index区分响应，可根据action区分响应，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDestructiveTitle(@"按钮1");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"cancel");
            }
            else if (buttonIndex == 1) {
                NSLog(@"按钮1");
            }
            NSLog(@"%@--%@", action.title, action);
        }];
    }
    else if (indexPath.row == 1)
    {
        [self jxt_showActionSheetWithTitle:@"常规alertController-ActionSheet" message:@"基于系统UIAlertController封装，按钮以链式语法模式快捷添加，可根据按钮index区分响应，可根据action区分响应，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDestructiveTitle(@"按钮1").
            addActionDefaultTitle(@"按钮2").
            addActionDefaultTitle(@"按钮3").
            addActionDestructiveTitle(@"按钮4");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"cancel"]) {
                NSLog(@"cancel");
            }
            else if ([action.title isEqualToString:@"按钮1"]) {
                NSLog(@"按钮1");
            }
            else if ([action.title isEqualToString:@"按钮2"]) {
                NSLog(@"按钮2");
            }
            else if ([action.title isEqualToString:@"按钮3"]) {
                NSLog(@"按钮3");
            }
            else if ([action.title isEqualToString:@"按钮4"]) {
                NSLog(@"按钮4");
            }
        }];
    }
    else if (indexPath.row == 2)
    {
        [self jxt_showAlertWithTitle:@"无按钮alert-toast" message:@"toast样式，可自定义展示延时时间，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 1;
            [alertMaker setAlertDidShown:^{
                [self logMsg:@"alertDidShown"];//不用担心循环引用
            }];
            alertMaker.alertDidDismiss = ^{
                [self logMsg:@"alertDidDismiss"];
            };
        } actionsBlock:NULL];
    }
    else if (indexPath.row == 3)
    {
        [self jxt_showActionSheetWithTitle:@"无按钮actionSheet-toast" message:@"toast样式，可自定义展示延时时间，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 1;
            //关闭动画效果
            [alertMaker alertAnimateDisabled];
            
            [alertMaker setAlertDidShown:^{
                NSLog(@"alertDidShown");
            }];
            alertMaker.alertDidDismiss = ^{
                NSLog(@"alertDidDismiss");
            };
        } actionsBlock:NULL];
    }
    else if (indexPath.row == 4)
    {
        [self jxt_showAlertWithTitle:@"带输入框的alertController-Alert" message:@"点击按钮，控制台打印对应输入框的内容" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionDestructiveTitle(@"获取输入框1").
            addActionDestructiveTitle(@"获取输入框2");
            
            [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"输入框1-请输入";
            }];
            [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"输入框2-请输入";
            }];
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                UITextField *textField = alertSelf.textFields.firstObject;
                [self logMsg:textField.text];//不用担心循环引用
            }
            else if (buttonIndex == 1) {
                UITextField *textField = alertSelf.textFields.lastObject;
                [self logMsg:textField.text];
            }
        }];
    }
}


#pragma mark - Other Methods
- (void)logMsg:(NSString *)msg
{
    NSLog(@"%@", msg);
}
- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:0.3f];
}

@end
