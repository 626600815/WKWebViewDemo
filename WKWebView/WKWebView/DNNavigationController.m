//
//  DNNavigationController.m
//  DNAppDemo
//
//  Created by mainone on 15/12/9.
//  Copyright © 2015年 wjn. All rights reserved.
//

#import "DNNavigationController.h"
#import "ViewController.h"

@interface DNNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) ViewController *newsVc;

@end

@implementation DNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
}

/**
 *  重写push方法
 *
 *  @param viewController 每一次push进来的子控件
 *  @param animated       是否动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 左上角的返回键
    // if不是第一个push进来的子控制器{
    if (self.childViewControllers.count >= 1) {
        // 左上角的返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0); // 这里微调返回键的位置
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        if ([viewController isKindOfClass:[ViewController class]]) {
            [backButton setTitle:@"后退" forState:UIControlStateNormal];
            backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, -40); // 这里微调返回键的位置
            UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
            UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:backButton];
            _newsVc = (ViewController *)viewController;
            _newsVc.navigationItem.leftBarButtonItem = backBtn;
//            [_newsVc.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: backBtn,closeBtn ,nil]];
            _newsVc.navigationItem.rightBarButtonItem = closeBtn;
        }
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    // super的push方法一定要写到最后面
    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view
    // 也就会调用viewController的viewDidLoad方法
    [super pushViewController:viewController animated:animated];
}

- (void)closeAction{
    [self popViewControllerAnimated:YES];
}

- (void)back{
//    [self popViewControllerAnimated:YES];// 这里不用写self.navigationController，因为它自己就是导航控制器
    if ([self.newsVc.webView canGoBack]) {
        if ([self.newsVc.webView canGoBack]) {
            [self.newsVc.webView goBack];
        }
    }else{
        [self popViewControllerAnimated:YES];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(nonnull UIGestureRecognizer *)gestureRecognizer{
    // 如果当前显示的是第一个子控制器,就应该禁止掉[返回手势]
    return self.childViewControllers.count > 1;
}

+ (void)setUpNavigationBarTheme{
    
    UINavigationBar *navcBar = [UINavigationBar appearance];
    //设置navigationController的title的字体颜色
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor colorWithRed:30 green:30 blue:30 alpha:1];
    att[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    [navcBar setTitleTextAttributes:att];
    //设置返回按钮颜色
    [navcBar setTintColor:[UIColor darkGrayColor]];//返回按钮颜色
}

//设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return [self.topViewController preferredStatusBarStyle];
}

- (BOOL)shouldAutorotate{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
