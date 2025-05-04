import 'package:flutter/material.dart';

enum DeviceScreenType { mobile, tablet, desktop }

class ResponsiveUtils {
  // Private constructor
  ResponsiveUtils._();

  static DeviceScreenType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return DeviceScreenType.mobile;
    } else if (width < 900) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.desktop;
    }
  }

  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceScreenType.mobile;
  }

  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceScreenType.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceScreenType.desktop;
  }

  // Get dynamic padding based on screen size
  static EdgeInsets getScreenPadding(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceScreenType.mobile:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0);
      case DeviceScreenType.tablet:
        return const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0);
      case DeviceScreenType.desktop:
        return const EdgeInsets.symmetric(horizontal: 48.0, vertical: 48.0);
    }
  }

  // Get dynamic width for content containers
  static double getContentMaxWidth(BuildContext context) {
    final deviceType = getDeviceType(context);
    final width = MediaQuery.of(context).size.width;
    
    switch (deviceType) {
      case DeviceScreenType.mobile:
        return width;
      case DeviceScreenType.tablet:
        return width * 0.85;
      case DeviceScreenType.desktop:
        return width > 1400 ? 1200 : width * 0.7;
    }
  }

  // Dynamic font sizing
  static double getHeadingFontSize(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceScreenType.mobile:
        return 28.0;
      case DeviceScreenType.tablet:
        return 36.0;
      case DeviceScreenType.desktop:
        return 48.0;
    }
  }

  static double getSubheadingFontSize(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceScreenType.mobile:
        return 18.0;
      case DeviceScreenType.tablet:
        return 22.0;
      case DeviceScreenType.desktop:
        return 28.0;
    }
  }

  static double getBodyFontSize(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceScreenType.mobile:
        return 16.0;
      case DeviceScreenType.tablet:
        return 16.0;
      case DeviceScreenType.desktop:
        return 18.0;
    }
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobileBuilder;
  final Widget? tabletBuilder;
  final Widget? desktopBuilder;

  const ResponsiveBuilder({
    super.key,
    required this.mobileBuilder,
    this.tabletBuilder,
    this.desktopBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveUtils.getDeviceType(context);

    switch (deviceType) {
      case DeviceScreenType.mobile:
        return mobileBuilder;
      case DeviceScreenType.tablet:
        return tabletBuilder ?? mobileBuilder;
      case DeviceScreenType.desktop:
        return desktopBuilder ?? tabletBuilder ?? mobileBuilder;
    }
  }
}