//
//  SquareView.h
//  draw
//
//  Created by Leroy Yu Tse on 23/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareView : UIView
{
    CGFloat bottomLeftX,bottomLeftY,bottomRightX,bottomRightY,topLeftX,topLeftY,topRightX,topRightY,radiusX,radiusY;
}
-(void)view:(UIView*)view startPoint:(CGPoint*)_startPoint touchPoint:(CGPoint*)_touchPoint red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
