import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:school_management_app/app/common/style.dart';

class ProfileListItem extends StatelessWidget {
  final IconData ?icon;
  final Widget ?iconWidget;
  final IconData ?suffixIcon;
  final String? text;
  final bool? hasNavigation;
  final Color? color;
  final Color? suffixIconcolor;
  final double? width;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text,
    this.hasNavigation = true, this.color, this.suffixIcon, this.suffixIconcolor, this.iconWidget, this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit.w * 4,
      width: width??0.0,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 4,
      ).copyWith(
        bottom: kSpacingUnit.w * 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color:color?? primaryColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color:lWhite,
            size: kSpacingUnit.w * 2.5,
          ),
          SizedBox(width: kSpacingUnit.w * 1.5),
          Text(
            text!,
            style: kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: lWhite
            ),
          ),
          const Spacer(),
          if (hasNavigation!)
          iconWidget??  Icon(
             suffixIcon?? LineAwesomeIcons.angle_right,
             color:suffixIconcolor?? lWhite,
              size: kSpacingUnit.w * 2.5,
            ),
        ],
      ),
    );
  }
}