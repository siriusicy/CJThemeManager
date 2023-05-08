//
//  NSObject+Theme.m
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/23.
//

#import "NSObject+Theme.h"
#import "CJThemeManager.h"
#import <objc/runtime.h>
#import "CJDeallocBlockExecutor.h"

static void *CJThemeManagerDeallocHelperKey;

@interface NSObject ()

@property (nonatomic, strong) NSMutableArray<ThemeChangedBlock> *blocks;

@end

@implementation NSObject (Theme)

- (void)yf_addThemeChangedBlock:(ThemeChangedBlock)block {
    if (block) {
        [self.blocks addObject:[block copy]];
        block([CJThemeManager currentTheme]);
    }
}

- (void)themeChange:(NSNotification *)noti {
    [self.blocks enumerateObjectsUsingBlock:^(ThemeChangedBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
        block([CJThemeManager currentTheme]);
    }];
}

#pragma mark -  set/get
- (NSMutableArray<ThemeChangedBlock> *)blocks {
    NSMutableArray<ThemeChangedBlock> *blocks = objc_getAssociatedObject(self, @selector(blocks));
    if (!blocks) {
        
        @autoreleasepool {
            // 在对象释放时解除监听通知
            if (objc_getAssociatedObject(self, &CJThemeManagerDeallocHelperKey) == nil) {
                __unsafe_unretained typeof(self) weakSelf = self;
                CJDeallocBlockExecutor *deallocHelper = [CJDeallocBlockExecutor executorWithDeallocBlock:^{
                    [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
                }];
                objc_setAssociatedObject(self, &CJThemeManagerDeallocHelperKey, deallocHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        
        
        blocks = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, @selector(blocks), blocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:YFThemeChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:YFThemeChangeNotification object:nil];
    }
    return blocks;
}

@end
