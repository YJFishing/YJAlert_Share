//
//  YJAlertCollectionViewCell.m
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/13.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJAlertCollectionViewCell.h"
#import "YJAlertAction.h"

@interface YJAlertCollectionViewCell()

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *customView;

@end

@implementation YJAlertCollectionViewCell

- (UIButton *)imageButton {
    if (_imageButton == nil) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_imageButton];
        
        _imageButton.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *imageButtonTopCons = [NSLayoutConstraint constraintWithItem:_imageButton attribute:(NSLayoutAttributeTop) relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:15];
        NSLayoutConstraint *imageButtonLeftCons = [NSLayoutConstraint constraintWithItem:_imageButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:15];
        NSLayoutConstraint *imageButtonRightCons = [NSLayoutConstraint constraintWithItem:_imageButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-15];
        NSLayoutConstraint *imageButtonHeightCons = [NSLayoutConstraint constraintWithItem:_imageButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_imageButton attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        [self.contentView addConstraints:@[imageButtonTopCons,imageButtonLeftCons,imageButtonRightCons,imageButtonHeightCons]];
    }
    return _imageButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *titleLabelLeftCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *titleLabelRightCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *titleLabelBottomCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self.contentView addConstraints:@[titleLabelLeftCons,titleLabelRightCons,titleLabelBottomCons]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}


- (void)initialization {
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    _imageButton.highlighted = selected;
    
    if (!selected) {
        _titleLabel.textColor = (self.action.alertActionStyle == YJAlertActionStyleDefault) ? [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0] : [UIColor redColor];
        return;
    }
    _titleLabel.textColor = (self.action.alertActionStyle == YJAlertActionStyleDefault) ? [UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1] : [[UIColor redColor] colorWithAlphaComponent:0.5];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (!highlighted) {
        _titleLabel.textColor = (self.action.alertActionStyle == YJAlertActionStyleDefault) ? [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0] : [UIColor redColor];
        return;
    }
    _titleLabel.textColor = (self.action.alertActionStyle == YJAlertActionStyleDefault) ? [UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1] : [[UIColor redColor] colorWithAlphaComponent:0.5];
}

- (void)setAction:(YJAlertAction *)action {
    _action = action;
    _titleLabel.hidden = NO;
    _imageButton.hidden = _titleLabel.hidden;
    
    if (action.customView != nil) {
        _titleLabel.hidden = YES;
        _imageButton.hidden = _titleLabel.hidden;
        self.customView = action.customView;
        _customView.hidden = NO;
        return;
    }
    _customView.hidden = YES;
    self.titleLabel.textColor = (action.alertActionStyle == YJAlertActionStyleDefault) ? [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1]:[UIColor redColor];
    self.titleLabel.attributedText = action.attributedTitle;
    self.titleLabel.text = action.title;
    [self.imageButton setBackgroundImage:_action.normalImage forState:UIControlStateNormal];
    [self.imageButton setBackgroundImage:_action.highLightedImage forState:UIControlStateHighlighted];
}

- (void)setCustomView:(UIView *)customView {
    if (_customView == customView) {
        return;
    }
    _customView = customView;
    [self.contentView addSubview:_customView];
    
    customView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *customViewConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|0-0[customView]-0-|" options:0 metrics:nil views:@{@"customView":customView}];
    NSArray *customViewConsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[customView]-0-|" options:0 metrics:nil views:@{@"customView":customView}];
    [self addConstraints:customViewConsV];
    [self addConstraints:customViewConsH];
}
@end
