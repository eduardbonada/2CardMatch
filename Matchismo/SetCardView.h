//
//  SetCardView.h
//  Matchismo
//
//  Created by Eduard on 2/21/13.
//  Copyright (c) 2013 ebc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

@property (nonatomic) BOOL faceUp;

@end
