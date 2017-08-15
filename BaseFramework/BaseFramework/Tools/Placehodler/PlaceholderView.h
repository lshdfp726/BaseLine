//
//  PlaceholderView.h
//  zheft
//
//  Created by lsh726 on 2017/5/9.
//  Copyright © 2017年 zheft. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RefreshDataBlock)(void);
typedef void (^BottomBtnBlock) (void);
@interface PlaceholderView : UIView

//方法
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addToSuperView:(UIView *)view;
- (void)hiddenBottomBtn;
- (void)showBottomBtn;



//属性
@property (nonatomic, copy)   NSString *placeTitle;
@property (nonatomic, strong) UIImage  *placeImage;
@property (nonatomic, copy)   NSString *placeBtnTitle;
@property (nonatomic, copy)   RefreshDataBlock refreshDataAction;
@property (nonatomic, copy)   BottomBtnBlock BottomBtnAction;


@end
