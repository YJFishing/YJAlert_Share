//
//  YJAlertView.m
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/13.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJAlertView.h"
#import "YJAlertTextView.h"
#import "YJAlertTableViewCell.h"

#define YJAlertScreenW ([UIScreen mainScreen].bounds.size.width)
#define YJAlertScreenH ([UIScreen mainScreen].bounds.size.width)
#define YJAlertScrrenScale ([UIScreen mainScreen].scale)

#define YJAlertIsiPhoneX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)):NO)

#define YJAlertHomeIndicatorHeight (YJAlertIsiPhoneX ? 34 : 0)
#define YJAlertAdjustHomeIndicatorHeight (AutoAdjustHomeIndicator ? YJAlertHomeIndicatorHeight : 0)

//plain
#define YJAlertRowHeight ((YJAlertScreenW > 321) ? 53 : 46)
#define YJAlertPlainViewMaxH (YJAlertScreenH - 100)
#define YJAlertTextContainerViewMaxH (YJAlertScreenH - 100 - YJAlertScrollViewMaxH)
#define YJAlertSheetMaxH (YJAlertScreenH * 0.85)


static CGFloat const YJAlertMinTitleLabelH = (22);
static CGFloat const YJAlertMinMessageLabelH = (17);
static CGFloat const YJAlertTitleMessageMargin = (7);
static CGFloat const YJAlertScrollViewMaxH = 176;

static CGFloat const YJAlertButtonH = 44;
static NSInteger const YJAlertPlainButtonBeginTag = 100;
static NSString *const YJAlertDismissNotification = @"YJAlertDismissNotification";
static CGFloat const YJAlertSheetTitleMargin = 6;

@interface YJAlertView()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,YJAlertViewProtocol>
{
    CGFloat TBMargin;
    CGFloat textContatinerViewCurrentMaxH_;
    CGFloat _iPhoneXLandScapeTextMargin;
    CGFloat YJAlertSeparatorLineWH;
    CGFloat PlainViewWidth;
    BOOL AutoAdjustHomeIndicator;
    BOOL Showed;
    BOOL enableDeallocLog;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *sheetContainerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout2;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionView *collectionView2;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *collectionButton;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) NSMutableArray *actions;
@property (nonatomic, strong) NSMutableArray *actions2;
@property (nonatomic, assign) YJAlertStyle alertStyle;
@property (nonatomic, strong) NSString *alertTitle;
@property (nonatomic, strong) NSAttributedString *alertAttributedTitle;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSAttributedString *attirbutedMessage;
@property (nonatomic ,strong) UIView *plainView;
//palin样式添加自定义的titleView
@property (nonatomic, strong) UIView *customPlainTitleView;
//collection样式添加自定义的titleView的父视图
@property (nonatomic, strong) UIScrollView *customPlainTitleScrollView;
@property (nonatomic , strong) UIView *customHUD;
@property (nonatomic, strong) UIView *textContainerView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) YJAlertTextView *titleTextView;
@property (nonatomic, strong) YJAlertTextView *messageTextView;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *titleContentView;
@property (nonatomic, copy) void (^dismissComplete)(void);
@end


@implementation YJAlertView

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message stye:(YJAlertStyle)alertStyle {
    if (alertStyle == YJAlertStyleNone) {
        return nil;
    }
    YJAlertView *alertView = [[YJAlertView alloc] init];
    alertView.alertStyle = alertStyle;
    alertView.alertTitle = [title copy];
    alertView.message = [message copy];
    return alertView;
}

+ (YJAlertView *(^)(NSString *, NSString *, YJAlertStyle))alertView {
    return ^(NSString *title,NSString *message,YJAlertStyle style) {
        return [YJAlertView alertViewWithTitle:title message:message stye:style];
    };
}

+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage style:(YJAlertStyle)alertStyle {
    if (alertStyle == YJAlertStyleNone) {
        return nil;
    }
    YJAlertView *alertView = [[YJAlertView alloc] init];
    alertView.alertStyle = alertStyle;
    alertView.alertAttributedTitle = [attributedTitle copy];
    alertView.attirbutedMessage = [attributedMessage copy];
    return alertView;
}

+ (YJAlertView *(^)(NSAttributedString *, NSAttributedString *, YJAlertStyle))alertViewAttributed {
    return ^(NSAttributedString *attributedTitle,NSAttributedString *attributedMessage,YJAlertStyle style) {
        return [YJAlertView alertViewWithAttributedTitle:attributedTitle attributedMessage:attributedMessage style:style];
    };
}

+ (YJAlertView *(^)(NSString *))showHUDWithTitle {
    return ^(NSString *title) {
        YJAlertView *alertView = nil;
        if (title == nil) {
            return alertView;
        }
        alertView = [YJAlertView alertViewWithTitle:title message:nil stye:YJAlertStyleHUD];
        [alertView show];
        return alertView;
    };
}

+ (YJAlertView *(^)(NSAttributedString *))showHUDWithAttributedTitle {
    return ^(NSAttributedString *attributedTitle) {
        YJAlertView *alertView = nil;
        if (!attributedTitle) {
            return  alertView;
        }
       alertView = [YJAlertView alertViewWithAttributedTitle:attributedTitle attributedMessage:nil style:YJAlertStyleHUD];
        [alertView show];
        return alertView;
    };
}

