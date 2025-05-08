class AppConstants {
  // Private Constructor
  AppConstants._();

  // App Info
  static const String appName = 'Your Portfolio';
  static const String appDescription =
      'Personal portfolio website showcasing my work and skills';

  // Social Links
  static const String githubUrl = 'https://github.com/yourusername';
  static const String linkedinUrl = 'https://linkedin.com/in/yourusername';
  static const String twitterUrl = 'https://twitter.com/yourusername';
  static const String emailAddress = 'your.email@example.com';

  // Navigation
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);

  // Asset Paths
  static const String imagePath = 'assets/images/';
  static const String projectImagesPath = 'assets/images/project_images/';

  // Spacing
  static const double defaultPadding = 24.0;
  static const double defaultMargin = 16.0;
  static const double defaultBorderRadius = 12.0;

  // Animation
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // Resume URL
  static const String resumeUrl = 'https://drive.google.com/file/d/1lZJz7b190mjf756-wTrnKvPTAS4o8wPz/view?usp=drive_link';
}

// Breakpoints matching the reference website CSS - Exactly as defined in CSS
class AppBreakpoints {
  static const double xs = 0; // --breakpoint-xs
  static const double sm = 576; // --breakpoint-sm
  static const double md = 768; // --breakpoint-md
  static const double lg = 992; // --breakpoint-lg
  static const double xl = 1200; // --breakpoint-xl
}

// Font families matching the reference website CSS
class AppFonts {
  static const String primaryFontFamily = 'HankenGrotesk';
}

// Typography classes exactly matching the reference CSS
class AppTypography {
  // Font sizes (in rem converted to px at 16px base)
  static const double font10 = 10; // 0.625rem
  static const double font12 = 12; // 0.75rem - blog-tags, timeline-date
  static const double font14 =
      14; // 0.875rem - section-heading, about-sec-h, post-tag
  static const double font16 = 16; // 1rem - p, timeline-item
  static const double font18 = 18; // 1.125rem - h6
  static const double font20 = 20; // 1.25rem - h5
  static const double font24 = 24; // 1.5rem - h4
  static const double font28 = 28; // 1.75rem - h3
  static const double font32 = 32; // 2rem - h2
  static const double font40 = 40; // 2.5rem - h1

  // Line heights (in rem converted to px at 16px base)
  static const double lineHeight10 = 16; // 1rem
  static const double lineHeight15 = 24; // 1.5rem
  static const double lineHeight20 = 32; // 2rem
  static const double lineHeight225 = 36; // 2.25rem
  static const double lineHeight25 = 40; // 2.5rem
  static const double lineHeight35 = 56; // 3.5rem

  // Letter spacing
  static const double letterSpacingNormal = 0;
  static const double letterSpacing006 = -0.006;
  static const double letterSpacing011 = -0.011;
  static const double letterSpacing014 = -0.014;
  static const double letterSpacing017 = -0.017;
  static const double letterSpacing019 = -0.019;
  static const double letterSpacing021 = -0.021;
  static const double letterSpacing01 = 0.01;
  static const double letterSpacing0125 = 0.125;
}

// Layout constants adjusted to reference
class AppLayout {
  // Default paddings
  static const double paddingXS = 8.0;
  static const double paddingSM = 16.0;
  static const double paddingMD = 24.0;
  static const double paddingLG = 32.0;
  static const double paddingXL = 40.0;

  // Default margins
  static const double marginXS = 8.0;
  static const double marginSM = 16.0;
  static const double marginMD = 24.0;
  static const double marginLG = 32.0;
  static const double marginXL = 40.0;

  // Border radius
  static const double borderRadiusSM = 4.0;
  static const double borderRadiusMD = 8.0;
  static const double borderRadiusLG = 12.0;
  static const double borderRadiusXL = 16.0;
  static const double borderRadiusPill =
      100.0; // For fully rounded pill-shaped buttons and navbar

  // Maximum content width (container)
  static const double maxContentWidth =
      708.0; // From CSS: main { width: 708px; }

  // Line heights to match reference CSS
  static const double lineHeightNormal = 1.15; // Default from CSS
  static const double lineHeightTight = 1.0;
  static const double lineHeightLoose = 1.5;

  // Font sizes
  static const double fontSizeXS = 12.0;
  static const double fontSizeSM = 14.0;
  static const double fontSizeMD = 16.0;
  static const double fontSizeLG = 18.0;
  static const double fontSizeXL = 24.0;
}
