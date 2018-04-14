//
//  YJAlertView.m
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/13.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJAlertView.h"
#import "YJAlertTextView.h"

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
@property (nonatomic, assign) YJAlertActionStyle alertStyle;
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


@end
