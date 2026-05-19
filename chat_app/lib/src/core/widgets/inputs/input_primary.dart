import 'package:chat_app/src/core/widgets/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPrimary extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool password;
  final FocusNode? focusNode;
  final bool onlyNumber;
  final bool showPasswordToggle;
  final String? errorMessage;
  final bool enableUnit;
  final String? unitText;

  const InputPrimary({
    super.key,
    required this.label,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.password = false,
    this.onlyNumber = false,
    this.focusNode,
    this.showPasswordToggle = true,
    this.errorMessage,
    this.enableUnit = false,
    this.unitText,
  });

  @override
  State<InputPrimary> createState() => _InputPrimaryState();
}

class _InputPrimaryState extends State<InputPrimary> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final hasLabel = widget.label.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          Text(
            widget.label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],

        SizedBox(
          height: 44,
          child: widget.enableUnit && widget.unitText != null
              ? Container(
                  decoration: BoxDecoration(
                    color: AppColors.inputBg(context),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border(context)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(fontSize: 14),
                          controller: widget.controller,
                          focusNode: widget.focusNode,
                          onTapOutside: (_) => widget.focusNode?.unfocus(),
                          readOnly: widget.readOnly,
                          onTap: () {
                            widget.onTap?.call();

                            final textLength =
                                widget.controller?.text.length ?? 0;

                            widget.controller?.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: textLength,
                            );
                          },
                          textAlign: TextAlign.right,
                          keyboardType: widget.onlyNumber
                              ? TextInputType.number
                              : TextInputType.text,
                          inputFormatters: widget.onlyNumber
                              ? [FilteringTextInputFormatter.digitsOnly]
                              : null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      Text(
                        widget.unitText!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                )
              : TextField(
                  style: const TextStyle(fontSize: 14),
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  onTapOutside: (_) => widget.focusNode?.unfocus(),
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  obscureText: widget.password ? _obscure : false,
                  textAlign: TextAlign.left,
                  keyboardType: widget.onlyNumber
                      ? TextInputType.number
                      : TextInputType.text,
                  inputFormatters: widget.onlyNumber
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.inputBg(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    suffixIcon: widget.password && widget.showPasswordToggle
                        ? IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.border(context),
                            ),
                            onPressed: () {
                              setState(() => _obscure = !_obscure);
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: AppColors.border(context)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: AppColors.border(context)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: AppColors.brand(context)),
                    ),
                  ),
                ),
        ),

        SizedBox(
          height: 18,
          child: widget.errorMessage != null && widget.errorMessage!.isNotEmpty
              ? Text(
                  widget.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
