import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/controllers/home_controller.dart';
import 'package:flutter_hello_my_doctor/widgets/profile_button_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/custom_colors.dart';
import '../../utils/theme_utils.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  HomeController? _controller;

  Widget get _buildTopWidget => Container(
        height: _height * 0.15,
        width: _width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_width * 0.06),
            bottomRight: Radius.circular(_width * 0.06),
          ),
          gradient: LinearGradient(
            colors: [
              HexColor(CustomColors.blue2),
              HexColor(CustomColors.blue3),
            ],
          ),
        ),
        padding: EdgeInsets.only(
          top: Get.mediaQuery.padding.top + _height * 0.015,
          left: _width * 0.03,
          right: _width * 0.03,
        ),
        child: LayoutBuilder(builder: (context, cons) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoButton(
                color: Colors.transparent,
                padding: EdgeInsets.zero,
                minSize: 0,
                borderRadius: BorderRadius.circular(_width),
                onPressed: _controller!.onDrawerMenuPressed,
                child: Icon(
                  Icons.menu_rounded,
                  size: cons.maxHeight * 0.35,
                ),
              ),
              SizedBox(width: _width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: cons.maxHeight * 0.05),
                    Text(
                      "Hi Pragya!",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w300,
                        fontSize: cons.maxHeight * 0.2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: cons.maxHeight * 0.04),
                    Text(
                      "Find Your Doctor",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: cons.maxHeight * 0.28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: _width * 0.02),
              ProfileButtonWidget(),
            ],
          );
        }),
      );

  Widget _buildServiceWidget(String title, String iconPath) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_width * 0.04),
              color: HexColor(CustomColors.blue1),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: _width * 0.025,
              vertical: _height * 0.01,
            ),
            child: LayoutBuilder(
              builder: (context, cons) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: cons.maxHeight * 0.35,
                    width: cons.maxHeight * 0.35,
                    child: Image.asset(
                      iconPath,
                    ),
                  ),
                  SizedBox(height: cons.maxHeight * 0.08),
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: cons.maxHeight * 0.09,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(_width * 0.04),
                onTap: _controller!.onServiceSelected,
              ),
            ),
          ),
        ],
      );

  Widget get _buildServicesGridViewWidget => GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: _height * 0.06,
          horizontal: _width * 0.1,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: _width * 0.1,
          mainAxisSpacing: _height * 0.05,
          childAspectRatio: 0.8,
        ),
        children: [
          _buildServiceWidget(
            "Doctor Appointment",
            "assets/images/doctor_appointment.webp",
          ),
          _buildServiceWidget(
            "Medicine Delivery",
            "assets/images/medicine_delivery.webp",
          ),
          _buildServiceWidget(
            "Pathology Service",
            "assets/images/pathology_service.webp",
          ),
          _buildServiceWidget(
            "Covid-19 RT-PCR Test",
            "assets/images/covid.webp",
          ),
        ],
      );

  Widget _buildTitleWidget(String title) => Text(
        title,
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          fontSize: _height * 0.021,
          color: Colors.black,
        ),
      );

  Widget get _buildSeeAllDoctorsButtonWidget => TextButton(
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
              horizontal: _width * 0.02,
              vertical: _height * 0.008,
            ),
          ),
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          overlayColor: MaterialStatePropertyAll(
            HexColor(CustomColors.blue1).withOpacity(0.4),
          ),
          foregroundColor: MaterialStatePropertyAll(
            HexColor(CustomColors.grey1),
          ),
        ),
        onPressed: _controller!.onSeeAllDoctorsPressed,
        child: Text(
          "See All",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.rubik(
            fontWeight: FontWeight.w400,
            fontSize: _height * 0.0165,
          ),
        ),
      );

  Widget _buildPopularDoctorItemWidget() =>
      LayoutBuilder(builder: (context, cons) {
        return Container(
          width: _width * 0.5,
          height: cons.maxHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_width * 0.04),
          ),
          child: Column(
            children: [
              SizedBox(
                height: cons.maxHeight * 0.65,
                width: double.infinity,
                child: Image.asset("assets/sample/sample1.png"),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _width * 0.015,
                    vertical: cons.maxHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dr. Shruti Grab",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: cons.maxHeight * 0.065,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: cons.maxHeight * 0.01),
                      Text(
                        "Medicine Specialist",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w300,
                          fontSize: cons.maxHeight * 0.05,
                          color: HexColor(CustomColors.grey1).withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: cons.maxHeight * 0.01),
                      RatingBar.builder(
                        tapOnlyMode: true,
                        ignoreGestures: true,
                        initialRating: 4.5,
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
                ),
              ),
            ],
          ),
        );
      });

  Widget _buildReviewItemWidget() => LayoutBuilder(builder: (context, cons) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: cons.maxHeight * 0.85,
                  width: _width * 0.32,
                  child: Image.asset(
                    "assets/sample/sample2.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Icon(
                  Icons.play_circle_outline_outlined,
                  color: Colors.white,
                  size: cons.maxHeight * 0.17,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: cons.maxHeight * 0.03,
                ),
                child: Text(
                  "Rahul Kumar",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: cons.maxHeight * 0.08,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      });

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<HomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarOneTheme(context),
      child: Scaffold(
        body: Column(
          children: [
            _buildTopWidget,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildServicesGridViewWidget,
                    SizedBox(height: _height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: _buildTitleWidget("Popular Doctor")),
                          _buildSeeAllDoctorsButtonWidget,
                        ],
                      ),
                    ),
                    SizedBox(height: _height * 0.01),
                    SizedBox(
                      height: _height * 0.3,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: 5,
                        padding:
                            EdgeInsets.symmetric(horizontal: _width * 0.04),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: _width * 0.05);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return _buildPopularDoctorItemWidget();
                        },
                      ),
                    ),
                    SizedBox(height: _height * 0.04),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: _width * 0.04),
                        child:
                            _buildTitleWidget("Reviews From Happy Customers"),
                      ),
                    ),
                    SizedBox(height: _height * 0.01),
                    SizedBox(
                      height: _height * 0.23,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: 5,
                        padding:
                            EdgeInsets.symmetric(horizontal: _width * 0.04),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: _width * 0.06);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return _buildReviewItemWidget();
                        },
                      ),
                    ),
                    SizedBox(height: _height * 0.015),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
