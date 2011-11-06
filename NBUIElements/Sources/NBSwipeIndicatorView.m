//
//  NBSwipeIndicatorView.m
//  NBUIElements
//
//  Created by nbonatsakis on 9/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NBSwipeIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

@interface NBSwipeIndicatorView ()
- (void) initDefaults;
- (void) drawLeft;
- (void) drawRight;
- (void) applyColors:(UIBezierPath*)path;
@end

@implementation NBSwipeIndicatorView

@synthesize barWidthPercent;
@synthesize arrowWidthPercent;
@synthesize spaceBetweenArrowsPercent;
@synthesize borderWidth;
@synthesize fillColor;
@synthesize borderColor;
@synthesize page;
@synthesize numPages;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initDefaults];
    }
    return self;
}

#define kDefaultArrowWidthPercent 0.1f
#define kDefaultBarWidth 0.6f
#define kDefaultSpaceBetweenPercent 0.5f

- (void) initDefaults {
    self.arrowWidthPercent = kDefaultArrowWidthPercent;
    self.barWidthPercent = kDefaultBarWidth;
    self.spaceBetweenArrowsPercent = kDefaultSpaceBetweenPercent;
    self.fillColor = [UIColor blueColor];
    self.borderWidth = 1.0f;
}

- (void) layoutSubviews {
}

- (void)drawRect:(CGRect)rect {
    if (self.numPages == 1) {
        return;
    }
    
    if (self.page == self.numPages - 1) {
        [self drawLeft];
    } else if (self.page == 0) {
        [self drawRight];
    } else {
        [self drawLeft];
        [self drawRight];
    }
}

- (void) drawLeft {
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    
    CGFloat bWdith = self.bounds.size.width;
    CGFloat bHeight = self.bounds.size.height;
    CGFloat arrowHeadWidth = bWdith * self.arrowWidthPercent;
    CGFloat arrowBarWidth = bHeight * self.barWidthPercent;
    
    CGFloat emptySpace = bWdith * self.spaceBetweenArrowsPercent;
    CGFloat rightEndX = (bWdith - (emptySpace)) / 2;
    
    [path moveToPoint:CGPointMake   (0,                        bHeight / 2)];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           0)];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(rightEndX,  (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(rightEndX,  bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           bHeight)];
    [path addLineToPoint:CGPointMake(0,                        bHeight/2)];
    
    [self applyColors:path];
}

- (void) drawRight {
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    
    CGFloat bWdith = self.bounds.size.width;
    CGFloat bHeight = self.bounds.size.height;
    CGFloat arrowHeadWidth = bWdith * self.arrowWidthPercent;
    CGFloat arrowBarWidth = bHeight * self.barWidthPercent;
    
    CGFloat emptySpace = bWdith * self.spaceBetweenArrowsPercent;
    CGFloat leftStartX = emptySpace + ((bWdith - (emptySpace)) / 2);
    
    [path moveToPoint:   CGPointMake(leftStartX,               (bHeight - arrowBarWidth)/2)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  0)];
    [path addLineToPoint:CGPointMake(bWdith,                   bHeight / 2)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(leftStartX,               bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(leftStartX,               (bHeight - arrowBarWidth)/2)];
    
    [self applyColors:path];
}


- (void) applyColors:(UIBezierPath*)path {
    if (self.borderColor && self.borderWidth > 0) {
        [path setLineWidth:self.borderWidth];
        [self.borderColor setStroke];
        [path stroke];
    }
    
    [self.fillColor setFill];
    [path fill];
}

@end
