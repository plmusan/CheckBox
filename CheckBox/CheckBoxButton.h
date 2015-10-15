//
//  CheckBoxButton.h
//  CheckBox
//
//  Created by x.wang on 15/4/7.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CheckBoxState) {
    CheckBoxStateNormal,
    CheckBoxStateSelected
};

@interface CheckBoxButton : UIView

- (instancetype)initWithTaget:(id)taget action:(SEL)action;
- (instancetype)initWithTaget:(id)taget action:(SEL)action frame:(CGRect)rect;
- (void)addTaget:(id)taget action:(SEL)action;

@property (nonatomic) UIFont *font;
@property (nonatomic, getter=isEnabled) BOOL enable;
@property (nonatomic, getter=isSelected) BOOL selected;

@property (nonatomic, readonly) CheckBoxState state;
@property (nonatomic, strong, readonly) UILabel *btnText;
@property (nonatomic, strong, readonly) UIImageView *btnImage;

- (void)setTitle:(NSString *)title forState:(CheckBoxState)state;
- (void)setTitleColor:(UIColor *)color forState:(CheckBoxState)state;
- (void)setImage:(UIImage *)image forState:(CheckBoxState)state;

- (NSString *)titleForState:(CheckBoxState)state;
- (UIColor *)colorForState:(CheckBoxState)state;
- (UIImage *)imageForState:(CheckBoxState)state;

@end
