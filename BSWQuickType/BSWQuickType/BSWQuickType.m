//
//  BSWQuickType.m
//  BSWQuickType
//
//  Created by Zane Helton on 2/6/15.
//  Copyright (c) 2015 BisonSoftware. All rights reserved.
//

#import "BSWQuickType.h"

@implementation BSWQuickType {
	NSArray *_suggestionArray;
}
@synthesize delegate;

- (instancetype)init {
	if (self = [super init]) {
		
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame suggestionArray:(NSArray *)suggestionArray onTextField:(UITextField *)textField {
	self = [super initWithFrame:frame];
	_suggestionArray = suggestionArray;
	
	// displays all the buttons in the scroll view
	for (int i = 0; i < suggestionArray.count; i++) {
		UIButton *suggestionButton = [[UIButton alloc] initWithFrame:CGRectMake(i*frame.size.width/3,
																		  0,
																		  frame.size.width/3,
																		  frame.size.height)];
		[suggestionButton setTitle:suggestionArray[i] forState:UIControlStateNormal];
		[suggestionButton setBackgroundColor:[UIColor colorWithRed:173.0/255 green:180.0/255 blue:190.0/255 alpha:1]];
		[suggestionButton setTag:i];
		[suggestionButton addTarget:self
					   action:@selector(suggestionTapped:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:suggestionButton];
	}
	
	[textField setAutocorrectionType:UITextAutocorrectionTypeNo];
	return self;
}

- (void)drawRect:(CGRect)rect {
	[self setContentSize:CGSizeMake(rect.size.width, rect.size.height)];
	
	if (_quickTypeShouldScroll) {
		// makes the scroll view bigger so it can actually scroll
		[self setContentSize:CGSizeMake(_suggestionArray.count*rect.size.width/3, 44)];
	}
	
	if (_quickTypePagingEnabled) {
		[self setPagingEnabled:YES];
	}
	
	if (_quickTypeBouncingEnabled) {
		[self setBounces:YES];
	}
}

- (IBAction)suggestionTapped:(UIButton *)sender {
	[delegate quickType:self selectedButtonAtIndex:sender.tag];
}

@end
