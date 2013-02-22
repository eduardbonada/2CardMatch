//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Eduard on 2/20/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
