//
//  ViewController.m
//  DrawApp
//
//  Created by Leroy Yu Tse on 23/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import "ViewController.h"
#import "pencil.h"
#import "EclipseView.h"
#import "rectangle.h"
#import "SquareView.h"
#import "TriangleView.h"
#import "line.h"
#import <Google/Analytics.h>

#define DefaultSelectedSegmentIndex 0

#define DrawAppScreenMain @"DrawAppMainScreen"

#define ShapeSelected @"ShapeSelected"
#define ColourSelected @"ColourSelected"
#define PencilSelected @"PencilSelected"
#define Reset @"Reset"
#define Save @"Save"
#define UndoSelected @"UndoSelected"

@interface ViewController ()
{
    UIBezierPath *_currentPath;
    CAShapeLayer *_shapeLayer;
    CGPoint _startPoint,_lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    float lineWidth;
    int sublayersCount;
    pencil *_pencil;
    EclipseView *_eclipseView;
    rectangle *_rectangle;
    TriangleView *_triangleView;
    line *_line;
    SquareView *_squareView;
    BOOL pencilPressed,eclipsePressed,rectanglePressed,trianglePressed,squarePressed,linePressed,trianglePressed1;
}
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:DrawAppScreenMain];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    GAI *gai = [GAI sharedInstance];
    gai.logger.logLevel = kGAILogLevelVerbose;
}

- (void)viewDidLoad {
    
    alpha = 1.0f;
    
    [super viewDidLoad];
    [self addSegmentedCtrl];
    
    
    self.colorArray =  @[@0x000000, @0xfe0000, @0xff7900, @0xffb900, @0xffde00, @0xfcff00, @0xd2ff00, @0x05c000, @0x00c0a7, @0x0600ff, @0x6700bf, @0x9500c0, @0xbf0199, @0xffffff ];
    self.colorImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.colorSlider.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.triangle.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.triangle.hidden = YES;
    self.lineWidth1.hidden = YES;
    self.lineWidth2.hidden = YES;
    self.lineWidth3.hidden = YES;


    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(freeStyle:)];
    
    [self.drawView addGestureRecognizer:panGesture];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString*)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    NSDate *date = [NSDate date];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    return formattedDateString;
}


-(void)eventTrackingWithCategory:(NSString*)category action:(NSString*)action label:
(NSString*)label
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                          action:action
                                                           label:label
                                                           value:nil] build]];
}

