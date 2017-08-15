//
//  BaseTableViewCell.m
//  zheft
//
//  Created by lsh726 on 2017/4/27.
//  Copyright © 2017年 zheft. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBaseUpView];
    }
    return self;
}


- (void)setBaseUpView {
    [self.contentView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.height.mas_equalTo(commonSeparatorLineHeight);
    }];

    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(commonSeparatorLineHeight);
    }];
}


#pragma mark -懒加载
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        [_topLine setBackgroundColor:commonSeparatorLineColor];
        [_topLine setHidden:YES];//默认为NO
    }
    return _topLine;
}


- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        [_bottomLine setBackgroundColor:commonSeparatorLineColor];
    }
    return _bottomLine;
}

@end
