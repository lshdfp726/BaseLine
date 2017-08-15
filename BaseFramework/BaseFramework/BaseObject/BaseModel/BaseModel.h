//
//  BaseModel.h
//  zheft
//
//  Created by lsh726 on 2017/4/25.
//  Copyright © 2017年 zheft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic, strong) id data;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;


- (NSMutableDictionary *)modelToDictory;//模型转字典
- (NSArray *)getPropertyNameList;//获取属性列表
@end
