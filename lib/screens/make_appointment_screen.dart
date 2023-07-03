import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/constants/patient_type_enum.dart';
import 'package:flutter_hello_my_doctor/controllers/make_appointment_controller.dart';
import 'package:flutter_hello_my_doctor/widgets/button_widget.dart';
import 'package:flutter_hello_my_doctor/widgets/circular_loading_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/custom_colors.dart';
import '../utils/theme_utils.dart';
import '../utils/utils.dart';
import '../widgets/back_button_widget.dart';

// ignore: must_be_immutable
class MakeAppointmentScreen extends StatelessWidget {
  MakeAppointmentScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  MakeAppointmentController? _controller;

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
                    "Make an Appointment",
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
        borderRadius: BorderRadius.circular(_width * 0.035),
        borderSide: BorderSide(
          color: color ?? HexColor(CustomColors.grey1).withOpacity(0.16),
          width: _height * 0.001,
        ),
      );

  Widget _buildTextFieldWidget(
    TextEditingController controller,
    String hint, {
    bool obscureText = false,
    bool enabled = true,
    TextInputType inputType = TextInputType.emailAddress,
    String? Function(String?)? validator,
    bool isRequired = true,
  }) =>
      TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: _height * 0.017,
        ),
        validator: isRequired
            ? validator ?? (val) => Utils.notEmptyValidator(val, "Required")
            : null,
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.rubik(
            fontWeight: FontWeight.w300,
            color: HexColor(CustomColors.grey1),
            fontSize: _height * 0.017,
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
            vertical: _height * 0.015,
            horizontal: _width * 0.04,
          ),
        ),
      );

  Widget _buildDatePickerWidget(
    TextEditingController controller,
    String hint,
  ) =>
      GestureDetector(
        onTap: _controller!.openDatePicker,
        child: _buildTextFieldWidget(
          controller,
          hint,
          enabled: false,
        ),
      );

  Widget _buildTitleWidget(String title) => Text(
        title,
        style: GoogleFonts.rubik(
          color: Colors.black,
          fontSize: _height * 0.018,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget get _buildPaymentSuccessDialogWidget => Column(
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
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor(CustomColors.green2),
                  ),
                  padding: EdgeInsets.all(_width * 0.09),
                  child: SizedBox(
                    height: _height * 0.06,
                    width: _height * 0.06,
                    child: Image.asset("assets/images/thumb_up.webp"),
                  ),
                ),
                SizedBox(height: _height * 0.015),
                Text(
                  "Thank You !",
                  style: GoogleFonts.rubik(
                    fontSize: _height * 0.032,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: _height * 0.01),
                Text(
                  "Your Appointment Successful",
                  style: GoogleFonts.rubik(
                    fontSize: _height * 0.021,
                    color: HexColor(CustomColors.grey1),
                  ),
                ),
                SizedBox(height: _height * 0.035),
                Text(
                  "You booked an appointment with ${_controller!.selectedDoctor?.name} on ${_controller!.dateController.text}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontSize: _height * 0.018,
                    color: HexColor(CustomColors.grey1),
                  ),
                ),
                SizedBox(height: _height * 0.035),
                ButtonWidget(
                  text: "Done",
                  onPressed: _controller!.onDonePressed,
                ),
              ],
            ),
          ),
        ],
      );

  Future<void> _showPaymentSuccessDialog() async {
    return await showCupertinoDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: _buildPaymentSuccessDialogWidget,
          ),
        );
      },
    );
  }

  Widget _buildPatientTyperadioWidget(String title, PatientType type) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(_width * 0.015),
          onTap: () => _controller!.onPatientTypeChanged(type),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: _height * 0.005),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Radio<PatientType>(
                    value: type,
                    groupValue: _controller!.selectedPatientType.value,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: _controller!.onPatientTypeChanged,
                  ),
                ),
                Flexible(
                  child: Text(
                    title,
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: _height * 0.018,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get _buildContentWidget => Column(
        children: [
          _buildAppbarWidget,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                    margin: EdgeInsets.only(
                      top: _height * 0.02,
                      bottom: _height * 0.03,
                      left: _width * 0.05,
                      right: _width * 0.05,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: _width * 0.035,
                      // vertical: _height * 0.05,
                    ),
                    child: Form(
                      key: _controller!.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: _height * 0.03),
                          _buildTitleWidget("Patient Type : "),
                          _buildPatientTyperadioWidget(
                            "New (नया नँबर लगाने के लिए)",
                            PatientType.newPatient,
                          ),
                          _buildPatientTyperadioWidget(
                            "Existing (दुबारा नँबर लगाने के लिए अगर परामर्श शुल्क की अवधि खत्म नही हुई है)",
                            PatientType.existingPatient,
                          ),
                          SizedBox(height: _height * 0.035),
                          _buildTitleWidget("Patient Name : "),
                          SizedBox(height: _height * 0.015),
                          _buildTextFieldWidget(
                            _controller!.nameController,
                            "Add Patient Name",
                          ),
                          SizedBox(height: _height * 0.025),
                          _buildTitleWidget("Patient Age : "),
                          SizedBox(height: _height * 0.015),
                          _buildTextFieldWidget(
                            _controller!.ageController,
                            "Add Patient Age",
                            inputType: TextInputType.number,
                          ),
                          SizedBox(height: _height * 0.025),
                          _buildTitleWidget("Father/Husband's name : "),
                          SizedBox(height: _height * 0.015),
                          _buildTextFieldWidget(
                            _controller!.fhNameController,
                            "Enter Father/Husband's name",
                          ),
                          SizedBox(height: _height * 0.025),
                          _buildTitleWidget("Mobile Number : "),
                          SizedBox(height: _height * 0.015),
                          _buildTextFieldWidget(
                            _controller!.mobileController,
                            "Add Mobile Number",
                            inputType: TextInputType.phone,
                            validator: (val) => Utils.validator2(
                              val,
                              "Required",
                              isMobile: true,
                            ),
                          ),
                          SizedBox(height: _height * 0.025),
                          _buildTitleWidget("Address (Optional) : "),
                          SizedBox(height: _height * 0.015),
                          _buildTextFieldWidget(
                            _controller!.addressController,
                            "Add Address (Optional)",
                            isRequired: false,
                          ),
                          SizedBox(height: _height * 0.025),
                          _buildTitleWidget("Date of Appointment : "),
                          SizedBox(height: _height * 0.015),
                          _buildDatePickerWidget(
                            _controller!.dateController,
                            "Enter date of appointment",
                          ),
                          // SizedBox(height: _height * 0.02),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
                    child: Obx(
                      () => _controller!.loading.value
                          ? CircularLoadingWidget(_width, center: true)
                          : ButtonWidget(
                              text: "Continue",
                              onPressed: _controller!.onContinuePressed,
                            ),
                    ),
                  ),
                  SizedBox(height: _height * 0.03),
                ],
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      _controller = Get.find<MakeAppointmentController>();
      _controller!.listenPaymentSuccessDialogState(_showPaymentSuccessDialog);
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
              _buildContentWidget,
            ],
          ),
        ),
      ),
    );
  }
}
