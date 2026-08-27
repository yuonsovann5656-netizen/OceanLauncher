// Ocean Launcher — a re-brand of Zenith Launcher / AngelAuraAmethyst / PojavLauncher
// Copyright (C) 2024 Ocean Launcher Contributors
// SPDX-License-Identifier: GPL-3.0-or-later
//
// Based on Zenith Launcher (https://github.com/thenullastris/Zenith-Launcher)
// Original project licensed under GPL-3.0

#import "OceanTheme.h"

// ── Color Constants ───────────────────────────────────────────────────────────

UIColor *OceanColorBackground;
UIColor *OceanColorSurface;
UIColor *OceanColorCard;
UIColor *OceanColorCardBorder;
UIColor *OceanColorAccent;
UIColor *OceanColorTeal;
UIColor *OceanColorTextPrimary;
UIColor *OceanColorTextSecondary;
UIColor *OceanColorDanger;
UIColor *OceanColorSuccess;
UIColor *OceanColorOverlay;

// ── OceanTheme Implementation ─────────────────────────────────────────────────

@implementation OceanTheme

+ (void)initialize {
    if (self == [OceanTheme class]) {
        OceanColorBackground   = [UIColor colorWithRed:0.020 green:0.051 blue:0.102 alpha:1.0]; // #050D1A
        OceanColorSurface      = [UIColor colorWithRed:0.039 green:0.086 blue:0.157 alpha:1.0]; // #0A1628
        OceanColorCard         = [UIColor colorWithRed:0.051 green:0.122 blue:0.235 alpha:0.80]; // #0D1F3C 80%
        OceanColorCardBorder   = [UIColor colorWithRed:0.055 green:0.647 blue:0.914 alpha:0.25]; // #0EA5E9 25%
        OceanColorAccent       = [UIColor colorWithRed:0.055 green:0.647 blue:0.914 alpha:1.0]; // #0EA5E9
        OceanColorTeal         = [UIColor colorWithRed:0.000 green:0.847 blue:0.784 alpha:1.0]; // #00D8C8
        OceanColorTextPrimary  = [UIColor colorWithWhite:1.0 alpha:1.0];
        OceanColorTextSecondary= [UIColor colorWithRed:0.580 green:0.639 blue:0.718 alpha:1.0]; // #94A3B8
        OceanColorDanger       = [UIColor colorWithRed:0.957 green:0.247 blue:0.369 alpha:1.0]; // #F43F5E
        OceanColorSuccess      = [UIColor colorWithRed:0.133 green:0.827 blue:0.933 alpha:1.0]; // #22D3EE
        OceanColorOverlay      = [UIColor colorWithRed:0.020 green:0.051 blue:0.102 alpha:0.75];
    }
}

+ (instancetype)shared {
    static OceanTheme *_shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[OceanTheme alloc] init];
    });
    return _shared;
}

// ── Global UIAppearance pass ──────────────────────────────────────────────────

