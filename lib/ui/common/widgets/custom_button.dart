import 'package:adel_tarek/utils/core.util.dart';
import 'package:flutter/material.dart';

import 'package:adel_tarek/ui/style/app.colors.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final Function onPressed;
  final String label;

  final TextStyle? style;
  final Widget? icon;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? customBorderColor;
  final Color? buttonStartColor;
  final Color? buttonEndColor;
  final double? customWidth;

  final double customVerticalPadding;
  final double customHorizontalPadding;
  final double cornerRadius;
  final double containerHeight;
  final double borderWidth;

  const CustomButton({
    required this.isLoading,
    required this.onPressed,
    required this.label,
    this.style,
    this.icon,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.customBorderColor,
    this.buttonStartColor,
    this.buttonEndColor,
    this.customWidth,
    this.customVerticalPadding = 12,
    this.customHorizontalPadding = 0,
    this.cornerRadius = 8,
    this.containerHeight = 44,
    this.borderWidth = 1.5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : () => onPressed(),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          side: customBorderColor != null
              ? BorderSide(color: customBorderColor!, width: borderWidth)
              : BorderSide.none,
        ),
        
        padding: const EdgeInsets.all(0.0),
        backgroundColor: buttonColor ?? AppColors.primaryColor,
      ),
      child: isLoading
          ? Container(
              height: screenAwareHeight(containerHeight, context),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  vertical: customVerticalPadding,
                  horizontal: customHorizontalPadding),
              decoration: BoxDecoration(
                color: buttonColor ?? AppColors.primaryColor,
                border: Border.all(
                    color: borderColor ?? Colors.transparent, width: 1.5),
                gradient: buttonStartColor != null
                    ? LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          buttonStartColor != null
                              ? buttonStartColor!
                              : Theme.of(context).colorScheme.secondary,
                          buttonEndColor != null
                              ? buttonEndColor!
                              : AppColors.primaryColors[100]!,
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
              ),
              child: Center(
                heightFactor: 1,
                widthFactor: 1,
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.secondary),
                    strokeWidth: 1.5,
                  ),
                ),
              ),
            )
          : Ink(
              decoration: BoxDecoration(
                color: buttonColor ?? AppColors.primaryColor,
                border: Border.all(
                    color: borderColor ?? Colors.transparent, width: 1.5),
                gradient: buttonStartColor != null
                    ? LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          buttonStartColor != null
                              ? buttonStartColor!
                              : Theme.of(context).colorScheme.secondary,
                          buttonEndColor != null
                              ? buttonEndColor!
                              : AppColors.primaryColors[100]!,
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
              ),
              child: Container(
                height: screenAwareHeight(containerHeight, context),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: icon ??
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: style ??
                          Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: textColor ?? Colors.white,
                              ),
                    ),
              ),
            ),
      //color: buttonColor ?? Theme.of(context).accentColor,
    );
  }
}
