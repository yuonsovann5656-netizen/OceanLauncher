// Ocean Launcher — a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later
//
// Based on Zenith Launcher (https://github.com/thenullastris/Zenith-Launcher)
// Original project licensed under GPL-3.0

#import "OceanHomeViewController.h"
#import "OceanTheme.h"

// ── Recent Profile Cell ───────────────────────────────────────────────────────

@interface OceanRecentProfileCell : UICollectionViewCell
@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *versionLabel;
- (void)configureWithProfile:(NSDictionary *)profile;
@end

@implementation OceanRecentProfileCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[OceanTheme shared] applyGlassEffect:self.contentView cornerRadius:14];
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 36, 36)];
        _iconView.layer.cornerRadius = 8;
        _iconView.layer.masksToBounds = YES;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.image = [UIImage imageNamed:@"DefaultProfile"];
        [self.contentView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 12, frame.size.width - 68, 20)];
        _nameLabel.textColor = OceanColorTextPrimary;
        _nameLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightSemibold];
        _nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_nameLabel];
        
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 32, frame.size.width - 68, 16)];
        _versionLabel.textColor = OceanColorTextSecondary;
        _versionLabel.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
        _versionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_versionLabel];
    }
    return self;
}

- (void)configureWithProfile:(NSDictionary *)profile {
    _nameLabel.text = profile[@"name"] ?: @"Default";
    _versionLabel.text = profile[@"lastVersionId"] ?: @"—";
}

@end

// ── News Card Cell ────────────────────────────────────────────────────────────

@interface OceanNewsCell : UITableViewCell
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) UIView *typePill;
@property(nonatomic, strong) UILabel *typeLabel;
- (void)configureWithTitle:(NSString *)title date:(NSString *)date type:(NSString *)type;
@end

@implementation OceanNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        OceanCardView *card = [[OceanCardView alloc] initWithFrame:CGRectMake(16, 8, 280, 70)];
        card.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        card.tag = 999;
        [self.contentView addSubview:card];
        
        _typePill = [[UIView alloc] initWithFrame:CGRectMake(12, 10, 60, 18)];
        _typePill.backgroundColor = [OceanColorAccent colorWithAlphaComponent:0.2];
        _typePill.layer.cornerRadius = 9;
        [card addSubview:_typePill];
        
        _typeLabel = [[UILabel alloc] initWithFrame:_typePill.bounds];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.textColor = OceanColorAccent;
        _typeLabel.font = [UIFont systemFontOfSize:9.5 weight:UIFontWeightBold];
        [_typePill addSubview:_typeLabel];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 32, card.bounds.size.width - 24, 20)];
        _titleLabel.textColor = OceanColorTextPrimary;
        _titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightSemibold];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [card addSubview:_titleLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 50, card.bounds.size.width - 24, 14)];
        _dateLabel.textColor = OceanColorTextSecondary;
        _dateLabel.font = [UIFont systemFontOfSize:11.0];
        _dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [card addSubview:_dateLabel];
    }
    return self;
}

- (void)configureWithTitle:(NSString *)title date:(NSString *)date type:(NSString *)type {
    _titleLabel.text = title;
    _dateLabel.text = date;
    _typeLabel.text = [type uppercaseString];
    
    if ([type isEqualToString:@"Release"]) {
        _typePill.backgroundColor = [OceanColorSuccess colorWithAlphaComponent:0.2];
        _typeLabel.textColor = OceanColorSuccess;
    } else if ([type isEqualToString:@"Snapshot"]) {
        _typePill.backgroundColor = [OceanColorTeal colorWithAlphaComponent:0.2];
        _typeLabel.textColor = OceanColorTeal;
    } else {
        _typePill.backgroundColor = [OceanColorAccent colorWithAlphaComponent:0.2];
        _typeLabel.textColor = OceanColorAccent;
    }
}

@end

// ── OceanHomeViewController ───────────────────────────────────────────────────

@interface OceanHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

