import 'package:design_system/src/atoms/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationTextFormField extends StatelessWidget {
  final String hintText;
  final bool? visibility;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? enabled;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const DonationTextFormField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.visibility,
    this.enabled,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity((enabled ?? true) ? 0.15 : 0.1),
            blurRadius: SizeConfig.width(context, 0.03),
            // blurRadius: SizeConfig.width(context, 0.01),
            // soften the shadow
            spreadRadius:
                (enabled ?? true) ? SizeConfig.width(context, 0.005) : 0,
            //extend the shadow
            offset: (enabled ?? true)
                ? Offset(
                    SizeConfig.width(context, 0.01),
                    SizeConfig.width(context, 0.01),
                  )
                : Offset.zero,
          ),
        ],
      ),
      child: TextFormField(
        key: key,
        controller: controller,
        enabled: enabled,
        autocorrect: true,
        keyboardType: keyboardType,
        obscureText: visibility ?? false,
        maxLength: maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textCapitalization: keyboardType == TextInputType.name
            ? TextCapitalization.words
            : TextCapitalization.none,
        onChanged: onChanged ?? (String value) {},
        inputFormatters: inputFormatters ??
            ((keyboardType == TextInputType.phone ||
                    keyboardType == TextInputType.number)
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(r'\d')),
                  ]
                : []),
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          counter: const SizedBox(),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
              SizeConfig.width(context, 0.03),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            // vertical: SizeConfig.height(context, 0.03),
            vertical: SizeConfig.height(context, 0.01),
            horizontal: SizeConfig.width(context, 0.03),
          ),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
