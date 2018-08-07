//
//  ViewController.m
//  waterOpenDemo
//
//  Created by Changqing Qu on 2018/8/3.
//  Copyright © 2018 SteFan. All rights reserved.
//

#import "ViewController.h"
#import "WaterOpenCell.h"
#import "WaterOpenTransiting.h"
#import "SecondViewController.h"
#define margin 10
#define endWidth 40
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic,assign) CGRect coverRect;
@property (nonatomic,strong) WaterOpenTransiting *openTransition;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView * tableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:NSClassFromString(@"WaterOpenCell") forCellReuseIdentifier:@"WaterOpenCell"];
    [self.view addSubview:tableView];
    
}

- (WaterOpenTransiting *)openTransition
{
    if (_openTransition == nil) {
        _openTransition = [[WaterOpenTransiting alloc]init];
    }
    return _openTransition;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaterOpenCell * cell = [[WaterOpenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WaterOpenCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaterOpenCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIBezierPath * startPath = [UIBezierPath bezierPathWithRoundedRect:cell.backImage.frame cornerRadius:cell.backImage.bounds.size.height / 2];
    UIBezierPath * endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((SCREEN_WIDTH/2 - endWidth/2), 120/2 - endWidth/2, endWidth, endWidth) cornerRadius:20];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = endPath.CGPath;
    cell.backImage.layer.mask = layer;
    
    //缩放动画
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    scaleAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    scaleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    scaleAnimation.beginTime = 0.f;
    scaleAnimation.duration = 0.35f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = YES;
    [layer addAnimation:scaleAnimation forKey:@"path"];
    
    
    [UIView animateWithDuration:1   //动画持续时间
                          delay:0.1 //动画延迟执行时间
         usingSpringWithDamping:0.1 //阻尼系数，通常是0～1区间，阻尼系数越大，减速越明显，设为1的话，没有弹簧效果
          initialSpringVelocity:1 //动画开始时的速度
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            CGPoint aniPosition = cell.backImage.layer.position;
                            aniPosition.y += 15;
                            cell.backImage.layer.position = aniPosition;
                            
                        } completion:^(BOOL finished) {
                            
                            //计算当前缩小区域相对于屏幕所在的位置
                            //当前缩小区域的坐标
                            CGFloat y = (120 - endWidth)/2 + 15;
                            CGFloat x = (SCREEN_WIDTH-endWidth)/2;
                            CGRect rect = CGRectMake(x, y, endWidth, endWidth);
                            CGRect coverRect = [cell.backImage convertRect:rect toView:self.view];
                            self.coverRect = coverRect;
                            NSLog(@"%@",NSStringFromCGRect(coverRect));
                            SecondViewController * vc = [[SecondViewController alloc]init];
                            [self presentViewController:vc animated:YES completion:nil];
                        }];
}


@end