-(void)freeStyle:(UIGestureRecognizer*)recognizer
{
    //Get the location of current touch point
    CGPoint point = [recognizer locationInView:self.drawView];
    NSLog(@"xPos: %.2f yPos: %.2f", point.x, point.y);
    if (pencilPressed) {
        _pencil = [pencil alloc];
    }
    if (!trianglePressed && !trianglePressed1) {
        self.triangle.hidden = YES;
    }
    if (!linePressed && !pencilPressed) {
        self.lineWidth1.hidden = YES;
        self.lineWidth2.hidden = YES;
        self.lineWidth3.hidden = YES;
    }
    //Detect different states of pan gesture
    switch (recognizer.state) {

        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"GestureRecognizerStateBegan");
            
            _lastPoint = [recognizer locationInView:recognizer.view];
            
             _startPoint = [recognizer locationInView:recognizer.view];
            
            _currentPath = [UIBezierPath bezierPath ];
            _shapeLayer = [CAShapeLayer layer];
            [_pencil startPoint:&(_startPoint) view:self.drawView path:_currentPath layer:_shapeLayer red:red green:green blue:blue alpha:alpha lineWidth:lineWidth];

        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            if (eclipsePressed || rectanglePressed || trianglePressed || squarePressed || trianglePressed1 || linePressed) {
                [self refresh];
            }
            NSLog(@"GestureRecognizerStateChanged");
            CGPoint _touchPoint = [recognizer locationInView:self.drawView];

            [_pencil touchPoint:&(_touchPoint) path:_currentPath layer:_shapeLayer];
            
            if (eclipsePressed) {
                _eclipseView = [EclipseView alloc];
                [_eclipseView drawRect:(CGRect){{_startPoint.x, _startPoint.y}, _touchPoint.x - _startPoint.x, _touchPoint.y - _startPoint.y} view:self.drawView red:red green:green blue:blue alpha:alpha];
            }
            
            if (rectanglePressed) {
                _rectangle = [rectangle alloc];
                CGFloat sizeX = _touchPoint.x - _lastPoint.x;
                CGFloat sizeY = _touchPoint.y - _lastPoint.y;
                
                if (_lastPoint.x > _touchPoint.x) {
                    sizeX = _lastPoint.x - _touchPoint.x;
                    _startPoint.x = _touchPoint.x;
                }
                if (_lastPoint.y > _touchPoint.y) {
                    sizeY = _lastPoint.y - _touchPoint.y;
                    _startPoint.y = _touchPoint.y;
                }
                [_rectangle drawRect:(CGRect){{_startPoint.x, _startPoint.y}, sizeX, sizeY} view:self.drawView red:red green:green blue:blue alpha:alpha];
            }
            if (trianglePressed) {
                _triangleView = [TriangleView alloc];
                [_triangleView view:self.drawView topPoint:&(_touchPoint) startPoint:&(_startPoint) red:red green:green blue:blue alpha:alpha];
            }
            if (trianglePressed1) {
                _triangleView = [TriangleView alloc];
                [_triangleView view1:self.drawView topPoint:&(_touchPoint) startPoint:&(_startPoint) red:red green:green blue:blue alpha:alpha];
            }
            if (linePressed) {
                _line = [line alloc];
                [_line startPoint:&(_startPoint) touchPoint:&(_touchPoint) view:self.drawView red:red green:green blue:blue alpha:alpha lineWidth:lineWidth];
            }
            if (squarePressed) {
                _squareView = [SquareView alloc];
                [_squareView view:self.drawView startPoint:&(_startPoint) touchPoint:&(_touchPoint) red:red green:green blue:blue alpha:alpha];
            }
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"GestureRecognizerStateEnded");
            if (eclipsePressed || rectanglePressed || trianglePressed || squarePressed || trianglePressed1 || linePressed) {
                sublayersCount++;
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

- (IBAction)triangle1:(id)sender
{
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"Triangle selected"
                              label:[self dateFormatter]];
    eclipsePressed = NO;
    pencilPressed = NO;
    trianglePressed1 = YES;
    trianglePressed = NO;
    linePressed = NO;
    squarePressed = NO;
    rectanglePressed = NO;

    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    
    self.colorSlider.value = 0;
}

- (IBAction)pencil:(id)sender
{
    [self eventTrackingWithCategory:PencilSelected
                             action:@"Pencil selected"
                              label:[self dateFormatter]];
    self.lineWidth1.hidden = NO;
    self.lineWidth2.hidden = NO;
    self.lineWidth3.hidden = NO;
    
    pencilPressed = YES;
    eclipsePressed = NO;
    trianglePressed = NO;
    trianglePressed1 = NO;
    linePressed = NO;
    squarePressed = NO;
    rectanglePressed = NO;
    
    lineWidth = 3.f;
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    
    self.colorSlider.value = 0;
}

- (IBAction)colorSlider:(id)sender
{
    NSNumber* rgbNumber = _colorArray[(int)(self.colorSlider.value)];

    CGFloat r  = ([rgbNumber intValue] >> 16) & 0xFF;
    CGFloat g  = ([rgbNumber intValue] >> 8) & 0xFF;
    CGFloat b  = [rgbNumber intValue] & 0xFF;
    
    red = r/255.0;
    green = g/255.0;
    blue = b/255.0;
}

- (IBAction)eclipse:(id)sender
{
    
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"Eclipse selected"
                              label:[self dateFormatter]];
    eclipsePressed = YES;
    pencilPressed = NO;
    trianglePressed = NO;
    linePressed = NO;
    squarePressed = NO;
    rectanglePressed = NO;
    trianglePressed1 = NO;
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    
    self.colorSlider.value = 0;
}

