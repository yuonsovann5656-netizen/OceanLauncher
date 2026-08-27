// Ocean Launcher — a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later
//
// Based on Zenith Launcher (https://github.com/thenullastris/Zenith-Launcher)
// Original project licensed under GPL-3.0

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Ocean Launcher Home Screen.
///
/// Displayed as the first content view inside LauncherNavigationController.
/// Shows the player profile card, selected version, PLAY button, recently
/// played profiles, and the news/update feed.
///
/// This view controller does NOT replace the existing Minecraft launching
/// machinery — it delegates to the existing LauncherNavigationController
/// PLAY action and version selection through the standard channel.
@interface OceanHomeViewController : UIViewController

/// Called when the user taps the PLAY button.
/// Forwarded to the parent LauncherNavigationController.
@property(nonatomic, copy, nullable) void (^onPlayTapped)(void);

/// Called when the user taps a recently-played profile to select it.
@property(nonatomic, copy, nullable) void (^onProfileSelected)(NSString *profileName);

/// Called when the user taps "Change version".
@property(nonatomic, copy, nullable) void (^onVersionTapped)(void);

/// Updates the displayed Minecraft account info.
/// @param username  The player's display name.
/// @param avatarURL The URL string for the player's avatar (Minotar or similar). Nullable.
/// @param accountType  The type of account e.g. "Microsoft", "Offline"
- (void)updateWithUsername:(NSString *)username
                 avatarURL:(nullable NSString *)avatarURL
               accountType:(NSString *)accountType;

/// Updates the displayed selected Minecraft version.
/// @param versionId   e.g. "1.21.4", "1.21.4-fabric"
/// @param versionType e.g. "Release", "Snapshot", "Fabric", "Forge", "NeoForge"
- (void)updateSelectedVersion:(NSString *)versionId type:(NSString *)versionType;

/// Updates the recently-played profiles list.
- (void)updateRecentProfiles:(NSArray<NSDictionary *> *)profiles;

/// Animates a "loading" state on the PLAY button while the game downloads.
- (void)setPlayButtonLoading:(BOOL)loading;

@end

NS_ASSUME_NONNULL_END
