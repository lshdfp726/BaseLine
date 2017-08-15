//
//  PlaceholderView.m
//  zheft
//
//  Created by lsh726 on 2017/5/9.
//  Copyright © 2017年 zheft. All rights reserved.
//

#import "PlaceholderView.h"

@interface PlaceholderView () {
    UITapGestureRecognizer *_reg;
}
@property (nonatomic, strong) UIImageView *placeImageView;
@property (nonatomic, strong) UILabel     *placeLabel;
@property (nonatomic, strong) UIButton    *bottomBtn;
@end

@implementation PlaceholderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpView];
        [self addRefreshControl];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
        [self addRefreshControl];
    }
    return self;
}


- (void)addRefreshControl {
    _reg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshMethod)];
    [self addGestureRecognizer:_reg];
}


- (void)refreshMethod {
    if (self.refreshDataAction) {
        self.refreshDataAction();
    }
}


- (void)setUpView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.placeImageView];
    [self.placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50.0, 50.0));
    }];

    [self addSubview:self.placeLabel];
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeImageView.mas_bottom);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(25.0);
    }];

    [self addSubview:self.bottomBtn];
    [self.bottomBtn obsersverEvents:UIControlEventTouchUpInside withBlock:^(UIButton *btn) {
        if (self.BottomBtnAction) {
            self.BottomBtnAction();
        }
    }];

    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeLabel.mas_bottom).offset(73.0);
        make.left.equalTo(self).offset(87.5);
        make.right.equalTo(self).offset(-87.5);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(37.0);
    }];

}


//增加视图
- (void)addToSuperView:(UIView *)view {
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[self class]]) {
            [v removeFromSuperview];
        }
    }
    [view addSubview:self];
}


#pragma mark - 懒加载
- (UIImageView *)placeImageView {
    if (!_placeImageView) {
        _placeImageView = [[UIImageView alloc] init];
        [_placeImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_placeImageView setBackgroundColor:commonBackgroundColor];
        [_placeImageView setImage:[ColorToImageTools createImageWithColor:[UIColor blueColor]]];
    }
    return _placeImageView;
}


- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] init];
        [_placeLabel setTextColor:[ColorHex colorWithHexString:@"#AEAEAE"]];
        [_placeLabel setFont:COMMONFONT(15.0)];
//        [_placeLabel setText:@"网络错误"];
    }
    return _placeLabel;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_bottomBtn.layer setCornerRadius:5.0];
//        [_bottomBtn.layer setMasksToBounds:YES];
//        [_bottomBtn.layer setBorderWidth:1.0];
//        [_bottomBtn.layer setBorderColor:[UIColor blackColor].CGColor];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn setBackgroundImage:[ColorToImageTools createImageWithColor:[ColorHex colorWithHexString:@"#3595FF"]] forState:UIControlStateNormal];
        [_bottomBtn setHidden:YES];
    }
    return _bottomBtn;
}


#pragma mark - 设置参数
- (void)setPlaceTitle:(NSString *)placeTitle {
    [_placeLabel setText:placeTitle];
}


- (void)setPlaceImage:(UIImage *)placeImage {
    [_placeImageView setImage:placeImage];
}


- (void)setPlaceBtnTitle:(NSString *)placeBtnTitle {
    [_bottomBtn setTitle:placeBtnTitle forState:UIControlStateNormal];
}



#pragma mark - 隐藏底部按钮
- (void)hiddenBottomBtn {
    [_bottomBtn setHidden:YES];
}


- (void)showBottomBtn {
    [_bottomBtn setHidden:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
