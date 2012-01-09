//
//  NBSwipeIndicatorView.h
//  NBUIElements
//
//  Created by Nick Bonatsakis.
//  Copyright 2011 Atlantia Software LLC. All rights reserved.
//

/*
 * Draws a combination of two arros to indicate whether a given view can be scrolled 
 * left, right, or either, based on a page number or direct control. This can be handy for 
 * UIScrollView subclasses where a page indicator is not appropriate or you are using fluid scrolling
 * and you want more than the flashing scroll bar indicator.
 */

#import <UIKit/UIKit.h>

typedef enum {
    NBSwipeIndicatorStateLeft,
    NBSwipeIndicatorStateRight,
    NBSwipeIndicatorStateBoth,
    NBSwipeIndicatorStateNone
} NBSwipeIndicatorState;

@interface NBSwipeIndicatorView : UIView

// dimensions and proportions
@property CGFloat barWidthPercent;
@property CGFloat arrowWidthPercent;
@property CGFloat spaceBetweenArrowsPercent;
@property CGFloat borderWidth;

// colors
@property (nonatomic, strong) UIColor* fillColor;
@property (nonatomic, strong) UIColor* borderColor;

// page configuration
@property (nonatomic) int page;
@property (nonatomic) int numPages;

- (void) refreshSubviews;
- (void) setState:(NBSwipeIndicatorState)state;
- (void) setLeftVisible:(BOOL)visible;
- (void) setRightVisible:(BOOL)visible;

@end
