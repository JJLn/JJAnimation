//
//  JJAnimation.h
//  demo
//
//  Created by HotYQ on 16/4/25.
//  Copyright © 2016年 HotYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface JJAnimation : NSObject

///丢到垃圾箱效果
//针对collectView
-  (void)startAnimationView:(UIView *)view targetView:(UIView *)targetView scrollView:(UIScrollView *)scroll imgUrl:(NSString *)imgUrl;
///针对tableView
-  (void)startAnimationView:(UIView *)view onCell:(UIView *)cell targetView:(UIView *)targetView  scrollView:(UIScrollView *)scroll  imgUrl:(NSString *)imgUrl;
- (void)startAnmationShow:(UIView *)view;
//闪烁
-(void)opacityForever_Animation:(float)time view:(UIView *)view;


@end
