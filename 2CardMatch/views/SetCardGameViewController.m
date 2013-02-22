//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Eduard on 2/11/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface CardGameViewController()
-(void)updateUI;
@end

@interface SetCardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation SetCardGameViewController

/*************************************************/
/*               setters and getter              */
/*************************************************/

- (CardMatchingGame *) game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[SetCardDeck alloc] init]
                                             matchingNcards:3]; // the deck is allocated on the fly - 3 cards by default
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

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flippedCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [super flipCard:sender];
}

-(void) updateContentsOfCards
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        if ([card isKindOfClass:[SetCard class]]){
            [cardButton setAttributedTitle:[SetCardGameViewController attributedStringDescriptionOfCard:(SetCard *) card] forState:UIControlStateSelected];
            [cardButton setAttributedTitle:[SetCardGameViewController attributedStringDescriptionOfCard:(SetCard *) card] forState:UIControlStateNormal];
        }
                
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.1 : 1.0;
        
        cardButton.backgroundColor = cardButton.isSelected ? [UIColor grayColor]:[UIColor whiteColor];
    }
}

-(id)stringForLastFlipResult
{
    NSMutableAttributedString *lastFlipResultAttributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    NSString *lastFlipResultString = [NSString stringWithFormat:@""];
    
    if(self.game.lastMatch.count == 0 || self.game.lastMatch.count == 1 || self.game.lastMatch.count == 2){
        lastFlipResultString = [NSString stringWithFormat:@"Select 3 matching cards."];
        lastFlipResultAttributedString = [[NSMutableAttributedString alloc] initWithString:lastFlipResultString];
    }
    else if(self.game.lastMatch.count == 3){
        
        [lastFlipResultAttributedString appendAttributedString:[SetCardGameViewController attributedStringDescriptionOfCard:(SetCard *) self.game.lastMatch[0]]];
        [lastFlipResultAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"-"]];
        [lastFlipResultAttributedString appendAttributedString:[SetCardGameViewController attributedStringDescriptionOfCard:(SetCard *) self.game.lastMatch[1]]];
        [lastFlipResultAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"-"]];
        [lastFlipResultAttributedString appendAttributedString:[SetCardGameViewController attributedStringDescriptionOfCard:(SetCard *) self.game.lastMatch[2]]];

        if(self.game.scoreLastMatch > 0){
            [lastFlipResultAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" match! (%dp)", self.game.scoreLastMatch]]];
        }
        else if (self.game.scoreLastMatch < 0){
            [lastFlipResultAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" do not match! (%dp)", self.game.scoreLastMatch]]];
        }
    }
    
    return lastFlipResultAttributedString;
}


+(NSMutableAttributedString *)attributedStringDescriptionOfCard:(SetCard *)card
{
    NSString *symbolString;  // the plain text string we will attribute for the card.symbol
    if ([card.symbol isEqualToString:@"Diamond"]){
        symbolString=@"▲";
    }
    else if ([card.symbol isEqualToString:@"Squiggle"]){
        symbolString=@"■";
    }
    else if ([card.symbol isEqualToString:@"Oval"]){
        symbolString=@"●";
    }
    
    // repeat the symbol 1, 2 or 3 times - for the card.number
    symbolString = [symbolString stringByPaddingToLength:card.number withString:symbolString startingAtIndex:0];
    
    NSMutableAttributedString *fancyString = [[NSMutableAttributedString alloc] initWithString:symbolString];
    
    NSRange wholeThing = NSMakeRange(0, [symbolString length]);
    
    // set the color according to card.color
    UIColor *color;
    if ([card.color isEqualToString:@"Red"]){
        color = [UIColor redColor];
    }
    else if ([card.color isEqualToString:@"Green"]){
        color = [UIColor greenColor];
    }
    else if ([card.color isEqualToString:@"Purple"]){
        color = [UIColor purpleColor];
    }
    
    // and the alpha according to card.shading
    if ([card.shading isEqualToString:@"Solid"]){
        color = [color colorWithAlphaComponent:1.0f];
        [fancyString addAttribute:NSForegroundColorAttributeName value:color range:wholeThing];
    }
    else if ([card.shading isEqualToString:@"Striped"]){
        color = [color colorWithAlphaComponent:0.4f];
        [fancyString addAttribute:NSForegroundColorAttributeName value:color range:wholeThing];
    }
    else if ([card.shading isEqualToString:@"Open"]){
        [fancyString addAttribute:NSForegroundColorAttributeName value:[color colorWithAlphaComponent:0.02f] range:wholeThing];
        [fancyString addAttribute:NSStrokeColorAttributeName value:color range:wholeThing];
        [fancyString addAttribute:NSStrokeWidthAttributeName value:@5.0f range:wholeThing];
    }
    
    return fancyString;
}

@end
