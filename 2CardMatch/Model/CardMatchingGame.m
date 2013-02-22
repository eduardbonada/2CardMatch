//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Eduard on 1/30/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards; // array of Card
@property (nonatomic, readwrite) int score;

@property (strong, nonatomic, readwrite) NSMutableArray *lastMatch; // array of Card (the last matching cards)
@property (nonatomic, readwrite) int scoreLastMatch;

@end

@implementation CardMatchingGame

/*************************************************/
/*              setters & getters                */
/*************************************************/

-(NSMutableArray *) cards
{
    if(!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray *) lastMatch
{
    if(!_lastMatch) _lastMatch=[[NSMutableArray alloc] init];
    return _lastMatch;
}


/*************************************************/
/*                  initializer                  */
/*************************************************/
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *) deck
        matchingNcards:(int) n
{
    self = [super init];
    
    if(self){
        for(int i=0; i < count ; i++){
            Card *card = [deck drawRandomCard];
            if(!card){
                self=nil;
            }
            else{
                self.cards[i] = card;
            }
        }
    }
    
    self.matchingMode=n;

    return self;
}

/*************************************************/
/*                   interface                   */
/*************************************************/
#define MATCH_BONUS 8
#define MISMATCH_PENALTY 4
#define FLIP_COST 1
-(void)flippedCardAtIndex:(NSUInteger) index
{
    Card *card = [self cardAtIndex:index];

    // manage lastMatch array
    [self.lastMatch removeAllObjects];
    self.scoreLastMatch = self.score;
        
    if(!card.isUnplayable){
        
        if(!card.isFaceUp){
            
            if(self.matchingMode==2){ // 2-card matching
            
                [self.lastMatch addObject:card];
                
                for(Card *otherCard in self.cards){
                    if(otherCard.isFaceUp && !otherCard.isUnplayable){
                        int matchScore = [card match:@[otherCard]];
                        if(matchScore){
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                        }
                        else{
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                        }
                        
                        [self.lastMatch addObject:otherCard];
                        break;
                    }
                }
                self.scoreLastMatch = self.score - self.scoreLastMatch;
                self.score -= FLIP_COST;
            }
            else if(self.matchingMode==3){ // 3-card matching

                [self.lastMatch addObject:card];

                NSMutableArray *playedCards = [[NSMutableArray alloc] init];
                
                for (Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        [playedCards addObject:otherCard];
                        [self.lastMatch addObject:otherCard];
                    }
                }
                
                if ([playedCards count] == 0 || [playedCards count] == 1) {
                    // no cards to match yet...
                }
                else if ([playedCards count] == 2) { // matching 3 cards facing up
                    int matchScore = [card match:playedCards];
                    if (matchScore) {
                        card.unplayable = YES;
                        for (Card *otherCard in playedCards) {
                            otherCard.unplayable = YES;
                        }
                        self.score += matchScore * MATCH_BONUS;
                    }
                    else {
                        for (Card *otherCard in playedCards) {
                            otherCard.faceUp = NO;
                        }
                        self.score -= MISMATCH_PENALTY;
                    }
                }
                self.scoreLastMatch = self.score - self.scoreLastMatch;
                self.score -= FLIP_COST;
            }
        }
        card.faceUp = !card.isFaceUp;
    }
}

/*************************************************/
/*                   auxiliary                   */
/*************************************************/
-(Card *)cardAtIndex:(NSUInteger) index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

/*
 -(void)dealWithCardCount:(NSUInteger)count usingDeck:(Deck *) deck
{
    [self.cards removeAllObjects];

    for(int i=0; i < count ; i++){
        Card *card = [deck drawRandomCard];
        if(card){
            self.cards[i] = card;
        }
    }
    
    self.score = 0;

    self.scoreLastMatch = 0;
    [self.lastMatch removeAllObjects];
}
 */



@end
