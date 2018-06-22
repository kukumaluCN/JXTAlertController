# JXTAlertController
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/kukumaluCN/JXTAlertController/blob/master/LICENSE)

基于UIAlertController的封装，利用链式语法，使得UIAlertController使用起来更简单。

## JXTAlertController(>=iOS8)

### 1.alert
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

### 2.添加textField
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
