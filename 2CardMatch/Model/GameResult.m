//
//  GameResult.m
//  Matchismo
//
//  Created by Eduard on 2/21/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"


# pragma mark - class methods

+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}


# pragma mark - init

// convenience initializer
- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            if (!_start || !_end) self = nil;
        }
    }
    return self;
}

// designated initializer
- (id)init
{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}


#pragma mark - setters & getters

- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}


#pragma mark - data updating methods

- (void)synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    mutableGameResultsFromUserDefaults[[self.start description]] = @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score) };
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - sorting methods

- (NSComparisonResult)compareScoreToGameResult:(GameResult *)otherResult
{
    if (self.score > otherResult.score) {
        return NSOrderedAscending;
    } else if (self.score < otherResult.score) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

- (NSComparisonResult)compareEndDateToGameResult:(GameResult *)otherResult
{
    return [otherResult.end compare:self.end];
}

- (NSComparisonResult)compareDurationToGameResult:(GameResult *)otherResult
{
    if (self.duration > otherResult.duration) {
        return NSOrderedDescending;
    } else if (self.duration < otherResult.duration) {
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }
}

@end
