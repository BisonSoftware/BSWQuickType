# BSWQuickType
Imitates the functionality of Apple's QuickType with the ability to fill in custom elements rather than suggested words.

`BSWQuickType` is a great way to suggest more relevant words to your users than Apple's QuickType will. This `UIScrollView` works by attaching to the top of the users keyboard and allowing them to tap the suggestions.

- Bison Software: http://www.bisonsoftware.us/

![Demo](https://i.imgur.com/SxGWtcf.gif)

##Usage
First you're going to want to import the `BSWQuickType` files by adding the files to your project then adding an import statement to the top of your .h file like so:

`#import "BSWQuickType.h"`

You'll then want to conform your current class to the `BSWQuickTypeDelegate` by adding `<BSWQuickTypeDelegate>` to your .h file.

Now you'll be able to create a `BSWQuickType` object in your .m file. It's recommended you make your `BSWQuickType` object an instance variable in case you need to use it outside of the method it's being initialized in. To create your `BSWQuickType` object, use the following lines:

```BSWQuickType *quickTypeView = [[BSWQuickType alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 36) suggestionArray:@[@"Text", @"For", @"You"] filterSuggestions:YES onTextField:_demoTextField];```

This'll create a `BSWQuickType` view object automatically, and nothing else is required in order for it to work, although there are a few configurations.

##Configurations
- `quickTypeShouldScroll` - Should the user be able to scroll the suggestions. (BOOL)
- `quickTypePagingEnabled` - Should the scroll view have "pages" of suggestions when scrolling, or should it be continuous scrolling. (BOOL)
- `quickTypeBouncingEnabled` - Determines if the scroll view should bounce if the user goes too far to once side when scrolling. (BOOL)
- `quickTypeFilter` - Should the BSWQuickType filter through your suggestions and give the most relevant ones first. (BOOL)

##Protocols
```- (void)quickType:(BSWQuickType *)quickType selectedButtonAtIndex:(NSInteger)buttonIndex withArray:(NSArray *)resultsArray;```

This is the only protocol currently available in `BSWQuickType` and is called whenever a user taps a suggestion. The method allows the use of the current `BSWQuickType` object, the suggestion button's index, and finally the array used if filtering is enabled.

##Methods
```- (void)hideQuickType;```
Hides the QuickType view from the user.

```- (void)showQuickType;```
Shows the QuickType view to the user.
