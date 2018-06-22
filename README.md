# JXTAlertController

[![CocoaPods compatible](https://img.shields.io/cocoapods/v/JXTAlertController.svg?style=flat)](https://cocoapods.org/pods/JXTAlertController)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-green.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![License: MIT](https://img.shields.io/cocoapods/l/JXTAlertController.svg?style=flat)](http://opensource.org/licenses/MIT)


基于UIAlertController的封装，利用链式语法，使得UIAlertController使用起来更简单。

## JXTAlertController(>=iOS8)

### 1.安装
#### CocoaPods
- 1.在 Podfile 中添加 pod 'JXTAlertController'。  
- 2.执行 pod install 或 pod update。  
- 3.导入 \<JXTAlertController/JXTAlertController.h\>。  

**注意：**  
如果执行`pod search JXTAlertController`检索不到，考虑使用`pod search JXTAlertController --simple`命令，或者尝试更新本地库。


### 2.示例（更多用法详见demo）
#### 2.1.常规用法
在某一VC内：

```objective-c
[self jxt_showAlertWithTitle:@"title"
                     message:@"message"
           appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
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
}];
```

#### 2.2.支持添加textField

```objective-c
[self jxt_showAlertWithTitle:@"title"
                     message:@"message"
           appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
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
```
