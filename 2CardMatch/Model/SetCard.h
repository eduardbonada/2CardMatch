//
//  SetCard.h
//  Matchismo
//
//  Created by Eduard on 2/11/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger  number;
@property (nonatomic) NSString   *symbol;
@property (nonatomic) NSString   *shading;
@property (nonatomic) NSString   *color;

+(NSArray *)validSymbols;
+(NSArray *)validShadings;
+(NSArray *)validColors;

@end
