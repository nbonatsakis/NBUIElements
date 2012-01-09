//
//  ViewController.h
//  NBUIElements
//
//  Created by Nick Bonatsakis.
//  Copyright 2011 Atlantia Software LLC. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize swipeIndicator;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // set up pages
    self.swipeIndicator.numPages = 3;
    self.swipeIndicator.page = 0;
    
    // set up colors
    self.swipeIndicator.borderColor = [UIColor whiteColor];
    self.swipeIndicator.fillColor = [UIColor blueColor];
    
    // set up proportions
    self.swipeIndicator.barWidthPercent = 0.5f;
    self.swipeIndicator.arrowWidthPercent = 0.2f;
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(cyclePage) userInfo:nil repeats:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark Cycle Modes

- (void) cyclePage {
    if (self.swipeIndicator.page == 3) {
        self.swipeIndicator.page = 0;
    } else {
        self.swipeIndicator.page++;
    }
}

@end