// Player card
@property(nonatomic, strong) OceanCardView *playerCard;
@property(nonatomic, strong) UIImageView *avatarView;
@property(nonatomic, strong) UILabel *usernameLabel;
@property(nonatomic, strong) UILabel *accountTypeLabel;
@property(nonatomic, strong) UIView *accountTypePill;

// Version card
@property(nonatomic, strong) OceanCardView *versionCard;
@property(nonatomic, strong) UILabel *versionIdLabel;
@property(nonatomic, strong) UIView *versionTypePill;
@property(nonatomic, strong) UILabel *versionTypeLabel;
@property(nonatomic, strong) UIButton *changeVersionButton;

// PLAY button
@property(nonatomic, strong) OceanButton *playButton;
@property(nonatomic, strong) UIActivityIndicatorView *playSpinner;

// Recently played section
@property(nonatomic, strong) UILabel *recentHeaderLabel;
@property(nonatomic, strong) UICollectionView *recentProfilesCV;
@property(nonatomic, strong) NSArray<NSDictionary *> *recentProfiles;

// News section
@property(nonatomic, strong) UILabel *newsHeaderLabel;
@property(nonatomic, strong) UITableView *newsTableView;
@property(nonatomic, strong) NSArray<NSDictionary *> *newsItems;

// Layout
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *contentView;

@end

@implementation OceanHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = OceanColorBackground;
    
    [self _setupScrollView];
    [self _setupPlayerCard];
    [self _setupVersionCard];
    [self _setupPlayButton];
    [self _setupRecentProfiles];
    [self _setupNewsSection];
    [self _loadDefaultNewsItems];
    
    // Start PLAY button pulse
    [[OceanTheme shared] startPulseAnimation:_playButton color:OceanColorAccent];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self _layoutContent];
}

// ── Scroll View Setup ─────────────────────────────────────────────────────────

- (void)_setupScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1200)];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_scrollView addSubview:_contentView];
}

// ── Player Card ───────────────────────────────────────────────────────────────

- (void)_setupPlayerCard {
    CGFloat w = MIN(self.view.bounds.size.width - 32, 600);
    _playerCard = [[OceanCardView alloc] initWithFrame:CGRectMake(16, 20, w, 80) showAccentBorder:NO];
    _playerCard.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_contentView addSubview:_playerCard];
    
    // Avatar circle
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 52, 52)];
    _avatarView.layer.cornerRadius = 26;
    _avatarView.layer.masksToBounds = YES;
    _avatarView.layer.borderWidth = 2;
    _avatarView.layer.borderColor = OceanColorAccent.CGColor;
    _avatarView.image = [UIImage imageNamed:@"DefaultAccount"];
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    [_playerCard addSubview:_avatarView];
    
    // Username
    _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 16, w - 100, 24)];
    _usernameLabel.textColor = OceanColorTextPrimary;
    _usernameLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];
    _usernameLabel.text = @"Player";
    _usernameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_playerCard addSubview:_usernameLabel];
    
    // Account type pill
    _accountTypePill = [[UIView alloc] initWithFrame:CGRectMake(78, 44, 80, 20)];
    _accountTypePill.backgroundColor = [OceanColorAccent colorWithAlphaComponent:0.15];
    _accountTypePill.layer.cornerRadius = 10;
    [_playerCard addSubview:_accountTypePill];
    
    _accountTypeLabel = [[UILabel alloc] initWithFrame:_accountTypePill.bounds];
    _accountTypeLabel.textAlignment = NSTextAlignmentCenter;
    _accountTypeLabel.textColor = OceanColorAccent;
    _accountTypeLabel.font = [UIFont systemFontOfSize:10.5 weight:UIFontWeightSemibold];
    _accountTypeLabel.text = @"Offline";
    [_accountTypePill addSubview:_accountTypeLabel];
}

// ── Version Card ──────────────────────────────────────────────────────────────

