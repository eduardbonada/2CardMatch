//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Eduard on 2/18/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

-(void)pinch: (UIPinchGestureRecognizer *)gesture;

@end
