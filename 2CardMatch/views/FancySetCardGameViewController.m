//
//  FancySetCardGameViewController.m
//  Matchismo
//
//  Created by Eduard on 2/21/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import "FancySetCardGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardCollectionViewCell.h"

@interface FancySetCardGameViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int flipCount;
@property (nonatomic) NSInteger startingCardCount;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@end

@implementation FancySetCardGameViewController

/*************************************************/
/*               setters and getter              */
/*************************************************/

- (CardMatchingGame *) game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                  usingDeck:[[SetCardDeck alloc] init]
                                             matchingNcards:2]; // the deck is allocated on the fly - 2 cards by default
    }
    return _game;
}

-(NSInteger) startingCardCount
{
    return 12;
}

/*************************************************/
/*                      methods                  */
/*************************************************/

- (void)updateUI
{
    [super updateUI];
}

/* THIS METHODS ARE IN SET CARD VIEW CONTROLLER



- (IBAction)flipCard:(UIButton *)sender
{

}

-(id)stringForLastFlipResult
{

}

+(NSMutableAttributedString *)attributedStringDescriptionOfCard:(SetCard *)card
{
    
}

*/


/* THIS METHODS ARE IN FANCY MATCH CARD VIEW CONTROLLER
 
-(void) updateContentsOfCards
{
    
}

*/

-(void) updateContentsOfCards
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]){
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:NO];
    }
}

- (IBAction)flipCard:(UITapGestureRecognizer *)sender {
    CGPoint tapLocation = [sender locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath){
        [self.game flippedCardAtIndex:indexPath.item];
        self.flipCount++;
        
        UICollectionViewCell *cell = [self.cardCollectionView cellForItemAtIndexPath:indexPath];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:YES];
        
        [self updateUI];
    }

}

- (void) updateCell:(UICollectionViewCell *) cell
          usingCard:(Card *) card
            animate:(BOOL) animate
{
    //if(animate == NO){
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            setCardView.number = setCard.number;
            setCardView.symbol = setCard.symbol;
            setCardView.shading = setCard.shading;
            setCardView.color = setCard.color;
            setCardView.faceUp = setCard.isFaceUp;
            setCardView.alpha = setCard.isUnplayable ? 0.3 : 1.0;
        }
    }
    //}
    //else{
    //}

}



/*************************************************/
/*                protocol methods               */
/*************************************************/

- (NSInteger) collectionView:(UICollectionView *)collectionView
      numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView
                   cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animate:NO];
    return cell;
}


@end

