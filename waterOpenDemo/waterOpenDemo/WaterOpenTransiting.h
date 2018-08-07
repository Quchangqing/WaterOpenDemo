//
//  WaterOpenTransiting.h
//  waterOpenDemo
//
//  Created by Changqing Qu on 2018/8/6.
//  Copyright © 2018 SteFan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TypePresent,
    TypeDismiss,
} WaterType;

@interface WaterOpenTransiting : NSObject <UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property (nonatomic,assign) WaterType type;
- (instancetype )initWithType:(WaterType)type;
@end
