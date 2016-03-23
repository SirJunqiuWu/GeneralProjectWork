//
//  CoreUtil.m
//  FashionMovie
//
//  Created by 吴 吴 on 15/8/26.
//  Copyright (c) 2015年 蔡成汉. All rights reserved.
//

#import "CoreUtil.h"

@implementation CoreUtil

#pragma mark ------------------ 字符串处理模块 --------------

+ (NSString *)getTimeStringByDate:(NSDate *)date Formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = formatter;
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    NSString *tempTime = [dateFormatter stringFromDate:date];
    return tempTime;
}

+ (float)getStringWidth:(NSString *)string AndFont:(float)font {
    float width = 0.0;
    CGSize size = CGSizeMake(AppScreenWidth, MAXFLOAT);
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [string boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:NULL];
    width = rect.size.width;
    return width;
}

+ (NSString *)nullString:(NSString *)string {
    if (string == nil) {
        string = @"";
    }
    return string;
}

+ (NSString *)getJsonStringWithObj:(id)obj {
    NSData *tempData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:NULL];
    if (tempData == nil || tempData.length == 0)
    {
        tempData = [NSData data];
    }
    NSString *result = [[NSString alloc]initWithData:tempData encoding:NSUTF8StringEncoding];
    return result;
}

+ (NSAttributedString *)getFormatStringWithSourceString:(NSString *)source KeyWords:(NSString *)keyWords Font:(UIFont *)font Color:(UIColor*)color {
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]initWithString:source];
    NSRange range = [source rangeOfString:keyWords];
    /**
     *  关键字的字体大小
     */
    [resultString addAttribute:NSFontAttributeName value:font range:range];
    /**
     *  关键字的字体颜色
     */
    [resultString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return resultString;
}

+ (BOOL)isAllSpaceInTheString:(NSString *)string {
    BOOL result = YES;
    for (int i = 0; i <string.length; i ++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *tempStr = [string substringWithRange:range];
        /**
         *  发现有一个不是，即返回NO
         */
        if (![tempStr isEqualToString:@" "]) {
            result = NO;
        }
    }
    return result;
}

#pragma mark ------------------ 获取UIImage模块 -------------

+ (UIImage *)getVideoFirstFrameWithVideoUrl:(NSString *)videoUrl VideoStatus:(VideoStatus)videoStatus {
    UIImage *resultImage = nil;
    if (videoUrl.length == 0 || videoUrl == nil)
    {
        resultImage = [UIImage imageNamed:@"cacheImage"];
    }
    else
    {
        NSURL *videoURL = videoStatus == LocalVideo ?[[NSURL alloc]initFileURLWithPath:videoUrl]:[NSURL URLWithString:videoUrl];
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *img = [[UIImage alloc] initWithCGImage:image];
        if(img == nil)
        {
            img =  [UIImage imageNamed:@"cacheImage"];
        }
        resultImage = img;
        
    }
    return resultImage;
}

+ (void)downloadImageWithImageUrl:(NSString *)imageUrl {
    UIImage *tpImage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:imageUrl];
    if (tpImage!=nil) {
        return;
    }
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageDownloaderContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        /**
         *  下载完成，对图片进行存储
         */
        if (finished) {
            [[SDImageCache sharedImageCache]storeImage:image forKey:imageUrl toDisk:YES];
        }
    }];
}

#pragma mark - 加载框提示

+ (void)showHud:(NSString *)title View:(UIView *)view {
    [CoreUtil hideHUDWithView:view];
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    hud.color = [UIColor clearColor];
    hud.margin = 10;
    hud.labelColor = [UIColor whiteColor];
    hud.labelFont = FONT16;
    hud.dimBackground = NO;
    
    UIView *waitingView = [[UIView alloc] initWithFrame:AppFrame(0, 0, 60, 60)];
    
    UIImageView *animation = [[UIImageView alloc] initWithFrame:AppFrame(0, 0, 60, 60)];
    animation.image = [UIImage imageNamed:@"hud_waiting_animation"];
    [waitingView addSubview:animation];
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:AppFrame(0, 0, 60, 60)];
    logo.image = [UIImage imageNamed:@"hud_waiting_logo"];
    [waitingView addSubview:logo];
    
    hud.customView = waitingView;
    
    /**
     *  动画显示
     */
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [animation.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    if ([title length]>0) {
        hud.labelText = title;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
}

+ (void)showProgressHUD:(NSString *)title View:(UIView *)view {
    [CoreUtil hideHUDWithView:view];
    MBProgressHUD *hud =[[MBProgressHUD alloc] initWithView:view];
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    if ([title length]>0)
    {
        hud.labelText = title;
    }
    [view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}

+ (void)showSuccessHUD:(NSString *)title View:(UIView *)view {
    [CoreUtil hideHUDWithView:view];
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    hud.margin = 10;
    hud.labelColor = [UIColor whiteColor];
    hud.labelFont = FONT16;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-success"]];
    if ([title length]>0)
    {
        hud.labelText = title;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

+ (void)showFailedHUD:(NSString *)title  View:(UIView *)view {
    [CoreUtil hideHUDWithView:view];
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    hud.margin = 10;
    hud.labelColor =[UIColor whiteColor];
    hud.labelFont = FONT16;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-failed"]];
    if ([title length]>0)
    {
        hud.labelText = title;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

+ (void)showWarningHUD:(NSString *)title View:(UIView *)view {
    [CoreUtil hideHUDWithView:view];
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    hud.margin = 10;
    hud.labelColor = [UIColor whiteColor];
    hud.labelFont = FONT16;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-warning"]];
    if ([title length]>0)
    {
        hud.labelText = title;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

+ (void)hideHUDWithView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

+ (void)showText:(NSString *)string View:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

#pragma mark - 根据颜色值画图片

+ (UIImage *)getImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 2, 2);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - 网络是否正常

+ (BOOL)isNetwork {
    if ([CoreUtil isConnectionAvailable] != NetWorkNotReachable )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NetWorkStatus) isConnectionAvailable {
    NetWorkStatus status;
    //    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if ([reach currentReachabilityStatus] == ReachableViaWiFi)
    {
        status = NetWorkIsWIFI;
    }
    else if ([reach currentReachabilityStatus] == ReachableViaWWAN)
    {
        status = NetWorkIs3G;
    }
    else
    {
        status = NetWorkNotReachable;
    }
    return status;
}

@end