- (void)applyGlobalAppearance {
    // Navigation bar
    UINavigationBarAppearance *navAppearance = [[UINavigationBarAppearance alloc] init];
    navAppearance.configureWithOpaqueBackground;
    navAppearance.backgroundColor = OceanColorSurface;
    navAppearance.titleTextAttributes = @{
        NSForegroundColorAttributeName: OceanColorTextPrimary,
        NSFontAttributeName: [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]
    };
    navAppearance.largeTitleTextAttributes = @{
        NSForegroundColorAttributeName: OceanColorTextPrimary,
        NSFontAttributeName: [UIFont systemFontOfSize:34.0 weight:UIFontWeightBold]
    };
    navAppearance.shadowColor = [UIColor clearColor];
    
    UINavigationBar.appearance.standardAppearance = navAppearance;
    UINavigationBar.appearance.scrollEdgeAppearance = navAppearance;
    UINavigationBar.appearance.compactAppearance = navAppearance;
    UINavigationBar.appearance.tintColor = OceanColorAccent;
    
    // Tab bar
    UITabBarAppearance *tabAppearance = [[UITabBarAppearance alloc] init];
    tabAppearance.configureWithOpaqueBackground;
    tabAppearance.backgroundColor = OceanColorSurface;
    UITabBar.appearance.standardAppearance = tabAppearance;
    UITabBar.appearance.tintColor = OceanColorAccent;
    
    // Toolbar
    UIToolbarAppearance *toolbarAppearance = [[UIToolbarAppearance alloc] init];
    toolbarAppearance.configureWithOpaqueBackground;
    toolbarAppearance.backgroundColor = OceanColorSurface;
    toolbarAppearance.shadowColor = [UIColor clearColor];
    UIToolbar.appearance.standardAppearance = toolbarAppearance;
    UIToolbar.appearance.tintColor = OceanColorAccent;
    
    // Table view
    UITableView.appearance.backgroundColor = OceanColorBackground;
    UITableView.appearance.separatorColor = [OceanColorCardBorder colorWithAlphaComponent:0.4];
    
    // Table view cell
    UITableViewCell.appearance.backgroundColor = [UIColor clearColor];
    
    // Switch
    UISwitch.appearance.onTintColor = OceanColorAccent;
    
    // Slider
    UISlider.appearance.minimumTrackTintColor = OceanColorAccent;
    
    // Segmented control
    UISegmentedControl.appearance.selectedSegmentTintColor = OceanColorAccent;
    [UISegmentedControl.appearance setTitleTextAttributes:@{
        NSForegroundColorAttributeName: OceanColorTextPrimary
    } forState:UIControlStateNormal];
    [UISegmentedControl.appearance setTitleTextAttributes:@{
        NSForegroundColorAttributeName: OceanColorBackground
    } forState:UIControlStateSelected];
    
    // Progress view
    UIProgressView.appearance.progressTintColor = OceanColorAccent;
    UIProgressView.appearance.trackTintColor = [OceanColorCardBorder colorWithAlphaComponent:0.3];
    
    // Override the root window background
    UIView.appearance.tintColor = OceanColorAccent;
}

// ── Individual Component Styling ──────────────────────────────────────────────

- (void)applyOceanNavigationBar:(UINavigationBar *)navBar {
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    [appearance configureWithOpaqueBackground];
    appearance.backgroundColor = OceanColorSurface;
    appearance.titleTextAttributes = @{
        NSForegroundColorAttributeName: OceanColorTextPrimary,
        NSFontAttributeName: [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]
    };
    appearance.shadowColor = [UIColor clearColor];
    navBar.standardAppearance = appearance;
    navBar.scrollEdgeAppearance = appearance;
    navBar.tintColor = OceanColorAccent;
}

- (void)applyOceanToolbar:(UIToolbar *)toolbar {
    UIToolbarAppearance *appearance = [[UIToolbarAppearance alloc] init];
    [appearance configureWithOpaqueBackground];
    appearance.backgroundColor = OceanColorSurface;
    appearance.shadowColor = [UIColor clearColor];
    toolbar.standardAppearance = appearance;
    toolbar.tintColor = OceanColorAccent;
    toolbar.barStyle = UIBarStyleBlack;
}

- (void)applyOceanTableView:(UITableView *)tableView {
    tableView.backgroundColor = OceanColorBackground;
    tableView.separatorColor = [OceanColorCardBorder colorWithAlphaComponent:0.35];
    tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
}

// ── Glassmorphism Helpers ─────────────────────────────────────────────────────

- (void)applyGlassEffect:(UIView *)view cornerRadius:(CGFloat)cornerRadius {
    // Background color with semi-transparency
    view.backgroundColor = OceanColorCard;
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    
    // Border glow
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = OceanColorCardBorder.CGColor;
    
    // Add blur effect behind if not already present
    BOOL hasBlur = NO;
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UIVisualEffectView class]]) {
            hasBlur = YES; break;
        }
    }
    if (!hasBlur) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = view.bounds;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        blurView.alpha = 0.6;
        [view insertSubview:blurView atIndex:0];
    }
}

- (void)applyAccentBorder:(UIView *)view cornerRadius:(CGFloat)cornerRadius {
    view.layer.cornerRadius = cornerRadius;
    view.layer.borderWidth = 1.5;
    view.layer.borderColor = OceanColorAccent.CGColor;
    
    // Outer glow via shadow
    view.layer.shadowColor = OceanColorAccent.CGColor;
    view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowRadius = 8.0;
    view.layer.shadowOpacity = 0.45;
    view.layer.masksToBounds = NO;
}

