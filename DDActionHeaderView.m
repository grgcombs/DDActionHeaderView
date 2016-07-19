//
//  DDActionHeaderView.m
//  Heavily modified by Greg Combs
//
//  DDActionHeaderView (Released under MIT License)
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
#import <QuartzCore/QuartzCore.h>

@interface DDActionHeaderView ()
@property(nonatomic, strong) UIView *actionPickerView;
@property(nonatomic, strong) CAGradientLayer *actionPickerGradientLayer;
- (void)handleActionPickerViewTap:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation DDActionHeaderView

#pragma mark -
#pragma mark View lifecycle

- (void)setup
{
    [super setup];
	_actionPickerView = [[UIView alloc] initWithFrame:CGRectZero];
	_actionPickerView.layer.cornerRadius = 15;
	_actionPickerView.layer.borderWidth = 1.5;
	_actionPickerView.layer.borderColor = [UIColor darkGrayColor].CGColor;
	_actionPickerView.clipsToBounds = YES;
	
	_actionPickerGradientLayer = [CAGradientLayer layer];
	_actionPickerGradientLayer.anchorPoint = CGPointZero;
	_actionPickerGradientLayer.position = CGPointZero;
	_actionPickerGradientLayer.startPoint = CGPointZero;
	_actionPickerGradientLayer.endPoint = CGPointMake(0, 1);
	_actionPickerGradientLayer.colors = @[(id)[UIColor grayColor].CGColor, (id)[UIColor darkGrayColor].CGColor];
	[_actionPickerView.layer addSublayer:_actionPickerGradientLayer];
	[self addSubview:_actionPickerView];
	
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionPickerViewTap:)];
	tapGesture.delegate = self;
	[_actionPickerView addGestureRecognizer:tapGesture];
}


static const CGFloat DDActionHeaderClosedWidth = 60;
static const CGFloat DDActionHeaderPickerHeight = 50;

- (void)layoutSubviews {
    const CGFloat offset = 10;
    const CGFloat twoOffsets = offset * 2;
    const CGFloat halfOffset = offset / 2;

    CGFloat closedWidth = DDActionHeaderClosedWidth;
    CGFloat pickerHeight = DDActionHeaderPickerHeight;
    CGFloat width = CGRectGetWidth(self.frame);

    self.titleLabel.frame = CGRectMake(offset, offset, width - (closedWidth+twoOffsets), (pickerHeight - halfOffset));
    self.actionPickerGradientLayer.bounds = CGRectMake(0, 0, width, pickerHeight);

	if (CGRectIsEmpty(self.actionPickerView.frame))
    {
		self.actionPickerView.frame = CGRectMake(width - (closedWidth+halfOffset), 7, closedWidth, pickerHeight);
	}
    else
    {
        __weak __typeof__(self) wSelf = self;
		[UIView animateWithDuration:0.2 animations:^ {
            __strong __typeof__(wSelf) sSelf = wSelf;

            CGFloat width = CGRectGetWidth(sSelf.frame);
            CGFloat closedWidth = DDActionHeaderClosedWidth;
            CGFloat pickerHeight = DDActionHeaderPickerHeight;

            if (sSelf.titleLabel.isHidden)
                sSelf.actionPickerView.frame = CGRectMake(offset, 7, width - (twoOffsets-halfOffset), pickerHeight);
            else
                sSelf.actionPickerView.frame = CGRectMake(width - (closedWidth + halfOffset), 7, closedWidth, pickerHeight);
        }];		
	}
}

- (void)shrinkActionPicker {
    self.titleLabel.hidden = NO;
    [self setNeedsLayout];
}

- (BOOL)isActionPickerExpanded {
	return (self.titleLabel.isHidden && self.actionPickerView.bounds.size.width != DDActionHeaderClosedWidth);
}

- (void)setItems:(NSArray *)newItems {
    if (_items == newItems)
        return;
    for (UIView *subview in self.actionPickerView.subviews) {
        [subview removeFromSuperview];
    }
    
    _items = [newItems copy];
    
    for (id item in _items) {
        if ([item isKindOfClass:[UIView class]]) {
            [self.actionPickerView addSubview:item];
        }
    }
}

#pragma mark -
#pragma mark UITapGestureRecognizer & UIGestureRecognizerDelegate

- (void)handleActionPickerViewTap:(UIGestureRecognizer *)gestureRecognizer {
    self.titleLabel.hidden = !self.titleLabel.isHidden;
    [self setNeedsLayout];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    for (UIView *subview in self.actionPickerView.subviews) {
        if (subview == touch.view && self.titleLabel.isHidden) {
            return NO;
        }
    }
    return YES;
}

@end
