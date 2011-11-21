//  TitleBarView.m
//  Reconstituted by Greg Combs on 11/17/11.
//     Originates from digdog's DDActionHeaderView, MIT License, https://github.com/digdog/DDActionHeaderView
//
//  OpenStates by Sunlight Foundation, based on work at https://github.com/sunlightlabs/StatesLege
//
//  This work is licensed under the Creative Commons Attribution-NonCommercial 3.0 Unported License. 
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/3.0/
//  or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
//
//

#import "TitleBarView.h"
#import <QuartzCore/QuartzCore.h>

@interface TitleBarView()
- (void)drawLinearGradientInRect:(CGRect)rect colors:(NSArray *)colors;
- (void)drawLineInRect:(CGRect)rect color:(CGColorRef)strokeColor;
@end

UIColor *DDColorWithRGBA(int r, int g, int b, CGFloat a);

const CGFloat kTitleBarHeight = 70;
const CGFloat kGradientBorderHeight = 5;

@implementation TitleBarView
@synthesize useGradientBorder;
@synthesize titleLabel = _titleLabel;
@synthesize gradientColors = _gradientColors;
@synthesize borderShadowColors = _borderShadowColors;
@synthesize strokeTopColor = _strokeTopColor;
@synthesize strokeBottomColor = _strokeBottomColor;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kTitleBarHeight)];
	if (self) {
		[self setup];		
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [self initWithFrame:frame];
    if (self) {
        self.title = title;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if ((self = [super initWithCoder:coder])) {
		[self setup];
    }
    return self;
} 

- (void)setup {
	self.opaque = NO;
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	useGradientBorder = YES;
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_titleLabel.numberOfLines = 2;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
	_titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.shadowOffset = CGSizeMake(-1, 1);
    static UIColor *defaultTextColor;
    if (!defaultTextColor)
        defaultTextColor = [[[UIColor darkTextColor] colorWithAlphaComponent:0.9] retain];
    _titleLabel.textColor =  defaultTextColor;
    static UIColor *defaultShadowColor;
    if (!defaultShadowColor)
        defaultShadowColor = [[[UIColor lightTextColor] colorWithAlphaComponent:0.7] retain];
    _titleLabel.shadowColor = defaultShadowColor;
    static UIFont *defaultTextFont;
    if (!defaultTextFont)
        defaultTextFont = [[UIFont fontWithName:@"BlairMdITC TT" size:13.f] retain];
    _titleLabel.font = defaultTextFont;
//  _titleLabel.font = [UIFont boldSystemFontOfSize:16];

    [self addSubview:_titleLabel];
    
    static UIColor *gradientTop;
    if (!gradientTop)
        gradientTop = [DDColorWithRGBA(204, 206, 191, 1) retain];
    static UIColor *gradientBottom;
    if (!gradientBottom)
        gradientBottom = [DDColorWithRGBA(162, 165, 148, 1) retain];
    self.gradientColors = [NSArray arrayWithObjects:(id)gradientTop.CGColor, (id)gradientBottom.CGColor, nil];

    static UIColor *shadowTop;
    if (!shadowTop)
        shadowTop = [DDColorWithRGBA(79, 80, 72, 0.5f) retain];
    static UIColor *shadowBottom;
    if (!shadowBottom)
        shadowBottom = [[shadowTop colorWithAlphaComponent:0.1f] retain];
    self.borderShadowColors = [NSArray arrayWithObjects:(id)shadowTop.CGColor, (id)shadowBottom.CGColor, nil];
    
    self.strokeTopColor = DDColorWithRGBA(236, 239, 215, 1);
    self.strokeBottomColor = DDColorWithRGBA(100, 102, 92, 1);

}

- (void)dealloc {
    self.titleLabel = nil;
    self.borderShadowColors = nil;
    self.gradientColors = nil;
    self.strokeTopColor = nil;
    self.strokeBottomColor = nil;
    [super dealloc];
}

- (CGFloat)opticalHeight {
    return kTitleBarHeight - 5;
}

#pragma mark Layout & Redraw

- (void)layoutSubviews {
    const CGFloat offsetX = 12;
    const CGFloat offsetY = 10;
    CGFloat labelWidth = CGRectGetWidth(self.frame) - (2*offsetX);
    const CGFloat labelHeight = kTitleBarHeight - (2*offsetY) - kGradientBorderHeight;
    self.titleLabel.frame = CGRectMake(offsetX, offsetY, labelWidth, labelHeight);
}

- (void)drawRect:(CGRect)rect {	
	[self drawLinearGradientInRect:CGRectMake(0, 0, rect.size.width, self.opticalHeight - 1 ) colors:_gradientColors];
    if (useGradientBorder)
        [self drawLinearGradientInRect:CGRectMake(0, self.opticalHeight, rect.size.width, kGradientBorderHeight) colors:_borderShadowColors];
    [self drawLineInRect:CGRectMake(0, 0, rect.size.width, 0) color:_strokeTopColor.CGColor];
    [self drawLineInRect:CGRectMake(0, self.opticalHeight - .5, rect.size.width, 0) color:_strokeBottomColor.CGColor];      
}

- (void)drawLinearGradientInRect:(CGRect)rect colors:(NSArray *)colors {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(rgb, (CFArrayRef)colors, NULL);
	CGColorSpaceRelease(rgb);
	CGPoint start = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * 0.25);
	CGPoint end = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * 0.75);
	CGContextClipToRect(context, rect);
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
}

- (void)drawLineInRect:(CGRect)rect color:(CGColorRef)strokeColor {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, strokeColor);
	CGContextSetLineCap(context, kCGLineCapButt);
	CGContextSetLineWidth(context, 1.5);
	CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
}

#pragma mark Accessors

- (void)setUseGradientBorder:(BOOL)visible{
    useGradientBorder = visible;
    [self setNeedsDisplay];
}

- (void)setTitle:(NSString *)newTitle {
    self.titleLabel.text = newTitle;
    [self.titleLabel setNeedsDisplay];
    [self setNeedsDisplay];
}

- (NSString *)title {
    return self.titleLabel.text;
}

@end

UIColor *DDColorWithRGBA(int r, int g, int b, CGFloat a) {
    return [UIColor colorWithRed:(CGFloat)r/255.0 green:(CGFloat)g/255.0 blue:(CGFloat)b/255.0 alpha:a];
}