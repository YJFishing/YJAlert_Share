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

@end
