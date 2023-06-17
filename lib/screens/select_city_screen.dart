import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/models/city_model.dart';
import 'package:flutter_hello_my_doctor/widgets/circular_loading_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/custom_colors.dart';
import '../controllers/select_city_controller.dart';
import '../utils/theme_utils.dart';
import '../utils/utils.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/no_data_found_widget.dart';

// ignore: must_be_immutable
class SelectCityScreen extends StatelessWidget {
  SelectCityScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  UserController? _userController;
  SelectCityController? _controller;

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
                if (_controller!.afterLogin == false)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BackButtonWidget(),
                      SizedBox(width: _width * 0.03),
                    ],
                  )
                else if (_userController!.isLogin.value &&
                    _controller!.afterLogin == false)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BackButtonWidget(),
                      SizedBox(width: _width * 0.03),
                    ],
                  ),

                // if (!_controller!.afterLogin && _userController!.isLogin.value)
                //   Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       BackButtonWidget(),
                //       SizedBox(width: _width * 0.03),
                //     ],
                //   ),
                Expanded(
                  child: Text(
                    "Select Your City",
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

  Widget _buildTextFieldWidget(
    TextEditingController controller,
    String hint, {
    bool obscureText = false,
    bool enabled = true,
    TextInputType inputType = TextInputType.emailAddress,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: _height * 0.018,
        ),
        validator:
            validator ?? (val) => Utils.notEmptyValidator(val, "Required"),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.ptSans(
            fontWeight: FontWeight.w400,
            color: HexColor(CustomColors.grey1),
            fontSize: _height * 0.018,
          ),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: _controller!.onSearch,
      );

  Widget get _buildSearchWidget => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_width * 0.025),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? Colors.white.withOpacity(0.09)
                  : const Color(0x10002958),
              offset: const Offset(0, 0),
              blurRadius: _width * 0.02,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(
          horizontal: _width * 0.05,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.03,
          vertical: _height * 0.02,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.search,
              size: _height * 0.027,
              color: HexColor(CustomColors.grey1),
            ),
            SizedBox(width: _width * 0.025),
            Expanded(
              child: _buildTextFieldWidget(
                _controller!.searchController,
                "Search...",
              ),
            ),
            SizedBox(width: _width * 0.025),
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed: _controller!.onCanclePressed,
              child: Icon(
                Icons.close,
                color: HexColor(CustomColors.grey1),
                size: _height * 0.027,
              ),
            ),
          ],
        ),
      );

  Widget _buildItemWidget(CityModel data) => Stack(
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
                      data.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w600,
                        fontSize: cons.maxHeight * 0.1,
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
                onTap: () => _controller!.onCitySelected(data),
              ),
            ),
          ),
        ],
      );

  Widget get _buildGridViewWidget => Obx(
        () => GridView.builder(
          itemCount: _controller!.dataList.length,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: _height * 0.02,
            horizontal: _width * 0.1,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: _width * 0.1,
            mainAxisSpacing: _height * 0.02,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _buildItemWidget(_controller!.dataList[index]);
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    _userController = Get.find<UserController>();
    _controller ??= Get.find<SelectCityController>();

    print("_controller!.afterLogin --> ${_controller!.afterLogin}");

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
                  SizedBox(height: _height * 0.02),
                  _buildSearchWidget,
                  SizedBox(height: _height * 0.02),
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
