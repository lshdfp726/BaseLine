//
//  LKDBHelperManager.m
//  zheft
//
//  Created by lsh726 on 2017/5/8.
//  Copyright © 2017年 zheft. All rights reserved.
//

#import "LKDBHelperManager.h"
#import <LKDBHelper/LKDBHelper.h>

#define TABLENAME @"ZFT.db"
#define DB_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0]

@interface LKDBHelperManager (){
    LKDBHelper *_db;
}

@end

@implementation LKDBHelperManager
+ (instancetype)manager {
    static LKDBHelperManager *_LKDBHelperManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _LKDBHelperManager = [[LKDBHelperManager alloc] init];
    });
    return _LKDBHelperManager;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _db = [[LKDBHelper alloc] initWithDBPath:[DB_PATH stringByAppendingPathComponent:TABLENAME]];
        NSLog(@"数据库路径:%@",[DB_PATH stringByAppendingPathComponent:TABLENAME]);
    }
    return self;
}


//创建对应的model表
- (BOOL)loadDataBaseName:(Class)dataClass {
    return [_db getTableCreatedWithClass:dataClass];
}


- (id)querSignleDataWithModel:(Class)aClass {
    return [_db searchSingle:aClass where:nil orderBy:nil];
}


@end
