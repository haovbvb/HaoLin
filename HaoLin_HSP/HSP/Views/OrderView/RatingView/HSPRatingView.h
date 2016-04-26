//
//  HSPRatingView.h
//  HaoLin
//
//  Created by PING on 14-9-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HSPRatingViewDelegate
-(void)ratingChanged:(float)newRating;
@end


@interface HSPRatingView : UIView {
	UIImageView *s1, *s2, *s3, *s4, *s5;
	UIImage *unselectedImage, *partlySelectedImage, *fullySelectedImage;
	id<HSPRatingViewDelegate> viewDelegate;
    
	float starRating, lastRating;
	float height, width; // of each image of the star!
}

@property (nonatomic, retain) UIImageView *s1;
@property (nonatomic, retain) UIImageView *s2;
@property (nonatomic, retain) UIImageView *s3;
@property (nonatomic, retain) UIImageView *s4;
@property (nonatomic, retain) UIImageView *s5;

-(void)setImagesDeselected:(NSString *)unselectedImage partlySelected:(NSString *)partlySelectedImage
			  fullSelected:(NSString *)fullSelectedImage andDelegate:(id<HSPRatingViewDelegate>)d;
-(void)displayRating:(float)rating;
-(float)rating;


@end
