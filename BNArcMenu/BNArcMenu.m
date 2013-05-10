//
//  BNArcMenu.m
//  BNArcMenuDemo
//
//  Created by Aaron Ritchie on 2013-05-08.
//  Copyright (c) 2013 Aaron Ritchie. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BNArcMenu.h"

@implementation BNArcMenu

@synthesize deletage   = _delegate;
@synthesize mainButton = _mainButton;
@synthesize menuItems  = _menuItems;
@synthesize radius     = _radius;
@synthesize arcLength;
@synthesize arcAngle;
@synthesize animationSpeed;
@synthesize bounceAmount;
@synthesize bounceSpeed;
@synthesize delayInterval;
@synthesize mainButtonRotate;
@synthesize mainButtonScale;
@synthesize mainButtonTranslate;
@synthesize mainButtonAnimationSpeed;
@synthesize mainButtonBounceAmount;
@synthesize mainButtonBounceSpeed;
@synthesize reverseExpand;
@synthesize reverseCollapse;
@synthesize expanded;
@synthesize animating;


#pragma mark - Object Lifecycle

- (id)init
{
    if (self = [super init])
        [self doesNotRecognizeSelector:_cmd];

    return nil;
}

- (id)initWithMenuItems:(NSArray *)menuItems
    mainButton:(UIButton *)mainButton
    delegate:(UIViewController *)delegate
{
    if (self = [super init])
    {
        self.deletage                 = delegate;
        self.menuItems                = menuItems;
        self.mainButton               = mainButton;
        self.radius                   = RADIUS;
        self.arcLength                = ARC_LENGTH;
        self.arcAngle                 = ARC_ANGLE;
        self.animationSpeed           = ANIMATION_SPEED;
        self.bounceAmount             = BOUNCE_AMOUNT;
        self.bounceSpeed              = BOUNCE_SPEED;
        self.delayInterval            = DELAY_INTERVAL;
        self.mainButtonRotate         = BUTTON_ROTATION_ANGLE;
        self.mainButtonScale          = BUTTON_SCALE;
        self.mainButtonTranslate      = BUTTON_TRANSLATE;
        self.mainButtonAnimationSpeed = ANIMATION_SPEED;
        self.mainButtonBounceAmount   = BOUNCE_AMOUNT;
        self.mainButtonBounceSpeed    = BOUNCE_SPEED;
        self.reverseExpand            = REVERSE_EXPAND;
        self.reverseCollapse          = REVERSE_COLLAPSE;
        expanded                      = NO;
        animating                     = NO;
        
        if (self.mainButton != nil)
        {
            for (UIView *view in self.menuItems)
            {
                view.hidden = YES;
                [self.deletage.view insertSubview:view belowSubview:self.mainButton];
            }
            
            [self.mainButton
                addTarget:self
                action:@selector(didPressMenuButton)
                forControlEvents:UIControlEventTouchUpInside
            ];
        }
    }
    return self;
}


#pragma mark - Instance Methods

- (void)expand
{
    animating = YES;
    
    float rotateBounce = (
        self.mainButtonBounceAmount * self.mainButtonRotate * M_PI / 180.0
    ) + self.mainButtonRotate * M_PI / 180.0;
    
    float scaleBounce;
    if (self.mainButtonScale > 1.0)
    {
        scaleBounce = (
            self.mainButtonBounceAmount * self.mainButtonScale
        ) + self.mainButtonScale;
    }
    else if (self.mainButtonScale < 1.0)
    {
        scaleBounce = fabsf((
            self.mainButtonBounceAmount * self.mainButtonScale
        ) - self.mainButtonScale);
    }
    else
    {
        scaleBounce = self.mainButtonScale;
    }
    
    float translateBounceX = (
        self.mainButtonBounceAmount * self.mainButtonTranslate.x
    ) + self.mainButtonTranslate.x;
    float translateBounceY = (
        self.mainButtonBounceAmount * self.mainButtonTranslate.y
    ) + self.mainButtonTranslate.y;
    
    [UIView
        animateWithDuration:self.mainButtonAnimationSpeed
        delay:0.0
        options:UIViewAnimationOptionCurveEaseIn
        animations:^
        {
            self.mainButton.transform = CGAffineTransformConcat(
                CGAffineTransformConcat(
                    CGAffineTransformMakeRotation(rotateBounce),
                    CGAffineTransformMakeScale(scaleBounce, scaleBounce)
                ),
                CGAffineTransformMakeTranslation(translateBounceX, translateBounceY)
            );
        }
        completion:^(BOOL finished)
        {
            [UIView
                animateWithDuration:self.mainButtonBounceSpeed
                animations:^
                {
                    self.mainButton.transform = CGAffineTransformConcat(
                        CGAffineTransformConcat(
                            CGAffineTransformMakeRotation(
                                self.mainButtonRotate * M_PI / 180.0
                            ),
                            CGAffineTransformMakeScale(
                                self.mainButtonScale,
                                self.mainButtonScale
                            )
                        ),
                        CGAffineTransformMakeTranslation(
                            self.mainButtonTranslate.x,
                            self.mainButtonTranslate.y
                        )
                    );
                }
            ];
        }
    ];
    
    for (UIView *view in self.menuItems)
    {
        view.center = self.mainButton.center;
        view.hidden = NO;
        
        int index = (!self.reverseExpand) ?
            self.menuItems.count - [self.menuItems indexOfObject:view] - 1 :
            [self.menuItems indexOfObject:view];
        
        CGFloat oneOverCount = self.menuItems.count <= 1 ? 1.0 : (1.0 / (self.menuItems.count - 1));
        CGFloat indexOverCount = index * oneOverCount;
        
        CGFloat rad = (indexOverCount * self.arcLength * M_PI / 180.0)
            - (M_PI * ((self.arcLength + (self.arcAngle * 2) - 180.0) / 360.0));
        
        CGAffineTransform rotation = CGAffineTransformMakeRotation(rad);
        CGFloat x = (self.radius + self.bounceAmount * self.radius) * rotation.a;
        CGFloat y = (self.radius + self.bounceAmount * self.radius) * rotation.c;
        CGPoint center = CGPointMake(view.center.x + x, view.center.y + y);
        
        [UIView
            animateWithDuration:self.animationSpeed
            delay:self.delayInterval * ((self.reverseExpand) ? indexOverCount : 1.0 - indexOverCount)
            options:UIViewAnimationOptionCurveEaseIn
            animations:^
            {
                view.center = center;
            } 
            completion:^(BOOL finished)
            {
                [UIView
                    animateWithDuration:self.bounceSpeed
                    animations:^{
                        CGFloat x = self.bounceAmount * self.radius * rotation.a;
                        CGFloat y = self.bounceAmount * self.radius * rotation.c;
                        CGPoint center = CGPointMake(view.center.x - x, view.center.y - y);
                        view.center = center;
                    }
                ];
                
                if (view == self.menuItems.lastObject)
                {
                    expanded = YES;
                    animating = NO;
                }
            }
        ];
    }
}

