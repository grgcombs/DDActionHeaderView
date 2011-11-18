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
@property(nonatomic, retain) UILabel *titleLabel;
- (void)drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colours;
- (void)drawLineInRect:(CGRect)rect colors:(CGFloat[])colors;
@end

const CGFloat kTitleBarHeight = 70;
const CGFloat kGradientBorderHeight = 5;

@implementation TitleBarView
@synthesize useGradientBorder;
@synthesize titleLabel = titleLabel_;

#pragma mark -
#pragma mark View lifecycle

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
	titleLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
	titleLabel_.font = [UIFont boldSystemFontOfSize:16];
	titleLabel_.numberOfLines = 2;        
	titleLabel_.backgroundColor = [UIColor clearColor];
	titleLabel_.textColor = [UIColor darkTextColor];
	titleLabel_.shadowColor = [UIColor whiteColor];
	titleLabel_.shadowOffset = CGSizeMake(0, 1);
	[self addSubview:titleLabel_];
}

- (void)dealloc {
    self.titleLabel = nil;
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

	CGFloat colors[] = {
		200.0f / 255.0f, 207.0f / 255.0f, 212.0f / 255.0f, 1.0f,
        169.0f / 255.0f, 178.0f / 255.0f, 185.0f / 255.0f, 1.0f
	};	
	[self drawLinearGradientInRect:CGRectMake(0, 0, rect.size.width, self.opticalHeight - 1 ) colors:colors];

    if (useGradientBorder) {
        CGFloat colors2[] = {
            152.0f / 255.0f, 156.0f / 255.0f, 161.0f / 255.0f, 0.5f,
            152.0f / 255.0f, 156.0f / 255.0f, 161.0f / 255.0f, 0.1f
        };
        [self drawLinearGradientInRect:CGRectMake(0, self.opticalHeight, rect.size.width, kGradientBorderHeight) colors:colors2];		
    }
        
    CGFloat line1[]={240.0f / 255.0f, 230.0f / 255.0f, 230.0f / 255.0f, 1.0f};
    [self drawLineInRect:CGRectMake(0, 0, rect.size.width, 0) colors:line1];
    
    CGFloat line2[]={94.0f / 255.0f,  103.0f / 255.0f, 109.0f / 255.0f, 1.0f};
    [self drawLineInRect:CGRectMake(0, self.opticalHeight - .5, rect.size.width, 0) colors:line2];      
	
}

- (void)drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colours {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colours, NULL, 2);
	CGColorSpaceRelease(rgb);
	CGPoint start = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * 0.25);
	CGPoint end = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * 0.75);
	CGContextClipToRect(context, rect);
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
}

- (void)drawLineInRect:(CGRect)rect colors:(CGFloat[])colors {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
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
