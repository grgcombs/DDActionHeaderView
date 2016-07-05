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

@interface TitleBarView : UIView <UIAppearance>
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, weak) NSString *title;
@property(nonatomic, readonly) CGFloat opticalHeight;
@property(nonatomic, assign) BOOL useGradientBorder;
@property(nonatomic, weak) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, weak) UIColor *titleColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *gradientTopColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *gradientBottomColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, assign) CGFloat borderShadowHeight UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *borderShadowTopColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *borderShadowBottomColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *strokeTopColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *strokeBottomColor UI_APPEARANCE_SELECTOR;
- (void)setup; // used for overriding subclasses
@end

extern const CGFloat kTitleBarHeight;
