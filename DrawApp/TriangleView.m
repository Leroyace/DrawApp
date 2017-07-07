//
//  TriangleView.m
//  draw
//
//  Created by Leroy Yu Tse on 23/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView

-(void)view:(UIView*)view topPoint:(CGPoint*)topPoint startPoint:(CGPoint*)startPoint red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    
    heightX = startPoint->x - topPoint->x;
    heightY = startPoint->y - topPoint->y;
    
    if (topPoint->y > startPoint->y || topPoint->y < startPoint->y)
    {
        leftBottomX = startPoint->x - heightY;
        rightBottomX = startPoint->x + heightY;
        leftBottomY = startPoint->y;
        rightBottomY = startPoint->y;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(topPoint->x,topPoint->y)];
    [path addLineToPoint:CGPointMake(leftBottomX,leftBottomY)];
    [path addLineToPoint:CGPointMake(rightBottomX,rightBottomY)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = ([UIColor colorWithRed:red green:green blue:blue alpha:alpha]).CGColor;
    
    [view.layer addSublayer:shapeLayer];
}

-(void)view1:(UIView*)view topPoint:(CGPoint*)topPoint startPoint:(CGPoint*)startPoint red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    
    heightX = startPoint->x - topPoint->x;
    heightY = startPoint->y - topPoint->y;
    
    if (topPoint->x > startPoint->x || topPoint->x < startPoint->x)
    {
        leftBottomX = startPoint->x;
        rightBottomX = startPoint->x;
        leftBottomY = startPoint->y - heightX;
        rightBottomY = startPoint->y + heightX;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(topPoint->x,topPoint->y)];
    [path addLineToPoint:CGPointMake(leftBottomX,leftBottomY)];
    [path addLineToPoint:CGPointMake(rightBottomX,rightBottomY)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = ([UIColor colorWithRed:red green:green blue:blue alpha:alpha]).CGColor;
    
    [view.layer addSublayer:shapeLayer];
}





@end
