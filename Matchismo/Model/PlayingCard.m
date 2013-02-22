//
//  PlayingCard.m
//  Matchismo
//
//  Created by Eduard on 1/28/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

/*************************************************/
/*       implementations of superclass           */
/*************************************************/
-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [NSString stringWithFormat:@"%@%@", rankStrings[self.rank], self.suit];
}

-(int)match:(NSArray *) otherCards
{
    int score = 0;
    
    if(otherCards.count == 1){ // match calculation if it is a 2-card match
        id otherCard = [otherCards lastObject];
        if([otherCard isKindOfClass:[PlayingCard class]]){
            PlayingCard *otherPlayingCard = (PlayingCard *) otherCard;
            if([otherPlayingCard.suit isEqualToString:self.suit]){
                score=1; // see powerpoint for points calculation according to probabilities
            }
            else if(otherPlayingCard.rank == self.rank){
                score=4; // see powerpoint for points calculation according to probabilities
            } 
        }
    }
    else if (otherCards.count == 2) {  // 3 Cards Matching
        id otherCard1 = [otherCards objectAtIndex:0];
        id otherCard2 = [otherCards objectAtIndex:0];
        if([otherCard1 isKindOfClass:[PlayingCard class]] && [otherCard2 isKindOfClass:[PlayingCard class]]){
            PlayingCard *otherPlayingCard1 = (PlayingCard *) otherCard1;
            PlayingCard *otherPlayingCard2 = (PlayingCard *) otherCard2;
            if( [otherPlayingCard1.suit isEqualToString:self.suit] && [otherPlayingCard2.suit isEqualToString:self.suit] ){
                score = 5; // see powerpoint for points calculation according to probabilities
            } else if ( (otherPlayingCard1.rank == self.rank) && (otherPlayingCard2.rank == self.rank) ) {
                score = 100; // see powerpoint for points calculation according to probabilities
            }
        }
    }
    
    return score;
}


/*************************************************/
/*              setters & getters                */
/*************************************************/
@synthesize suit = _suit; /* when implementing the getter AND the setter you HAVE to synthesize manually */

-(void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

/*************************************************/
/*          utility class methods                */
/*************************************************/
+(NSArray *)validSuits
{
    return @[@"♠", @"♦", @"♥", @"♣"];
}
+(NSUInteger)maxRank {
    return [self rankStrings].count-1;
}
+(NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

@end
