
// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/strings/enum/location_enum.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';
import 'package:awad_nahas/features/locations/presentation/screens/set_and_get_coordinates.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:permission_handler/permission_handler.dart';



class AddNewLocationScreen extends StatefulWidget {
  final LocationEntity? locationEntity;
  final String? type;
  const AddNewLocationScreen({Key? key,this.locationEntity,this.type="shipping"}) : super(key: key);

  @override
  State<AddNewLocationScreen> createState() => _AddNewLocationScreenState();
}

class _AddNewLocationScreenState extends State<AddNewLocationScreen> {
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController cityTextEditingController = TextEditingController();
  final TextEditingController streetTextEditingController = TextEditingController();
  final TextEditingController areaTextEditingController = TextEditingController();
  final TextEditingController flatNumberTextEditingController = TextEditingController();
  final TextEditingController buildingNumberTextEditingController = TextEditingController();
  final TextEditingController postCodeNumberTextEditingController = TextEditingController();
  late LocationsBloc locationsBloc;
  LocationMapEntity? locationMapEntity;
  LocationEnum locationEnum = LocationEnum.Billing;

  @override
  void didChangeDependencies() {
    locationsBloc = LocationsBloc.get(context);
    if(widget.locationEntity!=null){
      locationMapEntity = LocationMapEntity(
          lat: widget.locationEntity!.lat, long: widget.locationEntity!.long,
          address: widget.locationEntity!.address2, city: widget.locationEntity!.address1,
          country: widget.locationEntity!.country,postalCode: widget.locationEntity!.postCode.toString(),street: widget.locationEntity!.state.toString());
      if(widget.locationEntity!.type=="billing"){
        locationEnum = LocationEnum.Billing;
      }else if(widget.locationEntity!.type=="shipping"){
        locationEnum = LocationEnum.Shipping;
      }else{
        locationEnum = LocationEnum.OTHER;
      }
      nameTextEditingController.text = Util.getName();
      phoneTextEditingController.text = widget.locationEntity!.phone;
      streetTextEditingController.text =  widget.locationEntity!.address2;
      cityTextEditingController.text =  widget.locationEntity!.address1;
      postCodeNumberTextEditingController.text = locationMapEntity!.postalCode;
      locationsBloc.add(UpdateCurrentLocationEvent(isShipping: locationEnum == LocationEnum.Shipping));
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
        title: widget.locationEntity!=null?widget.locationEntity!.address1:translate("map.add_location"),
        leadingIcon: const BackArrowButton(),
      ),
      body: BlocListener<LocationsBloc,LocationsState>(
        listenWhen: (ctx, state){
          return state is LocationsSuccessfullyState;
        },
        listener:  (ctx, state){
          if(state is LocationsSuccessfullyState){
            SnackBarBuilder.showFeedBackMessage(context, translate("toast.update_user_data"), Colors.green);
            Navigator.pop(context);
          }
          if(state is LocationsFailedState)SnackBarBuilder.showFeedBackMessage(context, translate("toast.oops"), Colors.red);
        },
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: locationMapEntity!=null?190.h:160.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5,color: kSecondPrimary)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        color: kSecondPrimary,
                        fontSize: AppStyle.small.sp,
                        fontWeight: FontWeight.w700,
                        text: translate("map.location_details"),
                      ),
                      const Divider(color: kSecondPrimary,),

