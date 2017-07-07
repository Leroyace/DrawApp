//
//  SquareView.m
//  draw
//
//  Created by Leroy Yu Tse on 23/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import "SquareView.h"

@implementation SquareView

-(void)view:(UIView*)view startPoint:(CGPoint*)_startPoint touchPoint:(CGPoint*)_touchPoint red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
{
    radiusX = _touchPoint->x - _startPoint->x;
    radiusY = _touchPoint->y - _startPoint->y;

    if (radiusX != radiusY && radiusX > radiusY) {
        radiusX = radiusX - (radiusX - radiusY);
    }

    if (radiusX != radiusY && radiusY > radiusX) {
        radiusY = radiusY - (radiusY - radiusX);
    }

    topLeftX = _startPoint->x - radiusX;
    topLeftY = _startPoint->y - radiusY;
    bottomLeftX = _startPoint->x - radiusX;
    bottomLeftY = _startPoint->y + radiusY;
    topRightX = _startPoint->x + radiusX;
    topRightY = _startPoint->y - radiusY;
    bottomRightX = _startPoint->x + radiusX;
    bottomRightY = _startPoint->y + radiusY;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(topLeftX, topLeftY)];
    [path addLineToPoint:CGPointMake(bottomLeftX, bottomLeftY)];
    [path addLineToPoint:CGPointMake(bottomRightX, bottomRightY)];
    [path addLineToPoint:CGPointMake(topRightX, topRightY)];

    [path addLineToPoint:CGPointMake(topLeftX, topLeftY)];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = ([UIColor colorWithRed:red green:green blue:blue alpha:alpha]).CGColor;

    [view.layer addSublayer:layer];
}

@end