- (void)styleTableCell:(UITableViewCell *)cell {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = OceanColorTextPrimary;
    cell.detailTextLabel.textColor = OceanColorTextSecondary;
    cell.tintColor = OceanColorAccent;
    
    UIView *selectedBG = [[UIView alloc] init];
    selectedBG.backgroundColor = [OceanColorAccent colorWithAlphaComponent:0.12];
    cell.selectedBackgroundView = selectedBG;
    
    // Accessory chevron tint
    cell.accessoryView = nil;
    if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (UIView *)makeSectionHeader:(NSString *)title {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    container.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 300, 24)];
    label.text = [title uppercaseString];
    label.textColor = OceanColorTextSecondary;
    label.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightSemibold];
    label.letterSpacing = 1.2; // via attributed string below
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[title uppercaseString]];
    [attrStr addAttribute:NSKernAttributeName value:@1.5 range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:OceanColorAccent range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0 weight:UIFontWeightSemibold] range:NSMakeRange(0, attrStr.length)];
    label.attributedText = attrStr;
    
    [container addSubview:label];
    return container;
}

// ── Pulse Animation ───────────────────────────────────────────────────────────

static NSString *const kPulseAnimationKey = @"oceanPulseAnimation";

- (void)startPulseAnimation:(UIView *)view color:(UIColor *)color {
    // Shadow pulse
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowOpacity = 0.0;
    view.layer.shadowRadius = 20.0;
    view.layer.masksToBounds = NO;
    
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    pulse.fromValue = @0.0;
    pulse.toValue = @0.75;
    pulse.duration = 1.2;
    pulse.autoreverses = YES;
    pulse.repeatCount = HUGE_VALF;
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [view.layer addAnimation:pulse forKey:kPulseAnimationKey];
}

- (void)stopPulseAnimation:(UIView *)view {
    [view.layer removeAnimationForKey:kPulseAnimationKey];
    view.layer.shadowOpacity = 0.0;
}

@end

// ── OceanButton Implementation ────────────────────────────────────────────────

@implementation OceanButton

+ (instancetype)primaryButtonWithTitle:(NSString *)title {
    OceanButton *btn = [OceanButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:OceanColorTextPrimary forState:UIControlStateNormal];
    btn.backgroundColor = OceanColorAccent;
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightSemibold];
    btn.layer.cornerRadius = 12.0;
    btn.layer.masksToBounds = YES;
    btn.contentEdgeInsets = UIEdgeInsetsMake(12, 20, 12, 20);
    return btn;
}

+ (instancetype)secondaryButtonWithTitle:(NSString *)title {
    OceanButton *btn = [OceanButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:OceanColorAccent forState:UIControlStateNormal];
    btn.backgroundColor = [OceanColorAccent colorWithAlphaComponent:0.12];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium];
    btn.layer.cornerRadius = 12.0;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = OceanColorAccent.CGColor;
    btn.layer.masksToBounds = YES;
    btn.contentEdgeInsets = UIEdgeInsetsMake(12, 20, 12, 20);
    return btn;
}

+ (instancetype)dangerButtonWithTitle:(NSString *)title {
    OceanButton *btn = [OceanButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:OceanColorTextPrimary forState:UIControlStateNormal];
    btn.backgroundColor = [OceanColorDanger colorWithAlphaComponent:0.85];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightSemibold];
    btn.layer.cornerRadius = 12.0;
    btn.layer.masksToBounds = YES;
    btn.contentEdgeInsets = UIEdgeInsetsMake(12, 20, 12, 20);
    return btn;
}

+ (instancetype)playButton {
    OceanButton *btn = [OceanButton buttonWithType:UIButtonTypeSystem];
    
    // Build attributed title: "▶  PLAY"
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
    [btn setAttributedTitle:title forState:UIControlStateNormal];
    
    // Gradient background
    btn.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = @[
        (id)[UIColor colorWithRed:0.055 green:0.647 blue:0.914 alpha:1.0].CGColor, // #0EA5E9
        (id)[UIColor colorWithRed:0.000 green:0.847 blue:0.784 alpha:1.0].CGColor  // #00D8C8
    ];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint   = CGPointMake(1.0, 0.5);
    gradient.cornerRadius = 20.0;
    gradient.frame = CGRectMake(0, 0, 260, 64);
    [btn.layer insertSublayer:gradient atIndex:0];
    
    btn.layer.cornerRadius = 20.0;
    btn.layer.masksToBounds = NO;
    btn.contentEdgeInsets = UIEdgeInsetsMake(16, 48, 16, 48);
    
    // Glow
    btn.layer.shadowColor = OceanColorAccent.CGColor;
    btn.layer.shadowOffset = CGSizeZero;
    btn.layer.shadowRadius = 18.0;
    btn.layer.shadowOpacity = 0.6;
    
    return btn;
}

