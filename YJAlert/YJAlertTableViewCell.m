//
//  YJAlertTableViewCell.m
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/13.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJAlertTableViewCell.h"
#import "YJAlertAction.h"

@interface YJAlertTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIView *customView;

@end

@implementation YJAlertTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.selectedBackgroundView.frame = self.contentView.frame;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17];
        label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self.contentView insertSubview:label atIndex:0];
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *labelConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]-15-|" options:0 metrics:nil views:@{@"label":label}];
        NSArray *labelConV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label":label}];
        [self addConstraints:labelConsH];
        [self addConstraints:labelConV];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)setAction:(YJAlertAction *)action {
    _action = action;
    self.selectionStyle = _action.isEmpty ? UITableViewCellSelectionStyleNone :UITableViewCellSelectionStyleDefault;
    self.bottomLineView.hidden = _action.separatorLineHidden;
    
    _titleLabel.hidden =  NO;
    if (action.customView != nil) {
        _titleLabel.hidden = YES;
        self.customView = action.customView;
        _customView.hidden = NO;
        return;
    }
    _customView.hidden = YES;
    self.titleLabel.textColor = (action.alertActionStyle == YJAlertActionStyleDefault) ? [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] : [UIColor redColor];
    
    self.titleLabel.attributedText = action.attributedTitle;
    self.titleLabel.text = action.title;
}

- (void)setCustomView:(UIView *)customView {
    if (_customView == customView) {
        return;
    }
    [_customView removeFromSuperview];
    _customView = customView;
    
    [self.contentView insertSubview:_customView atIndex:0];
    
    customView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *customViewConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[customView]-0-|" options:0 metrics:nil views:@{@"customView":customView}];
    [self addConstraints:customViewConsH];
    
    NSArray *customViewConsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[customView]-0-|" options:0 metrics:nil views:@{@"customView":customView}];
    [self addConstraints:customViewConsV];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    self.backgroundColor = [UIColor darkGrayColor];
    self.contentView.backgroundColor = [UIColor blueColor];
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *bottomLineViewConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomLineView]-0-|" options:0 metrics:nil views:@{@"bottomLineView":bottomLineView}];
    [self addConstraints:bottomLineViewConsH];
    
    NSArray *bottomLineViewConsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|bottomLineView(0.5)-0-|" options:0 metrics:nil views:@{@"bottomLineView":bottomLineView}];
    [self addConstraints:bottomLineViewConsV];
}

@end
