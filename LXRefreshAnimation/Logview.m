//
//  Logview.m
//  LXRefreshAnimation
//
//  Created by chuanglong02 on 16/11/30.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "Logview.h"
#import "UIView+Frame.h"
@implementation Logview
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.logview];
        [self.logview.layer addSublayer:self.circleLayer];
        [self addSubview:self.circleView];
        self.circleLayer.strokeEnd = 0.9;
    }
    return self;
}
-(UIImageView *)logview
{
    if (!_logview) {
        _logview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.height, self.height)];
//        _logview.backgroundColor =[UIColor redColor];
        _logview.image =[UIImage imageNamed:@"zhi@2x.png"];
    }
    return _logview;
}
-(CAShapeLayer *)getShape{
    UIBezierPath *path       = [UIBezierPath bezierPathWithOvalInRect:self.logview.bounds];//先写剧本
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path          = path.CGPath;//安排剧本
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;//填充色要为透明，不然会遮挡下面的图层
    shapeLayer.strokeColor   = [UIColor redColor].CGColor;
    shapeLayer.lineWidth     = 1.0;
    shapeLayer.frame         = self.logview.bounds;
    
    return shapeLayer;
}
- (CALayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [self getShape];
        _circleLayer.hidden = YES;
    }
    return _circleLayer;
}
-(UIImageView *)circleView
{
    if (!_circleView) {
        _circleView =[[UIImageView alloc]initWithFrame:self.logview.bounds];
        _circleView.image =[UIImage imageNamed:@"circle@2x.png"];
        [_circleView.layer addAnimation:[self getTransformAnimation] forKey:nil];
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
