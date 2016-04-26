//
//  JJAnimation.m
//  demo
//
//  Created by HotYQ on 16/4/25.
//  Copyright © 2016年 HotYQ. All rights reserved.
//

#import "JJAnimation.h"
#import "UIImageView+WebCache.h"

@interface JJAnimation ()
@property (nonatomic , strong) UIView * view;

@end
@implementation JJAnimation

-  (void)startAnimationView:(UIView *)view onCell:(UIView *)cell targetView:(UIView *)targetView  scrollView:(UIScrollView *)scroll  imgUrl:(NSString *)imgUrl
{
    
    UIImageView *cellImg  = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.origin.x, cell.frame.origin.y - scroll.contentOffset.y, view.frame.size.width - 10, view.frame.size.height - 10)];
    cellImg.backgroundColor = [UIColor yellowColor];
    [cellImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    [targetView addSubview:cellImg];
    self.view  = targetView;
    [self startAnimation2:cellImg];
      [self performSelector:@selector(removeObjectView:) withObject:cellImg afterDelay:1.9];

}
-  (void)startAnimationView:(UIView *)view targetView:(UIView *)targetView scrollView:(UIScrollView *)scroll imgUrl:(NSString *)imgUrl
{
    UIImageView *cellImg  = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y - scroll.contentOffset.y, view.frame.size.width - 10, view.frame.size.height - 10)];
        cellImg.backgroundColor = [UIColor yellowColor];
    [cellImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    [targetView addSubview:cellImg];
    self.view  = targetView;
    [self startAnimation2:cellImg];
    
     [self performSelector:@selector(removeObjectView:) withObject:cellImg afterDelay:1.9];
}
- (void)removeObjectView:(UIView *)view
{
    [view removeFromSuperview];
}


- (void)startAnmationShow:(UIView *)view
{
    [self startAnimation1:view];
}
-(void)startAnimation1:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue   = [NSNumber numberWithFloat:10.0f];
    //animation.duration = 0.5f;
    //animation.fillMode = kCAFillModeForwards;
    //animation.removedOnCompletion = NO;
    //animation.repeatCount = 2;
    //[self.ViewTest.layer addAnimation:animation forKey:nil];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue   = [NSNumber numberWithFloat:10.0f];
    //animation.duration = 0.5f;
    //animation.fillMode = kCAFillModeForwards;
    //animation.removedOnCompletion = NO;
    //animation.repeatCount = 2;
    //[self.ViewTest.layer addAnimation:animation1 forKey:nil];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 2.0f;
    groupAnimation.autoreverses  = YES;
    groupAnimation.repeatCount = 5;
    [groupAnimation setAnimations:[NSArray arrayWithObjects:animation,animation1, nil]];
    
    [view.layer addAnimation:groupAnimation forKey:nil];
}

//组合动画
-(void)startAnimation2:(UIView *)view
{
    //界限
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect: view.bounds];
    boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectZero];
    //透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.5];
    
    //位置移动
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue =  [NSValue valueWithCGPoint: view.layer.position];
    CGPoint toPoint = self.view.layer.position;
    toPoint.x += 180;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width/4 *3, self.view.bounds.size.height)];
    
    //旋转动画
    CABasicAnimation* rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 3];
    // 3 is the number of 360 degree rotations
    
    // Make the rotation animation duration slightly less than the other animations to give it the feel
    // that it pauses at its largest scale value
    rotationAnimation.duration = 2.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓入缓出
    //rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    scaleAnimation.duration = 2.0f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2.0f;
    animationGroup.autoreverses = NO;   //是否重播，原动画的倒播
    animationGroup.repeatCount = NSNotFound;//HUGE_VALF;	 //HUGE_VALF,源自math.h
    [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation,animation, scaleAnimation,boundsAnimation, nil]];
    
    //将上述两个动画编组
    
    [view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

//永久闪烁的动画
-(void)opacityForever_Animation:(float)time view:(UIView *)view
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.0];
    animation.autoreverses=YES;
    animation.duration=time;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    
    [view.layer addAnimation:animation forKey:@"opacityForever"];
}


@end
