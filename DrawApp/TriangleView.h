//
//  TriangleView.h
//  draw
//
//  Created by Leroy Yu Tse on 23/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TriangleView : UIView
{
    CGFloat leftBottomX,leftBottomY,rightBottomX,rightBottomY,heightX,heightY;
}
-(void)view:(UIView*)view topPoint:(CGPoint*)topPoint startPoint:(CGPoint*)startPoint red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

-(void)view1:(UIView*)view topPoint:(CGPoint*)topPoint startPoint:(CGPoint*)startPoint red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
