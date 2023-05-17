import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:school_management_app/app/common/curved_shape.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/profile_list.dart';
import 'package:school_management_app/app/common/style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultAppbar(
          context,
          autoImplying: true,
          title: const Text(
            'PROFILE',
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w600,

            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: HeaderCurvedContainer(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,

                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/img/logo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: SizedBox(
                        child: ListView(
                          children:const [
                            ProfileListItem(
                              icon: LineAwesomeIcons.user_shield,
                              text: 'Privacy',
                            ),
                            ProfileListItem(
                              icon: LineAwesomeIcons.question_circle,
                              text: 'Help & Support',
                            ),
                            ProfileListItem(
                              icon: LineAwesomeIcons.cog,
                              text: 'Settings',
                            ),
                            ProfileListItem(
                              color: lRed,
                              icon: LineAwesomeIcons.alternate_sign_out,
                              text: 'Logout',
                              hasNavigation: false,
                            ),
                          ],
                        ),
                        ),
                )
             
              ],
            ),
          ],
        ),
      ),
    );
  }
}
