import 'dart:io';

import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';



class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final TextEditingController firstNameTextEditingController = TextEditingController();
  final TextEditingController lastNameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController complaintTextEditingController = TextEditingController();
  final TextEditingController warrantyTextEditingController = TextEditingController();
  int deviceNumber = 1;
  File? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
        title: translate("drawer.maintaenance_request"),
        leadingIcon: const BackArrowButton(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
          height: 40.h,
          width: 200.w,
          circular: 10,
          color: DMUtil.getRED(),
          widget: CustomText(
            text: translate("button.send"),
            color: Colors.white,
            fontSize: AppStyle.average.sp,
          ),
          onPressed: () {
            RootBloc.get(context).sendMaintenance({
              "first_name": firstNameTextEditingController.text.trim(),
              "last_name": firstNameTextEditingController.text.trim(),
              "city": firstNameTextEditingController.text.trim(),
              "neighborhood": firstNameTextEditingController.text.trim(),
              "phone_number": phoneTextEditingController.text.trim(),
              "complaints": complaintTextEditingController.text.trim(),
              "warranty": warrantyTextEditingController.text.trim(),
              "number_of_maintained_devices": deviceNumber,
              "product_serial": deviceNumber,
              "brand_id": deviceNumber,
              "product_type": deviceNumber,
              "product_model": deviceNumber,
              "device_complete_2_years": deviceNumber,
              'img': img!,
            });
          },
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: 14.h),
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<RootBloc,RootState>(
            builder: (ctx,state){
              var bloc = RootBloc.get(ctx);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: translate("profile.name"),
                            color: DMUtil.getDC(),
                            fontSize: AppStyle.average.sp,
                          ),
                          const SizedBox(width: 5,),
                          SizedBox(
                            width: 160.w,
                            child: CustomTextFromField(
                              hintText: translate("signup.first_name"),
                              labelText: "",
                              hasBorder: true,
                              smallPadding: true,
                              cursorColor: kPrimary,
                              radius: 10,
                              textEditingController: firstNameTextEditingController,
                              validator: (){},
                              obscureText: false,
                              isLabelError: false,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: translate("signup.last_name"),
                            color: DMUtil.getDC(),
                            fontSize: AppStyle.average.sp,
                          ),
                          const SizedBox(width: 5,),
                          SizedBox(
                            width: 160.w,
                            child: CustomTextFromField(
                              hintText: translate("signup.last_name"),
                              labelText: "",
                              hasBorder: true,
                              smallPadding: true,
                              cursorColor: kPrimary,
                              radius: 10,
                              textEditingController: lastNameTextEditingController,
                              validator: (){},
                              obscureText: false,
                              isLabelError: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),
                  CustomText(
                    text: translate("signup.phone"),
                    color: DMUtil.getDC(),
                    fontSize: AppStyle.average.sp,
                  ),
                  CustomTextFromField(
                    hintText: translate("signup.phone"),
                    labelText: "",
                    hasBorder: true,
                    smallPadding: true,
                    cursorColor: kPrimary,
                    radius: 10,
                    textEditingController: phoneTextEditingController,
                    validator: (){},
                    obscureText: false,
                    isLabelError: false,
                  ),

                  const SizedBox(height: 12,),
                  DropdownButtonFormField(
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: DMUtil.getD2C()),),
                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent),),
                      border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent),),
                      hintText:translate("maintenance.number_of_maintenance_device"),
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: DMUtil.getD2C()),
                      isDense: true,
                    ),
                    // value: deviceNumber,
                    items: <DropdownMenuItem<String>>[
                      for (var i = 0; i < 5; i++)
                        DropdownMenuItem(
                            value: (i + 1).toString(),
                            child: Text((i + 1).toString(),
                                style: TextStyle(
                                  color: DMUtil.getD2C()
                                )))
                    ],
                    onChanged: (value) {
                      setState(() {
                        deviceNumber = int.parse(value.toString());
                      });
                    },
                  ),


                ],
              );
            },
          )
      ),
    );
  }
}
