//
//  BNArcMenu.h
//  BNArcMenuDemo
//
//  Created by Aaron Ritchie on 2013-05-08.
//  Copyright (c) 2013 Aaron Ritchie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RADIUS                100.0
#define ARC_LENGTH            90.0
#define ARC_ANGLE             0.0
#define ANIMATION_SPEED       0.2
#define BOUNCE_AMOUNT         0.2
#define BOUNCE_SPEED          0.2
#define DELAY_INTERVAL        0.2
#define BUTTON_ROTATION_ANGLE 45.0
#define BUTTON_SCALE          1.0
#define BUTTON_TRANSLATE      CGPointMake(0, 0)
#define REVERSE_EXPAND        NO
#define REVERSE_COLLAPSE      NO

@interface BNArcMenu : NSObject
{
    __weak UIViewController *_delegate;
    UIButton                *_mainButton;
    NSArray                 *_menuItems;
    CGFloat                 _radius;
    CGFloat                 arcLength;
    CGFloat                 arcAngle;
    CGFloat                 animationSpeed;
    CGFloat                 bounceAmount;
    CGFloat                 bounceSpeed;
    CGFloat                 delayInterval;
    CGFloat                 mainButtonRotate;
    CGFloat                 mainButtonScale;
    CGPoint                 mainButtonTranslate;
    CGFloat                 mainButtonAnimationSpeed;
    CGFloat                 mainButtonBounceAmount;
    CGFloat                 mainButtonBounceSpeed;
    BOOL                    reverseExpand;
    BOOL                    reverseCollapse;
    BOOL                    expanded;
    BOOL                    animating;
}

@property (weak)     UIViewController *deletage;
@property (strong)   UIButton         *mainButton;
@property (strong)   NSArray          *menuItems;
@property            CGFloat          radius;
@property            CGFloat          arcLength;
@property            CGFloat          arcAngle;
@property            CGFloat          animationSpeed;
@property            CGFloat          bounceAmount;
@property            CGFloat          bounceSpeed;
@property            CGFloat          delayInterval;
@property            CGFloat          mainButtonRotate;
@property            CGFloat          mainButtonScale;
@property            CGPoint          mainButtonTranslate;
@property            CGFloat          mainButtonAnimationSpeed;
@property            CGFloat          mainButtonBounceAmount;
@property            CGFloat          mainButtonBounceSpeed;
@property (assign)   BOOL             reverseExpand;
@property (assign)   BOOL             reverseCollapse;
@property (readonly) BOOL             expanded;
@property (readonly) BOOL             animating;


#pragma mark - Object Lifecycle

- (id)init;
- (id)initWithMenuItems:(NSArray *)menuItems
    mainButton:(UIButton *)mainButton
    delegate:(UIViewController *)delegate;


#pragma mark - Instance Methods

- (void)expand;
- (void)collapse;
- (void)didPressMenuButton;

@end