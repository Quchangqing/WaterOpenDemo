//
//  WaterOpenCell.h
//  waterOpenDemo
//
//  Created by Changqing Qu on 2018/8/3.
//  Copyright © 2018 SteFan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterOpenCell;
@interface WaterOpenCell : UITableViewCell
@property (nonatomic,copy) void (^animationHandle)(WaterOpenCell * cell);
@property (nonatomic,strong)UIImageView * backImage;
@end
