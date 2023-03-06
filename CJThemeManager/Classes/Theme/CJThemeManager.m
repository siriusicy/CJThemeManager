//
//  CJThemeManager.m
//  CJThemeManager
//
//  Created by ChenJie on 2023/2/23.
//

#import "CJThemeManager.h"
#import "CJThemeDefault.h"
#import "CJThemeDark.h"

NSString *const YFThemeChangeNotification = @"YFThemeChangeNotification";

@interface CJThemeManager ()

@property (nonatomic, strong) id<CJThemeProtocol> currentTheme;
@property (nonatomic, assign, readwrite) CJThemeType currentThemeType;

@end

@implementation CJThemeManager

+ (CJThemeManager *)sharedManager {
    static dispatch_once_t once;
    static CJThemeManager *instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (id<CJThemeProtocol>)currentTheme {
    return CJThemeManager.sharedManager.currentTheme;
}

+ (CJThemeType)currentThemeType {
    return CJThemeManager.sharedManager.currentThemeType;
}

+ (void)themeChange:(CJThemeType)themeType {
    
    CJThemeManager.sharedManager.currentThemeType = themeType;

}

#pragma mark -  set/get

- (void)setCurrentThemeType:(CJThemeType)currentThemeType {
    if (_currentThemeType == currentThemeType) {
        return;
    }

    switch (currentThemeType) {
        case CJThemeType_Default: {
            CJThemeManager.sharedManager.currentTheme = [[CJThemeDefault alloc] init];
        }
            break;
        case CJThemeType_Dark: {
            CJThemeManager.sharedManager.currentTheme = [[CJThemeDark alloc] init];
        }
            break;
        default: {
            return;
        }
            break;
    }
    
    _currentThemeType = currentThemeType;
    [[NSNotificationCenter defaultCenter] postNotificationName:YFThemeChangeNotification object:nil];
}

- (id<CJThemeProtocol>)currentTheme {
    if (_currentTheme == nil) {
        _currentTheme = [[CJThemeDefault alloc] init];
    }
    return _currentTheme;
}



@end
