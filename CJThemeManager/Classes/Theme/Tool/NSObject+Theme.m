//
//  NSObject+Theme.m
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/23.
//

#import "NSObject+Theme.h"
#import "CJThemeManager.h"
#import <objc/runtime.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableArray<ThemeChangedBlock> *blocks;

@end

@implementation NSObject (Theme)

- (void)yf_addThemeChangedBlock:(ThemeChangedBlock)block {
    if (block) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:YFThemeChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:YFThemeChangeNotification object:nil];
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
        blocks = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, @selector(blocks), blocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return blocks;
}

- (void)setBlocks:(NSMutableArray<ThemeChangedBlock> *)blocks {
    objc_setAssociatedObject(self, @selector(blocks), blocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (blocks == nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:YFThemeChangeNotification object:nil];
    }
}

@end
