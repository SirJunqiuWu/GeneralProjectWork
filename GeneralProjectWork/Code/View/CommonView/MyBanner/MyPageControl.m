//
//  MyPageControl.m
//  MyBanner
//
//  Created by JackWu on 15/8/19.
//  Copyright (c) 2015年 JackWu. All rights reserved.
//

#import "MyPageControl.h"

@implementation MyPageControl

-(void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++)
    {
        UIImageView *tpView = [self.subviews objectAtIndex:subviewIndex];
        
        /**
         *  frame重置
         */
        CGSize size;
        size.height = 7;
        size.width = 7;
        [tpView setFrame:CGRectMake(tpView.frame.origin.x, tpView.frame.origin.y,size.width,size.height)];
        
//        /**
//         *  图片替换
//         */
//        if (subviewIndex == currentPage)
//        {
//            /**
//             *  为当前展示的点
//             */
//            tpView.image = [UIImage imageNamed:@""];
//        }
//        else
//        {
//            /**
//             *  为当前非展示的点
//             */
//            tpView.image = [UIImage imageNamed:@""];
//        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
