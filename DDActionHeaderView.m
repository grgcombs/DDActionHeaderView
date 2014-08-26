//
//  DDActionHeaderView.m
//  DDActionHeaderView (Released under MIT License)
//
//  Created by digdog on 10/5/10.
//  Copyright (c) 2010 Ching-Lan 'digdog' HUANG.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  

#import "DDActionHeaderView.h"
#import "TexLegeTheme.h"

@interface DDActionHeaderView ()
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UIView *actionPickerView;
@end

@implementation DDActionHeaderView

#pragma mark -
#pragma mark View lifecycle

// For creating programmatically
- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 65.f)])) {
		[self setup];		
	}
	return self;
}

// For using in IB
- (id)initWithCoder:(NSCoder *)coder {
    if ((self = [super initWithCoder:coder])) {
		[self setup];
    }
    return self;
} 

- (void)setup {
	self.opaque = YES;
    UIColor *background = [UIColor colorWithRed:200.0/255.0 green:207.0/255.0 blue:212.0/255.0 alpha:1];
    self.backgroundColor = background;

	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_titleLabel.font = [TexLegeTheme boldEighteen];
	_titleLabel.numberOfLines = 1;
	_titleLabel.backgroundColor = background;
	_titleLabel.textColor = [TexLegeTheme textDark];
	_titleLabel.opaque = YES;
	[self addSubview:_titleLabel];

    _actionPickerView = [[UIView alloc] initWithFrame:CGRectZero];
    _actionPickerView.backgroundColor = background;
	_actionPickerView.layer.cornerRadius = 25.0f;
	_actionPickerView.clipsToBounds = YES;
    _actionPickerView.opaque = YES;
	[self addSubview:_actionPickerView];
}

- (void)dealloc {
    nice_release(_titleLabel);
    nice_release(_items);
    nice_release(_actionPickerView);
    [super dealloc];
}

#pragma mark Layout & Redraw

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.titleLabel.frame = CGRectMake(12.0f, 10.0f, self.frame.size.width - 70.0f, 45.0f);
    self.actionPickerView.frame = CGRectMake(self.frame.size.width - 60.0f, 7.0f, 50.0f, 50.0f);
}

#pragma mark Accessors

- (void)setItems:(NSArray *)newItems {
    if (_items != newItems) {
        for (UIView *subview in self.actionPickerView.subviews) {
            [subview removeFromSuperview];
        }
        
        [_items release];
        _items = [newItems copy];
        
        for (id item in _items) {
			if ([item isKindOfClass:[UIView class]]) {
				[self.actionPickerView addSubview:item];
			}
        }
    }
}

@end
