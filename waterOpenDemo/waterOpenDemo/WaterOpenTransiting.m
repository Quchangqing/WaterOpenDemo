//
//  WaterOpenTransiting.m
//  waterOpenDemo
//
//  Created by Changqing Qu on 2018/8/6.
//  Copyright © 2018 SteFan. All rights reserved.
//

#import "WaterOpenTransiting.h"

@implementation WaterOpenTransiting

- (instancetype )initWithType:(WaterType)type
{
    if (self == [super init]) {
        _type = type;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_type == TypePresent) {
        [self presentAnimation:transitionContext];
    }else{
        [self dismissAnimation:transitionContext];
    }
    
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * toView = nil;
    UIView * fromView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromVc.view;
        toView = toVc.view;
    }
    
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    NSNumber * num = [fromVc valueForKey:@"coverRect"];
    CGRect coverRect = [num CGRectValue];
    coverRect.origin.y += 20;
    NSLog(@"%@",NSStringFromCGRect(coverRect));
    UIBezierPath * startPath = [UIBezierPath bezierPathWithRoundedRect:coverRect cornerRadius:20];
    
    //取出在x和y方向上 坐标距离屏幕边缘的最大值
    //    CGFloat x = MAX(coverRect.origin.x, containerView.bounds.size.width - coverRect.origin.x);
    //    CGFloat y = MAX(coverRect.origin.y, containerView.bounds.size.height - coverRect.origin.y);
    //
    //    //勾股定理开方
    //    CGFloat rabuit = sqrtf(pow(x, 2) + pow(y, 2));
    //
    //    UIBezierPath * endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:rabuit startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    UIBezierPath * endPath = [UIBezierPath bezierPathWithRoundedRect:toView.frame cornerRadius:coverRect.size.width];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = endPath.CGPath;
    toVc.view.layer.mask = layer;
    
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    scaleAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    scaleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    scaleAnimation.duration = 0.35;
    scaleAnimation.removedOnCompletion = YES;
    scaleAnimation.delegate = self;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [scaleAnimation setValue:transitionContext forKey:@"transitionContext"];
    [layer addAnimation:scaleAnimation forKey:@"path"];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * toView = nil;
    UIView * fromView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromVc.view;
        toView = toVc.view;
    }
    UIView * containerView = [transitionContext containerView];
    //toView需不需要加入到containerView要根据动画效果而定，如果需要显示后面toView，设置self.modalPresentationStyle = UIModalPresentationCustom;
//    [containerView addSubview:toView];
    
    NSNumber * num = [toVc valueForKey:@"coverRect"];
    CGRect coverRect = num.CGRectValue;
    
    UIBezierPath * startPath = [UIBezierPath bezierPathWithRoundedRect:containerView.frame cornerRadius:coverRect.size.width];
    UIBezierPath * endPath = [UIBezierPath bezierPathWithRoundedRect:coverRect cornerRadius:20];
    
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.path = endPath.CGPath;
    fromVc.view.layer.mask = shapLayer;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    animation.duration = 0.35f;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [shapLayer addAnimation:animation forKey:@"path"];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35f;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    switch (_type) {
        case TypePresent:
        {
            id<UIViewControllerContextTransitioning> transitionContent = [anim valueForKey:@"transitionContext"];
            [transitionContent completeTransition:YES];
            [transitionContent viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
        }
            break;
        case TypeDismiss:
        {
            id<UIViewControllerContextTransitioning> transitionContent = [anim valueForKey:@"transitionContext"];
            [transitionContent completeTransition:YES];
            [transitionContent viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            
            
//            [transitionContent completeTransition:![transitionContent transitionWasCancelled]];
//            if ([transitionContent transitionWasCancelled]) {
//                [transitionContent viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
//        }
            break;
    }
    
    }
}

@end