- (void)_setupVersionCard {
    CGFloat w = MIN(self.view.bounds.size.width - 32, 600);
    _versionCard = [[OceanCardView alloc] initWithFrame:CGRectMake(16, 116, w, 64) showAccentBorder:NO];
    _versionCard.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_contentView addSubview:_versionCard];
    
    // MC icon
    UILabel *mcIcon = [[UILabel alloc] initWithFrame:CGRectMake(14, 16, 32, 32)];
    mcIcon.text = @"⛏";
    mcIcon.font = [UIFont systemFontOfSize:22];
    [_versionCard addSubview:mcIcon];
    
    // Version ID
    _versionIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 10, w - 130, 24)];
    _versionIdLabel.textColor = OceanColorTextPrimary;
    _versionIdLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
    _versionIdLabel.text = @"No version selected";
    _versionIdLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_versionCard addSubview:_versionIdLabel];
    
    // Version type pill
    _versionTypePill = [[UIView alloc] initWithFrame:CGRectMake(54, 36, 70, 18)];
    _versionTypePill.backgroundColor = [OceanColorTeal colorWithAlphaComponent:0.18];
    _versionTypePill.layer.cornerRadius = 9;
    [_versionCard addSubview:_versionTypePill];
    
    _versionTypeLabel = [[UILabel alloc] initWithFrame:_versionTypePill.bounds];
    _versionTypeLabel.textAlignment = NSTextAlignmentCenter;
    _versionTypeLabel.textColor = OceanColorTeal;
    _versionTypeLabel.font = [UIFont systemFontOfSize:9.5 weight:UIFontWeightBold];
    _versionTypeLabel.text = @"VANILLA";
    [_versionTypePill addSubview:_versionTypeLabel];
    
    // Change version button
    _changeVersionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_changeVersionButton setTitle:@"Change" forState:UIControlStateNormal];
    [_changeVersionButton setTitleColor:OceanColorAccent forState:UIControlStateNormal];
    _changeVersionButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    _changeVersionButton.frame = CGRectMake(w - 80, 14, 70, 36);
    _changeVersionButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [_changeVersionButton addTarget:self action:@selector(_changeVersionTapped) forControlEvents:UIControlEventTouchUpInside];
    [_versionCard addSubview:_changeVersionButton];
}

// ── PLAY Button ───────────────────────────────────────────────────────────────

- (void)_setupPlayButton {
    _playButton = [OceanButton playButton];
    _playButton.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat w = MIN(self.view.bounds.size.width - 80, 320);
    _playButton.frame = CGRectMake((self.view.bounds.size.width - w) / 2.0, 196, w, 64);
    _playButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [_playButton addTarget:self action:@selector(_playTapped) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_playButton];
    
    // Spinner (hidden by default)
    _playSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    _playSpinner.color = OceanColorBackground;
    _playSpinner.center = CGPointMake(_playButton.bounds.size.width / 2.0, _playButton.bounds.size.height / 2.0);
    _playSpinner.hidesWhenStopped = YES;
    [_playButton addSubview:_playSpinner];
}

// ── Recent Profiles ───────────────────────────────────────────────────────────

- (void)_setupRecentProfiles {
    _recentHeaderLabel = [[OceanTheme shared] makeSectionHeader:@"Recently Played"];
    _recentHeaderLabel.frame = CGRectMake(0, 280, self.view.bounds.size.width, 40);
    _recentHeaderLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_contentView addSubview:_recentHeaderLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(200, 60);
    layout.minimumLineSpacing = 12;
    layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    
    _recentProfilesCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 320, self.view.bounds.size.width, 76) collectionViewLayout:layout];
    _recentProfilesCV.backgroundColor = [UIColor clearColor];
    _recentProfilesCV.showsHorizontalScrollIndicator = NO;
    _recentProfilesCV.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _recentProfilesCV.dataSource = self;
    _recentProfilesCV.delegate = self;
    [_recentProfilesCV registerClass:[OceanRecentProfileCell class] forCellWithReuseIdentifier:@"ProfileCell"];
    [_contentView addSubview:_recentProfilesCV];
    
    _recentProfiles = @[];
}

