//
//  CJThemeDark.m
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/24.
//

#import "CJThemeDark.h"

@implementation CJThemeDark

#pragma mark -  CJThemeProtocol

///状态栏样式
- (UIStatusBarStyle)theme_statusBarStyle {
    return UIStatusBarStyleLightContent;
}
///字体颜色
- (UIColor *)theme_textColor {
    return [UIColor theme_hexColor:@"#BD98F5"];
}

@end
