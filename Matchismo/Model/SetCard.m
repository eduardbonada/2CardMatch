//
//  SetCard.m
//  Matchismo
//
//  Created by Eduard on 2/11/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

/*************************************************/
/*       implementations of superclass           */
/*************************************************/
-(NSString *)contents
{
    return [NSString stringWithFormat:@"(%d-%@-%@-%@)", self.number, self.color, self.shading, self.symbol];
}

-(int)match:(NSArray *) otherCards
{
    int score = 0;

    if (otherCards.count == 2) // in this game, only 3-cards match at a time
    {
        SetCard *c1 = self;
        SetCard *c2 = otherCards[0];
        SetCard *c3 = otherCards[1];
        
        // we have a set exactly if:
        if (
            (  // either there are three cards all of the same number:
             ((c1.number == c2.number) &&
              (c2.number == c3.number) &&
              (c1.number == c3.number))
             ||
             // or all three different numbers...
             ((c1.number != c2.number) &&
              (c2.number != c3.number) &&
              (c1.number != c3.number)
              )
             )
            &&   // AND as if that wasn't hard enough we must also have
            ( // either all three of the same symbol
             ([c1.symbol isEqualToString:c2.symbol] &&
              [c2.symbol isEqualToString:c2.symbol] &&
              [c3.symbol isEqualToString:c3.symbol])
             ||
             // or all three different symbols
             ((![c1.symbol isEqualToString:c2.symbol]) &&
              (![c2.symbol isEqualToString:c3.symbol]) &&
              (![c1.symbol isEqualToString:c3.symbol])
              )
             )
            &&  // AND ...
            ( // all same or all different shading
             ([c1.shading isEqualToString:c2.shading] &&
              [c2.shading isEqualToString:c3.shading] &&
              [c1.shading isEqualToString:c3.shading])
             ||
             ((![c1.shading isEqualToString:c2.shading]) &&
              (![c2.shading isEqualToString:c3.shading]) &&
              (![c1.shading isEqualToString:c3.shading])
              )
             )
            &&
            ( // AND all same or all different color!
             ([c1.color isEqualToString:c2.color] &&
              [c2.color isEqualToString:c3.color] &&
              [c1.color isEqualToString:c3.color])
             ||
             ((![c1.color isEqualToString:c2.color]) &&
              (![c2.color isEqualToString:c3.color]) &&
              (![c1.color isEqualToString:c3.color])
              )
             )
            ) score = 1;
    }

    return score;
}

/*************************************************/
/*              setters & getters                */
/*************************************************/
-(void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

-(void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

-(void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) _color = color;
}


/*************************************************/
/*          utility class methods                */
/*************************************************/
+(NSArray *)validSymbols
{
    static NSArray *validSymbols = nil;
    
    if (!validSymbols) {
        validSymbols = @[@"Diamond", @"Squiggle", @"Oval"];
    }
    return validSymbols;
}

+(NSArray *)validShadings
{
    static NSArray *validShadings = nil;
    
    if (!validShadings) {
        validShadings = @[@"Solid", @"Striped", @"Open"];
    }
    return validShadings;
}

+(NSArray *)validColors
{
    static NSArray *validColors = nil;
    
    if (!validColors) {
        validColors = @[@"Red", @"Green", @"Purple"];
    }
    
    return validColors;
}

@end
