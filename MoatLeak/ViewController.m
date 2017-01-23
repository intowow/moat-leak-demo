//
//  ViewController.m
//  MoatLeak
//
//  Created by 鄭岳弘 on 2017/1/20.
//  Copyright © 2017年 intowow. All rights reserved.
//

#import "ViewController.h"
#import <IWOWMoatMobileAppKit/IWOWMoatMobileAppKit.h>
@interface ViewController ()
@property (nonatomic, strong) IWOWMoatTracker *tracker;
@property (nonatomic, strong) UIView *displayView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"jpg"];

    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];

    self.displayView = [[UIImageView alloc] initWithImage:image];

    [self.view addSubview:self.displayView];
    self.view.backgroundColor = [UIColor grayColor];

    self.displayView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.displayView
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.displayView
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.displayView
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:2.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.displayView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.displayView
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:image.size.width/image.size.height
                                                              constant:0.0]
                                ]];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor whiteColor];
    self.label = label;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapButton:)];
    self.tap = tap;
    [label addGestureRecognizer:tap];

    [self.view addSubview:label];

    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:label
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:label
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.displayView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:80.0],
                                [NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:label
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:4.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:label
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:label
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:2
                                                              constant:0.0]
                                ]];

    [self stopTracker];
}

- (void)onTapButton:(UITapGestureRecognizer *)gesture
{
    if (self.tracker == nil){
        [self startTracker];
    } else {
        [self stopTracker];
    }
}

- (void)startTracker
{
    self.tracker = [IWOWMoatTracker trackerWithAdView:self.displayView
                                          partnerCode:@"intowownativedisplay919298090356"];
    [self.tracker trackAd:@{}];
    NSLog(@"tracker started, %@", self.tracker);
    self.label.text = @"started";
}

- (void)stopTracker
{
    [self.tracker stopTracking];
    NSLog(@"tracker stopped, %@", self.tracker);
    self.tracker = nil;
    self.label.text = @"stopped";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
