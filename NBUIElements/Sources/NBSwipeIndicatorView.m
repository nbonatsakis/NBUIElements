//
//  NBSwipeIndicatorView.m
//  NBUIElements
//
//  Created by Nick Bonatsakis.
//  Copyright 2011 Atlantia Software LLC. All rights reserved.
//

#import "NBSwipeIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

typedef enum {
    ArrowDirectionLeft,
    ArrowDirectionRight
} ArrowDirection;

@interface ArrowView : UIView 
@property ArrowDirection direction; 
@property CGFloat barWidthPercent;
@property CGFloat arrowWidthPercent;
@property CGFloat borderWidth;
@property (nonatomic, strong) UIColor* fillColor;
@property (nonatomic, strong) UIColor* borderColor;

- (void) drawLeft;
- (void) drawRight;
- (void) applyColors:(UIBezierPath*)path;

@end

@implementation ArrowView

@synthesize direction;
@synthesize barWidthPercent;
@synthesize arrowWidthPercent;
@synthesize borderWidth;
@synthesize fillColor;
@synthesize borderColor;

- (void)drawRect:(CGRect)rect {
    if (self.direction == ArrowDirectionLeft) {
        [self drawLeft];
    } else {
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
    
    [path moveToPoint:CGPointMake   (0,                        bHeight / 2)];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           0)];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith,                   (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith,                   bHeight - ((bHeight - arrowBarWidth)/2) )];
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
    
    [path moveToPoint:   CGPointMake(0,                        (bHeight - arrowBarWidth)/2)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  0)];
    [path addLineToPoint:CGPointMake(bWdith,                   bHeight / 2)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(0,                        bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(0,                        (bHeight - arrowBarWidth)/2)];
    
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
    
@interface NBSwipeIndicatorView ()
@property (nonatomic, strong) ArrowView* leftArrowView;
@property (nonatomic, strong) ArrowView* rightArrowView;

- (void) initDefaults;
- (void) setArrow:(ArrowView*)arrowView visible:(BOOL)visible;
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
@synthesize leftArrowView;
@synthesize rightArrowView;

- (id)initWithFrame:(CGRect)frame {
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

- (void) layoutSubviews {
    [self refreshSubviews];
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

    self.leftArrowView = [[ArrowView alloc] init];
    self.rightArrowView = [[ArrowView alloc] init];
    
    self.leftArrowView.alpha = 0.0f;
    self.rightArrowView.alpha = 0.0f;
    
    [self addSubview:self.leftArrowView];
    [self addSubview:self.rightArrowView];
}

- (void) refreshSubviews {
    self.leftArrowView.barWidthPercent = self.barWidthPercent;
    self.leftArrowView.arrowWidthPercent = self.arrowWidthPercent;
    self.leftArrowView.fillColor = self.fillColor;
    self.leftArrowView.borderColor = self.borderColor;
    self.leftArrowView.borderWidth = self.borderWidth;
    self.leftArrowView.direction = ArrowDirectionLeft;
    self.leftArrowView.backgroundColor = [UIColor clearColor];
    [self.leftArrowView setNeedsDisplay];
    
    self.rightArrowView.barWidthPercent = self.barWidthPercent;
    self.rightArrowView.arrowWidthPercent = self.arrowWidthPercent;
    self.rightArrowView.fillColor = self.fillColor;
    self.rightArrowView.borderColor = self.borderColor;
    self.rightArrowView.borderWidth = self.borderWidth;
    self.rightArrowView.direction = ArrowDirectionRight;
    self.rightArrowView.backgroundColor = [UIColor clearColor];
    [self.rightArrowView setNeedsDisplay];
    
    CGFloat spaceBetween = self.bounds.size.width * self.spaceBetweenArrowsPercent;
    CGFloat arrowViewWidth = (self.bounds.size.width - spaceBetween) / 2;
    
    self.leftArrowView.frame = CGRectMake(0, 0, arrowViewWidth, self.bounds.size.height);
    self.rightArrowView.frame = CGRectMake(arrowViewWidth + spaceBetween, 0, arrowViewWidth, self.bounds.size.height);
}

- (void) setLeftVisible:(BOOL)visible {
    [self setArrow:self.leftArrowView visible:visible];
}

- (void) setRightVisible:(BOOL)visible {
    [self setArrow:self.rightArrowView visible:visible];
}

- (void) setArrow:(ArrowView*)arrowView visible:(BOOL)visible {
    if ((visible && arrowView.alpha == 1.0f) ||
        (!visible && arrowView.alpha == 0.0f)) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        if (visible) {
            arrowView.alpha = 1.0f;
        } else {
            arrowView.alpha = 0.0f;
        }
    }];
}

- (void) setPage:(int)p {
    page = p;
    
    if (self.numPages <= 1) {
        [self setState:NBSwipeIndicatorStateNone];
        return;
    }
    
    if (self.page == self.numPages - 1) {
        [self setState:NBSwipeIndicatorStateLeft];
    } else if (self.page == 0) {
        [self setState:NBSwipeIndicatorStateRight];
    } else {
        [self setState:NBSwipeIndicatorStateBoth];
    }
}

- (void) setState:(NBSwipeIndicatorState)state {
    if (state == NBSwipeIndicatorStateLeft) {
        [self setLeftVisible:YES];
        [self setRightVisible:NO];
    } else if (state == NBSwipeIndicatorStateRight) {
        [self setLeftVisible:NO];
        [self setRightVisible:YES];
    } else if (state == NBSwipeIndicatorStateBoth) {
        [self setLeftVisible:YES];
        [self setRightVisible:YES];
    } else {
        [self setLeftVisible:NO];
        [self setRightVisible:NO];
    }
}

@end
