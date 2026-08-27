// Ocean Launcher — a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later
//
// Based on Zenith Launcher (https://github.com/thenullastris/Zenith-Launcher)
// Original project licensed under GPL-3.0
//
// FILE: OceanNavigationStyling.h
//
// Drop-in category that applies Ocean theming to LauncherNavigationController.
// Import this file alongside LauncherNavigationController.h in the .m file.
// All existing functionality is preserved — only visual styling is changed.

#import "LauncherNavigationController.h"
#import "OceanTheme.h"

NS_ASSUME_NONNULL_BEGIN

/// Category that adds Ocean theming helpers to LauncherNavigationController.
/// The original LauncherNavigationController.m source is left intact;
/// this category is applied additively via method swizzling in OceanAppSetup.
@interface LauncherNavigationController (OceanStyling)

/// Call this from viewDidLoad after [super viewDidLoad] to apply Ocean styling.
- (void)ocean_applyTheme;

/// Styles the version picker text field with Ocean theme.
- (void)ocean_styleVersionTextField:(UITextField *)textField;

/// Creates the Ocean-styled progress section under the toolbar.
- (UIView *)ocean_makeProgressSection;

@end

NS_ASSUME_NONNULL_END
