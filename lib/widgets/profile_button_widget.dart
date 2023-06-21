import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/custom_colors.dart';
import '../controllers/user_controller.dart';

// ignore: must_be_immutable
class ProfileButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? radius;

  ProfileButtonWidget({this.onPressed, this.radius, Key? key})
      : super(key: key);
  final double _height = Get.height;

  UserController? _userController;

  @override
  Widget build(BuildContext context) {
    _userController ??= Get.find<UserController>();

    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: HexColor(CustomColors.blue1),
        ),
        padding: EdgeInsets.all(_height * 0.003),
        child: Obx(
          () => CircleAvatar(
            radius: radius ?? _height * 0.026,
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            foregroundImage: CachedNetworkImageProvider(
              _userController!.user.value.userImg,
            ),
            child: _userController!.user.value.userImg.isEmpty
                ? _userController!.user.value.userName.isNotEmpty
                    ? Text(
                        _userController!.user.value.userName[0],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: _height * 0.018,
                        ),
                      )
                    : null
                : null,
          ),
        ),
        // child: CircleAvatar(
        //   radius: radius ?? _height * 0.026,
        //   foregroundImage: const CachedNetworkImageProvider(
        //       "https://cdn-icons-png.flaticon.com/512/1053/1053244.png"),
        //   backgroundImage: const CachedNetworkImageProvider(
        //       "https://cdn-icons-png.flaticon.com/512/1053/1053244.png"),
        // ),
      ),
    );
  }
}
