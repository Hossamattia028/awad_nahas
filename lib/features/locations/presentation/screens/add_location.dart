
import 'package:awad_nahas/core/strings/enum/location_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';
import 'package:awad_nahas/features/locations/presentation/screens/set_and_get_coordinates.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/location_kind.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';



class AddNewLocationScreen extends StatefulWidget {
  final LocationEntity? locationEntity;
  final String? type;
  const AddNewLocationScreen({Key? key,this.locationEntity,this.type="work"}) : super(key: key);

  @override
  State<AddNewLocationScreen> createState() => _AddNewLocationScreenState();
}

class _AddNewLocationScreenState extends State<AddNewLocationScreen> {
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController streetTextEditingController = TextEditingController();
  final TextEditingController areaTextEditingController = TextEditingController();
  final TextEditingController flatNumberTextEditingController = TextEditingController();
  final TextEditingController buildingNumberTextEditingController = TextEditingController();
  late LocationsBloc locationsBloc;
  LocationMapEntity? locationMapEntity;
  LocationEnum locationEnum = LocationEnum.HOME;

  @override
  void didChangeDependencies() {
    locationsBloc = LocationsBloc.get(context);
    if(widget.locationEntity!=null){
      locationMapEntity = LocationMapEntity(
          lat: widget.locationEntity!.lat, long: widget.locationEntity!.long,
          address: widget.locationEntity!.address, city: widget.locationEntity!.city, country: widget.locationEntity!.country);
      if(widget.locationEntity!.type=="work"){
        locationEnum = LocationEnum.WORK;
      }else if(widget.locationEntity!.type=="home"){
        locationEnum = LocationEnum.HOME;
      }else{
        locationEnum = LocationEnum.OTHER;
      }
      nameTextEditingController.text = Util.getName();
      phoneTextEditingController.text = widget.locationEntity!.phone;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GlobalAppBar(
          title: widget.locationEntity!=null?widget.locationEntity!.address:translate("map.add_location"),
          justLogo: true,
          leadingIcon: GlobalWidgets.backArrowButton(()=> Navigator.of(context).pop(),kText1,Alignment.center,),
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
                  InkWell(
                    onTap: ()async{
                      final res = await Util.pushPage(MapScreen(isSet: true, title: translate("map.select_on_map")), context);
                      if(res!=null){
                        setState(() {
                          locationMapEntity = res;
                        });
                      }
                    },
                    child: Container(
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
                            height: 75.h,
                            child: const GoogleMap(
                              initialCameraPosition: CameraPosition(target: LatLng(25.2062701, 55.3498132), zoom: 10),
                              mapType: MapType.normal,
                            ),
                          ),
                          Align(
                            child: CustomText(
                              text: locationMapEntity==null?translate("map.select_on_map"):translate("button.edit"),
                              color: kPrimary,
                              fontSize: AppStyle.small.sp,
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
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 420.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 2),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5,color: kSecondPrimary)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: translate("map.personal"),
                          color: kSecondPrimary,
                          fontSize: AppStyle.small.sp,
                        ),
                        const Divider(color: kSecondPrimary,),

                        const SizedBox(height: 10,),
                        CustomTextFromField(
                            hintText: translate("map.street_number"),
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
                        const SizedBox(height: 10,),
                        CustomTextFromField(
                            hintText: translate("map.area"),
                            labelText: translate("map.area"),
                            onChanged: (val){},
                            maxLines: 1,
                            hasBorder: true,
                            cursorColor: kPrimary,
                            radius: 4,
                            textEditingController: areaTextEditingController,
                            validator: (){},
                            obscureText: false,
                            isLabelError: false),
                        const SizedBox(height: 10,),
                        CustomTextFromField(
                            hintText: translate("map.flat_number"),
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
                        const SizedBox(height: 10,),
                        CustomTextFromField(
                            hintText: translate("map.building_name"),
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
                        const SizedBox(height: 10,),

                        CustomTextFromField(
                            hintText: translate("profile.mobile"),
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
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 100.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5,color: kSecondPrimary)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: translate("map.location_name"),
                          color: kSecondPrimary,
                          fontSize: AppStyle.small.sp,
                        ),
                        const Divider(color: kSecondPrimary,),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            LocationKindWidget(selected: locationEnum == LocationEnum.HOME,img: AppImages.logo, title: translate("map.home"), fn: (){setState(() { locationEnum = LocationEnum.HOME;});}),
                            const SizedBox(width: 10,),
                            LocationKindWidget(selected: locationEnum == LocationEnum.WORK,img: AppImages.logo, title: translate("map.work"), fn: (){setState(() { locationEnum = LocationEnum.WORK;});}),
                            const SizedBox(width: 10,),
                            LocationKindWidget(selected: locationEnum == LocationEnum.OTHER,img: AppImages.logo, title: translate("map.other"), fn: (){setState(() { locationEnum = LocationEnum.OTHER;});}),
                          ],
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 30,),
                  BlocBuilder<LocationsBloc,LocationsState>(
                    builder: (ctx, state){
                      bool isLoading = state is LocationsLoadingState;
                      return CustomButton(
                        height: 40.h,
                        width: double.infinity,
                        circular: 4,
                        widget: isLoading?const CircularProgressIndicator(color: Colors.white,):
                        CustomText(
                          color: Colors.white,
                          fontSize: AppStyle.small.sp,
                          fontWeight: FontWeight.w400,
                          text: translate("map.save_location"),
                        ),
                        color: kPrimary,
                        onPressed: () async {
                          var phone = phoneTextEditingController.text.trim();
                          if(flatNumberTextEditingController.text.trim().isNotEmpty&&buildingNumberTextEditingController.text.trim().isNotEmpty){
                            if(widget.locationEntity!=null){
                              locationsBloc.add(UpdateLocationEvent(data: {
                                "id":widget.locationEntity!.id,
                                "street1": locationMapEntity!.address,
                                "street2": locationMapEntity!.address,
                                "country": locationMapEntity!.country,
                                "city": locationMapEntity!.city,
                                "zipcode": "00",
                                "longitude": locationMapEntity!.lat,
                                "latitude": locationMapEntity!.long,
                                "phone": phone.isEmpty?Util.getMobile().toString():phone ,
                                "type": locationEnum == LocationEnum.HOME? "home":locationEnum == LocationEnum.WORK?"work":"other",
                                "user_id":Util.getUserID()
                              }));
                            }else{
                              if(locationMapEntity==null)return SnackBarBuilder.showFeedBackMessage(context, translate("toast.select_location"), Colors.red);
                              locationsBloc.add(AddLocationEvent(data: {
                                "street1": locationMapEntity!.address,
                                "street2": locationMapEntity!.address,
                                "country": locationMapEntity!.country,
                                "city": locationMapEntity!.city,
                                "zipcode": "00",
                                "longitude": locationMapEntity!.lat,
                                "latitude": locationMapEntity!.long,
                                "phone": phone.isEmpty?Util.getMobile().toString():phone ,
                                "type": locationEnum == LocationEnum.HOME? "home":locationEnum == LocationEnum.WORK?"work":"other",
                                "user_id":Util.getUserID()
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
