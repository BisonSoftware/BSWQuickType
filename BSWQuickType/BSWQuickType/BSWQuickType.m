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
	NSArray *_contents;
	NSArray *_searchResults;
	CGRect _frame;
}
@synthesize delegate;

#pragma mark - Initializer / Dealloc
- (instancetype)initWithFrame:(CGRect)frame
			  suggestionArray:(NSArray *)suggestionArray
			filterSuggestions:(BOOL)filter
				  onTextField:(UITextField *)textField {
	self = [super initWithFrame:frame];
	// change this if you need a different background color (only seen if bounce is enabled)
	[self setBackgroundColor:[UIColor clearColor]];
	
	_suggestionArray = suggestionArray;
	_textField = textField;
	_frame = frame;
	_quickTypeFilter = filter;
	_searchResults = _suggestionArray;
	
	[self updateQuickTypeWithContents:suggestionArray frame:frame];
	
	[_textField addTarget:self
				   action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	
	[textField setInputAccessoryView:self];
	[textField setAutocorrectionType:UITextAutocorrectionTypeNo];
	return self;
}

- (void)dealloc {
	[_textField removeTarget:self
					  action:@selector(textFieldDidChange:)
			forControlEvents:UIControlEventEditingChanged];
}
#pragma mark -

#pragma mark - Do'er methods
- (void)drawRect:(CGRect)rect {
	[self setContentSize:CGSizeMake(rect.size.width, rect.size.height)];
	
	if (_quickTypeShouldScroll) {
		// makes the scroll view bigger so it can actually scroll
		[self setContentSize:CGSizeMake(_contents.count*rect.size.width/3, self.frame.size.height)];
	}
	
	if (_quickTypePagingEnabled) {
		[self setPagingEnabled:YES];
	}
	
	if (_quickTypeBouncingEnabled) {
		[self setBounces:YES];
	}
}

- (IBAction)suggestionTapped:(UIButton *)sender {
	[delegate quickType:self selectedButtonAtIndex:sender.tag withArray:_searchResults];
}

- (void)textFieldDidChange:(UITextField *)sender {
	NSArray *tempArray = _suggestionArray;
	NSString *searchString = sender.text;
	
	NSPredicate *searchSearch = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", searchString];
	NSArray *searchResults = [tempArray filteredArrayUsingPredicate:searchSearch];
	
	if (searchResults.count == 0 || !_quickTypeFilter) {
		_searchResults = _suggestionArray;
		[self updateQuickTypeWithContents:_suggestionArray frame:_frame];
	} else {
		_searchResults = searchResults;
		[self updateQuickTypeWithContents:searchResults frame:_frame];
	}
}

- (void)updateQuickTypeWithContents:(NSArray *)contents frame:(CGRect)frame {
	_contents = contents;
	[self drawRect:frame];
	[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	// displays all the buttons in the scroll view
	for (int i = 0; i < contents.count; i++) {
		CALayer *borderLeft = [CALayer layer];
		borderLeft.frame = CGRectMake(0, 0, 0.5, frame.size.height);
		[borderLeft setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5].CGColor];
		CALayer *borderRight = [CALayer layer];
		borderRight.frame = CGRectMake(0, 0, 0.5, frame.size.height);
		[borderRight setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5].CGColor];
		
		UIButton *suggestionButton = [[UIButton alloc] initWithFrame:CGRectMake(i*frame.size.width/3,
																		  0,
																		  frame.size.width/3,
																		  frame.size.height)];
		[suggestionButton setTitle:contents[i] forState:UIControlStateNormal];
		
		// styling
		[suggestionButton setBackgroundImage:[self setColor:[UIColor colorWithRed:173.0/255 green:180.0/255 blue:190.0/255 alpha:1]]
									forState:UIControlStateNormal];
		[suggestionButton setBackgroundImage:[self setColor:[UIColor colorWithRed:235.0/255 green:237.0/255 blue:239.0/255 alpha:1]]
									forState:UIControlStateHighlighted];
		[suggestionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[suggestionButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
		
		[suggestionButton setTag:i];
		[suggestionButton setClipsToBounds:YES];
		[suggestionButton.layer addSublayer:borderLeft];
		[suggestionButton.layer addSublayer:borderRight];
		[suggestionButton addTarget:self
					   action:@selector(suggestionTapped:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:suggestionButton];
	}
}

- (void)hideQuickType {
	[self setHidden:YES];
}

- (void)showQuickType {
	[self setHidden:NO];
}
#pragma mark -

#pragma mark - Helper methods
- (UIImage *)setColor:(UIColor *)color
{
	UIView *colorView = [[UIView alloc] initWithFrame:self.frame];
	colorView.backgroundColor = color;
	
	UIGraphicsBeginImageContext(colorView.bounds.size);
	[colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
	
	UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return colorImage;
}
#pragma -

@end
