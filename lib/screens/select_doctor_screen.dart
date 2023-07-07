import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/models/doctor_model.dart';
import 'package:flutter_hello_my_doctor/widgets/circular_loading_widget.dart';
import 'package:flutter_hello_my_doctor/widgets/no_data_found_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/custom_colors.dart';
import '../controllers/select_doctor_controller.dart';
import '../utils/theme_utils.dart';
import '../utils/utils.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/button_widget.dart';

// ignore: must_be_immutable
class SelectDoctorScreen extends StatelessWidget {
  SelectDoctorScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  SelectDoctorController? _controller;

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
                    "Select Doctor",
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

  Widget _buildInfoWidget(String data) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: _height * 0.015,
            width: _height * 0.015,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor(CustomColors.green1),
            ),
          ),
          SizedBox(width: _width * 0.013),
          Flexible(
            child: Text(
              data,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.rubik(
                color: HexColor(CustomColors.grey1),
                fontSize: _height * 0.013,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      );

  Widget _buildBookNowButtonWidget(DoctorDetailsModel data) => TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_width * 0.02),
            ),
          ),
          minimumSize: const MaterialStatePropertyAll(Size.zero),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: _width * 0.075,
              vertical: _height * 0.012,
            ),
          ),
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(
            data.isDoctorOnLeave ? Colors.grey : HexColor(CustomColors.blue1),
          ),
          overlayColor: MaterialStatePropertyAll(
            Colors.white.withOpacity(0.4),
          ),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          textStyle: MaterialStatePropertyAll(
            GoogleFonts.rubik(
              fontSize: _height * 0.018,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onPressed: () => _controller!.onBookNowPressed(data),
        child: const Text(
          "Book Now",
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _buildDoctorItemWidget(DoctorDetailsModel data) => GestureDetector(
        onTap: () => _controller!.onDoctorPressed(data),
        child: Container(
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
          padding: EdgeInsets.symmetric(
            horizontal: _width * 0.03,
            vertical: _height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _height * 0.1,
                    width: _height * 0.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        _width * 0.03,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: data.image,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, _, __) => SizedBox(
                          height: double.infinity,
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
                  SizedBox(width: _width * 0.025),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: _height * 0.008),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.rubik(
                              color: Colors.black,
                              fontSize: _height * 0.0185,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: _height * 0.006),
                          Text(
                            data.degree,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.ptSans(
                              color: HexColor(CustomColors.green1),
                              fontSize: _height * 0.016,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: _height * 0.006),
                          Text(
                            "${data.startExperience} Years experience",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.rubik(
                              color: HexColor(CustomColors.grey1),
                              fontSize: _height * 0.015,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: _height * 0.005),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   children: [
                          //     Flexible(
                          //       child: _buildInfoWidget("87%"),
                          //     ),
                          //     SizedBox(width: _width * 0.05),
                          //     Flexible(
                          //       child: _buildInfoWidget("69 Patient Stories"),
                          //     ),
                          //   ],
                          // ),
                          RatingBar.builder(
                            tapOnlyMode: true,
                            ignoreGestures: true,
                            initialRating: data.rating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: _height * 0.02,
                            itemPadding: EdgeInsets.zero,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (data.description.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: _height * 0.02),
                    Text(
                      data.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        color: HexColor(CustomColors.grey1),
                        fontSize: _height * 0.015,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: _height * 0.02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (data.isDoctorOnLeave)
                          Text(
                            "On Leave",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.rubik(
                              color: Colors.red,
                              fontSize: _height * 0.016,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        else
                          Text(
                            "Next Available",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.rubik(
                              color: HexColor(CustomColors.green1),
                              fontSize: _height * 0.016,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        SizedBox(height: _height * 0.005),
                        if (data.isDoctorOnLeave)
                          Text(
                            "${data.fromDate} - ${data.toDate}",
                            style: GoogleFonts.rubik(
                              color: HexColor(CustomColors.grey1),
                              fontSize: _height * 0.016,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        else
                          RichText(
                            text: TextSpan(
                              text: data.fromTime,
                              style: GoogleFonts.rubik(
                                color: HexColor(CustomColors.grey1),
                                fontSize: _height * 0.016,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      " ${data.getNextAvailability(Utils.getTomorrowDayName())}",
                                  style: GoogleFonts.rubik(
                                    color: HexColor(CustomColors.grey1),
                                    fontSize: _height * 0.016,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: _width * 0.02),
                  _buildBookNowButtonWidget(data),
                ],
              ),
            ],
          ),
        ),
      );

  // Widget get _buildLocationDropDownWidget => Obx(
  //       () => DropdownSearch<CityModel>(
  //         autoValidateMode: AutovalidateMode.onUserInteraction,
  //         validator: (val) => Utils.notEmptyValidator(val, "Required"),
  //         dropdownDecoratorProps: DropDownDecoratorProps(
  //           baseStyle: GoogleFonts.ptSans(
  //             fontWeight: FontWeight.w400,
  //             fontSize: _height * 0.018,
  //           ),
  //           dropdownSearchDecoration: const InputDecoration(
  //             isDense: true,
  //             labelText: "Location",
  //             border: InputBorder.none,
  //             disabledBorder: InputBorder.none,
  //             enabledBorder: InputBorder.none,
  //             focusedBorder: InputBorder.none,
  //             errorBorder: InputBorder.none,
  //             focusedErrorBorder: InputBorder.none,
  //             contentPadding: EdgeInsets.zero,
  //           ),
  //           textAlignVertical: TextAlignVertical.center,
  //         ),
  //         dropdownButtonProps: const DropdownButtonProps(
  //           padding: EdgeInsets.zero,
  //           constraints: BoxConstraints(),
  //         ),
  //         selectedItem: _controller!.selectedCity.value,
  //         items: _controller!.cityList.toList(),
  //         itemAsString: (val) => val.name,
  //         onChanged: _controller!.onLocationChanged,
  //       ),
  //     );

  Widget get _buildListViewWidget => Obx(
        () => _controller!.loading.value
            ? CircularLoadingWidget(_width, center: true)
            : _controller!.dataList.isNotEmpty
                ? ListView.separated(
                    itemCount: _controller!.dataList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: _width * 0.05,
                      right: _width * 0.05,
                      bottom: _height * 0.02,
                    ),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: _height * 0.02);
                    },
                    itemBuilder: (context, index) {
                      return _buildDoctorItemWidget(
                          _controller!.dataList[index]);
                    },
                  )
                : NoDataFoundWidget("No doctor found"),
      );

  Widget get _buildLeaveDialogWidget => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_width * 0.035),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: _width * 0.06,
              vertical: _height * 0.03,
            ),
            child: Column(
              children: [
                Text(
                  "${_controller!.selectedDoctor?.name} is on leave",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontSize: _height * 0.021,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: _height * 0.01),
                Text(
                  "${_controller!.selectedDoctor!.fromDate} - ${_controller!.selectedDoctor!.toDate}",
                  style: GoogleFonts.rubik(
                    color: HexColor(CustomColors.grey1),
                    fontSize: _height * 0.016,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_controller!.selectedDoctor != null &&
                    _controller!.selectedDoctor!.description.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: _height * 0.015),
                      Text(
                        _controller!.selectedDoctor!.description,
                        textAlign: TextAlign.center,
                        maxLines: 20,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.rubik(
                          fontSize: _height * 0.018,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: _height * 0.025),
                ButtonWidget(
                  text: "Close",
                  onPressed: _controller!.onClosePressed,
                ),
              ],
            ),
          ),
        ],
      );

  Future<void> _showLeaveDialog() async {
    return await showCupertinoDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: _buildLeaveDialogWidget,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      _controller = Get.find<SelectDoctorController>();
      _controller!.listenLeaveDialogState(_showLeaveDialog);
    }

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
                  SizedBox(height: _height * 0.03),
                  Expanded(child: _buildListViewWidget),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