+ (YJAlertView *(^)(UIView *(^)(void)))showCustomHUD {
    return ^(UIView *(^customHUD)(void)) {
        YJAlertView *alertView = nil;
        if (!customHUD) {
            return alertView;
        }
        UIView *customView = customHUD();
        if (customView.frame.size.width <=0 || customView.frame.size.height <= 0) {
            return alertView;
        }
        alertView = [[YJAlertView alloc] init];
        alertView.customHUD = customView;
        [alertView show];
        return alertView;
    };
}

//移除当前所有YJAlertView
+ (void (^)(void))dismiss {
    [[NSNotificationCenter defaultCenter] postNotificationName:YJAlertDismissNotification object:nil];
    return ^{};
}

#pragma mark ---懒加载---
- (NSMutableArray *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (NSMutableArray *)actions2 {
    if (!_actions2) {
        _actions2 = [NSMutableArray array];
    }
    return _actions2;
}

- (UIView *)textContainerView {
    if (!_textContainerView) {
        UIView *textContainerView = [[UIView alloc] init];
        [self addSubview:textContainerView];
        _textContainerView = textContainerView;
    }
    return _textContainerView;
}

- (YJAlertTextView *)titleTextView {
    if (!_titleTextView) {
        YJAlertTextView *titleLabel = [[YJAlertTextView alloc] init];
        titleLabel.textColor = self.alertStyle == YJAlertStyleStylePlain ? [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]:[UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1];
        titleLabel.font = self.alertStyle == YJAlertStyleStylePlain ? [UIFont boldSystemFontOfSize:17]:[UIFont systemFontOfSize:17];
        [self addSubview:titleLabel];
        _titleTextView = titleLabel;
    }
    return _titleTextView;
}

- (YJAlertTextView *)messageTextView {
    if (!_messageTextView) {
        YJAlertTextView *messageLabel = [[YJAlertTextView alloc] init];
        messageLabel.textColor = self.alertStyle == YJAlertStyleActionSheet ? [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1]:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        messageLabel.font = self.alertStyle == YJAlertStyleStylePlain ? [UIFont systemFontOfSize:14]:[UIFont systemFontOfSize:13];
        [self addSubview:messageLabel];
        _messageTextView = messageLabel;
    }
    return _messageTextView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        [self addSubview:scrollView];
        
        //适配ios11
        SEL selector = NSSelectorFromString(@"setContentInsetAdjustmentBehavior:");
        if ([scrollView respondsToSelector:selector]) {
            IMP imp = [scrollView methodForSelector:selector];
            void (*func)(id,SEL,NSInteger) = (void *)imp;
            func(scrollView,selector,2);
//            [scrollView performSelector:@selector(setContentInsetAdjustmentBehavior:) withObject:2];
        }
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIView *)sheetContainerView {
    if (!_sheetContainerView) {
        UIView *sheetContainerView = [[UIView alloc] init];
        sheetContainerView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:0.7];
        [self.contentView addSubview:sheetContainerView];
        
        UIToolbar *toolBar = [[UIToolbar alloc] init];
        [sheetContainerView insertSubview:toolBar atIndex:0];
        toolBar.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *cons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolBar]-0-|" options:0 metrics:nil views:@{@"toolBar":toolBar}];
        NSArray *cons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[toolBar]-0-|" options:0 metrics:nil views:@{@"toolBar":toolBar}];
        [sheetContainerView addConstraints:cons1];
        [sheetContainerView addConstraints:cons2];
        _sheetContainerView = sheetContainerView;
    }
    return _sheetContainerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self.textContainerView addSubview:bottomLineView];
        _bottomLineView = bottomLineView;
        
        //title和message的容器
        self.textContainerView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:0.7];
        [self.sheetContainerView addSubview:self.textContainerView];
        
        [self.textContainerView insertSubview:self.scrollView atIndex:0];
        [self.scrollView addSubview:self.titleTextView];
        [self.scrollView addSubview:self.messageTextView];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollsToTop = NO;
        tableView.scrollEnabled = NO;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, YJAlertAdjustHomeIndicatorHeight, 0);
        tableView.scrollIndicatorInsets = tableView.contentInset;
        tableView.backgroundColor = [UIColor clearColor];
        [tableView registerClass:[YJAlertTableViewCell class] forCellReuseIdentifier:NSStringFromClass([YJAlertTableViewCell class])];
        [_sheetContainerView addSubview:tableView];
        
        tableView.rowHeight = YJAlertRowHeight;
        tableView.sectionFooterHeight = 0;
        tableView.sectionHeaderHeight = 0;
        
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YJAlertScreenW, CGFLOAT_MIN)];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YJAlertScreenW, CGFLOAT_MIN)];
        
        if (@available(iOS 11.0,*)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView = tableView;
        
    }
    return _tableView;
}
- (UIButton *)cancelButton {
    if (!_cancelAction) {
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:0.7];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [cancelButton setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = cancelButton;
    }
    return _cancelButton;
}
@end
