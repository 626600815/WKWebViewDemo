//
//  RootViewController.m
//  WKWebView
//
//  Created by mainone on 15/12/9.
//  Copyright © 2015年 wjn. All rights reserved.
//

#import "RootViewController.h"
#import <SafariServices/SafariServices.h>


@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (IBAction)safafi:(UIButton *)sender {
    
    if ([SFSafariViewController class]) {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        SFSafariViewController *safari = [[SFSafariViewController alloc]initWithURL:url];
        [self.navigationController presentViewController:safari animated:YES completion:nil];
    }else {
        NSLog(@"该升级系统啦,骚年!");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告框" message:@"该升级系统啦,骚年!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
