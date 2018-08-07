//
//  UIImage+clip.h
//  waterOpenDemo
//
//  Created by Changqing Qu on 2018/8/3.
//  Copyright © 2018 SteFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (clip)
- (UIImage *)drawCornerInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
@end
