import 'package:festit_invited/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatefulWidget {
  final String? title;
  final Widget? suffixIcon;
  final Color? borderColor;
  final int maxLines;
  final String? hintText;
  final FontWeight? stylefontWeight;
  final String? labelText;
  final TextEditingController? controller;
  final bool readOnly;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final bool optional;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final double? radius;
  final Color? fillColor;
  final Color? textColor;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final MaxLengthEnforcement? maxLengthEnforcement;

  const AppTextFormField({
    super.key,
    this.fillColor,
    this.autovalidateMode,
    this.suffixIcon,
    this.maxLines = 1,
    this.hintText,
    this.stylefontWeight,
    this.labelText,
    this.controller,
    this.readOnly = false,
    this.enabled = true,
    this.isPassword = false,
    this.focusNode,
    this.optional = false,
    this.inputFormatters,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.prefixIcon,
    this.radius,
    this.textColor,
    this.title,
    this.borderColor,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.maxLengthEnforcement,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLengthEnforcement: widget.maxLengthEnforcement,
      textCapitalization: TextCapitalization.sentences,
      onFieldSubmitted: widget.onFieldSubmitted,
      autovalidateMode: widget.autovalidateMode,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      controller: widget.controller,
      obscureText: !widget.isPassword ? false : obscureText,
      inputFormatters: widget.inputFormatters,
      textAlignVertical: TextAlignVertical.center,
      textAlign: widget.textAlign,
      validator: widget.validator ??
          (value) {
            if (widget.optional == false && (value?.trim().isEmpty ?? true)) {
              return 'Campo obrigatório.';
            }
            return null;
          },
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          backgroundColor: AppColors.text,
          color: AppColors.text,
        ),
        filled: true,
        fillColor: widget.fillColor ?? Colors.white,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 4,
            ),
        alignLabelWithHint: true,
        suffixIconConstraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: 0,
        ),
        suffixIcon: Visibility(
          visible: widget.isPassword,
          replacement: widget.suffixIcon ?? const SizedBox.shrink(),
          child: IconButton(
            icon: Icon(
              obscureText
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined,
              color: AppColors.text,
            ),
            onPressed: () {
              obscureText = !obscureText;
              setState(() {});
            },
          ),
        ),
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: TextStyle(
          fontFamily: 'Montserrat-Italic',
          color: widget.textColor ?? AppColors.text,
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.border.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.border.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.border.withOpacity(0.5),
            width: 1.5,
          ),
        ),
      ),
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: widget.textColor ?? AppColors.buttonPrimary,
        fontSize: 15,
        fontWeight: widget.stylefontWeight ?? FontWeight.w400,
      ),
    );
  }
}
