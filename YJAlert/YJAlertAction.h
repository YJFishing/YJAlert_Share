//
//  YJAlertAction.h
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/12.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,YJAlertActionStyle) {
    YJAlertActionStyleDefault,    //黑色字体
    YJAlertActionStyleDestructive, //红色字体
};

@interface YJAlertAction : NSObject

//title
@property (nonatomic, strong, readonly) NSAttributedString *attributedTitle;
@property (nonatomic, strong, readonly) NSString *title;

//handler
@property (nonatomic, copy, readonly) void (^handler)(YJAlertAction *action);

//展示image
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highLightedImage;

//如果以上五个属性都为nil 为空的action，在非plain样式外，点击没有反应
@property (nonatomic, assign, readonly) BOOL isEmpty;

//样式
@property (nonatomic, assign, readonly) YJAlertActionStyle alertActionStyle;

//actionSheet样式Cell高度
@property (nonatomic, assign, readonly) CGFloat rowHeight;

//是否隐藏分割线
@property (nonatomic, assign) BOOL separatorLineHidden;

@property (nonatomic, strong) UIView *customView;

//实例化action
+ (instancetype)actionWithTitle:(NSString *)title style:(YJAlertActionStyle)style handler:(void (^)(YJAlertAction *action))handler;

//链式实例化action
+ (YJAlertAction *(^)(NSString *title,YJAlertActionStyle style,void(^handler)(YJAlertAction *action)))action;

+(instancetype)actionWithAttributedTitle:(NSAttributedString *)attributedTitle handler:(void(^)(YJAlertAction *action))handler;

+(YJAlertAction *(^)(NSAttributedString *attributedTitle,void(^handler)(YJAlertAction *action)))actionAttributed;

@property (nonatomic, copy, readonly) YJAlertAction *(^setNormalImage)(UIImage *image);

@property (nonatomic, copy, readonly) YJAlertAction *(^setHighLightImage)(UIImage *image);

@property (nonatomic, copy, readonly) YJAlertAction *(^setCustomView)(UIView *(customView)(void));

@property (nonatomic, copy, readonly) YJAlertAction *(^setSeparatorLineHidden)(BOOL hidden);
@end
