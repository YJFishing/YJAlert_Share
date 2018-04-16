//
//  YJAlertView.h
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/13.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJAlertAction.h"

typedef NS_ENUM(NSUInteger,YJAlertStyle) {
   YJAlertStyleNone,
    YJAlertStyleActionSheet,
    YJAlertStyleStylePlain,
    YJAlertStyleCollectionSheet,
    YJAlertStyleHUD,
};

@protocol YJAlertViewProtocol

@required
//用来监听YJAlertView消失事件
- (void (^)(void (^dismissComplete)(void)))setDismissComplete;

@end

@interface YJAlertView : UIView

//默认yes，title和message是否可以响应点击事件
@property (nonatomic, assign) BOOL textViewUserInteractionEnabled;
@property (nonatomic, copy) YJAlertView *(^setTextViewUserInteractionEnabled)(BOOL userInteractionEnabled);

//title和message是否可以选择文字，默认NO
@property (nonatomic, assign) BOOL textViewCanSelectText;
@property (nonatomic, copy) YJAlertView *(^setTextViewCanSelectText)(BOOL canSelectText);

//设置titleTextViewDelegate
@property (nonatomic, weak) id<UITextViewDelegate> titleTextViewDelegate;
@property (nonatomic, copy) YJAlertView *(^setTitleTextViewDelegate)(id<UITextViewDelegate> delegate);

@property (nonatomic, weak) id<UITextViewDelegate> messageTextViewDelegate;
@property (nonatomic, copy) YJAlertView *(^setMessageTextViewDelegate)(id<UITextViewDelegate>delegate);

@property (nonatomic, assign) NSTextAlignment titleTextViewAlignment;
@property (nonatomic, copy, readonly) YJAlertView *(^setTitleTextViewAlignment)(NSTextAlignment textAlignment);

@property (nonatomic, assign) NSTextAlignment messageTextViewAlignment;
@property (nonatomic, copy, readonly) YJAlertView *(^setMessageTextViewAlignment)(NSTextAlignment textAlignment);

//title和message的左右间距
@property (nonatomic, assign) CGFloat textViewLeftRightMargin;
@property (nonatomic, copy, readonly) YJAlertView *(^setTextViewLeftRightMargin)(CGFloat margin);

//actionsheet样式底部的取消action，不能设置为nil
@property (nonatomic, strong) YJAlertAction *cancelAction;
@property (nonatomic, copy, readonly) YJAlertAction *(^setCancelAction)(YJAlertAction *action);

//dealloc时候调用的block
@property (nonatomic ,copy) void (^deallocBlock)(void);
@property (nonatomic, copy, readonly) void (^setDeallocBlock)(void(^deallocBlock)(void));

@property (nonatomic, copy, readonly) YJAlertView *(^enableDeallocLog)(BOOL enable);

#pragma mark  ----plain---
@property (nonatomic, copy, readonly) YJAlertView *(^setPlainWidth)(CGFloat width);
//plain样式添加自定义的titleView
@property (nonatomic, copy, readonly) YJAlertView *(^addCustomPlainTitleView)(UIView *(^customView)(void));

#pragma mark ---collectonSheet---
@property (nonatomic, assign) CGFloat flowLayoutItemWidth;
@property (nonatomic, copy, readonly) YJAlertView *(^setFlowLayoutItemWidth)(CGFloat width);

//是否将两个collection合体
@property (nonatomic, assign) BOOL compoundCollection;
@property (nonatomic, copy, readonly) YJAlertView *(^setCompoundCollection)(BOOL compoundCollection);

//设置collection是否分页
@property (nonatomic , assign) BOOL collectionPagingEnabled;
@property (nonatomic, assign) YJAlertView *(^setCollectionPagingEnabled)(BOOL collectionPagingEnabled);

//设置是否显示pageControl
@property (nonatomic, assign) BOOL showPageControl;
@property (nonatomic, copy, readonly) YJAlertView *(^setShowPageControl)(BOOL showPageControl);

//collection样式底部按钮左右间距
@property (nonatomic, assign) CGFloat collectionButtonLeftRightMargin;
@property (nonatomic, copy, readonly) YJAlertView *(^setCollectionButtonLeftRightMargin)(CGFloat margin);

//设置这个可以在取消按钮上面再添加一个按钮
@property (nonatomic, strong) YJAlertAction *collectionAction;
@property (nonatomic, copy, readonly) YJAlertView *(^setCollectionAction)(YJAlertAction *action);

//collection添加自定义的titleView
@property (nonatomic, copy, readonly) YJAlertView *(^addCustomCollectionTitleView)(UIView *(^customView)(void));

//添加第二个collectionView的action
@property (nonatomic, copy, readonly) YJAlertView *(^addSecondCollectionAction)(YJAlertAction *action);
- (void)addSecondCollectionAction:(YJAlertAction *)action;

#pragma mark ---HUD---
//dismiss的时间，小于等于0表示不自动隐藏
@property (nonatomic, assign) CGFloat dismissTimeInterval;
@property (nonatomic, copy, readonly) YJAlertView *(^setDismissTimeInterval)(CGFloat dismissTimeInterval);

#pragma mark ---类方法---
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message stye:(YJAlertStyle)alertStyle;
//链式实例化
+ (YJAlertView *(^)(NSString *title,NSString *message,YJAlertStyle style))alertView;

+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage style:(YJAlertStyle)alertStyle;
//链式实例化
+ (YJAlertView *(^)(NSAttributedString *attributedTitle,NSAttributedString *attributedMessage,YJAlertStyle style))alertViewAttributed;

+ (YJAlertView *(^)(NSString *title))showHUDWithTitle;
+ (YJAlertView *(^)(NSAttributedString *attributedTitle))showHUDWithAttributedTitle;

//显示自定义的HUD
+ (YJAlertView *(^)(UIView *(^)(void)))showCustomHUD;

+ (void(^)(void))dismiss;

#pragma mark ---添加action---
- (void)addAction:(YJAlertAction *)action;
@property (nonatomic, copy, readonly) YJAlertView *(^addAction)(YJAlertAction *action);

#pragma mark ---显示---
@property (nonatomic, copy, readonly) id<YJAlertViewProtocol> (^show)(void);

//显示并监听YJAlertView消失东动画完成
@property (nonatomic, copy, readonly) void (^showWithDismissComplete)(void(^dismissComplete)(void));

@property (nonatomic, copy, readonly) void (^dismiss)(void);

@property (nonatomic, copy, readonly) void (^setDismissComplete)(void(^dismissComplete)(void));

#pragma mark ---其他适配---
@property (nonatomic, copy, readonly) YJAlertView *(^setBottomButtonMargin)(CGFloat margin);

@property (nonatomic, copy, readonly) YJAlertView *(^setAutoAdjustHomeIndicator)(BOOL autoAdjust);







@end
