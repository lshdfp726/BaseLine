//
//  BaseViewModel.m
//  FnscoDataServerApp
//
//  Created by fns on 2017/7/3.
//  Copyright © 2017年 fnsco. All rights reserved.
//

#import "BaseViewModel.h"


@implementation BaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSourceArray = [NSArray array];
        _isShowError     = YES;
    }
    return self;
}


//- (void)requestDataWithMethod:(RequestMethod)method
//                          url:(NSString *)url
//                       params:(NSDictionary *)params
//                        class:(Class)responseClass
//                 responseType:(ResponseType)type
//                      success:(SuccessBlockWithModel)success
//                      failure:(FailureBlockWithModel)failure {
//
//}

@end
