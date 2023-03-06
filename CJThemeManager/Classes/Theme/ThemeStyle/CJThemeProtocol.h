//
//  CJThemeProtocol.h
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/24.
//

#import <Foundation/Foundation.h>
#import "UIColor+Theme.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CJThemeProtocol <NSObject>

///状态栏样式
- (UIStatusBarStyle)theme_statusBarStyle;
///字体颜色
- (UIColor *)theme_textColor;

// TODO:- 添加自定义颜色



@end

NS_ASSUME_NONNULL_END
