//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Eduard on 1/30/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated inititalizer
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *) deck
        matchingNcards:(int) n;

-(void)flippedCardAtIndex:(NSUInteger) index;

-(Card *)cardAtIndex:(NSUInteger) index;

/*
 -(void)dealWithCardCount:(NSUInteger)count
           usingDeck:(Deck *) deck;
*/

@property (nonatomic, readonly) int score;
@property (strong, nonatomic, readonly) NSMutableArray *lastMatch; 
@property (nonatomic, readonly) int scoreLastMatch;

@property (nonatomic, readwrite) int matchingMode; // 2=>2 cards - 3=>3 cards

@end
