//
//  PlayingCard.h
//  Matchismo
//
//  Created by Eduard on 1/28/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property(strong, nonatomic) NSString *suit; /* 'pal' */
@property(nonatomic) NSUInteger rank; /* number */

+(NSArray *) validSuits;
+(NSUInteger) maxRank;

@end
