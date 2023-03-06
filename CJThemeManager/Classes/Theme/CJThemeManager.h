//
//  CJThemeManager.h
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/23.
//

#import <Foundation/Foundation.h>
#import "CJThemeProtocol.h"
#import "NSObject+Theme.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CJThemeType) {
    CJThemeType_Default = 0,
    CJThemeType_Dark = 1,
};

///主题切换通知
extern NSString *const YFThemeChangeNotification;

@interface CJThemeManager : NSObject

+ (CJThemeManager *)sharedManager ;

///当前主题
+ (id<CJThemeProtocol>)currentTheme;
///当前主题样式
+ (CJThemeType)currentThemeType;
///主题切换
+ (void)themeChange:(CJThemeType)themeType;

@end

NS_ASSUME_NONNULL_END
