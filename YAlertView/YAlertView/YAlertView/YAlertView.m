//
//  YAlertView.m
//  YAlertView
//
//  Created by shusy on 2017/12/18.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YAlertView.h"
#define ALERT_WSPACE 30          //距离左右间距
#define ALERT_HSPACE 110        //距离上下间距
#define ALBTNWH 35                    //按钮的宽高
#define ALSPRINGVALUE 20              //弹性幅度值 上下抖动的值 默认10
#define ALDURATION 0.25              //动画时间

@interface YAlertView()
/**总的内容视图*/
@property(nonatomic,strong)UIView *contentView;
/**背景视图*/
@property(nonatomic,strong)UIImageView *bgImageV;
/**scrollView视图*/
@property(nonatomic,strong)UIScrollView *scrollView;
/**scrollView 的内部内容视图*/
@property(nonatomic,strong)UIView *scrollViewContentView;
/**内部标题视图*/
@property(nonatomic,strong)UILabel *titleL;
/**关闭按钮视图*/
@property(nonatomic,strong)UIButton *closeBtn;
@end

@implementation YAlertView

- (instancetype)initWithBg:(NSString*)bgName title:(NSString*)title  {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(ALERT_WSPACE,-self.frame.size.height, self.frame.size.width - 2*ALERT_WSPACE, self.frame.size.height-2*ALERT_HSPACE)];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
        
        _bgImageV = [[UIImageView alloc] initWithFrame:_contentView.bounds];
        if (bgName != nil) {
            _bgImageV.image = [UIImage imageNamed:bgName];
        }
        _bgImageV.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageV.clipsToBounds = YES;
        [_contentView addSubview:_bgImageV];
        
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, ALBTNWH)];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.text = (title != nil ? title : @"温馨提示") ;
        _titleL.font = [UIFont systemFontOfSize:15];
        _titleL.textColor = [UIColor blackColor];
        [_contentView addSubview:_titleL];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ALBTNWH-0.5, _contentView.frame.size.width, 0.4)];
        lineView.alpha = 0.5;
        lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [_contentView addSubview:lineView];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ALBTNWH, _contentView.frame.size.width, _contentView.frame.size.height-ALBTNWH)];
        [_contentView addSubview:_scrollView];
        
        _scrollViewContentView = [[UIView alloc] initWithFrame:_scrollView.bounds];
        [_scrollView addSubview:_scrollViewContentView];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width-ALBTNWH)*0.5, self.frame.size.height-ALERT_HSPACE+ALBTNWH, ALBTNWH, ALBTNWH)];
        [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn setAdjustsImageWhenHighlighted:NO];
        closeBtn.backgroundColor = [UIColor whiteColor];
        closeBtn.layer.cornerRadius = ALBTNWH*0.5;
        closeBtn.layer.masksToBounds = YES;
        closeBtn.alpha = 0.0;
        self.closeBtn = closeBtn;
        [self addSubview:closeBtn];

    }
    return self;
}

- (void)show {
    
    //找代理要数据
    if ( [self.delegate respondsToSelector:@selector(alertView:configContentView:scrollContentView:title:bgImageV:)]) {
        [self.delegate alertView:self configContentView:self.scrollView scrollContentView:self.scrollViewContentView title:self.titleL bgImageV:self.bgImageV];
    }
    self.alpha = 1.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGRect frame = self.contentView.frame;
    frame.origin.y = ALERT_HSPACE+ALSPRINGVALUE;
    [UIView animateWithDuration:ALDURATION animations:^{
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        CGRect frame = self.contentView.frame;
        frame.origin.y = ALERT_HSPACE;
        [UIView animateWithDuration:ALDURATION animations:^{
            self.contentView.frame = frame;
            self.closeBtn.alpha = 1.0;
        } completion:nil];
    }];
    
}

- (void)dismiss {
    CGRect frame = self.contentView.frame;
    frame.origin.y = ALERT_HSPACE+ALSPRINGVALUE;
    [UIView animateWithDuration:ALDURATION animations:^{
        self.contentView.frame = frame;
        self.closeBtn.alpha = 0.0;
    } completion:^(BOOL finished) {
        CGRect frame = self.contentView.frame;
        frame.origin.y = -self.frame.size.height;
        [UIView animateWithDuration:ALDURATION animations:^{
            self.alpha = 0.0f;
            self.contentView.frame = frame;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

#pragma mark event
- (void)closeBtnClick{
    [self dismiss];
}

@end
