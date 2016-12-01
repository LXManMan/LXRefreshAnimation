

//
//  LXRefreshHeader.m
//  LXRefreshAnimation
//
//  Created by chuanglong02 on 16/11/30.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "LXRefreshHeader.h"
#import "Logview.h"
CGRect kZZZLogoViewBounds = {0,0,30,30};
@interface LXRefreshHeader ()
@property(nonatomic,strong)UIImageView *logview;
@property(nonatomic,strong)CAShapeLayer *circleLayer;
@property(nonatomic,strong)UIImageView *circleView;
@property(nonatomic,assign)BOOL hasRefreshed;
@end
@implementation LXRefreshHeader

- (void)prepare
{
    [super prepare];
    [self.logview addSubview:self.circleView];
    [self.logview.layer addSublayer:self.circleLayer];
    
    [self addSubview:self.logview];
    self.hasRefreshed = NO;//初始化的时候，肯定是没有刷新过的
}
#pragma mark 在这里设置子控件的位置和尺寸

- (void)placeSubviews
{
    [super placeSubviews];
    self.logview.center = CGPointMake(self.mj_w/2.0, self.mj_h/2.0 + 10.0);// +10是为了logoView在中心点往下一点的位置，方便观看
    self.logview.bounds = kZZZLogoViewBounds;
    self.circleView.frame = self.logview.bounds;
    self.circleLayer.frame = self.logview.bounds;
    
}
#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.circleView.hidden = YES;
            self.circleLayer.hidden = NO;
            break;
        case MJRefreshStatePulling:
          
            break;
        case MJRefreshStateRefreshing:
            self.circleView.hidden = NO;
            [CATransaction begin];//
            [CATransaction setDisableActions:YES];//
            self.circleLayer.hidden = YES;//
            [CATransaction commit];//  操作layer 禁止隐式动画
            [self.circleView.layer addAnimation:[self getTransformAnimation] forKey:nil];
            self.hasRefreshed = YES;//刷新过了
            break;
        default:
            break;
    }}
#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    
    if (self.hasRefreshed) {//刷新返回的时候，strokeEnd = 1.0
        [CATransaction begin];
        [CATransaction setDisableActions:YES];//取出隐式动画
        self.circleLayer.strokeEnd = 1.0;
        [CATransaction commit];
        self.hasRefreshed = NO;//重置状态为未刷新
    }else{
        self.circleLayer.strokeEnd = pullingPercent;
    }
}

- (void)endRefreshing{
    
    [self.circleView.layer removeAllAnimations];
    [super endRefreshing];
}
-(UIImageView *)logview
{
    if (!_logview) {
        _logview =[[UIImageView alloc]init];
        _logview.image =[UIImage imageNamed:@"zhi@2x.png"];
    }
    return _logview;
}
-(CAShapeLayer *)getShape{
    UIBezierPath *path       = [UIBezierPath bezierPathWithOvalInRect:kZZZLogoViewBounds];//先写剧本
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path          = path.CGPath;//安排剧本
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;//填充色要为透明，不然会遮挡下面的图层
    shapeLayer.strokeColor   = [UIColor redColor].CGColor;
    shapeLayer.lineWidth     = 1.0;
    shapeLayer.frame         = self.logview.bounds;
    
    return shapeLayer;
}
- (CAShapeLayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [self getShape];
    }
    return _circleLayer;
}
-(UIImageView *)circleView
{
    if (!_circleView) {
        _circleView =[[UIImageView alloc]init];
        _circleView.image =[UIImage imageNamed:@"circle@2x.png"];
        _circleView.hidden = YES;
    }
    return _circleView;
}
-(CABasicAnimation *)getTransformAnimation{
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:@"transform.rotation"]; //指定对transform.rotation属性做动画
    animation.duration            = 2.0f; //设定动画持续时间
    animation.byValue             = @(M_PI*2); //设定旋转角度，单位是弧度
    animation.fillMode            = kCAFillModeForwards;//设定动画结束后，不恢复初始状态之设置一
    animation.repeatCount         = 1000;//设定动画执行次数
    animation.removedOnCompletion = NO;//设定动画结束后，不恢复初始状态之设置二
    return animation;
}

@end
