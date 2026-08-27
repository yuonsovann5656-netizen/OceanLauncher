// Ocean Launcher — a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Main setup class to initialize the Ocean Launcher theme and hook into the existing
/// Zenith UI controllers seamlessly without destructive edits.
@interface OceanAppSetup : NSObject

/// Configures the global appearance and installs method swizzles for UI styling.
/// Must be called from AppDelegate didFinishLaunchingWithOptions.
+ (void)initializeOceanTheme;

@end

NS_ASSUME_NONNULL_END
