//
//  BSWQuickType.h
//  BSWQuickType
//
//  Created by Zane Helton on 2/6/15.
//  Copyright (c) 2015 BisonSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSWQuickTypeDelegate;

@interface BSWQuickType : UIScrollView {
	__weak id <BSWQuickTypeDelegate> delegate;
}

#pragma mark - Configurations
@property (assign) BOOL quickTypeShouldScroll;
@property (assign) BOOL quickTypePagingEnabled;
@property (assign) BOOL quickTypeBouncingEnabled;
@property (nonatomic, strong) UIColor *backgroundColor;
#pragma mark -

@property (weak) id <BSWQuickTypeDelegate> delegate;

/**
 *  Initializes the QuickType frame with a list of suggestions. The textField parameter is to make your life easieri as the programmer.
 *
 *  @param frame      A CGRect determining the frame of the QuickType view. (optional)
 *  @param suggestion An array containing the results you'd like to display in QuickType. (required)
 *  @param textField  The TextField you'd like to add the QuickType view to. (required)
 *
 *  @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame suggestionArray:(NSArray *)suggestion onTextField:(UITextField *)textField;

@end

@protocol BSWQuickTypeDelegate

/**
 *  Called whenever a user taps one of the suggestions.
 *
 *  @param quickType   The QuickType object that sent the message.
 *  @param buttonIndex The index in the suggestions array that was tapped.
 */
- (void)quickType:(BSWQuickType *)quickType selectedButtonAtIndex:(NSInteger)buttonIndex;

@end