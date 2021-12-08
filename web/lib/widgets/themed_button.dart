import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/condtional_wrapper.dart.dart';

class ThemedButton extends StatelessWidget {
  const ThemedButton({Key? key, this.outlined = false, this.onPressed, this.icon, required this.label, this.disabledMessage}) : super(key: key);

  final bool outlined;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String label;
  final String? disabledMessage;

  static const double fontSize = 18;
  static const double toolTipFontSize = 15;
  static const double outlinedOpacity = .3;

  @override
  Widget build(BuildContext context) {
    var disabled = onPressed == null;
    var color = disabled ? NcThemes.current.tertiaryColor : NcThemes.current.accentColor;

    return ConditionalWrapper(
      condition: disabled && disabledMessage != null,
      builder: (context, child) => Tooltip(
        message: disabledMessage ?? "",
        textStyle: TextStyle(color: NcThemes.current.textColor, fontSize: toolTipFontSize),
        decoration: BoxDecoration(
          color: NcThemes.current.tertiaryColor,
          borderRadius: BorderRadius.circular(ncRadius),
        ),
        child: child,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(icon,
                    size: fontSize,
                    color: outlined
                        ? disabled
                            ? NcThemes.current.tertiaryColor
                            : NcThemes.current.accentColor
                        : NcThemes.current.buttonTextColor),
              if (icon != null) NcSpacing.small(),
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  color: !outlined ? NcThemes.current.buttonTextColor : color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(ncRadius)),
              side: BorderSide(color: color),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(outlined ? color.withOpacity(outlinedOpacity) : color),
        ),
      ),
    );
  }
}
