# BSWQuickType
Imitates the functionality of Apple's QuickType with the ability to fill in custom elements rather than suggested words.

`BSWQuickType` is a great way to suggest more relevant words to your users than Apple's QuickType will. This `UIScrollView` works by attaching to the top of the users keyboard and allowing them to tap the suggestions.

- Bison Software: http://www.bison.software/

![Demo](https://i.imgur.com/SxGWtcf.gif)

##Usage
###Import
First you're going to want to import the `BSWQuickType` files by adding the files to your project then adding an import statement to the top of your .h file like so:

`#import "BSWQuickType.h"`

###Delegate
You'll then want to conform your current class to the `BSWQuickTypeDelegate` by adding `<BSWQuickTypeDelegate>` to your .h file.

###Initialize
Now you'll be able to create a `BSWQuickType` object in your .m file. It's recommended you make your `BSWQuickType` object an instance variable in case you need to use it outside of the method it's being initialized in. To create your `BSWQuickType` object, use the following lines:

```objective-c
BSWQuickType *quickTypeView = [[BSWQuickType alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 36) suggestionArray:@[@"Text", @"For", @"You"] filterSuggestions:YES onTextField:_demoTextField];
```

This'll create a `BSWQuickType` view object automatically, and nothing else is required in order for it to work, although there are a few configurations.

##Configurations
- `quickTypeShouldScroll` - Should the user be able to scroll the suggestions. (BOOL)
- `quickTypePagingEnabled` - Should the scroll view have "pages" of suggestions when scrolling, or should it be continuous scrolling. (BOOL)
- `quickTypeBouncingEnabled` - Determines if the scroll view should bounce if the user goes too far to once side when scrolling. (BOOL)
- `quickTypeFilter` - Should the BSWQuickType filter through your suggestions and give the most relevant ones first. (BOOL)

##Protocols
```objective-c
- (void)quickType:(BSWQuickType *)quickType selectedButtonAtIndex:(NSInteger)buttonIndex withArray:(NSArray *)resultsArray;
```

This is the only protocol currently available in `BSWQuickType` and is called whenever a user taps a suggestion. The method allows the use of the current `BSWQuickType` object, the suggestion button's index, and finally the array used if filtering is enabled.

##Methods
```- (void)hideQuickType;```
Hides the QuickType view from the user.

```- (void)showQuickType;```
Shows the QuickType view to the user.

##TODO
- [x] Make it visually more similar to Apple's QuickType

##License
The MIT License (MIT)

Copyright (c) 2015 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
