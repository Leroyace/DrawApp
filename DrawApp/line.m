//
//  line.m
//  PanGesture
//
//  Created by Leroy Yu Tse on 25/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import "line.h"

@implementation line


-(void)startPoint:(CGPoint*)startPoint touchPoint:(CGPoint*)currentPoint view:(UIView*)view red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha lineWidth:(float)lineWidth
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(startPoint->x,startPoint->y)];
    [path addLineToPoint:CGPointMake(currentPoint->x, currentPoint->y)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.strokeColor = ([UIColor colorWithRed:red green:green blue:blue alpha:alpha]).CGColor;
    
    shapeLayer.path = path.CGPath;
    [view.layer addSublayer:shapeLayer];
}

@end