- (IBAction)save:(id)sender
{
    
    [self eventTrackingWithCategory:Save
                             action:@"Save started"
                              label:[self dateFormatter]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select you Choice"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Save to photo album"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              [self eventTrackingWithCategory:Save
                                                                                       action:@"Save confirmed"
                                                                                        label:[self dateFormatter]];
                                                              [self savePhotoOfView:self.drawView];
                                                          }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               [self eventTrackingWithCategory:Save
                                                                                        action:@"Save canceled"
                                                                                         label:[self dateFormatter]];
                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                           }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];

    [alert setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alert
                                                     popoverPresentationController];
    popPresenter.sourceView = self.save;
    popPresenter.sourceRect = self.save.bounds;
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)savePhotoOfView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Image could not be saved.Please try again"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                             
                                                             [self eventTrackingWithCategory:Save
                                                                                      action:@"Save error"
                                                                                       label:[self dateFormatter]];
                                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                                         }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                       message:@"Image was successfully saved in photoalbum"
                                                                preferredStyle:UIAlertControllerStyleAlert]; 
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                   
                                                                   [self eventTrackingWithCategory:Save
                                                                                            action:@"Save Successed"
                                                                                             label:[self dateFormatter]];
                                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                               }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}
- (IBAction)eraser:(id)sender
{
    [self eventTrackingWithCategory:@"Eraser"
                             action:@"Eraser selected"
                              label:[self dateFormatter]];
    pencilPressed = YES;
    eclipsePressed = NO;
    trianglePressed = NO;
    linePressed = NO;
    squarePressed = NO;
    rectanglePressed = NO;
    trianglePressed1 = NO;
    
    lineWidth = 3.f;
    
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;

}

- (IBAction)triangle:(id)sender
{
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"Triangle selected"
                              label:[self dateFormatter]];
    self.triangle.hidden = NO;
    eclipsePressed = NO;
    pencilPressed = NO;
    trianglePressed = YES;
    trianglePressed1 = NO;
    linePressed = NO;
    squarePressed = NO;
    rectanglePressed = NO;
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    
    self.colorSlider.value = 0;
    
}

- (IBAction)rectangle:(id)sender
{
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"Rectangle selected"
                              label:[self dateFormatter]];
    eclipsePressed = NO;
    pencilPressed = NO;
    trianglePressed = NO;
    linePressed = NO;
    squarePressed = NO;
    rectanglePressed = YES;
    trianglePressed1 = NO;
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    
    self.colorSlider.value = 0;
}

- (IBAction)square:(id)sender
{
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"Square selected"
                              label:[self dateFormatter]];
    eclipsePressed = NO;
    pencilPressed = NO;
    trianglePressed = NO;
    linePressed = NO;
    squarePressed = YES;
    rectanglePressed = NO;
    trianglePressed1 = NO;
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    
    self.colorSlider.value = 0;
}

- (IBAction)line:(id)sender
{
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"Line selected"
                              label:[self dateFormatter]];
    self.lineWidth1.hidden = NO;
    self.lineWidth2.hidden = NO;
    self.lineWidth3.hidden = NO;
    eclipsePressed = NO;
    pencilPressed = NO;
    trianglePressed = NO;
    linePressed = YES;
    squarePressed = NO;
    rectanglePressed = NO;
    trianglePressed1 = NO;
    
    lineWidth = 3.f;
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    
    self.colorSlider.value = 0;
}

- (IBAction)undo:(id)sender
{
    [self eventTrackingWithCategory:UndoSelected
                             action:@"Undo selected"
                              label:[self dateFormatter]];
    [[self.drawView.layer.sublayers objectAtIndex:[self.drawView.layer.sublayers count] - 1] removeFromSuperlayer];
    if (sublayersCount > 0) {
        sublayersCount--;
    }
    
    NSLog(@"%lu,%d",[self.drawView.layer.sublayers count],sublayersCount);
}

