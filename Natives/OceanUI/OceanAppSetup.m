// Ocean Launcher — a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later

#import "OceanAppSetup.h"
#import "OceanTheme.h"
#import <objc/runtime.h>

/// Helper to swizzle instance methods
static void OceanSwizzleMethod(Class cls, SEL origSel, SEL newSel) {
    Method origMethod = class_getInstanceMethod(cls, origSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    if (!origMethod || !newMethod) {
        NSLog(@"[OceanLauncher] Failed to find methods for swizzling on %@", NSStringFromClass(cls));
        return;
    }
    if (class_addMethod(cls, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(cls, newSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@implementation OceanAppSetup

+ (void)initializeOceanTheme {
    // 1. Apply global appearance proxy (Colors, nav bars, etc.)
    [[OceanTheme shared] applyGlobalAppearance];
    
    // 2. Swizzle specific View Controllers to apply Ocean styling non-destructively
    
    // LauncherProfilesViewController
    Class profilesVC = NSClassFromString(@"LauncherProfilesViewController");
    if (profilesVC) {
        OceanSwizzleMethod(profilesVC, @selector(viewDidLoad), @selector(ocean_profiles_viewDidLoad));
        OceanSwizzleMethod(profilesVC, @selector(tableView:cellForRowAtIndexPath:), @selector(ocean_profiles_tableView:cellForRowAtIndexPath:));
    }
    
    // LauncherMenuViewController
    Class menuVC = NSClassFromString(@"LauncherMenuViewController");
    if (menuVC) {
        OceanSwizzleMethod(menuVC, @selector(viewDidLoad), @selector(ocean_menu_viewDidLoad));
        OceanSwizzleMethod(menuVC, @selector(tableView:cellForRowAtIndexPath:), @selector(ocean_menu_tableView:cellForRowAtIndexPath:));
    }
    
    // LauncherPreferencesViewController
    Class prefVC = NSClassFromString(@"LauncherPreferencesViewController");
    if (prefVC) {
        OceanSwizzleMethod(prefVC, @selector(viewDidLoad), @selector(ocean_prefs_viewDidLoad));
        OceanSwizzleMethod(prefVC, @selector(tableView:cellForRowAtIndexPath:), @selector(ocean_prefs_tableView:cellForRowAtIndexPath:));
    }
    
    // AccountListViewController
    Class accVC = NSClassFromString(@"AccountListViewController");
    if (accVC) {
        OceanSwizzleMethod(accVC, @selector(viewDidLoad), @selector(ocean_account_viewDidLoad));
        OceanSwizzleMethod(accVC, @selector(tableView:cellForRowAtIndexPath:), @selector(ocean_account_tableView:cellForRowAtIndexPath:));
    }
    
    // DownloadProgressViewController
    Class dlVC = NSClassFromString(@"DownloadProgressViewController");
    if (dlVC) {
        OceanSwizzleMethod(dlVC, @selector(viewDidLoad), @selector(ocean_download_viewDidLoad));
    }
    
    NSLog(@"[OceanLauncher] OceanTheme initialized and UI hooks installed.");
}

@end
