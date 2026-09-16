import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/controllers/notifications_controller.dart';
import 'package:flutter_hello_my_doctor/models/notification_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/custom_colors.dart';
import '../../utils/theme_utils.dart';
import '../../widgets/back_button_widget.dart';
import '../../widgets/circular_loading_widget.dart';
import '../../widgets/no_data_found_widget.dart';

// ignore: must_be_immutable
class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  NotificationsController? _controller;

  PreferredSizeWidget get _buildAppbarWidget => PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: Container(
          color: Colors.transparent,
          height: AppBar().preferredSize.height + Get.mediaQuery.padding.top,
          padding: EdgeInsets.only(
            top: Get.mediaQuery.padding.top,
            left: _width * 0.03,
            right: _width * 0.03,
          ),
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(builder: (context, cons) {
            return Row(
              children: [
                BackButtonWidget(),
                SizedBox(width: _width * 0.03),
                Expanded(
                  child: Text(
                    "Notifications",
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      fontSize: cons.maxHeight * 0.32,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      );

  Widget _buildListItemWidget(NotificationModel data) => InkWell(
        onTap: () => _controller!.onNotificationPressed(data),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: _height * 0.02,
            // horizontal: _width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: _height * 0.019,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: _height * 0.01),
              Text(
                data.notification,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: _height * 0.017,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: _height * 0.005),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  data.dateTime,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: _height * 0.015,
                    color: HexColor(CustomColors.grey2),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _buildListViewWidget => ListView.separated(
        itemCount: _controller!.dataList.length,
        padding: EdgeInsets.symmetric(
          vertical: _height * 0.02,
          horizontal: _width * 0.05,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildListItemWidget(_controller!.dataList[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
            height: _height * 0.01,
            thickness: _height * 0.001,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<NotificationsController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: _height * 0.25,
                  width: _height * 0.25,
                  child: Image.asset(
                    "assets/images/common_green_artwork.webp",
                    height: _height * 0.25,
                    width: _height * 0.25,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: _height * 0.25,
                  width: _height * 0.25,
                  child: Image.asset(
                    "assets/images/common_blue_artwork.webp",
                    height: _height * 0.25,
                    width: _height * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  _buildAppbarWidget,
                  Expanded(
                    child: Obx(
                      () => _controller!.loading.value
                          ? CircularLoadingWidget(_width, center: true)
                          : _controller!.dataList.isEmpty
                              ? NoDataFoundWidget("No data found")
                              : _buildListViewWidget,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
