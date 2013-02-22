//
//  MatchCardGameViewController.m
//  Matchismo
//
//  Created by Eduard on 2/20/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "MatchCardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface MatchCardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation MatchCardGameViewController

/*************************************************/
/*               setters and getter              */
/*************************************************/

- (CardMatchingGame *) game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                             matchingNcards:2]; // the deck is allocated on the fly - 2 cards by default
    }
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

/*************************************************/
/*                      methods                  */
/*************************************************/

- (void)updateUI
{
    [super updateUI];
}

-(void) updateContentsOfCards
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.5 : 1.0;
        
        if (card.isFaceUp) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        }
    }
}

-(id)stringForLastFlipResult
{
    
    NSString *lastFlipResultString = [NSString stringWithFormat:@""];
    
    if(self.game.lastMatch.count == 0){ // empty string, no cards flipped
        lastFlipResultString = [NSString stringWithFormat:@"Flip one card"];
    }
    else if(self.game.lastMatch.count == 1){ // 1 element string, one card flipped
        lastFlipResultString = [NSString stringWithFormat:@"Flipped %@",[[self.game.lastMatch lastObject] contents]];
    }
    else if(self.game.lastMatch.count == 2){ // 2 element string, two cards flipped
        if(self.game.scoreLastMatch > 0){
            lastFlipResultString = [NSString stringWithFormat:@"Matched %@-%@ for %d points",[[self.game.lastMatch objectAtIndex:0] contents],[[self.game.lastMatch objectAtIndex:1] contents], self.game.scoreLastMatch];
        }
        else if (self.game.scoreLastMatch < 0){
            lastFlipResultString = [NSString stringWithFormat:@"%@-%@ don't match. %d penalty!",[[self.game.lastMatch objectAtIndex:0] contents],[[self.game.lastMatch objectAtIndex:1] contents], self.game.scoreLastMatch];
        }
    }
    return lastFlipResultString;
    
    return nil;
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flippedCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [super flipCard:sender];
}

@end
