//
//  BaseModel.m
//  zheft
//
//  Created by lsh726 on 2017/4/25.
//  Copyright © 2017年 zheft. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>
@implementation BaseModel
//OBJC_EXPORT objc_property_t *class_copyPropertyList(Class cls, unsigned int *outCount)
//OBJC_EXPORT const char *property_getName(objc_property_t property)
- (NSArray *)getPropertyNameList { //获取类的属性名称
    NSMutableArray *propertyNameListArray = [NSMutableArray array];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (NSInteger i = 0 ; i < count; i ++) {
        const char *propertyCharName = property_getName(properties[i]);//c的字符串
        NSString *propertyOCName     = [NSString stringWithFormat:@"%s",propertyCharName];//转化成oc 字符串
        [propertyNameListArray addObject:propertyOCName];
    }
    NSArray *dataArray = [NSArray arrayWithArray:propertyNameListArray];
    return dataArray;
}


- (NSMutableDictionary *)modelToDictory {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *propertyNameList = [self getPropertyNameList];
    [propertyNameList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = obj;
        id value = [self valueForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString *v = (NSString *)value;
            if (v != nil) {//判断不是空，否则插入字典会崩溃
                [dic setObject:value forKey:key];
            }
        } else if ([value isKindOfClass:[NSArray class]]) {
            NSArray *v = (NSArray *)value;
            if (v.count != 0) {
                [dic setObject:value forKey:key];
            }
        }

    }];
    return dic;
}


- (id)copyWithZone:(NSZone *)zone {
    BaseModel *model = [[[self class] allocWithZone:zone] init];
    [[self getPropertyNameList] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [model setValue:[self valueForKey:obj] forKey:obj];
    }];
    return model;
}

@end
