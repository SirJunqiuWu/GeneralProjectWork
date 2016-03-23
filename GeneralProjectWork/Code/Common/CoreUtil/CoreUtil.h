//
//  CoreUtil.h
//  FashionMovie
//
//  Created by 吴 吴 on 15/8/26.
//  Copyright (c) 2015年 蔡成汉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
    NetWorkNotReachable,
    NetWorkIsWIFI,
    NetWorkIs3G,
}   NetWorkStatus;

typedef enum {
    LocalVideo,
    RemoteVideo
}   VideoStatus;

@interface CoreUtil : NSObject

#pragma mark ------------------ 字符串处理模块 --------------

/**
 *  根据时间格式，获取时间字符
 *
 *  @param date      NSDate
 *  @param formatter 时间格式 eg:yyyy-MM-dd
 *
 *  @return 格式化后的时间
 */
+ (NSString *)getTimeStringByDate:(NSDate *)date Formatter:(NSString *)formatter;

/**
 *  获取字符串宽度
 *
 *  @param string 目标字符串
 *  @param font   字体大小
 *
 *  @return 目标字符串的宽度
 */
+ (float)getStringWidth:(NSString *)string AndFont:(float)font;


/**
 *  返回不为nil的字符串
 *
 *  @param string 目标字符串
 *
 *  @return NSString
 */
+ (NSString *)nullString:(NSString *)string;


/**
 *  将目标数据转化为Json字符串
 *
 *  @param obj 目标数据
 *
 *  @return 转化后的Json字符串
 */
+ (NSString *)getJsonStringWithObj:(id)obj;


/**
 *  对目标字符串中的关键字进行大小或者字体颜色进行处理
 *
 *  @param source      目标字符串
 *  @param keyWords    关键词
 *  @param font        字体大小
 *  @param color       字体颜色
 *
 *  @return NSAttributedString 处理后的富文本
 */
+ (NSAttributedString *)getFormatStringWithSourceString:(NSString *)source KeyWords:(NSString *)keyWords Font:(UIFont *)font Color:(UIColor*)color;


#pragma mark ------------------ 加载框提示模块 --------------

+ (void)showHud:(NSString *)title View:(UIView *)view;
+ (void)showProgressHUD:(NSString *)title View:(UIView *)view;
+ (void)showSuccessHUD:(NSString *)title View:(UIView *)view;
+ (void)showFailedHUD:(NSString *)title  View:(UIView *)view;
+ (void)showWarningHUD:(NSString *)title View:(UIView *)view;
+ (void)hideHUDWithView:(UIView *)view;
+ (void)showText:(NSString *)string View:(UIView *)view;

#pragma mark ------------------ 获取UIImage模块 -------------

/**
 *  根据颜色值画图片
 *
 *  @param color 图片颜色
 *
 *  @return UIImage
 */
+ (UIImage *)getImageFromColor:(UIColor *)color;


/**
 *  根据视频链接和视频来源获取视频的第一帧图片
 *
 *  @param videoUrl    视频的链接
 *  @param videoStatus 0,本地视频;1,网络视频
 *
 *  @return 目标视频的第一帧图片
 */
+ (UIImage *)getVideoFirstFrameWithVideoUrl:(NSString *)videoUrl VideoStatus:(VideoStatus)videoStatus;


/**
 *  根据图片链接，下载图片
 *
 *  @param imageUrl 图片链接
 */
+ (void)downloadImageWithImageUrl:(NSString *)imageUrl;

#pragma mark ------------------ 网络监测模块 -------------

/**
 *  网络连接是否正常
 *
 *  @return NO不正常
 */
+ (BOOL)isNetwork;


@end
