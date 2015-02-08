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
	NSArray *_namesArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	_namesArray = @[@"Example", @"Text", @"For", @"You"];
	_exampleTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 200/2,
																	  55,
																	  200,
																	  40)];
	[_exampleTextField setBorderStyle:UITextBorderStyleRoundedRect];
	[_exampleTextField setPlaceholder:@"Start typing!"];
	[_exampleTextField setBackgroundColor:[UIColor lightGrayColor]];
	quickTypeView = [[BSWQuickType alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 36)
										suggestionArray:_namesArray
									  filterSuggestions:YES
											onTextField:_exampleTextField];
	quickTypeView.quickTypeShouldScroll = YES;
	quickTypeView.quickTypePagingEnabled = YES;
	quickTypeView.delegate = self;
	
	[_exampleTextField setDelegate:self];
	[self.view addSubview:_exampleTextField];
}

- (void)quickType:(BSWQuickType *)quickType selectedButtonAtIndex:(NSInteger)buttonIndex withArray:(NSArray *)resultsArray {
	[quickTypeView.textField insertText:resultsArray[buttonIndex]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.subtype == UIEventSubtypeMotionShake) {
		if (quickTypeView.hidden) {
			[quickTypeView showQuickType];
		} else {
			[quickTypeView hideQuickType];
		}
	}
	
	if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
		[super motionEnded:motion withEvent:event];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