- (void)collapse
{
    animating = YES;
    
    float rotateBounce = (
        (
            self.mainButtonBounceAmount * self.mainButtonRotate * M_PI / 180.0
        ) - self.mainButtonRotate * M_PI / 180.0
    ) / 4;
    
    float scaleBounce;
    if (self.mainButtonScale < 1.0)
    {
        scaleBounce = 1.0 + (fabsf(
            (self.mainButtonBounceAmount * self.mainButtonScale
        ) - self.mainButtonScale) / 4);
    }
    else if (self.mainButtonScale > 1.0)
    {
        scaleBounce = 1.0 - (self.mainButtonBounceAmount * self.mainButtonScale / 4);
    }
    else
    {
        scaleBounce = self.mainButtonScale;
    }
    
    float translateBounceX = 0.0 - (self.mainButtonBounceAmount * self.mainButtonTranslate.x);
    float translateBounceY = 0.0 - (self.mainButtonBounceAmount * self.mainButtonTranslate.y);
    
    [UIView
        animateWithDuration:self.mainButtonAnimationSpeed
        delay:0.0
        options:UIViewAnimationOptionCurveEaseIn
        animations:^
        {
            self.mainButton.transform = CGAffineTransformConcat(
                CGAffineTransformConcat(
                    CGAffineTransformMakeRotation(rotateBounce),
                    CGAffineTransformMakeScale(scaleBounce, scaleBounce)
                ),
                CGAffineTransformMakeTranslation(translateBounceX, translateBounceY)
            );
        }
        completion:^(BOOL finished)
        {
            [UIView
                animateWithDuration:self.mainButtonBounceSpeed
                animations:^
                {
                    self.mainButton.transform = CGAffineTransformMakeRotation(0);
                }
            ];
        }
    ];
    
    for (UIView *view in self.menuItems)
    {
        int index = [self.menuItems indexOfObject:view];
        
        CGFloat oneOverCount = self.menuItems.count <= 1 ? 1.0 : (1.0 / (self.menuItems.count - 1));
        CGFloat indexOverCount = index * oneOverCount;
        
        CGFloat delay;
        if (!self.reverseExpand)
        {
            delay = self.delayInterval * (
                (!self.reverseCollapse) ? 1.0 - indexOverCount : indexOverCount
            );
        }
        else
        {
            delay = self.delayInterval * (
                (self.reverseCollapse) ? 1.0 - indexOverCount : indexOverCount
            );
        }
        
        [UIView
            animateWithDuration:self.animationSpeed
            delay:delay
            options:UIViewAnimationOptionCurveEaseIn
            animations:^
            {
                view.center = self.mainButton.center;
            } 
            completion:^(BOOL finished)
            {
                if (view == self.menuItems.lastObject)
                {
                    expanded = NO;
                    animating = NO;
                }
            }
        ];
    }
}

- (void)didPressMenuButton
{
    if (!self.animating)
    {
        if (!self.expanded) [self expand];
        else [self collapse];
    }
}

@end
