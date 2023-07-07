import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/controllers/appointments_controller.dart';
import 'package:flutter_hello_my_doctor/models/appointment_model.dart';
import 'package:flutter_hello_my_doctor/widgets/circular_loading_widget.dart';
import 'package:flutter_hello_my_doctor/widgets/no_data_found_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/custom_colors.dart';
import '../../utils/theme_utils.dart';
import '../../widgets/back_button_widget.dart';

// ignore: must_be_immutable
class AppointmentsScreen extends StatelessWidget {
  AppointmentsScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  AppointmentsController? _controller;

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
                    "Appointments",
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

  Widget _buildInfoWidget(
    String title,
    String data, {
    Color? color,
    FontWeight? fontWeight,
  }) =>
      RichText(
        text: TextSpan(
          text: title,
          style: GoogleFonts.rubik(
            color: Colors.black,
            fontSize: _height * 0.0175,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: data,
              style: GoogleFonts.rubik(
                color: color ?? HexColor(CustomColors.black2),
                fontSize: _height * 0.0175,
                fontWeight: fontWeight ?? FontWeight.w400,
              ),
            ),
          ],
        ),
      );

  Widget _buildAppointmentItemWidget(AppointmentModel data) => GestureDetector(
        onTap: () {},
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_width * 0.025),
                  color: HexColor(CustomColors.blue2),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: _width * 0.03,
                  vertical: _height * 0.016,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.date,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: _height * 0.0185,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: _height * 0.004),
                    Text(
                      data.month,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: _height * 0.0185,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
                        data.docName,
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
                        data.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ptSans(
                          color: HexColor(CustomColors.green1),
                          fontSize: _height * 0.016,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: _height * 0.006),
                      _buildInfoWidget("Patient : ", data.patientName),
                      SizedBox(height: _height * 0.004),
                      _buildInfoWidget("Time : ", data.time),
                      SizedBox(height: _height * 0.004),
                      _buildInfoWidget("Token No. : ", data.serialNo),
                      SizedBox(height: _height * 0.004),
                      _buildInfoWidget("Fees : ", "Rs.${data.fees}"),
                      SizedBox(height: _height * 0.004),
                      _buildInfoWidget(
                        "Current Status : ",
                        data.status,
                        color: HexColor(CustomColors.green3),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
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
                    // itemCount: 10,
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
                      return _buildAppointmentItemWidget(
                          _controller!.dataList[index]);
                    },
                  )
                : NoDataFoundWidget("No appointment found"),
      );

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<AppointmentsController>();

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
