//
//  CheckBoxButton.m
//  CheckBox
//
//  Created by x.wang on 15/4/7.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import "CheckBoxButton.h"


#define RECT CGRectMake(0, 0, 30, 120)
#define SuppressPerformSelectorLeakWarning(Stuff) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \


@interface CheckBoxButton ()

@property (nonatomic, strong) UILabel *btnText;
@property (nonatomic, strong) UIImageView *btnImage;

@property (nonatomic, strong) NSMutableDictionary *images;
@property (nonatomic, strong) NSMutableDictionary *titles;
@property (nonatomic, strong) NSMutableDictionary *colors;

@property (nonatomic) SEL action;
@property (nonatomic, weak) id taget;
@property (nonatomic) CheckBoxState state;

@end


@implementation CheckBoxButton {
    BOOL _enable;
    BOOL _selected;
}

@synthesize enable = _enable;
@synthesize selected = _selected;

- (void)addTaget:(id)taget action:(SEL)action; {
    self.taget = taget;
    self.action = action;
}

- (instancetype)initWithTaget:(id)taget action:(SEL)action; {
    if (self = [super initWithFrame:RECT]) {
        [self instanceSelf];
        [self addTaget:taget action:action];
    }
    return self;
}

- (instancetype)initWithTaget:(id)taget action:(SEL)action frame:(CGRect)rect; {
    if (self = [super initWithFrame:rect]) {
        [self instanceSelf];
        [self addTaget:taget action:action];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self instanceSelf];
    }
    return self;
}

- (void)removeButton {
    [self.btnText removeFromSuperview];
    [self.btnImage removeFromSuperview];
    [self layoutSublayersOfLayer:self.layer];
}

- (void)addButton {
    if (! [self.subviews containsObject:self.btnImage]) {
        [self addSubview:self.btnImage];
        self.btnImage.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *imageCenterY = [NSLayoutConstraint constraintWithItem:self.btnImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *imageLeft = [NSLayoutConstraint constraintWithItem:self.btnImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:8];
        [self addConstraints:@[imageCenterY, imageLeft]];
    }
    
    if (! [self.subviews containsObject:self.btnText]) {
        [self addSubview:self.btnText];
        self.btnText.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *labelCenterY = [NSLayoutConstraint constraintWithItem:self.btnText attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:self.btnText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnImage attribute:NSLayoutAttributeRight multiplier:1 constant:8];
        [self addConstraints:@[labelCenterY, labelLeft]];
    }
}

- (void)instanceButton; {
    if (! self.btnImage) {
        self.btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.btnImage.image = [self imageForState:CheckBoxStateNormal];
    }
    if (! self.btnText) {
        self.btnText = [[UILabel alloc] init];
        self.btnText.text = [self titleForState:CheckBoxStateNormal];
        self.font = [UIFont systemFontOfSize:17.0];
    }
    [self addButton];
}

- (void)configView; {
    [self setBackgroundColor:[UIColor clearColor]];
    if (! self.images) {
        self.images = [NSMutableDictionary dictionary];
        [self setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:CheckBoxStateNormal];
        [self setImage:[UIImage imageNamed:@"checkbox_checked"] forState:CheckBoxStateSelected];
    }
    if (! self.titles) {
        self.titles = [NSMutableDictionary dictionary];
        [self setTitle:@"Button" forState:CheckBoxStateNormal];
    }
    if (! self.colors) {
        self.colors = [NSMutableDictionary dictionary];
        [self setTitleColor:[UIColor whiteColor] forState:CheckBoxStateNormal];
    }
}

- (void)instanceSelf {
    self.enable = YES;
    [self configView];
    [self instanceButton];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self instanceSelf];
}


- (BOOL)isEnabled {
    return _enable;
}

- (void)setEnable:(BOOL)enable {
    if (_enable != enable) {
        _enable = enable;
    }
    [self instanceButton];
    if (enable) {
        self.alpha = 1.0;
    } else {
        self.alpha = 0.5;
    }
}

- (BOOL)isSelected {
    return _selected;
}

- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        _selected = selected;
    }
    [self configView];
    [self instanceButton];
    [self changeLayoutWithSelected:selected];
}

- (void)changeLayoutWithSelected:(BOOL)selected {
    if (selected) {
        self.state = CheckBoxStateSelected;
    } else {
        self.state = CheckBoxStateNormal;
    }
    self.btnImage.image = [self imageForState:self.state];
    self.btnText.text = [self titleForState:self.state];
    self.btnText.tintColor = [self colorForState:self.state];
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
    }
    [self instanceButton];
    [self.btnText setFont:font];
}

- (void)setTitle:(NSString *)title forState:(CheckBoxState)state; {
    [self configView];
    [self.titles setValue:title forKey:@(state).stringValue];
}
- (void)setTitleColor:(UIColor *)color forState:(CheckBoxState)state; {
    [self configView];
    [self.colors setValue:color forKey:@(state).stringValue];
}
- (void)setImage:(UIImage *)image forState:(CheckBoxState)state; {
    [self configView];
    [self.images setValue:image forKey:@(state).stringValue];
}

- (NSString *)titleForState:(CheckBoxState)state; {
    id result = [self.titles valueForKey:@(state).stringValue];
    if ( ! result ) {
        result = [self.titles valueForKey:@(CheckBoxStateNormal).stringValue];
    }
    return result;
}
- (UIColor *)colorForState:(CheckBoxState)state; {
    id result = [self.colors valueForKey:@(state).stringValue];
    if ( ! result ) {
        result = [self.colors valueForKey:@(CheckBoxStateNormal).stringValue];
    }
    return result;
}
- (UIImage *)imageForState:(CheckBoxState)state; {
    id result = [self.images valueForKey:@(state).stringValue];
    if ( ! result ) {
        result = [self.images valueForKey:@(CheckBoxStateNormal).stringValue];
    }
    return result;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.enable) {
        self.selected = ! self.isSelected;
        [self changeLayoutWithSelected:self.isSelected];
        SuppressPerformSelectorLeakWarning(
                                           [self.taget performSelector:self.action]
                                           );
    }
}


@end
