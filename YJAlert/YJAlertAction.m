//
//  YJAlertAction.m
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/12.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJAlertAction.h"

@interface YJAlertAction() {
    CGFloat _rowHeight;
}
@end

@implementation YJAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(YJAlertActionStyle)style handler:(void (^)(YJAlertAction *))handler {
    YJAlertAction *action = [[YJAlertAction alloc] init];
    action->_title = [title copy];
    action->_handler = handler;
    action->_alertActionStyle = style;
    return action;
}

//链式实例化action
+ (YJAlertAction *(^)(NSString * title, YJAlertActionStyle style, void (^)(YJAlertAction *)))action {
    return ^(NSString *title,YJAlertActionStyle style,void(^handler)(YJAlertAction *action)) {
        return [YJAlertAction actionWithTitle:title style:style handler:handler];
    };
}

+ (instancetype)actionWithAttributedTitle:(NSAttributedString *)attributedTitle handler:(void (^)(YJAlertAction *))handler {
    YJAlertAction *action = [[YJAlertAction alloc] init];
    action->_attributedTitle = attributedTitle;
    action->_handler = handler;
    action->_alertActionStyle = YJAlertActionStyleDefault;
    return action;
}

+ (YJAlertAction *(^)(NSAttributedString *, void (^)(YJAlertAction *)))actionAttributed {
    return ^(NSAttributedString *attributedTitle,void(^handler)(YJAlertAction *action)) {
        return [YJAlertAction actionWithAttributedTitle:attributedTitle handler:handler];
    };
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    _rowHeight = -1;
    _separatorLineHidden = NO;
}

- (YJAlertAction *(^)(UIImage *))setNormalImage {
    return ^(UIImage *image) {
        self.normalImage = image;
        return self;
    };
}

- (YJAlertAction *(^)(UIImage *))setHighLightImage {
    return ^(UIImage *image) {
        self.highLightedImage = image;
        return self;
    };
}

- (YJAlertAction *(^)(UIView *(^customView)(void)))setCustomView {
    return ^(UIView *(^customView)(void)) {
        self.customView = !customView ? nil : customView();
        return self;
    };
}

- (BOOL)isEmpty {
    return self.title == nil &&
    self.attributedTitle == nil &&
    self.handler == nil &&
    self.normalImage == nil &&
    self.highLightedImage == nil;
}

- (CGFloat)rowHeight {
    if (_rowHeight < 0) {
        _rowHeight = self.customView ? self.customView.frame.size.height :(([UIScreen mainScreen].bounds.size.width > 321) ? 53 : 46);
    }
    return _rowHeight;
}
@end
