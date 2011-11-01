//
//  NBSwipeIndicatorView.h
//  NBUIElements
//
//  Created by nbonatsakis on 9/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBSwipeIndicatorView : UIView
@property CGFloat barWidthPercent;
@property CGFloat arrowWidthPercent;
@property CGFloat spaceBetweenArrowsPercent;
@property (nonatomic, strong) UIColor* fillColor;
@property (nonatomic, strong) UIColor* borderColor;
@property int page;
@property int numPages;

@end
