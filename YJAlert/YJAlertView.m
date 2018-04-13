//
//  YJAlertView.m
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/13.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJAlertView.h"

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
@end


@implementation YJAlertView


@end
