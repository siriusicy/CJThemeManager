//
//  NSObject+Theme.h
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/23.
//

#import <Foundation/Foundation.h>
#import "CJThemeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ThemeChangedBlock)(id<CJThemeProtocol> theme);

@interface NSObject (Theme)

- (void)yf_addThemeChangedBlock:(ThemeChangedBlock)block;


@end

NS_ASSUME_NONNULL_END