// ── News Section ──────────────────────────────────────────────────────────────

- (void)_setupNewsSection {
    _newsHeaderLabel = [[OceanTheme shared] makeSectionHeader:@"News & Updates"];
    _newsHeaderLabel.frame = CGRectMake(0, 412, self.view.bounds.size.width, 40);
    _newsHeaderLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_contentView addSubview:_newsHeaderLabel];
    
    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 452, self.view.bounds.size.width, 380) style:UITableViewStylePlain];
    _newsTableView.backgroundColor = [UIColor clearColor];
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _newsTableView.scrollEnabled = NO;
    _newsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    _newsTableView.rowHeight = 86;
    [_newsTableView registerClass:[OceanNewsCell class] forCellReuseIdentifier:@"NewsCell"];
    [_contentView addSubview:_newsTableView];
}

- (void)_loadDefaultNewsItems {
    _newsItems = @[
        @{@"title": @"Ocean Launcher 1.0 Released", @"date": @"2024", @"type": @"Release"},
        @{@"title": @"Minecraft 1.21.4 Now Supported", @"date": @"2024", @"type": @"Release"},
        @{@"title": @"Fabric Loader Updated to 0.16", @"date": @"2024", @"type": @"Snapshot"},
        @{@"title": @"Java 21 Runtime Available", @"date": @"2024", @"type": @"Update"},
    ];
    [_newsTableView reloadData];
}

// ── Layout ────────────────────────────────────────────────────────────────────

- (void)_layoutContent {
    CGFloat w = _contentView.bounds.size.width;
    CGFloat safeTop = self.view.safeAreaInsets.top;
    CGFloat cardW = MIN(w - 32, 600);
    CGFloat cardX = (w - cardW) / 2.0;
    
    _playerCard.frame = CGRectMake(cardX, safeTop + 16, cardW, 80);
    _versionCard.frame = CGRectMake(cardX, safeTop + 108, cardW, 64);
    
    CGFloat playW = MIN(w - 80, 320);
    _playButton.frame = CGRectMake((w - playW) / 2.0, safeTop + 192, playW, 64);
    
    _recentHeaderLabel.frame = CGRectMake(0, safeTop + 278, w, 40);
    _recentProfilesCV.frame = CGRectMake(0, safeTop + 316, w, 76);
    _newsHeaderLabel.frame = CGRectMake(0, safeTop + 408, w, 40);
    _newsTableView.frame = CGRectMake(0, safeTop + 448, w, CGFloat(_newsItems.count) * 86.0);
    
    CGFloat totalHeight = safeTop + 448 + CGFloat(_newsItems.count) * 86.0 + 40;
    _contentView.frame = CGRectMake(0, 0, w, totalHeight);
    _scrollView.contentSize = CGSizeMake(w, totalHeight);
}

// ── Public API ────────────────────────────────────────────────────────────────

- (void)updateWithUsername:(NSString *)username
                 avatarURL:(nullable NSString *)avatarURL
               accountType:(NSString *)accountType {
    _usernameLabel.text = username ?: @"Player";
    _accountTypeLabel.text = [accountType uppercaseString];
    
    BOOL isMicrosoft = [accountType isEqualToString:@"Microsoft"];
    _accountTypePill.backgroundColor = isMicrosoft
        ? [OceanColorSuccess colorWithAlphaComponent:0.15]
        : [OceanColorAccent colorWithAlphaComponent:0.15];
    _accountTypeLabel.textColor = isMicrosoft ? OceanColorSuccess : OceanColorAccent;
    
    if (avatarURL) {
        // Load avatar asynchronously using NSURLSession
        NSURL *url = [NSURL URLWithString:avatarURL];
        if (url) {
            NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (data && !error) {
                    UIImage *img = [UIImage imageWithData:data];
                    if (img) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self->_avatarView.image = img;
                        });
                    }
                }
            }];
            [task resume];
        }
    }
}

