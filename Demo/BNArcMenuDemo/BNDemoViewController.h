//
//  BNDemoViewController.h
//  BNArcMenuDemo
//
//  Created by Aaron Ritchie on 2013-05-08.
//  Copyright (c) 2013 Aaron Ritchie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNArcMenu;

@interface BNDemoViewController : UIViewController
{
    UIButton *mainButtonTop;
    UIButton *mainButtonBottom;
    BNArcMenu *arcMenuTop;
    BNArcMenu *arcMenuBottom;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    UIButton *button5;
    UIButton *button6;
    UIButton *button7;
    UIButton *button8;
    UIButton *button9;
    UIButton *button10;
}

@property (nonatomic, strong) IBOutlet UIButton *mainButtonTop;
@property (nonatomic, strong) IBOutlet UIButton *mainButtonBottom;
@property (strong) BNArcMenu *arcMenuTop;
@property (strong) BNArcMenu *arcMenuBottom;


#pragma mark - Instance Methods

- (IBAction)didPressMenuItem:(id)sender;

@end
