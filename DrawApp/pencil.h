//
//  pencil.h
//  PanGesture
//
//  Created by Leroy Yu Tse on 24/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pencil : UIView


-(void)startPoint:(CGPoint*)startPoint view:(UIView*)view path:(UIBezierPath*)currentPath layer:(CAShapeLayer*)shapeLayer red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha lineWidth:(float)lineWidth;
-(void)touchPoint:(CGPoint*)currentPoint path:(UIBezierPath*)currentPath layer:(CAShapeLayer*)shapeLayer;

@end
