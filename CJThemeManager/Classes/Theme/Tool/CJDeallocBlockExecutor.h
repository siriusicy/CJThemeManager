//
//  CJDeallocBlockExecutor.h
//  CJThemeManager
//
//  Created by Yafan on 2023/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDeallocBlockExecutor : NSObject

+ (instancetype)executorWithDeallocBlock:(void (^)(void))deallocBlock;

@property (nonatomic, copy) void (^ _Nullable deallocBlock)(void);

@end

NS_ASSUME_NONNULL_END
