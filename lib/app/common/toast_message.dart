import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/style.dart';

showToastMessage(message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    textColor: lBlack,
    backgroundColor: lWhite,
  );
}

showOnlineToast() {
  Fluttertoast.showToast(
      msg: 'online'.tr,
      gravity: ToastGravity.BOTTOM,
      textColor: lBlack,
      backgroundColor: lGrey);
}

showOfflineToast() {
  Fluttertoast.showToast(
    msg: 'offline'.tr,
    gravity: ToastGravity.BOTTOM,
    textColor: lBlack,
    backgroundColor: lRed,
  );
}
