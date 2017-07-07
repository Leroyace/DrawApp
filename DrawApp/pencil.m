//
//  pencil.m
//  PanGesture
//
//  Created by Leroy Yu Tse on 24/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import "pencil.h"

@implementation pencil


-(void)startPoint:(CGPoint*)startPoint view:(UIView*)view path:(UIBezierPath*)currentPath layer:(CAShapeLayer*)shapeLayer red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha lineWidth:(float)lineWidth
{
    [currentPath moveToPoint:CGPointMake(startPoint->x,startPoint->y)];

    shapeLayer.lineWidth = lineWidth;
    shapeLayer.strokeColor = ([UIColor colorWithRed:red green:green blue:blue alpha:alpha]).CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    [view.layer addSublayer:shapeLayer];
}

-(void)touchPoint:(CGPoint*)currentPoint path:(UIBezierPath*)currentPath layer:(CAShapeLayer*)shapeLayer
{
    
    [currentPath addLineToPoint:CGPointMake(currentPoint->x, currentPoint->y)];
    
    shapeLayer.path = currentPath.CGPath;
}

@end
