//
//  rectangle.m
//  DrawApp
//
//  Created by Leroy Yu Tse on 29/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import "rectangle.h"

@implementation rectangle

-(void)drawRect:(CGRect)rect view:(UIView*)view red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0.0];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = ([UIColor colorWithRed:red green:green blue:blue alpha:alpha]).CGColor;
    
    [view.layer addSublayer:layer];
}

@end
