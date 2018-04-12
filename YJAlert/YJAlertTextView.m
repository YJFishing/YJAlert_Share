//
//  YJAlertTextView.m
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/12.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJAlertTextView.h"

@interface YJAlertTextView()

@end

@implementation YJAlertTextView

- (CGRect)calculateFrameWithMaxWidth:(CGFloat)maxWidth minHeight:(CGFloat)minHeight originY:(CGFloat)originY superView:(UIView *)superView {
    if (self.hidden) {
        return CGRectZero;
    }
    CGRect rect = self.frame;
    rect.origin.y = originY;
    rect.size = [self sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)];
    rect.size.width = maxWidth;
    rect.size.height = ceil(rect.size.height);
    if (rect.size.height < minHeight) {
        self.textContainerInset = UIEdgeInsetsMake((minHeight - rect.size.height) * 0.5, 0, 0, 0);
        rect.size.height = minHeight;
    }
    self.frame = rect;
    CGPoint center = self.center;
    center.x = superView.frame.size.width * 0.5;
    self.center = center;
    return rect;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialazation];
    }
    return self;
}

- (void)initialazation {
    self.backgroundColor = nil;
    self.textAlignment = NSTextAlignmentCenter;
    self.scrollsToTop = NO;
    self.editable = NO;
    self.textContainer.lineFragmentPadding = 0;
    self.textContainerInset = UIEdgeInsetsZero;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_canSelectText) {
        return [super canPerformAction:action withSender:sender];
    }
    [self resignFirstResponder];
    [UIMenuController sharedMenuController].menuVisible = NO;
    return NO;
}
@end
