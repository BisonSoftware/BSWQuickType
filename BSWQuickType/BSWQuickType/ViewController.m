//
//  ViewController.m
//  BSWQuickType
//
//  Created by Zane Helton on 2/6/15.
//  Copyright (c) 2015 BisonSoftware. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
	UITextField *_exampleTextField;
	BSWQuickType *quickTypeView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_exampleTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 120/2,
																	  55,
																	  120,
																	  42)];
	[_exampleTextField setBackgroundColor:[UIColor lightGrayColor]];
	quickTypeView = [[BSWQuickType alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)
													  suggestionArray:@[@"Some", @"Stuff", @"About", @"Words"]
														  onTextField:_exampleTextField];
	quickTypeView.quickTypeShouldScroll = YES;
	quickTypeView.quickTypePagingEnabled = YES;
	quickTypeView.delegate = self;
	
	[_exampleTextField setInputAccessoryView:quickTypeView];
	[self.view addSubview:_exampleTextField];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
