import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/controllers/select_doctor_category_controller.dart';
import 'package:flutter_hello_my_doctor/models/doctor_category_model.dart';
import 'package:flutter_hello_my_doctor/widgets/circular_loading_widget.dart';
import 'package:flutter_hello_my_doctor/widgets/no_data_found_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/custom_colors.dart';
import '../utils/theme_utils.dart';
import '../widgets/back_button_widget.dart';

// ignore: must_be_immutable
class SelectDoctorCategoryScreen extends StatelessWidget {
  SelectDoctorCategoryScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  SelectDoctorCategoryController? _controller;

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
                    "Select Category",
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

  Widget _buildCategoryItemWidget(DoctorCategoryModel data) => Stack(
        children: [
          LayoutBuilder(builder: (context, cons) {
            return Column(
              children: [
                SizedBox(
                  height: cons.maxHeight * 0.78,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_width * 0.02),
                    child: CachedNetworkImage(
                      imageUrl: data.image,
                      height: cons.maxHeight * 0.78,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, _, __) => SizedBox(
                        height: cons.maxHeight * 0.78,
                        width: double.infinity,
                        child: CircularLoadingWidget(
                          _width * 0.5,
                          center: true,
                        ),
                      ),
                      errorWidget: (context, _, __) => SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/logo.webp",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: cons.maxHeight * 0.02),
                Expanded(
                  child: Text(
                    data.categoryName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w600,
                      fontSize: cons.maxHeight * 0.076,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          }),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(_width * 0.02),
                onTap: () => _controller!.onCategorySelected(data),
              ),
            ),
          ),
        ],
      );

  Widget _buildItemWidget(DoctorCategoryModel data) => Stack(
        children: [
          LayoutBuilder(builder: (context, cons) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_width * 0.04),
                color: HexColor(CustomColors.blue1),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: cons.maxWidth * 0.03,
                vertical: cons.maxHeight * 0.03,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: cons.maxHeight * 0.6,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_width * 0.04),
                      child: CachedNetworkImage(
                        imageUrl: data.image,
                        height: cons.maxHeight * 0.72,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, _, __) => SizedBox(
                          height: cons.maxHeight * 0.78,
                          width: double.infinity,
                          child: CircularLoadingWidget(
                            _width * 0.5,
                            center: true,
                          ),
                        ),
                        errorWidget: (context, _, __) => SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/logo.webp",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: cons.maxHeight * 0.025),
                  Expanded(
                    child: Text(
                      data.categoryName,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w600,
                        fontSize: cons.maxHeight * 0.08,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(_width * 0.04),
                onTap: () => _controller!.onCategorySelected(data),
              ),
            ),
          ),
        ],
      );

  Widget get _buildGridViewWidget => GridView.builder(
        itemCount: _controller!.dataList.length,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: _height * 0.02,
          horizontal: _width * 0.13,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: _width * 0.1,
          mainAxisSpacing: _height * 0.02,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _buildItemWidget(_controller!.dataList[index]);
        },
      );

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<SelectDoctorCategoryController>();

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
                          : _controller!.dataList.isNotEmpty
                              ? _buildGridViewWidget
                              : NoDataFoundWidget("No data found"),
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
