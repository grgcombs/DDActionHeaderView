//  TitleBarView.h
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

#import <UIKit/UIKit.h>

@interface TitleBarView : UIView
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) NSArray *gradientColors;
@property(nonatomic, retain) NSArray *borderShadowColors;
@property(nonatomic, retain) UIColor *strokeTopColor;
@property(nonatomic, retain) UIColor *strokeBottomColor;
@property(nonatomic, assign) NSString *title;
@property(nonatomic, readonly) CGFloat opticalHeight;
@property(nonatomic, assign) BOOL useGradientBorder;
- (void)setup; // used for overriding subclasses
@end

extern const CGFloat kTitleBarHeight;
