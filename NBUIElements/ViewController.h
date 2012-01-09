//
//  ViewController.h
//  NBUIElements
//
//  Created by Nick Bonatsakis.
//  Copyright 2011 Atlantia Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBSwipeIndicatorView.h"


@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet NBSwipeIndicatorView* swipeIndicator;

- (void) cyclePage;

@end
