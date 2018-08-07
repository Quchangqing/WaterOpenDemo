//
//  WaterOpenCell.m
//  waterOpenDemo
//
//  Created by Changqing Qu on 2018/8/3.
//  Copyright © 2018 SteFan. All rights reserved.
//

#import "WaterOpenCell.h"
#import "UIImage+clip.h"
#define margin 10
#define endWidth 40
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface WaterOpenCell ()

@end

@implementation WaterOpenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _backImage= [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, SCREEN_WIDTH - margin * 2 , 120 - margin*2)];
        UIImage * image = [[UIImage imageNamed:@"back.jpg"] drawCornerInRect:_backImage.bounds cornerRadius:4];
        _backImage.image = image;
        [self.contentView addSubview:_backImage];
        _backImage.layer.shadowColor = [UIColor grayColor].CGColor;
        _backImage.layer.shadowOffset = CGSizeMake(3, 3);
        _backImage.layer.shadowRadius = 4;
        _backImage.layer.shadowOpacity = 1;
    }
    return self;
}

@end
