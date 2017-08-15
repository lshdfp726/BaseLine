//
//  BaseViewModel.h
//  FnscoDataServerApp
//
//  Created by fns on 2017/7/3.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface BaseViewModel : NSObject

@property (nonatomic, strong) NSArray   *dataSourceArray;
@property (nonatomic, strong) BaseModel *dataModel;
@property (nonatomic, assign) BOOL isShowError;//YES,展示无数据页面，NO 表示有数据,默认是NO

//- (void)requestDataWithMethod:(RequestMethod)method
//                          url:(NSString *)url
//                       params:(NSDictionary *)params
//                        class:(Class)responseClass
//                 responseType:(ResponseType)type
//                      success:(SuccessBlockWithModel)success
//                      failure:(FailureBlockWithModel)failure;
@end