- (IBAction)lineWidth1:(id)sender
{
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"LineWidth1 selected"
                              label:[self dateFormatter]];
    lineWidth = 1.f;
}

- (IBAction)lineWidth2:(id)sender
{
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"LineWidth2 selected"
                              label:[self dateFormatter]];
    lineWidth = 3.f;
}

- (IBAction)lineWidth3:(id)sender
{
    [self eventTrackingWithCategory:ShapeSelected
                             action:@"LineWidth3 selected"
                              label:[self dateFormatter]];
    lineWidth = 5.f;
}

-(void)refresh
{
    if ([self.drawView.layer.sublayers count] > sublayersCount) {
        [[self.drawView.layer.sublayers objectAtIndex:[self.drawView.layer.sublayers count] - 1] removeFromSuperlayer];
    }
   
}
- (IBAction)clear:(id)sender
{
    
    [self eventTrackingWithCategory:Reset
                             action:@"Reset started"
                              label:[self dateFormatter]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Clear"
                                                                   message:@"All drawings & stickers will be deleted."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Clear"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              [self eventTrackingWithCategory:Reset
                                                                                       action:@"Reset confirmed"
                                                                                        label:[self dateFormatter]];
                                                              
                                                              while ([self.drawView.layer.sublayers count] > 0)
                                                              {
                                                                  [[self.drawView.layer.sublayers objectAtIndex:[self.drawView.layer.sublayers count] - 1] removeFromSuperlayer];
                                                                  sublayersCount = 0;
                                                              }
                                                              
                                                          }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                               [self eventTrackingWithCategory:Reset
                                                                                        action:@"Reset canceled"
                                                                                         label:[self dateFormatter]];
                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                           }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alert
                                                     popoverPresentationController];
    popPresenter.sourceView = self.clear;
    popPresenter.sourceRect = self.clear.bounds;
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)addSegmentedCtrl
{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]
                                            initWithItems:[NSArray arrayWithObjects:[[UIImage imageNamed:@"red"]
                                                                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                           [[UIImage imageNamed:@"yellow"]
                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                           [[UIImage imageNamed:@"green"]
                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                           [[UIImage imageNamed:@"blue"]
                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                           [[UIImage imageNamed:@"purple"]
                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                           nil]];
    segmentedControl.frame = CGRectMake(self.view.frame.size.width - 70,self.view.frame.size.height - 85,90,30);
    segmentedControl.transform = CGAffineTransformMakeRotation(M_PI_2);
    segmentedControl.tintColor = [UIColor blackColor];
    [segmentedControl addTarget:self action:@selector(chooseColor:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

-(void)chooseColor:(id)sender
{
    NSInteger index = ((UISegmentedControl*)sender).selectedSegmentIndex;
    if (index == 0) {
        red = 255.0/255.0;
        green = 0.0/255.0;
        blue = 0.0/255.0;
        [self eventTrackingWithCategory:ColourSelected
                                 action:@"Red selected"
                                  label:[self dateFormatter]];
    }
    if (index == 1) {
        red = 255.0/255.0;
        green = 255.0/255.0;
        blue = 0.0/255.0;
        [self eventTrackingWithCategory:ColourSelected
                                 action:@"Yellow selected"
                                  label:[self dateFormatter]];
    }
    if (index == 2) {
        red = 0.0/255.0;
        green = 255.0/255.0;
        blue = 0.0/255.0;
        [self eventTrackingWithCategory:ColourSelected
                                 action:@"Green selected"
                                  label:[self dateFormatter]];
    }
    if (index == 3) {
        red = 0.0/255.0;
        green = 0.0/255.0;
        blue = 255.0/255.0;
        [self eventTrackingWithCategory:ColourSelected
                                 action:@"Blue selected"
                                  label:[self dateFormatter]];
    }
    if (index == 4) {
        red = 160.0/255.0;
        green = 32.0/255.0;
        blue = 240.0/255.0;
        [self eventTrackingWithCategory:ColourSelected
                                 action:@"Purple selected"
                                  label:[self dateFormatter]];
    }
    
}

@end
