//
//  CJThemeDefault.m
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/24.
//

#import "CJThemeDefault.h"

@implementation CJThemeDefault

///状态栏样式
- (UIStatusBarStyle)theme_statusBarStyle {
    return UIStatusBarStyleDefault;
}
///字体颜色
- (UIColor *)theme_textColor {
    return [UIColor theme_hexColor:@"#434343"];
}

@end
