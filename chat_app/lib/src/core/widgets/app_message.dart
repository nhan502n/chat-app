import 'dart:ui';

import 'package:flutter/material.dart';

enum AppMessageType { success, error, warning, info }

class AppMessageMeta {
  final String title;
  final IconData icon;

  const AppMessageMeta(this.title, this.icon);

  static AppMessageMeta fromType(AppMessageType type) {
    switch (type) {
      case AppMessageType.success:
        return const AppMessageMeta('Success', Icons.check_circle_outline);
      case AppMessageType.error:
        return const AppMessageMeta('Error', Icons.cancel_outlined);
      case AppMessageType.warning:
        return const AppMessageMeta('Warning', Icons.warning_amber_outlined);
      case AppMessageType.info:
        return const AppMessageMeta('Info', Icons.info_outline);
    }
  }
}

Color flattenOnWhite(Color color) {
  return Color.alphaBlend(color, Colors.white);
}

class AppMessage extends StatelessWidget {
  final String message;
  final AppMessageType type;

  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final Color textColor;
  final VoidCallback? onClose;

  const AppMessage({
    super.key,
    required this.message,
    required this.type,
    required this.backgroundColor,
    required this.borderColor,
    required this.shadowColor,
    required this.textColor,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final meta = AppMessageMeta.fromType(type);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final messageColor = Theme.of(context).colorScheme.onSurface;
    final Color resolvedBackground = isDark
        ? backgroundColor
        : flattenOnWhite(backgroundColor);

    final BoxDecoration decoration = BoxDecoration(
      color: resolvedBackground,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isDark
            ? borderColor
            : Color.alphaBlend(borderColor, resolvedBackground),
      ),
    );

    return SafeArea(
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 64,
              ),
              decoration: decoration,
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(meta.icon, color: textColor, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meta.title,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message,
                          style: TextStyle(color: messageColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  if (onClose != null) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onClose,
                      child: Icon(Icons.close, size: 18, color: textColor),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
