//
//  BSWQuickType.h
//  BSWQuickType
//
//  Created by Zane Helton on 2/6/15.
//  Copyright (c) 2015 BisonSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSWQuickTypeDelegate;

@interface BSWQuickType : UIScrollView <UITextFieldDelegate> {
	__weak id <BSWQuickTypeDelegate> delegate;
}

#pragma mark - Configurations
@property (assign) BOOL quickTypeShouldScroll;
@property (assign) BOOL quickTypePagingEnabled;
@property (assign) BOOL quickTypeBouncingEnabled;
@property (assign) BOOL quickTypeFilter;
#pragma mark -

@property (nonatomic, strong) UITextField *textField;

@property (weak) id <BSWQuickTypeDelegate> delegate;

/**
 *  Initializes the InputAccessoryView that can be used later on your TextField.
 *
 *  @param frame           The frame in which you want the accessory view to be. Defaults to the size of QuickType.
 *  @param suggestionArray An array of words you want placed inside the QuickType bar.
 *  @param filter          Whether or not you want the words to adjust based on what the user types.
 *
 *  @return Returns a UIScrollView in which your can place in the InputAccessoryView of your TextField.
 */
- (instancetype)initWithFrame:(CGRect)frame
			  suggestionArray:(NSArray *)suggestionArray
			filterSuggestions:(BOOL)filter
				  onTextField:(UITextField *)textField;

- (void)hideQuickType;

- (void)showQuickType;

@end

@protocol BSWQuickTypeDelegate

@required
/**
 *  Called whenever a user taps one of the suggestions.
 *
 *  @param quickType    The QuickType object that sent the message.
 *  @param buttonIndex  The index in the suggestions array that was tapped.
 *  @param resultsArray Returns the array used in the QuickType view. If you are using the filter, you must use this array rather than your own.
 */
- (void)quickType:(BSWQuickType *)quickType selectedButtonAtIndex:(NSInteger)buttonIndex withArray:(NSArray *)resultsArray;

@end