//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Eduard on 1/28/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipLabel;

@property (strong, nonatomic) CardMatchingGame *game;

@end


@implementation CardGameViewController

#pragma mark - setters and getters


#pragma mark - UI

- (void)updateUI
{   
    // update the cardButtons
    [self updateContentsOfCards];
    
    // update the scoreLabel
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    
    // update the lastFlipLabel
    if([[self stringForLastFlipResult] isKindOfClass:[NSString class]]){
        self.lastFlipLabel.text = [self stringForLastFlipResult];
    }
    else if([[self stringForLastFlipResult] isKindOfClass:[NSMutableAttributedString class]]){
        self.lastFlipLabel.attributedText = [self stringForLastFlipResult];
    }

}

-(void) updateContentsOfCards
{
    // abstract
}

-(id)stringForLastFlipResult
{
    // abstract
    return nil;
}

#pragma mark - actions

- (IBAction)flipCard:(UIButton *)sender
{
    [self updateUI];
}

- (IBAction)dealNewGame:(UIButton *)sender {
    self.game=nil;
    [self updateUI];
}

@end
