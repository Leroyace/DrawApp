//
//  line.h
//  PanGesture
//
//  Created by Leroy Yu Tse on 25/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface line : UIView


-(void)startPoint:(CGPoint*)startPoint touchPoint:(CGPoint*)currentPoint view:(UIView*)view red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha lineWidth:(float)lineWidth;

@end
