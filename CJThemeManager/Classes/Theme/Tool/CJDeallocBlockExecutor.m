//
//  CJDeallocBlockExecutor.m
//  CJThemeManager
//
//  Created by Yafan on 2023/5/8.
//

#import "CJDeallocBlockExecutor.h"

@implementation CJDeallocBlockExecutor

+ (instancetype)executorWithDeallocBlock:(void (^)(void))deallocBlock {
    CJDeallocBlockExecutor *obj = [[CJDeallocBlockExecutor alloc] init];
    obj.deallocBlock = deallocBlock;
    return obj;
}

- (void)dealloc {
    if (self.deallocBlock) {
        self.deallocBlock();
        self.deallocBlock = nil;
    }
}

@end
