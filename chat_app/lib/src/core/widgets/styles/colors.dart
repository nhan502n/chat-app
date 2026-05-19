import 'package:flutter/material.dart';

class AppColors {
  static const Color bgPrimary = Color(0xFFFFFFFF);
  static const Color highlight = Color(0xFFF9E7B2);
  static const Color accent = Color(0xFFDDC57A);
  static const Color warm = Color(0xFFD34E4E);

  static const Color _brandLight = Color(0xFFce7e5a);
  static const Color _brandDark = Color(0xFFd79779);
  static Color brand(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _brandDark : _brandLight;
  }

  static const Color _inputBgDark = Color(0xFF09090b);
  static Color inputBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _inputBgDark : Colors.white;
  }

  static const Color _borderLightTheme = Color(0xFFe2e8f0);
  static const Color _borderDarkTheme = Color(0xFF3f3f46);

  static Color border(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _borderDarkTheme : _borderLightTheme;
  }

  static const Color _focusLight = Color(0xFFFDF9F7);
  static const Color _focusDarkBase = Color(0xFFD79779);
  static const Color _focusLightText = Color(0xFF90583f);
  static const Color _focusDarkText = Color(0xFFe4e3e2);

  static Color textItemSelected(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _focusDarkText : _focusLightText;
  }

  static Color bgItemSelected(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _focusDarkBase.withAlpha(41) : _focusLight;
  }

  static const Color completedTextLight = Color(0xFF15803d);
  static const Color completedTextDark = Color(0xFF86efac);
  static const Color completedBgLight = Color(0xFFdcfce7);
  static const Color completedBgDark = Color(0xFF22c55e);
  static Color completedText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? completedTextDark : completedTextLight;
  }

  static Color completedBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? completedBgDark.withAlpha(41) : completedBgLight;
  }

  static const Color _inProgressTextLight = Color(0xFFc2410c);
  static const Color _inProgressTextDark = Color(0xFFfdba74);
  static const Color _inProgressBgLight = Color(0xFFffedd5);
  static const Color _inProgressBgDark = Color(0xFFf97316);

  static Color inprogressText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _inProgressTextDark : _inProgressTextLight;
  }

  static Color inprogressBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _inProgressBgDark.withAlpha(41) : _inProgressBgLight;
  }

  static const Color _createdTextLight = Color(0xFF0369a1);
  static const Color _createdTextDark = Color(0xFF7dd3fc);
  static const Color _createdBgLight = Color(0xFFe0f2fe);
  static const Color _createdBgDark = Color(0xFF0EA5E9);

  static Color createdText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _createdTextDark : _createdTextLight;
  }

  static Color createdBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _createdBgDark.withAlpha(41) : _createdBgLight;
  }

  static const Color _dialogLight = Color(0xFFffffff);
  static const Color _dialogDark = Color(0xFF18181b);
  static Color dialogBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _dialogDark : _dialogLight;
  }

  static const Color _buttonBgLight = Color(0xFFf1f5f9);
  static const Color _buttonBgDark = Color(0xFF27272a);
  static Color buttonBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _buttonBgDark : _buttonBgLight;
  }

  static const Color _placeHolderLight = Color(0xFF64748b);
  static const Color _placeHolderDark = Color(0xFFa1a1aa);
  static Color placeHolder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _placeHolderDark : _placeHolderLight;
  }

  static const Color _toolTipLight = Color(0xFF334155);
  static const Color _toolTipDark = Color(0xFF3f3f46);
  static Color toolTip(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _toolTipDark : _toolTipLight;
  }

  static const Color _tagBgLight = Color(0xFFe0f2fe);
  static const Color _tagBgDark = Color(0x290EA5E9);

  static Color tagBg(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _tagBgDark : _tagBgLight;
  }

  static const Color _tagTextLight = Color(0xFF0369a1);
  static const Color _tagTextDark = Color(0xFF7dd3fc);

  static Color tagText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? _tagTextDark : _tagTextLight;
  }
}

class AppAssets {
  static String icon(BuildContext context, {required String name}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return 'assets/images/${name}_${isDark ? "dark" : "light"}.png';
  }
}

class ToastColors {
  final Color background;
  final Color border;
  final Color text;
  final Color shadow;

  const ToastColors({
    required this.background,
    required this.border,
    required this.text,
    required this.shadow,
  });
}

class NotificationsColors {
  static const ToastColors errorLight = ToastColors(
    background: Color(0xF2FEF2F2),
    border: Color(0xFFFECACA),
    text: Color(0xFFDC2626),
    shadow: Color(0x0AEF4444),
  );

  static const ToastColors errorDark = ToastColors(
    background: Color(0x29EF4444),
    border: Color(0x5CB91C1C),
    text: Color(0xFFEF4444),
    shadow: Color(0x0AEF4444),
  );

  static const ToastColors successLight = ToastColors(
    background: Color(0xF2F0FDF4),
    border: Color(0xFFBBF7D0),
    text: Color(0xFF16A34A),
    shadow: Color(0x0A22C55E),
  );

  static const ToastColors successDark = ToastColors(
    background: Color(0x2922C55E),
    border: Color(0x5C15803D),
    text: Color(0xFF22C55E),
    shadow: Color(0x0A22C55E),
  );

  static const ToastColors warningLight = ToastColors(
    background: Color(0xF2FEFCE8),
    border: Color(0xFFFEF08A),
    text: Color(0xFFCA8A04),
    shadow: Color(0x0AEAB308),
  );

  static const ToastColors warningDark = ToastColors(
    background: Color(0x29EAB308),
    border: Color(0x5CA16207),
    text: Color(0xFFEAB308),
    shadow: Color(0x0AEAB308),
  );

  static ToastColors error(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? errorDark : errorLight;
  }

  static ToastColors success(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark ? successDark : successLight;
  }

  static ToastColors warning(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? warningDark : warningLight;
  }

  static ToastColors info(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? warningDark : warningLight;
  }
}
