//
//  CJViewController.m
//  CJThemeManager
//
//  Created by ChenJie on 03/06/2023.
//  Copyright (c) 2023 ChenJie. All rights reserved.
//

#import "CJViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <CJThemeManager/CJThemeManager.h>

@interface CJViewController ()

@property (nonatomic, strong) UILabel *testLabel1;

@property (nonatomic, strong) UILabel *testLabel2;

@property (nonatomic, strong) UIButton *switchButton;

@end

@implementation CJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.testLabel1];
    [self.testLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(150);
    }];
    
    [self.view addSubview:self.testLabel2];
    [self.testLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(190);
    }];
    
    [self.view addSubview:self.switchButton];
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(60);
        make.bottom.mas_equalTo(-50);
    }];
    
    /// !!!添加block时会立即执行一次block里的内容!!!
    /// --- 主题切换时会调用 ---
    @weakify(self);
    [self yf_addThemeChangedBlock:^(id<CJThemeProtocol>  _Nonnull theme) {
        @strongify(self);
        self.testLabel2.hidden = [CJThemeManager currentThemeType] != CJThemeType_Default;
        self.testLabel1.textColor = theme.theme_textColor;
    }];
    
    /// --- 同一个实例可以多次添加,切换主题时都会调用 ---
    [self yf_addThemeChangedBlock:^(id<CJThemeProtocol>  _Nonnull theme) {
        @strongify(self);
        [self.switchButton setTitleColor:theme.theme_textColor forState:UIControlStateNormal];
        self.switchButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    }];
}

- (void)switchButtonAction:(UIButton *)btn{
    
    CJThemeType theme = [CJThemeManager currentThemeType] == CJThemeType_Default ? CJThemeType_Dark : CJThemeType_Default;
    [CJThemeManager themeChange:theme];
}

#pragma mark -  set/get

- (UILabel *)testLabel1{
    if (_testLabel1 == nil) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor redColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"testLabel_1";
        _testLabel1 = lab;
    }
    return _testLabel1;
}

- (UILabel *)testLabel2{
    if (_testLabel2 == nil) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor redColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"testLabel_2";
        _testLabel2 = lab;
    }
    return _testLabel2;
}

- (UIButton *)switchButton{
    if (_switchButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"SwitchTheme" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventTouchUpInside];

        _switchButton = btn;
    }
    return _switchButton;
}


@end
