//
//  YAlertView.h
//  YAlertView
//
//  Created by shusy on 2017/12/18.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YAlertView;

@protocol YAlertViewDelegate<NSObject>
@optional;
/**
 配置 标题 和 scrollView 内部展示内容 以及背景图片
 @param alertView alertView
 @param scrollView scrollView 可以设置contentsize
 @param  scrollContentView *scrollView 的内部内容视图 自己添加的内容添加到这里面
 @param titleL 标题
 @param bgImageV 背景视图
 */
- (void)alertView:(YAlertView*)alertView configContentView:(UIScrollView*)scrollView scrollContentView:(UIView*)scrollContentView title:(UILabel*)titleL bgImageV:(UIImageView*)bgImageV;
@end

@interface YAlertView : UIView
- (instancetype)initWithBg:(NSString*)bgName title:(NSString*)title;
@property(nonatomic,weak)id<YAlertViewDelegate> delegate;
- (void)show;
@end
