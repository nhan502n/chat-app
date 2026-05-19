import 'package:chat_app/src/core/local/app_keys.dart';
import 'package:chat_app/src/core/network/api_exception.dart';
import 'package:chat_app/src/core/widgets/app_message.dart';
import 'package:chat_app/src/core/widgets/styles/colors.dart';
import 'package:flutter/material.dart';

class MessageStyle {
  final AppMessageType type;
  final ToastColors toast;

  const MessageStyle({required this.type, required this.toast});
}

class ApiMessageHelper {
  static MessageStyle styleFromStatus(BuildContext context, int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return MessageStyle(
        type: AppMessageType.success,
        toast: NotificationsColors.success(context),
      );
    }

    if (statusCode >= 400 && statusCode < 500) {
      return MessageStyle(
        type: AppMessageType.error,
        toast: NotificationsColors.error(context),
      );
    }

    if (statusCode >= 500) {
      return MessageStyle(
        type: AppMessageType.error,
        toast: NotificationsColors.error(context),
      );
    }

    return MessageStyle(
      type: AppMessageType.warning,
      toast: NotificationsColors.warning(context),
    );
  }
}

class MessageService {
  static void showApiError(ApiException e) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    final style = ApiMessageHelper.styleFromStatus(context, e.statusCode);
    Future.delayed(const Duration(milliseconds: 200), () {
      _show(message: e.message, type: style.type, toast: style.toast);
    });
  }

  static void showSuccess(String message) {
    Future.delayed(const Duration(milliseconds: 200), () {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      if (!context.mounted) return;

      _show(
        message: message,
        type: AppMessageType.success,
        toast: NotificationsColors.success(context),
      );
    });
  }

  static void showError(String message) {
    Future.delayed(const Duration(milliseconds: 200), () {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      if (!context.mounted) return;
      _show(
        message: message,
        type: AppMessageType.error,
        toast: NotificationsColors.error(context),
      );
    });
  }

  static void showWarning(String message) {
    Future.delayed(const Duration(milliseconds: 200), () {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      if (!context.mounted) return;
      _show(
        message: message,
        type: AppMessageType.warning,
        toast: NotificationsColors.warning(context),
      );
    });
  }

  static OverlayEntry? _entry;

  static void _show({
    required String message,
    required AppMessageType type,
    required ToastColors toast,
  }) {
    final overlay = navigatorKey.currentState?.overlay;
    final context = navigatorKey.currentContext;

    if (overlay == null || context == null) return;

    _entry?.remove();

    _entry = OverlayEntry(
      builder: (_) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return MediaQuery(
          data: MediaQuery.of(context),
          child: Theme(
            data: Theme.of(context),
            child: Positioned(
              left: 16,
              right: 16,
              bottom: keyboardHeight > 0 ? keyboardHeight + 20 : 120,
              child: Material(
                color: Colors.transparent,
                child: AppMessage(
                  type: type,
                  message: message,
                  borderColor: toast.border,
                  backgroundColor: toast.background,
                  shadowColor: toast.shadow,
                  textColor: toast.text,
                  onClose: () {
                    _entry?.remove();
                    _entry = null;
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_entry!);

    Future.delayed(const Duration(seconds: 3), () {
      _entry?.remove();
      _entry = null;
    });
  }
}
