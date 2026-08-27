// Ocean Launcher â€” a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// Based on Zenith Launcher (https://github.com/thenullastris/Zenith-Launcher)
// Which is based on AngelAuraAmethyst and PojavLauncher
// Original project licensed under GPL-3.0

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

// â”€â”€ Ocean Color Constants â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

/// Ocean dark background â€” primary screen background
extern UIColor *OceanColorBackground;
/// Ocean surface â€” slightly lighter, for nav bars and panels
extern UIColor *OceanColorSurface;
/// Ocean card â€” glassmorphism card base
extern UIColor *OceanColorCard;
/// Ocean card border â€” subtle glow border for glass cards
extern UIColor *OceanColorCardBorder;
/// Ocean primary accent â€” ocean blue
extern UIColor *OceanColorAccent;
/// Ocean secondary accent â€” teal glow
extern UIColor *OceanColorTeal;
/// Ocean text primary
extern UIColor *OceanColorTextPrimary;
/// Ocean text secondary / muted
extern UIColor *OceanColorTextSecondary;
/// Ocean danger/error color
extern UIColor *OceanColorDanger;
/// Ocean success color
extern UIColor *OceanColorSuccess;
/// Ocean overlay (semi-transparent dark)
extern UIColor *OceanColorOverlay;

// â”€â”€ Ocean Theme Manager â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

/// Central theming singleton for Ocean Launcher.
/// Provides colors, glassmorphism helpers, and UIAppearance application.
@interface OceanTheme : NSObject

/// Returns the shared theme instance.
+ (instancetype)shared;

/// Applies global UIAppearance styles for all Ocean Launcher UI elements.
/// Call once from AppDelegate after application launch.
- (void)applyGlobalAppearance;

/// Applies Ocean-styled navigation bar appearance to the given navigation bar.
- (void)applyOceanNavigationBar:(UINavigationBar *)navBar;

/// Applies Ocean-styled toolbar appearance to the given toolbar.
- (void)applyOceanToolbar:(UIToolbar *)toolbar;

/// Applies Ocean-styled table view appearance to the given table view.
- (void)applyOceanTableView:(UITableView *)tableView;

/// Adds a glassmorphism visual effect to a UIView.
/// Creates a blur + semi-transparent background + subtle border.
/// @param view The view to apply glassmorphism to.
/// @param cornerRadius The corner radius for the glass card.
- (void)applyGlassEffect:(UIView *)view cornerRadius:(CGFloat)cornerRadius;

/// Applies the Ocean accent border glow to a view.
- (void)applyAccentBorder:(UIView *)view cornerRadius:(CGFloat)cornerRadius;

/// Configures an Ocean-styled table cell (dark background, ocean separator).
- (void)styleTableCell:(UITableViewCell *)cell;

/// Creates a labeled section header view with Ocean styling.
- (UIView *)makeSectionHeader:(NSString *)title;

/// Animates a "pulse glow" on the given view (used for the PLAY button).
- (void)startPulseAnimation:(UIView *)view color:(UIColor *)color;

/// Stops the pulse glow animation.
- (void)stopPulseAnimation:(UIView *)view;

@end

// â”€â”€ Ocean Button â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

/// Pre-styled Ocean Launcher button.
@interface OceanButton : UIButton

/// Primary ocean-blue filled button.
+ (instancetype)primaryButtonWithTitle:(NSString *)title;

/// Secondary outlined button with ocean border.
+ (instancetype)secondaryButtonWithTitle:(NSString *)title;

/// Danger (red/coral) button.
+ (instancetype)dangerButtonWithTitle:(NSString *)title;

/// Large PLAY button with animated glow.
+ (instancetype)playButton;

@end

// â”€â”€ Ocean Card View â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

/// A UIView subclass that renders as a glassmorphism card.
@interface OceanCardView : UIView

/// The corner radius of the card (default: 16).
@property(nonatomic) CGFloat cardCornerRadius;

/// Whether to show the accent border glow (default: NO).
@property(nonatomic) BOOL showAccentBorder;

/// Initializes the card view with optional accent border.
- (instancetype)initWithFrame:(CGRect)frame showAccentBorder:(BOOL)showAccentBorder;

@end

// â”€â”€ Ocean Progress Bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

/// Ocean-styled animated progress bar.
@interface OceanProgressView : UIView

/// Current progress (0.0 â€“ 1.0).
@property(nonatomic) float progress;

/// Subtitle/status label shown below the bar.
@property(nonatomic, strong) UILabel *statusLabel;

/// Animates progress change.
- (void)setProgress:(float)progress animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

