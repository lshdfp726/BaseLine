//
//  DisposeErrorMethod.m
//  UsualTest
//
//  Created by fns on 2017/6/14.
//  Copyright © 2017年 fns. All rights reserved.
//

#import "DisposeErrorMethod.h"
#import <objc/runtime.h>

@implementation DisposeErrorMethod


void myMethodIMP(id self, SEL _cmd)
{
    NSLog(@"此%@方法引起的的崩溃",NSStringFromSelector(_cmd));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)myMethodIMP, "v@:");
    return YES;
    return [super resolveInstanceMethod:sel];
}


- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return self;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

@end
