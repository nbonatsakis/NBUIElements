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
- (void) drawBoth;
- (void) drawRight;
- (void) applyColors:(UIBezierPath*)path;
@end

@implementation NBSwipeIndicatorView

@synthesize barWidthPercent;
@synthesize arrowWidthPercent;
@synthesize spaceBetweenArrowsPercent;
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
#define kDefaultSpaceBetweenPercent 50.0f

- (void) initDefaults {
    self.arrowWidthPercent = kDefaultArrowWidthPercent;
    self.barWidthPercent = kDefaultBarWidth;
    self.spaceBetweenArrowsPercent = kDefaultSpaceBetweenPercent;
    self.fillColor = [UIColor blueColor];
}

- (void) layoutSubviews {
}

- (void)drawRect:(CGRect)rect {
    if (self.page == self.numPages - 1) {
        [self drawLeft];
    } else if (self.page == 0) {
        [self drawRight];
    } else {
        [self drawBoth];
    }
}

- (void) drawBoth {
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    
    CGFloat bWdith = self.bounds.size.width;
    CGFloat bHeight = self.bounds.size.height;
    CGFloat arrowHeadWidth = bWdith * self.arrowWidthPercent;
    CGFloat arrowBarWidth = bHeight * self.barWidthPercent;
    
    [path moveToPoint:CGPointMake   (0,                        bHeight / 2)];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           0)];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  0)];
    [path addLineToPoint:CGPointMake(bWdith,                   bHeight / 2)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           bHeight)];
    [path addLineToPoint:CGPointMake(0,                        bHeight/2)];

    [self applyColors:path];
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
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight - ((bHeight - arrowBarWidth)/2) )];
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

    
    [path moveToPoint:CGPointMake(arrowHeadWidth,              0)];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  (bHeight - arrowBarWidth)/2 )];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  0)];
    [path addLineToPoint:CGPointMake(bWdith,                   bHeight / 2)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight)];
    [path addLineToPoint:CGPointMake(bWdith - arrowHeadWidth,  bHeight - ((bHeight - arrowBarWidth)/2) )];
    [path addLineToPoint:CGPointMake(arrowHeadWidth,           bHeight - ((bHeight - arrowBarWidth)/2) )];
    
    [self applyColors:path];
}


- (void) applyColors:(UIBezierPath*)path {
    if (self.borderColor) {
        [path setLineWidth:3.0f];
        [self.borderColor setStroke];
        [path stroke];
    }
    
    [self.fillColor setFill];
    [path fill];
}

//- (void) awakeFromNib {
//    [self performSelector:@selector(doGradient) withObject:nil afterDelay:1.0];
//}
//
//+ (Class)layerClass { 
//    return [CAGradientLayer class];
//}
//
//- (void) doGradient {
//    CAGradientLayer* gLayer = (CAGradientLayer*) self.layer;
//    
//    UIColor* color1 = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
//    UIColor* color2 = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f];
//    UIColor* color3 = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f];
//    
//    gLayer.colors = [NSArray arrayWithObjects:(id)[color1 CGColor],
//                     [color2 CGColor], [color3 CGColor], nil];
//    gLayer.startPoint = CGPointMake(0.0, 0.5);
//    gLayer.endPoint = CGPointMake(1.0, 0.5);
//    
////    [self.layer addSublayer:gLayer];
////    gLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//}

@end
