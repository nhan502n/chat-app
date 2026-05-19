import 'package:chat_app/src/core/widgets/styles/colors.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool disabled;

  const ButtonPrimary({
    super.key,
    required this.title,
    this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brand(context),
          disabledBackgroundColor: AppColors.brand(context).withAlpha(153),

          foregroundColor: Colors.white,
          disabledForegroundColor: Color(0xFFFFFFFF).withAlpha(153),

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class ActionIconButton extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final VoidCallback onTap;

  const ActionIconButton({
    super.key,
    required this.icon,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 26),
      ),
    );
  }
}
