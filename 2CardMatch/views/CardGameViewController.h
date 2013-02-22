//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Eduard on 1/28/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardGameViewController : UIViewController
- (void)updateUI;
- (IBAction)flipCard:(UIButton *)sender;
- (void) updateContentsOfCards; //abstract
- (id)stringForLastFlipResult; //abstract
- (IBAction)dealNewGame:(UIButton *)sender;

@end
