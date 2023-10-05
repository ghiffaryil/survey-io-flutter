import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';

class HorizontalMenu extends StatelessWidget {
  final String imageAsset;
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color textColor;

  const HorizontalMenu({
    Key? key,
    required this.imageAsset,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.iconColor = Colors.black, // Default icon color is black
    this.textColor = Colors.black, // Default text color is black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        splashColor: AppColors.light.withOpacity(0.3),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          padding: const EdgeInsets.only(left: 20, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    imageAsset,
                    height: 35,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors
                            .secondary, // Set your desired border color
                        width: 0.2, // Set your desired border width
                      ),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyles.medium(color: textColor),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(right: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.light, // Set your desired border color
                        width: 0.2, // Set your desired border width
                      ),
                    ),
                  ),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