                      SizedBox(
                        height: 110.h,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const GoogleMap(
                              initialCameraPosition: CameraPosition(target: LatLng(21.4504394, 38.8815082), zoom: 10),
                              mapType: MapType.normal,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 4),
                              child: CustomButton(
                                height: 22.h,
                                width: 70.w,
                                sideWidth: 0.6,
                                sideColor: DMUtil.getRED(),
                                circular: 10,
                                widget: CustomText(
                                  text: locationMapEntity==null?translate("map.select_on_map"):translate("button.edit"),
                                  color: DMUtil.getRED(),
                                  fontSize: AppStyle.small.sp,
                                ),
                                color: DMUtil.getWC(),
                                onPressed: ()async{
                                  await Permission.location.request();
                                  final res = await Util.pushPage(MapScreen(isSet: true, title: translate("map.select_on_map")), context);
                                  if(res!=null){
                                    setState(() {
                                      locationMapEntity = res;
                                    });
                                    cityTextEditingController.text = locationMapEntity!.city;
                                    streetTextEditingController.text = locationMapEntity!.street;
                                    postCodeNumberTextEditingController.text = locationMapEntity!.postalCode;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      if(locationMapEntity!=null)...[
                        const SizedBox(height: 4,),
                        CustomText(
                          text: locationMapEntity!.address,
                          color: kText1,
                          fontSize: AppStyle.verySmall.sp-1,
                          isEllipsis: true,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                CustomText(
                  text: translate("map.personal"),
                  color: kSecondPrimary,
                  fontSize: AppStyle.small.sp,
                ),
                const Divider(color: kSecondPrimary,),
                const SizedBox(height: 10,),
                CustomTextFromField(
                    hintText: "",
                    labelText: translate("map.town"),
                    onChanged: (val){},
                    maxLines: 1,
                    hasBorder: true,
                    cursorColor: kPrimary,
                    radius: 4,
                    textEditingController: cityTextEditingController,
                    validator: (){},
                    obscureText: false,
                    isLabelError: false),
                const SizedBox(height: 15,),
                CustomTextFromField(
                    hintText: "",
                    labelText: translate("map.street_number"),
                    onChanged: (val){},
                    maxLines: 1,
                    hasBorder: true,
                    cursorColor: kPrimary,
                    radius: 4,
                    textEditingController: streetTextEditingController,
                    validator: (){},
                    obscureText: false,
                    isLabelError: false),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: CustomTextFromField(
                          hintText: "",
                          labelText: translate("map.block_number"),
                          onChanged: (val){},
                          maxLines: 1,
                          hasBorder: true,
                          cursorColor: kPrimary,
                          radius: 4,
                          textEditingController: areaTextEditingController,
                          validator: (){},
                          obscureText: false,
                          isLabelError: false),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: CustomTextFromField(
                          hintText: "",
                          labelText: translate("map.flat_number"),
                          onChanged: (val){},
                          maxLines: 1,
                          hasBorder: true,
                          cursorColor: kPrimary,
                          radius: 4,
                          textEditingController: flatNumberTextEditingController,
                          validator: (){},
                          obscureText: false,
                          isLabelError: false),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: CustomTextFromField(
                          hintText: "",
                          labelText: translate("map.building_name"),
                          onChanged: (val){},
                          maxLines: 1,
                          hasBorder: true,
                          cursorColor: kPrimary,
                          radius: 4,
                          textEditingController: buildingNumberTextEditingController,
                          validator: (){},
                          obscureText: false,
                          isLabelError: false),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                CustomTextFromField(
                    hintText: "",
                    labelText: translate("profile.mobile"),
                    onChanged: (val){},
                    cursorColor: kPrimary,
                    textInputType: TextInputType.number,
                    hasBorder: true,
                    radius: 4,
                    textEditingController: phoneTextEditingController,
                    validator: (){},
                    obscureText: false,
                    isLabelError: false),
                const SizedBox(height: 15,),
                CustomTextFromField(
                    hintText: "",
                    labelText: translate("map.post_code"),
                    onChanged: (val){},
                    cursorColor: kPrimary,
                    textInputType: TextInputType.number,
                    hasBorder: true,
                    radius: 4,
                    textEditingController: postCodeNumberTextEditingController,
                    validator: (){},
                    obscureText: false,
                    isLabelError: false),



                const SizedBox(height: 20,),
                BlocBuilder<LocationsBloc,LocationsState>(
                  builder: (ctx, state){
                    bool isLoading = state is LocationsLoadingState;
                    return CustomButton(
                      height: 42.h,
                      width: double.infinity,
                      circular: 10,
                      widget: isLoading?const CircularProgressIndicator(color: Colors.white,):
                      CustomText(
                        color: Colors.white,
                        fontSize: AppStyle.average.sp,
                        text: translate("map.save_location"),
                      ),
                      color: DMUtil.getRED(),
                      onPressed: () async {
                        var type = locationEnum == LocationEnum.Shipping? "shipping":"billing";
                        var phone = phoneTextEditingController.text.trim();
                        if(flatNumberTextEditingController.text.trim().isNotEmpty&&buildingNumberTextEditingController.text.trim().isNotEmpty){
                          if(widget.locationEntity!=null){
                            locationsBloc.add(UpdateLocationEvent(data: {
                              // "id":widget.locationEntity!.id,
                              type:{
                               "${type}_phone": phone,
                               "${type}_email": Util.getEmail(),
                               "${type}_country": locationMapEntity!.country,
                               "${type}_postcode": locationMapEntity!.postalCode,
                               "${type}_state": locationMapEntity!.street,
                               "${type}_address_2": locationMapEntity!.street,
                               "${type}_address_1": locationMapEntity!.city,
                               "${type}_last_name": Util.getName(),
                               "${type}_first_name": Util.getName(),
                             }
                            }));
                          }else{
                            if(locationMapEntity==null)return SnackBarBuilder.showFeedBackMessage(context, translate("toast.select_location"), Colors.red);
                            locationsBloc.add(AddLocationEvent(data: {
                              type:{
                                "${type}_phone": phone,
                                "${type}_email": Util.getEmail(),
                                "${type}_country": locationMapEntity!.country,
                                "${type}_postcode": locationMapEntity!.postalCode,
                                "${type}_state": locationMapEntity!.street,
                                "${type}_address_2": locationMapEntity!.street,
                                "${type}_address_1": locationMapEntity!.city,
                                "${type}_last_name": Util.getName(),
                                "${type}_first_name": Util.getName(),
                              }
                            }));
                          }
                        }else{
                          return SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20,),

              ],
            ),
          ),
        )
      )
    );
  }


}
