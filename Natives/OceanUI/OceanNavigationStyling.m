// Ocean Launcher — a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later
//
// Based on Zenith Launcher (https://github.com/thenullastris/Zenith-Launcher)
// Original project licensed under GPL-3.0

#import "OceanNavigationStyling.h"

@implementation LauncherNavigationController (OceanStyling)

- (void)ocean_applyTheme {
    // Apply Ocean navigation bar
    [[OceanTheme shared] applyOceanNavigationBar:self.navigationBar];
    
    // Apply Ocean toolbar
    [[OceanTheme shared] applyOceanToolbar:self.toolbar];
    
    // Set the view background
    self.view.backgroundColor = OceanColorBackground;
    
    // Override the navigation bar separator
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    // Status bar should match ocean dark
    self.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)ocean_styleVersionTextField:(UITextField *)textField {
    // Dark field background
    textField.backgroundColor = OceanColorCard;
    textField.textColor = OceanColorTextPrimary;
    textField.tintColor = OceanColorAccent;
    textField.layer.cornerRadius = 10;
    textField.layer.borderWidth = 1.0;
    textField.layer.borderColor = OceanColorCardBorder.CGColor;
    textField.layer.masksToBounds = YES;
    
    // Placeholder
    if (textField.placeholder) {
        textField.attributedPlaceholder = [[NSAttributedString alloc]
            initWithString:textField.placeholder
            attributes:@{NSForegroundColorAttributeName: OceanColorTextSecondary}];
    }
    
    // Keyboard appearance
    textField.keyboardAppearance = UIKeyboardAppearanceDark;
}

- (UIView *)ocean_makeProgressSection {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    container.backgroundColor = [UIColor clearColor];
    
    // Ocean progress bar
    OceanProgressView *progressView = [[OceanProgressView alloc] initWithFrame:CGRectMake(16, 8, container.bounds.size.width - 32, 24)];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    progressView.statusLabel.text = @"Ready";
    [container addSubview:progressView];
    
    return container;
}

@end
