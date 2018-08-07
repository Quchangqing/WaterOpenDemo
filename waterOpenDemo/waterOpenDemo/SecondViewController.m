//
//  SecondViewController.m
//  waterOpenDemo
//
//  Created by Changqing Qu on 2018/8/6.
//  Copyright © 2018 SteFan. All rights reserved.
//

#import "SecondViewController.h"
#import "WaterOpenTransiting.h"
@interface SecondViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation SecondViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"qiku.jpg"].CGImage);
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[WaterOpenTransiting alloc]initWithType:TypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[WaterOpenTransiting alloc]initWithType:TypeDismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
