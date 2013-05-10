//
//  BNDemoViewController.m
//  BNArcMenuDemo
//
//  Created by Aaron Ritchie on 2013-05-08.
//  Copyright (c) 2013 Aaron Ritchie. All rights reserved.
//

#import "BNDemoViewController.h"
#import "BNArcMenu.h"

@implementation BNDemoViewController

@synthesize mainButtonTop;
@synthesize mainButtonBottom;
@synthesize arcMenuTop;
@synthesize arcMenuBottom;


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    button1  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button2  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button3  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button4  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button5  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    button6  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button7  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button8  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button9  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button10 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [button1 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button2 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button3 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button4 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button5 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button6 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button7 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button8 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button9 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button10 setImage:[
        [UIImage alloc]
        initWithContentsOfFile:[
            [NSBundle mainBundle]
            pathForResource:@"menu-item"
            ofType:@"png"
        ]
    ] forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [button5 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [button6 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [button7 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [button8 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [button9 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [button10 addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *buttonsTop = @[button1, button2, button3, button4, button5];
    NSArray *buttonsBottom = @[button6, button7, button8, button9, button10];
    
    self.arcMenuTop = [
        [BNArcMenu alloc]
        initWithMenuItems:buttonsTop
        mainButton:self.mainButtonTop
        delegate:self
    ];
    
    self.arcMenuTop.radius = 120.0;
    self.arcMenuTop.arcAngle = 180.0;
    self.arcMenuTop.arcLength = 140.0;
    self.arcMenuTop.mainButtonRotate = 45.0;
    self.arcMenuTop.mainButtonScale = 1.1;
    self.arcMenuTop.animationSpeed = 0.5;
    self.arcMenuTop.delayInterval = 0.5;
    self.arcMenuTop.mainButtonAnimationSpeed = 0.75;
    self.arcMenuTop.reverseCollapse = YES;
    
    self.arcMenuBottom = [
        [BNArcMenu alloc]
        initWithMenuItems:buttonsBottom
        mainButton:self.mainButtonBottom
        delegate:self
    ];
    
    self.arcMenuBottom.radius = 80.0;
    self.arcMenuBottom.arcLength = 140.0;
    self.arcMenuBottom.mainButtonRotate = 45.0;
    self.arcMenuBottom.mainButtonScale = 1.1;
    self.arcMenuBottom.reverseCollapse = YES;
}


#pragma mark - Instance Methods

- (IBAction)didPressMenuItem:(id)sender
{
    if (self.arcMenuTop.expanded)
        [self.arcMenuTop collapse];
    
    if (self.arcMenuBottom.expanded)
        [self.arcMenuBottom collapse];
}

@end