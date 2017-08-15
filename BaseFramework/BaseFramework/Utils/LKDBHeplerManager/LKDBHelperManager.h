//
//  LKDBHelperManager.h
//  zheft
//
//  Created by lsh726 on 2017/5/8.
//  Copyright © 2017年 zheft. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LKDBHelperManager : NSObject
+ (instancetype)manager;


//创建对应的model表
- (BOOL)loadDataBaseName:(Class)dataClass;

//查询单条model
- (id)querSignleDataWithModel:(Class)aClass;

@end
