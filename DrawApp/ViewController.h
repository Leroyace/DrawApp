//
//  ViewController.h
//  DrawApp
//
//  Created by Leroy Yu Tse on 23/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSArray *colorArray;

@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UISlider *colorSlider;
@property (weak, nonatomic) IBOutlet UIButton *triangle;
@property (weak, nonatomic) IBOutlet UIView *drawView;

@property (weak, nonatomic) IBOutlet UIButton *lineWidth1;
@property (weak, nonatomic) IBOutlet UIButton *lineWidth2;
@property (weak, nonatomic) IBOutlet UIButton *lineWidth3;

@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet UIButton *clear;

- (IBAction)triangle1:(id)sender;
- (IBAction)pencil:(id)sender;
- (IBAction)colorSlider:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)eclipse:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)eraser:(id)sender;
- (IBAction)triangle:(id)sender;
- (IBAction)rectangle:(id)sender;
- (IBAction)square:(id)sender;
- (IBAction)line:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)lineWidth1:(id)sender;
- (IBAction)lineWidth2:(id)sender;
- (IBAction)lineWidth3:(id)sender;

@end

