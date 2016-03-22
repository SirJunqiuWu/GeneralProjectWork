//
//  CoreUtil.m
//  FashionMovie
//
//  Created by 吴 吴 on 15/8/26.
//  Copyright (c) 2015年 蔡成汉. All rights reserved.
//

#import "CoreUtil.h"

@implementation CoreUtil

#pragma mark - 根据颜色值画图片

+ (UIImage *)getImageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 2, 2);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
