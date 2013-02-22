//
//  FancyMatchCardGameViewController.m
//  Matchismo
//
//  Created by Eduard on 2/20/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "FancyMatchCardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardCollectionViewCell.h"
#import "GameResult.h"

@interface FancyMatchCardGameViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;

@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@property (nonatomic) NSInteger startingCardCount;

@end

@implementation FancyMatchCardGameViewController

#pragma mark - setters and getters

- (CardMatchingGame *) game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                            matchingNcards:2]; // the deck is allocated on the fly - 2 cards by default
    }
    return _game;
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

-(NSInteger) startingCardCount
{
    return 16;
}

#pragma mark - methods

- (void)updateUI
{
    [super updateUI];
}


-(void) updateContentsOfCards
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]){
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:NO];
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
    
    //return nil;
}

- (IBAction)flipCard:(UITapGestureRecognizer *)sender
{
    CGPoint tapLocation = [sender locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath){
        [self.game flippedCardAtIndex:indexPath.item];

        self.gameResult.score = self.game.score;
        
        UICollectionViewCell *cell = [self.cardCollectionView cellForItemAtIndexPath:indexPath];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:YES];
        
        [self updateUI];
    }
}

- (void) updateCell:(UICollectionViewCell *) cell
          usingCard:(Card *) card
            animate: (BOOL) animate
{
    if(animate == NO){
        if([cell isKindOfClass:[PlayingCardCollectionViewCell class]]){
            PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *) cell).playingCardView;
            if([card isKindOfClass:[PlayingCard class]]){
                PlayingCard *playingCard = (PlayingCard *) card;
                playingCardView.rank = playingCard.rank;
                playingCardView.suit = playingCard.suit;
                playingCardView.faceUp = playingCard.isFaceUp;
                playingCardView.alpha = playingCard.isUnplayable ? 0.4 : 1.0;
            }
        }
    }
    else{
        [UIView transitionWithView:cell
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            if([cell isKindOfClass:[PlayingCardCollectionViewCell class]]){
                                PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *) cell).playingCardView;
                                if([card isKindOfClass:[PlayingCard class]]){
                                    PlayingCard *playingCard = (PlayingCard *) card;
                                    playingCardView.rank = playingCard.rank;
                                    playingCardView.suit = playingCard.suit;
                                    playingCardView.faceUp = playingCard.isFaceUp;
                                    playingCardView.alpha = playingCard.isUnplayable ? 0.4 : 1.0;
                                }
                            }
                        }
                        completion:NULL];
    }

}

- (IBAction)dealNewGame:(UIButton *)sender {
    self.game=nil;
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]){
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:YES];
    }
    [self updateUI];
}

#pragma mark - protocol methods

- (NSInteger) collectionView:(UICollectionView *)collectionView
      numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView
                   cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animate:NO];
    return cell;
}


@end
