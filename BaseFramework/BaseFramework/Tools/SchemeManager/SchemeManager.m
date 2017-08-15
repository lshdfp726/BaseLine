//
//  SchemeManager.m
//  FnscoDataServerApp
//
//  Created by fns on 2017/6/23.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import "SchemeManager.h"

@implementation SchemeManager

+ (NSString *)acchieveSchemeCharWithIndex:(NSInteger)index {
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    NSArray *array = dic[@"CFBundleURLTypes"];
    NSDictionary *schemeDic = [array objectAtIndex:index];
    NSString *scheme = [schemeDic[@"CFBundleURLSchemes"] firstObject];
    return scheme;
}

@end