// Scale-down press effect
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:0.12 animations:^{
        self.transform = CGAffineTransformMakeScale(0.96, 0.96);
        self.alpha = 0.9;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [UIView animateWithDuration:0.18 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:0 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    } completion:nil];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [UIView animateWithDuration:0.18 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    }];
}

@end

// ── OceanCardView Implementation ──────────────────────────────────────────────

@implementation OceanCardView

- (instancetype)initWithFrame:(CGRect)frame showAccentBorder:(BOOL)showAccentBorder {
    self = [super initWithFrame:frame];
    if (self) {
        _cardCornerRadius = 16.0;
        _showAccentBorder = showAccentBorder;
        [self _setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame showAccentBorder:NO];
}

- (void)_setup {
    self.backgroundColor = OceanColorCard;
    self.layer.cornerRadius = _cardCornerRadius;
    self.layer.masksToBounds = NO;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = OceanColorCardBorder.CGColor;
    
    // Blur underneath
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame = self.bounds;
    blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blurView.alpha = 0.55;
    blurView.layer.cornerRadius = _cardCornerRadius;
    blurView.layer.masksToBounds = YES;
    [self insertSubview:blurView atIndex:0];
    
    // Subtle drop shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 4);
    self.layer.shadowRadius = 12.0;
    self.layer.shadowOpacity = 0.45;
    
    if (_showAccentBorder) {
        self.layer.borderColor = OceanColorAccent.CGColor;
        self.layer.borderWidth = 1.5;
        self.layer.shadowColor = OceanColorAccent.CGColor;
        self.layer.shadowOpacity = 0.35;
        self.layer.shadowRadius = 10.0;
    }
}

@end

// ── OceanProgressView Implementation ─────────────────────────────────────────

@implementation OceanProgressView {
    UIView *_trackView;
    UIView *_fillView;
    CAGradientLayer *_fillGradient;
    CGFloat _currentProgress;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupProgressBar];
    }
    return self;
}

- (void)_setupProgressBar {
    self.backgroundColor = [UIColor clearColor];
    _currentProgress = 0.0;
    
    // Track
    _trackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 6)];
    _trackView.backgroundColor = [OceanColorCardBorder colorWithAlphaComponent:0.3];
    _trackView.layer.cornerRadius = 3.0;
    _trackView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_trackView];
    
    // Fill with gradient
    _fillView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 6)];
    _fillView.layer.cornerRadius = 3.0;
    _fillView.layer.masksToBounds = YES;
    
    _fillGradient = [CAGradientLayer layer];
    _fillGradient.colors = @[
        (id)OceanColorAccent.CGColor,
        (id)OceanColorTeal.CGColor
    ];
    _fillGradient.startPoint = CGPointMake(0, 0.5);
    _fillGradient.endPoint = CGPointMake(1, 0.5);
    _fillGradient.frame = CGRectMake(0, 0, self.bounds.size.width, 6);
    [_fillView.layer addSublayer:_fillGradient];
    [_trackView addSubview:_fillView];
    
    // Glow on fill
    _fillView.layer.shadowColor = OceanColorAccent.CGColor;
    _fillView.layer.shadowOffset = CGSizeMake(0, 0);
    _fillView.layer.shadowRadius = 4.0;
    _fillView.layer.shadowOpacity = 0.65;
    
    // Status label
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, self.bounds.size.width, 20)];
    _statusLabel.textColor = OceanColorTextSecondary;
    _statusLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
    _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_statusLabel];
}

- (void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}

- (float)progress {
    return _currentProgress;
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    _currentProgress = MAX(0.0, MIN(1.0, progress));
    CGFloat fullWidth = _trackView.bounds.size.width;
    CGFloat targetWidth = fullWidth * _currentProgress;
    
    void (^update)(void) = ^{
        self->_fillView.frame = CGRectMake(0, 0, targetWidth, 6);
        self->_fillGradient.frame = CGRectMake(0, 0, MAX(targetWidth, 1), 6);
    };
    
    if (animated) {
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:update completion:nil];
    } else {
        update();
    }
}

@end
