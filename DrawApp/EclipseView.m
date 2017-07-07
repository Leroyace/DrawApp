
//
//  EclipseView.m
//  draw
//
//  Created by Leroy Yu Tse on 23/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import "EclipseView.h"


@implementation EclipseView
{
    UIBezierPath *path;
}

-(void)drawRect:(CGRect)rect view:(UIView*)view red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = ([UIColor colorWithRed:red green:green blue:blue alpha:alpha]).CGColor;
    
    [view.layer addSublayer:layer];
}


@end