- (void)updateSelectedVersion:(NSString *)versionId type:(NSString *)versionType {
    _versionIdLabel.text = versionId ?: @"No version selected";
    _versionTypeLabel.text = [versionType uppercaseString];
    
    UIColor *pillColor = OceanColorTeal;
    if ([versionType isEqualToString:@"Release"])      pillColor = OceanColorSuccess;
    else if ([versionType isEqualToString:@"Snapshot"]) pillColor = OceanColorTeal;
    else if ([versionType isEqualToString:@"Fabric"])   pillColor = OceanColorAccent;
    else if ([versionType isEqualToString:@"Forge"])    pillColor = [UIColor colorWithRed:0.98 green:0.45 blue:0.09 alpha:1.0];
    else if ([versionType isEqualToString:@"NeoForge"]) pillColor = [UIColor colorWithRed:0.98 green:0.60 blue:0.09 alpha:1.0];
    
    _versionTypePill.backgroundColor = [pillColor colorWithAlphaComponent:0.18];
    _versionTypeLabel.textColor = pillColor;
    
    // Resize pill to fit text
    CGFloat pillW = MAX(70, [versionType uppercaseString].length * 7.5 + 16);
    _versionTypePill.frame = CGRectMake(54, 36, pillW, 18);
    _versionTypeLabel.frame = _versionTypePill.bounds;
}

- (void)updateRecentProfiles:(NSArray<NSDictionary *> *)profiles {
    _recentProfiles = profiles ?: @[];
    [_recentProfilesCV reloadData];
    [self _layoutContent];
}

- (void)setPlayButtonLoading:(BOOL)loading {
    if (loading) {
        [_playButton setAttributedTitle:nil forState:UIControlStateNormal];
        [_playButton setTitle:@"" forState:UIControlStateNormal];
        [_playSpinner startAnimating];
        _playButton.userInteractionEnabled = NO;
        [[OceanTheme shared] stopPulseAnimation:_playButton];
    } else {
        [_playSpinner stopAnimating];
        _playButton.userInteractionEnabled = YES;
        [[OceanTheme shared] startPulseAnimation:_playButton color:OceanColorAccent];
        // Restore attributed title
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
        NSAttributedString *icon = [[NSAttributedString alloc] initWithString:@"▶  " attributes:@{
            NSForegroundColorAttributeName: OceanColorBackground,
            NSFontAttributeName: [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold]
        }];
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"PLAY" attributes:@{
            NSForegroundColorAttributeName: OceanColorBackground,
            NSFontAttributeName: [UIFont systemFontOfSize:22.0 weight:UIFontWeightHeavy],
            NSKernAttributeName: @3.0
        }];
        [title appendAttributedString:icon];
        [title appendAttributedString:text];
        [_playButton setAttributedTitle:title forState:UIControlStateNormal];
    }
}

// ── Button Actions ────────────────────────────────────────────────────────────

- (void)_playTapped {
    if (self.onPlayTapped) self.onPlayTapped();
}

- (void)_changeVersionTapped {
    if (self.onVersionTapped) self.onVersionTapped();
}

// ── UICollectionView DataSource/Delegate ──────────────────────────────────────

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section {
    return MAX(_recentProfiles.count, 1); // Show placeholder if empty
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OceanRecentProfileCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    if (indexPath.item < _recentProfiles.count) {
        [cell configureWithProfile:_recentProfiles[indexPath.item]];
    } else {
        [cell configureWithProfile:@{@"name": @"Default", @"lastVersionId": @"Latest"}];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < _recentProfiles.count) {
        NSDictionary *profile = _recentProfiles[indexPath.item];
        if (self.onProfileSelected) self.onProfileSelected(profile[@"name"]);
    }
}

// ── UITableView DataSource/Delegate (News) ────────────────────────────────────

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return _newsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OceanNewsCell *cell = [tv dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    NSDictionary *item = _newsItems[indexPath.row];
    [cell configureWithTitle:item[@"title"] date:item[@"date"] type:item[@"type"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

@end
