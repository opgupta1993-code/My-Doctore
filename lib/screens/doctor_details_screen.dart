import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/widgets/circular_loading_widget.dart';
import 'package:flutter_hello_my_doctor/widgets/no_data_found_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../constants/custom_colors.dart';
import '../controllers/doctor_details_controller.dart';
import '../utils/theme_utils.dart';
import '../utils/utils.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/button_widget.dart';

// ignore: must_be_immutable
class DoctorDetailsScreen extends StatelessWidget {
  DoctorDetailsScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  DoctorDetailsController? _controller;

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
                    "Doctor Details",
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

  OutlineInputBorder _buildOutlineInputBorder({Color? color}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(_width * 0.02),
        borderSide: BorderSide(
          color: color ?? HexColor(CustomColors.grey1).withOpacity(0.16),
          width: _height * 0.001,
        ),
      );

  Widget _buildTextFieldWidget(
    TextEditingController controller,
    String hint, {
    bool obscureText = false,
    TextInputType inputType = TextInputType.text,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        maxLines: 5,
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: _height * 0.018,
        ),
        validator:
            validator ?? (val) => Utils.notEmptyValidator(val, "Required"),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.rubik(
            fontWeight: FontWeight.w400,
            color: HexColor(CustomColors.black1),
            fontSize: _height * 0.018,
          ),
          border: _buildOutlineInputBorder(),
          disabledBorder: _buildOutlineInputBorder(),
          enabledBorder: _buildOutlineInputBorder(),
          focusedBorder: _buildOutlineInputBorder(
            color: HexColor(CustomColors.blue1),
          ),
          errorBorder: _buildOutlineInputBorder(color: Colors.red),
          focusedErrorBorder: _buildOutlineInputBorder(color: Colors.red),
          contentPadding: EdgeInsets.symmetric(
            vertical: _height * 0.021,
            horizontal: _width * 0.04,
          ),
        ),
      );

  Widget _buildBookNowButtonWidget(BoxConstraints cons) => TextButton(
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
              horizontal: cons.maxWidth * 0.15,
              vertical: cons.maxHeight * 0.22,
            ),
          ),
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(
            _controller!.data?.doctorDetails.isDoctorOnLeave == true
                ? Colors.grey
                : HexColor(CustomColors.blue1),
          ),
          overlayColor: MaterialStatePropertyAll(
            Colors.white.withOpacity(0.4),
          ),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          textStyle: MaterialStatePropertyAll(
            GoogleFonts.rubik(
              fontSize: cons.maxHeight * 0.27,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onPressed: _controller!.onBookNowPressed,
        child: const Text(
          "Book Now",
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget get _buildDoctorWidget => Container(
        height: _height * 0.21,
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
        child: LayoutBuilder(builder: (context, cons) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: cons.maxHeight * 0.6,
                width: double.infinity,
                child: LayoutBuilder(builder: (context, cons1) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: cons1.maxHeight,
                        width: cons1.maxHeight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            cons1.maxWidth * 0.03,
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                _controller!.data?.doctorDetails.image ?? "",
                            height: cons1.maxHeight,
                            width: cons1.maxHeight,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, _, __) =>
                                SizedBox(
                              height: cons1.maxHeight,
                              width: cons1.maxHeight,
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
                      SizedBox(width: cons1.maxWidth * 0.03),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: cons1.maxHeight * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _controller!.data?.doctorDetails.name ??
                                          "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.rubik(
                                        color: Colors.black,
                                        fontSize: cons1.maxHeight * 0.18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: cons1.maxHeight * 0.03),
                                    Text(
                                      _controller!.data?.doctorDetails.degree ??
                                          "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.ptSans(
                                        color: HexColor(CustomColors.grey1),
                                        fontSize: cons1.maxHeight * 0.17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    tapOnlyMode: true,
                                    ignoreGestures: true,
                                    initialRating: 4.5,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: cons1.maxHeight * 0.25,
                                    itemPadding: EdgeInsets.zero,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  SizedBox(width: cons1.maxWidth * 0.07),
                                  Expanded(
                                    child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: "Rs.",
                                        style: GoogleFonts.rubik(
                                          color: HexColor(CustomColors.green1),
                                          fontSize: cons1.maxHeight * 0.19,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: _controller!
                                                    .data?.doctorDetails.fees ??
                                                "",
                                            style: GoogleFonts.rubik(
                                              color:
                                                  HexColor(CustomColors.grey1),
                                              fontSize: cons1.maxHeight * 0.19,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: cons.maxHeight * 0.02),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, cons1) => Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildBookNowButtonWidget(cons1),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      );

  Widget _buildRunningOngoingPatientWidget(String title, String data) =>
      Container(
        height: _height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_width * 0.025),
          color: HexColor(CustomColors.grey5).withOpacity(0.2),
        ),
        padding: EdgeInsets.symmetric(
          vertical: _height * 0.01,
          horizontal: _width * 0.015,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: _height * 0.021,
              ),
            ),
            SizedBox(height: _height * 0.002),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.rubik(
                color: HexColor(CustomColors.grey1),
                fontWeight: FontWeight.w300,
                fontSize: _height * 0.018,
              ),
            ),
          ],
        ),
      );

  Widget get _buildInformationWidget => Container(
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
          vertical: _height * 0.017,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildRunningOngoingPatientWidget(
                "Running",
                "300",
              ),
            ),
            SizedBox(width: _width * 0.033),
            Expanded(
              child: _buildRunningOngoingPatientWidget(
                "Ongoing",
                "400",
              ),
            ),
            SizedBox(width: _width * 0.033),
            Expanded(
              child: _buildRunningOngoingPatientWidget(
                "Patient",
                "500",
              ),
            ),
          ],
        ),
      );

  Widget _buildReviewRatingBarWidget(String star, double value) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            star,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: _height * 0.018,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          SizedBox(width: _width * 0.025),
          SizedBox(
            width: _width * 0.48,
            child: SfLinearGauge(
              showTicks: false,
              showLabels: false,
              animateAxis: true,
              axisTrackStyle: LinearAxisTrackStyle(
                thickness: _height * 0.011,
                edgeStyle: LinearEdgeStyle.bothFlat,
                borderWidth: 0,
                color: Colors.black.withOpacity(0.06),
              ),
              barPointers: <LinearBarPointer>[
                LinearBarPointer(
                  value: value,
                  thickness: _height * 0.011,
                  edgeStyle: LinearEdgeStyle.bothFlat,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildReviewRatingInfoWidget(String val1, String val2,
          {bool hasIcon = true}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                val1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.87),
                  fontWeight: FontWeight.w400,
                  fontSize: _height * 0.028,
                ),
              ),
              if (hasIcon)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: _width * 0.017),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: _height * 0.025,
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: _height * 0.006),
          Text(
            val2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(0.38),
              fontWeight: FontWeight.w400,
              fontSize: _height * 0.015,
            ),
          ),
        ],
      );

  Widget get _buildWriteReviewWidget => OutlinedButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: MaterialStatePropertyAll(
            BorderSide(
              color: Colors.black.withOpacity(0.12),
              width: _width * 0.003,
            ),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_width * 0.02),
            ),
          ),
          minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 0)),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: _width * 0.015,
              vertical: _height * 0.0185,
            ),
          ),
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          overlayColor: MaterialStatePropertyAll(
            Colors.white.withOpacity(0.4),
          ),
          foregroundColor:
              MaterialStatePropertyAll(Colors.black.withOpacity(0.6)),
          textStyle: MaterialStatePropertyAll(
            GoogleFonts.roboto(
              fontSize: _height * 0.02,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onPressed: _controller!.onWriteReviewPressed,
        child: const Text(
          "Write a review",
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _buildTitleWidget(String data) => Text(
        data,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          color: Colors.black.withOpacity(0.87),
          fontWeight: FontWeight.w400,
          fontSize: _height * 0.025,
        ),
      );

  Widget get _buildRatingsReviewsWidget => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: _height * 0.02,
          horizontal: _width * 0.04,
        ),
        child: Column(
          children: [
            _buildTitleWidget(
                "Ratings & Reviews (${_controller!.getTotalReviewa})"),
            SizedBox(height: _height * 0.025),
            Text(
              "Summary",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: _height * 0.02,
              ),
            ),
            SizedBox(height: _height * 0.025),
            Row(
              children: [
                Column(
                  children: [
                    _buildReviewRatingBarWidget(
                      "5",
                      _controller!.data!.rating.d5RatingPercent,
                    ),
                    SizedBox(height: _height * 0.015),
                    _buildReviewRatingBarWidget(
                      "4",
                      _controller!.data!.rating.d4RatingPercent,
                    ),
                    SizedBox(height: _height * 0.015),
                    _buildReviewRatingBarWidget(
                      "3",
                      _controller!.data!.rating.d3RatingPercent,
                    ),
                    SizedBox(height: _height * 0.015),
                    _buildReviewRatingBarWidget(
                      "2",
                      _controller!.data!.rating.d2RatingPercent,
                    ),
                    SizedBox(height: _height * 0.015),
                    _buildReviewRatingBarWidget(
                      "1",
                      _controller!.data!.rating.d1RatingPercent,
                    ),
                  ],
                ),
                SizedBox(width: _width * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReviewRatingInfoWidget(
                        "${_controller!.data?.doctorDetails.rating}",
                        "${_controller!.getTotalReviewa} Reviews",
                      ),
                      // SizedBox(height: _height * 0.04),
                      // _buildReviewRatingInfoWidget(
                      //   "88%",
                      //   "Recommended",
                      //   hasIcon: false,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: _height * 0.03),
            _buildWriteReviewWidget,
          ],
        ),
      );

  Widget _buildReviewItemWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Laxmi Sawant",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    color: Colors.black.withOpacity(0.87),
                    fontWeight: FontWeight.w400,
                    fontSize: _height * 0.018,
                  ),
                ),
              ),
              SizedBox(width: _width * 0.03),
              RatingBar.builder(
                tapOnlyMode: true,
                ignoreGestures: true,
                initialRating: _controller!.data?.doctorDetails.rating ?? 0,
                minRating: 1,
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
          SizedBox(height: _height * 0.01),
          Text(
            "Really Satisfied with the service!",
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(0.87),
              fontWeight: FontWeight.w400,
              fontSize: _height * 0.018,
            ),
          ),
          SizedBox(height: _height * 0.01),
          Text(
            "The interface of the App is very good even a layman can use it very easily.It gives you information about the alternate medicine which you can prefer for your disease and save your money on medication.",
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w400,
              fontSize: _height * 0.017,
            ),
          ),
          SizedBox(height: _height * 0.01),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "Nov 09, 2022",
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w400,
                fontSize: _height * 0.017,
              ),
            ),
          ),
        ],
      );

  Widget get _buildReviewRatingContentWidget => Container(
        padding: EdgeInsets.only(
          bottom: _height * 0.025,
          top: _height * 0.022,
          left: _width * 0.05,
          right: _width * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: _height * 0.007,
                width: _width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_width),
                  color: HexColor(CustomColors.grey6),
                ),
              ),
            ),
            SizedBox(height: _height * 0.06),
            Text(
              "Review & Rating",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                fontSize: _height * 0.023,
              ),
            ),
            SizedBox(height: _height * 0.015),
            // Text(
            //   "Enter your mobile number for the verification proccesss, we will send 4 digits code.",
            //   style: GoogleFonts.rubik(
            //     fontWeight: FontWeight.w400,
            //     fontSize: _height * 0.018,
            //     color: HexColor(CustomColors.grey1),
            //   ),
            // ),
            RatingBar.builder(
              tapOnlyMode: false,
              ignoreGestures: false,
              initialRating: _controller!.data?.doctorDetails.rating ?? 0.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: _height * 0.07,
              itemPadding: EdgeInsets.zero,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: _controller!.onRate,
            ),
            SizedBox(height: _height * 0.04),
            _buildTextFieldWidget(
              _controller!.descController,
              "Description",
            ),
            SizedBox(height: _height * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
              child: Obx(
                () => _controller!.reviewRatingLoading.value
                    ? CircularLoadingWidget(_width, center: true)
                    : ButtonWidget(
                        text: "Submit",
                        onPressed: _controller!.onSubmitReviewPressed,
                      ),
              ),
            ),
          ],
        ),
      );

  Future<void> _showReviewRatingBottomSheet() async {
    return showMaterialModalBottomSheet(
      context: Get.context!,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      barrierColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_height * 0.015),
          topRight: Radius.circular(_height * 0.015),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: Get.mediaQuery.viewInsets.bottom +
                Get.mediaQuery.padding.bottom,
            top: Get.mediaQuery.viewInsets.top,
          ),
          child: _buildReviewRatingContentWidget,
        );
      },
    );
  }

  Widget _buildDoctorDetailTextWidget(String title, String value) => RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: title,
          style: GoogleFonts.rubik(
            color: HexColor(CustomColors.grey3),
            fontSize: _height * 0.018,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: value,
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: _height * 0.018,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );

  Widget get _buildDoctorDetailsWidget => Container(
        width: _width,
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
            _buildDoctorDetailTextWidget(
              "Hostital : ",
              "${_controller!.data?.doctorDetails.hospitalName}",
            ),
            SizedBox(height: _height * 0.01),
            _buildDoctorDetailTextWidget(
              "Experience : ",
              "${_controller!.data?.doctorDetails.startExperience}",
            ),
            SizedBox(height: _height * 0.01),
            _buildDoctorDetailTextWidget(
              "Time : ",
              "${_controller!.data?.doctorDetails.fromTime} - ${_controller!.data?.doctorDetails.toTime}",
            ),
            SizedBox(height: _height * 0.01),
            _buildDoctorDetailTextWidget(
              "Days : ",
              "${_controller!.data?.doctorDetails.days}",
            ),
            SizedBox(height: _height * 0.01),
            _buildDoctorDetailTextWidget(
              "Address : ",
              "${_controller!.data?.doctorDetails.address}",
            ),
          ],
        ),
      );

  Widget get _buildContentWidget => SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
        child: Column(
          children: [
            _buildDoctorWidget,
            // SizedBox(height: _height * 0.035),
            // _buildInformationWidget,
            SizedBox(height: _height * 0.035),
            _buildDoctorDetailsWidget,
            SizedBox(height: _height * 0.035),
            _buildRatingsReviewsWidget,
            SizedBox(height: _height * 0.05),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTitleWidget("Patient Reviews"),
                  SizedBox(height: _height * 0.025),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    padding: EdgeInsets.symmetric(horizontal: _width * 0.03),
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: _height * 0.0015,
                        height: _height * 0.03,
                      );
                    },
                    itemBuilder: (context, index) {
                      return _buildReviewItemWidget();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: _height * 0.02),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      _controller = Get.find<DoctorDetailsController>();

      _controller!
          .listenReviewRatingBottomSheetState(_showReviewRatingBottomSheet);
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
                  SizedBox(height: _height * 0.03),
                  Expanded(
                    child: Obx(
                      () => _controller!.loading.value
                          ? CircularLoadingWidget(_width, center: true)
                          : _controller!.data == null
                              ? NoDataFoundWidget("Doctor details not found")
                              : _buildContentWidget,
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
