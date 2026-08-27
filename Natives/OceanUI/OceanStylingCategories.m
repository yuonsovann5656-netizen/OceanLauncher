// Ocean Launcher — a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later

#import <UIKit/UIKit.h>
#import "OceanTheme.h"

// We use categories to add the swizzled methods without needing the original headers.
// The swizzling is performed by OceanAppSetup.

// ── LauncherProfilesViewController ────────────────────────────────────────────

@interface UIViewController (OceanProfilesStyling)
- (void)ocean_viewDidLoad;
- (UITableViewCell *)ocean_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation UIViewController (OceanProfilesStyling)

- (void)ocean_viewDidLoad {
    [self ocean_viewDidLoad]; // Calls original viewDidLoad
    
    self.view.backgroundColor = OceanColorBackground;
    
    // Find the table view and style it
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tv = (UITableView *)view;
            [[OceanTheme shared] applyOceanTableView:tv];
            tv.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        }
    }
}

- (UITableViewCell *)ocean_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Call original method to get the populated cell
    UITableViewCell *cell = [self ocean_tableView:tableView cellForRowAtIndexPath:indexPath];
    [[OceanTheme shared] styleTableCell:cell];
    return cell;
}

@end

// ── LauncherMenuViewController ────────────────────────────────────────────────

@interface UIViewController (OceanMenuStyling)
- (void)ocean_viewDidLoad;
- (UITableViewCell *)ocean_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation UIViewController (OceanMenuStyling)

- (void)ocean_viewDidLoad {
    [self ocean_viewDidLoad];
    self.view.backgroundColor = OceanColorBackground;
    
    // Style table view
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tv = (UITableView *)view;
            tv.backgroundColor = [UIColor clearColor];
            tv.separatorStyle = UITableViewCellSeparatorStyleNone; // Hide separators on menu
        }
    }
    
    // Replace the titleView (logo)
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppLogo"]];
    [titleView setContentMode:UIViewContentModeScaleAspectFit];
    // Keep it small for the nav bar
    titleView.frame = CGRectMake(0, 0, 160, 36);
    self.navigationItem.titleView = titleView;
}

- (UITableViewCell *)ocean_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self ocean_tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = OceanColorTextPrimary;
    cell.textLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    
    UIView *selectedBG = [[UIView alloc] init];
    selectedBG.backgroundColor = [OceanColorAccent colorWithAlphaComponent:0.15];
    selectedBG.layer.cornerRadius = 8;
    cell.selectedBackgroundView = selectedBG;
    
    // Tint the imageView icon to ocean blue
    if (cell.imageView.image) {
        cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        cell.imageView.tintColor = OceanColorAccent;
    }
    
    return cell;
}

@end

// ── LauncherPreferencesViewController ─────────────────────────────────────────

@interface UIViewController (OceanPreferencesStyling)
- (void)ocean_viewDidLoad;
- (UITableViewCell *)ocean_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation UIViewController (OceanPreferencesStyling)

- (void)ocean_viewDidLoad {
    [self ocean_viewDidLoad];
    self.view.backgroundColor = OceanColorBackground;
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            [[OceanTheme shared] applyOceanTableView:(UITableView *)view];
        }
    }
}

- (UITableViewCell *)ocean_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self ocean_tableView:tableView cellForRowAtIndexPath:indexPath];
    [[OceanTheme shared] styleTableCell:cell];
    return cell;
}

@end

// ── AccountListViewController ─────────────────────────────────────────────────

@interface UIViewController (OceanAccountStyling)
- (void)ocean_viewDidLoad;
- (UITableViewCell *)ocean_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation UIViewController (OceanAccountStyling)

- (void)ocean_viewDidLoad {
    [self ocean_viewDidLoad];
    self.view.backgroundColor = OceanColorBackground;
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            [[OceanTheme shared] applyOceanTableView:(UITableView *)view];
        }
    }
}

- (UITableViewCell *)ocean_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self ocean_tableView:tableView cellForRowAtIndexPath:indexPath];
    [[OceanTheme shared] styleTableCell:cell];
    
    // Add account styling
    if (cell.imageView.image) {
        cell.imageView.layer.cornerRadius = cell.imageView.bounds.size.width / 2.0;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.borderWidth = 1.0;
        cell.imageView.layer.borderColor = OceanColorAccent.CGColor;
    }
    
    return cell;
}

@end

// ── DownloadProgressViewController ────────────────────────────────────────────

@interface UIViewController (OceanDownloadStyling)
- (void)ocean_viewDidLoad;
@end

@implementation UIViewController (OceanDownloadStyling)

- (void)ocean_viewDidLoad {
    [self ocean_viewDidLoad];
    
    // Apply glassmorphism to the download popup
    [[OceanTheme shared] applyGlassEffect:self.view cornerRadius:20];
    [[OceanTheme shared] applyAccentBorder:self.view cornerRadius:20];
    
    // Find UI elements to tint
    for (UIView *sub in self.view.subviews) {
        if ([sub isKindOfClass:[UIProgressView class]]) {
            UIProgressView *pv = (UIProgressView *)sub;
            pv.progressTintColor = OceanColorAccent;
            pv.trackTintColor = [OceanColorCardBorder colorWithAlphaComponent:0.3];
        } else if ([sub isKindOfClass:[UILabel class]]) {
            UILabel *lbl = (UILabel *)sub;
            lbl.textColor = OceanColorTextPrimary;
        } else if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            [btn setTitleColor:OceanColorDanger forState:UIControlStateNormal]; // Cancel button
        }
    }
}

@end
