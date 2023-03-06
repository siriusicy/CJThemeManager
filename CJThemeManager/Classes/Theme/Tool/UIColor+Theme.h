//
//  UIColor+Theme.h
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Theme)

+ (UIColor *)theme_hexColor:(NSString *)hex;

+ (UIColor *)theme_hexColor:(NSString *)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
