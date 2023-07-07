import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/constants/service_enum.dart';
import 'package:flutter_hello_my_doctor/controllers/home_controller.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/models/doctor_model.dart';
import 'package:flutter_hello_my_doctor/models/home_model.dart';
import 'package:flutter_hello_my_doctor/widgets/no_data_found_widget.dart';
import 'package:flutter_hello_my_doctor/widgets/profile_button_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/custom_colors.dart';
import '../../utils/theme_utils.dart';
import '../../widgets/circular_loading_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  UserController? _userController;
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
              HexColor(CustomColors.blue1),
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
                    Obx(
                      () => Text(
                        "Hi ${_userController!.user.value.userName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w300,
                          fontSize: cons.maxHeight * 0.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: cons.maxHeight * 0.04),
                    Text(
                      "Find Your Services",
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
              ProfileButtonWidget(
                onPressed: _controller!.onProfilePressed,
              ),
            ],
          );
        }),
      );

  Widget get _buildCarouselWidget => Column(
        children: [
          SizedBox(
            height: _height * 0.23,
            width: _width * 0.95,
            child: CarouselSlider.builder(
              carouselController: _controller!.carouselController,
              options: CarouselOptions(
                height: _height * 0.23,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: _controller!.onSliderChanged,
              ),
              itemCount: _controller!.data?.sliders.length,
              itemBuilder: (context, index, _) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width * 0.025),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_width * 0.025),
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: _controller!.data!.sliders[index].image,
                        height: _height * 0.23,
                        width: double.infinity,
                        progressIndicatorBuilder: (context, _, __) =>
                            CircularLoadingWidget(_width, center: true),
                        fit: BoxFit.cover,
                        errorWidget: (context, _, __) => Image.asset(
                          "assets/images/logo.webp",
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: _height * 0.01),
          Obx(
            () => AnimatedSmoothIndicator(
              activeIndex: _controller!.currentIndex.value,
              count: _controller!.data!.sliders.length,
              effect: ScrollingDotsEffect(
                dotColor: HexColor(CustomColors.grey7),
                activeDotColor: HexColor(CustomColors.blue1),
                dotHeight: _height * 0.008,
                dotWidth: _height * 0.008,
                spacing: _width * 0.018,
              ),
            ),
          ),
        ],
      );

  Widget _buildServiceWidget(String title, String iconPath, ServiceEnum type) =>
      Stack(
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
                onTap: () => _controller!.onServiceSelected(type),
              ),
            ),
          ),
        ],
      );

  Widget get _buildServicesGridViewWidget => GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
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
            ServiceEnum.doctorAppointment,
          ),
          _buildServiceWidget(
            "Medicine Delivery",
            "assets/images/medicine_delivery.webp",
            ServiceEnum.medicineDelivery,
          ),
          _buildServiceWidget(
            "Pathology Service",
            "assets/images/pathology_service.webp",
            ServiceEnum.pathologyService,
          ),
          _buildServiceWidget(
            "Covid-19 RT-PCR Test",
            "assets/images/covid.webp",
            ServiceEnum.covid19RTPCRTest,
          ),
        ],
      );

  Widget _buildTitleWidget(String title, {Color? color}) => Text(
        title,
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          fontSize: _height * 0.021,
          color: color ?? Colors.black,
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
            fontWeight: FontWeight.w500,
            fontSize: _height * 0.0175,
          ),
        ),
      );

  Widget _buildPopularDoctorItemWidget(DoctorDetailsModel data) =>
      LayoutBuilder(builder: (context, cons) {
        return Stack(
          children: [
            Container(
              width: _width * 0.5,
              height: cons.maxHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_width * 0.04),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_width * 0.04),
                      topRight: Radius.circular(_width * 0.04),
                    ),
                    child: SizedBox(
                      height: cons.maxHeight * 0.65,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: data.image,
                        height: cons.maxHeight * 0.65,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, _, __) => SizedBox(
                          height: cons.maxHeight * 0.65,
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
                            data.name,
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
                            data.degree,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w300,
                              fontSize: cons.maxHeight * 0.05,
                              color:
                                  HexColor(CustomColors.grey1).withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: cons.maxHeight * 0.01),
                          RatingBar.builder(
                            tapOnlyMode: true,
                            ignoreGestures: true,
                            initialRating: data.rating,
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
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(_width * 0.04),
                  onTap: () => _controller!.onDoctorPressed(data),
                ),
              ),
            ),
          ],
        );
      });

  Widget _buildReviewItemWidget(VideoReviewModel data) => InkWell(
        onTap: () => _controller!.onVideoReviewPressed(data),
        child: LayoutBuilder(builder: (context, cons) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: cons.maxHeight * 0.85,
                    width: _width * 0.32,
                    child: CachedNetworkImage(
                      imageUrl: "",
                      height: cons.maxHeight * 0.85,
                      width: _width * 0.32,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, _, __) => SizedBox(
                        height: cons.maxHeight * 0.85,
                        width: _width * 0.32,
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
                    data.title,
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
        }),
      );

  Widget _buildDoctorReviewItemWidget(VideoReviewModel data) => InkWell(
        onTap: () => _controller!.onVideoReviewPressed(data),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_width * 0.05),
          ),
          padding: EdgeInsets.all(_height * 0.005),
          child: LayoutBuilder(builder: (context, cons) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(_width * 0.05),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: cons.maxHeight * 0.8,
                        width: _width * 0.27,
                        child: CachedNetworkImage(
                          imageUrl: "",
                          height: cons.maxHeight * 0.8,
                          width: _width * 0.27,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, _, __) =>
                              SizedBox(
                            height: cons.maxHeight * 0.8,
                            width: _width * 0.27,
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
                      Icon(
                        Icons.play_circle_outline_outlined,
                        color: Colors.white,
                        size: cons.maxHeight * 0.17,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: cons.maxHeight * 0.03,
                    ),
                    child: Text(
                      data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: cons.maxHeight * 0.09,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      );

  Widget _buildServiceServedItemWidget(String data, String title) =>
      LayoutBuilder(builder: (context, cons) {
        return Container(
          decoration: BoxDecoration(
            color: HexColor(CustomColors.blue3),
            // color: Colors.black,
            borderRadius: BorderRadius.circular(_width * 0.02),
          ),
          padding: EdgeInsets.symmetric(
            vertical: cons.maxHeight * 0.03,
            horizontal: cons.maxWidth * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                style: GoogleFonts.rubik(
                  color: HexColor(CustomColors.blue2),
                  fontSize: cons.maxHeight * 0.15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: _height * 0.01),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  color: HexColor(CustomColors.blue1),
                  fontSize: cons.maxHeight * 0.1,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      });

  Widget get _buildDoctorReviewsWidget => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/doctor_review_bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _height * 0.02),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
                child: _buildTitleWidget(
                  "Doctors Review",
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: _height * 0.015),
            SizedBox(
              height: _height * 0.19,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _controller!.data!.doctorsReview.length,
                padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: _width * 0.06);
                },
                itemBuilder: (BuildContext context, int index) {
                  return _buildDoctorReviewItemWidget(
                    _controller!.data!.doctorsReview[index],
                  );
                },
              ),
            ),
            SizedBox(height: _height * 0.03),
          ],
        ),
      );

  Widget get _buildServicesServedGridViewWidget => GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: _width * 0.05,
          mainAxisSpacing: _height * 0.03,
        ),
        children: [
          _buildServiceServedItemWidget(
            "${_controller!.data?.serviceServed.clientRetention}%",
            "Client Retention",
          ),
          _buildServiceServedItemWidget(
            "${_controller!.data?.serviceServed.yearsOfService}",
            "Years of Service",
          ),
          _buildServiceServedItemWidget(
            "${_controller!.data?.serviceServed.teamOfProfessionals}+",
            "Team of Professtionals",
          ),
          _buildServiceServedItemWidget(
            "${_controller!.data?.serviceServed.satisfiedClient}+",
            "Satisfied Clients",
          ),
        ],
      );

  Widget get _buildCustomerReviewsWidget => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: _height * 0.04),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
              child: _buildTitleWidget("Reviews From Happy Customers"),
            ),
          ),
          SizedBox(height: _height * 0.01),
          SizedBox(
            height: _height * 0.23,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _controller!.data!.customersReview.length,
              padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: _width * 0.06);
              },
              itemBuilder: (BuildContext context, int index) {
                return _buildReviewItemWidget(
                  _controller!.data!.customersReview[index],
                );
              },
            ),
          ),
        ],
      );

  Widget get _buildContentWidget => SingleChildScrollView(
        child: Column(
          children: [
            if (_controller!.data!.sliders.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: _height * 0.02),
                  _buildCarouselWidget,
                ],
              ),
            SizedBox(height: _height * 0.06),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
                child: _buildTitleWidget("Find Your Service"),
              ),
            ),
            SizedBox(height: _height * 0.02),
            _buildServicesGridViewWidget,
            SizedBox(height: _height * 0.07),
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
            if (_controller!.data!.doctors.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: _height * 0.01),
                  SizedBox(
                    height: _height * 0.3,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _controller!.data!.doctors.length,
                      padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: _width * 0.05);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return _buildPopularDoctorItemWidget(
                          _controller!.data!.doctors[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            if (_controller!.data!.customersReview.isNotEmpty)
              _buildCustomerReviewsWidget,
            if (_controller!.data!.doctorsReview.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: _height * 0.02),
                  _buildDoctorReviewsWidget,
                ],
              ),
            SizedBox(height: _height * 0.05),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
                child: _buildTitleWidget("Service Served"),
              ),
            ),
            SizedBox(height: _height * 0.01),
            _buildServicesServedGridViewWidget,
            SizedBox(height: _height * 0.015),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    _userController ??= Get.find<UserController>();
    _controller ??= Get.find<HomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarOneTheme(context),
      child: Scaffold(
        body: Column(
          children: [
            _buildTopWidget,
            Expanded(
              child: Obx(
                () => _controller!.loading.value
                    ? CircularLoadingWidget(_width, center: true)
                    : _controller!.data == null
                        ? NoDataFoundWidget("An error accured")
                        : _buildContentWidget,
              ),
            )
          ],
        ),
      ),
    );
  }
}
