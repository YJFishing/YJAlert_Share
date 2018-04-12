//
//  YJAlertTextView.h
//  YJAlert_Share
//
//  Created by 包宇津 on 2018/4/12.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJAlertTextView : UITextView

@property (nonatomic,assign) BOOL canSelectText;

- (CGRect)calculateFrameWithMaxWidth:(CGFloat)maxWidth minHeight:(CGFloat)minHeight originY:(CGFloat)originY superView:(UIView *)superView;
@end
