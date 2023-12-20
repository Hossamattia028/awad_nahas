// ignore_for_file: use_build_context_synchronously
import 'package:awad_nahas/core/strings/enum/location_enum.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/shipping_list_drop_down.dart';
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
  final TextEditingController streetMoreDetailsTextEditingController = TextEditingController();
  final TextEditingController postCodeNumberTextEditingController = TextEditingController();
  late LocationsBloc locationsBloc;
  LocationMapEntity? locationMapEntity;
  LocationEnum locationEnum = LocationEnum.Billing;
  String locationType = "";

  @override
  void didChangeDependencies() {
    locationsBloc = LocationsBloc.get(context);
    if(widget.type=="billing"){
      locationEnum = LocationEnum.Billing;
    }else if(widget.type=="shipping"){
      locationEnum = LocationEnum.Shipping;
    }else if(widget.type == "local"){
      locationEnum = LocationEnum.LOCAL;
    }else{
      locationEnum = LocationEnum.OTHER;
    }
    if(widget.locationEntity!=null){
      locationsBloc.add(UpdateShippingCityEvent(city: widget.locationEntity!.address1.toString().trim()));
      locationType = widget.locationEntity!.locationType.toString();
      locationMapEntity = LocationMapEntity(
          lat: widget.locationEntity!.lat, long: widget.locationEntity!.long,
          address: widget.locationEntity!.address2, city: widget.locationEntity!.address1,
          country: widget.locationEntity!.country,postalCode: widget.locationEntity!.postCode.toString(),street: widget.locationEntity!.state.toString());
      nameTextEditingController.text = Util.getName();
      phoneTextEditingController.text = widget.locationEntity!.phone;
      streetTextEditingController.text =  widget.locationEntity!.address2;
      _updateStreet();
      cityTextEditingController.text =  widget.locationEntity!.address1;
      postCodeNumberTextEditingController.text = locationMapEntity!.postalCode;
      locationsBloc.add(UpdateCurrentLocationEvent(location: widget.locationEntity!));
    }else{
      _goToMap();
    }
    super.didChangeDependencies();
  }

  _goToMap()async{
    await Permission.location.request();
    final res = await Util.pushPage(MapScreen(isSet: true, title: translate("map.select_on_map")), context);
    if(res!=null){
      setState(() {
        locationMapEntity = res;
      });
      cityTextEditingController.text = locationMapEntity!.city;
      streetTextEditingController.text = locationMapEntity!.street;
      // postCodeNumberTextEditingController.text = locationMapEntity!.postalCode;
    }
  }

  _updateStreet(){
    if(streetTextEditingController.text.toString().contains(",,")){
      streetMoreDetailsTextEditingController.text = streetTextEditingController.text.split(",,").last.toString().trim();
      streetTextEditingController.text = streetTextEditingController.text.split(",,").first.toString().trim();
    }
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
          return state is AddLocationSuccessfullyState || state is LocationsFailedState;
        },
        listener:  (ctx, state){
          if(state is AddLocationSuccessfullyState){
            SnackBarBuilder.showFeedBackMessage(context, translate("toast.update_user_data"), Colors.green);
            Navigator.pop(context);
          }
          if(state is LocationsFailedState)SnackBarBuilder.showFeedBackMessage(context, translate("toast.oops"), Colors.red);
          _updateStreet();
        },
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  fontSize: AppStyle.small.sp,
                  color: DMUtil.getD2C().withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                  text: translate("map.location_details"),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(locationMapEntity!=null)...[
                      const SizedBox(height: 4,),
                      SizedBox(
                        width: 220.w,
                        child: CustomText(
                          text: locationMapEntity!.address,
                          color: DMUtil.getD2C().withOpacity(0.9),
                          fontSize: AppStyle.average.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 2,
                          isEllipsis: true,
                        ),
                      )
                    ],

                    SizedBox(
                      height: 70.h,
                      width: 74.w,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          const GoogleMap(
                            initialCameraPosition: CameraPosition(target: LatLng(21.4504394, 38.8815082), zoom: 15),
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
                            child: CustomButton(
                              height: 22.h,
                              width: 61.w,
                              sideWidth: 0.6,
                              sideColor: DMUtil.getRED(),
                              circular: 10,
                              widget: CustomText(
                                text: locationMapEntity==null?translate("map.select_on_map"):translate("button.edit"),
                                color: DMUtil.getRED(),
                                fontSize: AppStyle.small.sp-1,
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
                                  streetTextEditingController.text = locationMapEntity!.address;
                                  // postCodeNumberTextEditingController.text = locationMapEntity!.postalCode;
                                  String city =  locationMapEntity!.city.toString().trim().toLowerCase();
                                  int cityIndex = locationsBloc.shippingListAr.indexWhere((element) => element.trim().toLowerCase()==city);
                                  if(cityIndex==-1){
                                    cityIndex = locationsBloc.shippingListEn.indexWhere((element) => element.trim().toLowerCase()==city);
                                  }
                                  if(cityIndex!=-1){
                                    if(Util.getLang()=="ar"){
                                      locationsBloc.add(UpdateShippingCityEvent(city: locationsBloc.shippingListAr[cityIndex].toString().trim()));
                                    }else{
                                      locationsBloc.add(UpdateShippingCityEvent(city: locationsBloc.shippingListEn[cityIndex].toString().trim()));
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: DMUtil.getD2C().withOpacity(0.6),),
                const SizedBox(height: 10,),
                CustomText(
                  text: translate("map.personal"),
                  color: DMUtil.getD2C().withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                  fontSize: AppStyle.small.sp,
                ),
                // const Divider(color: kSecondPrimary,),
                const SizedBox(height: 20,),
                const ShippingListWidget(),
                const SizedBox(height: 20,),
                CustomTextFromField(
                    height: 64,
                    hintText: "",
                    labelText: translate("profile.address"),
                    onChanged: (val){},
                    maxLines: 3,
                    hasBorder: true,
                    cursorColor: kPrimary,
                    radius: 4,
                    textEditingController: streetTextEditingController,
                    validator: (){},
                    obscureText: false,
                    isLabelError: false),
                const SizedBox(height: 10,),
                CustomTextFromField(
                    height: 50,
                    hintText: "${translate("map.street_name")},${translate("map.area")},${translate("map.flat_number")}...",
                    labelText:"",
                    onChanged: (val){},
                    maxLines: 3,
                    hasBorder: true,
                    cursorColor: kPrimary,
                    radius: 4,
                    textEditingController: streetMoreDetailsTextEditingController,
                    validator: (){},
                    obscureText: false,
                    isLabelError: false),
                const SizedBox(height: 15,),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextFromField(
                          textAlign: Util.getLang()=="ar"?TextAlign.left:TextAlign.right,
                          height: 50,
                          hintText: "502441695",
                          labelText: translate("profile.mobile"),
                          onChanged: (val){},
                          cursorColor: kPrimary,
                          textInputType: TextInputType.number,
                          hasBorder: true,
                          radius: 1,
                          textEditingController: phoneTextEditingController,
                          validator: (){},
                          obscureText: false,
                          isLabelError: false
                      ),
                    ),
                    Container(
                      height: 50.h,
                      // decoration: BoxDecoration(
                      //     border: Border.all(width: 0,color: DMUtil.getD2C())
                      // ),
                      alignment: Alignment.center,
                      child: CustomText(
                        text: " 966+ ",
                        fontSize: AppStyle.small.sp,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15,),
                CustomTextFromField(
                    hintText: "",
                    labelText: translate("map.national_address"),
                    onChanged: (val){},
                    cursorColor: kPrimary,
                    textInputType: TextInputType.text,
                    hasBorder: true,
                    radius: 4,
                    textEditingController: postCodeNumberTextEditingController,
                    validator: (){},
                    obscureText: false,
                    isLabelError: false),

                const SizedBox(height: 15,),
                Row(
                  children: [
                    InkWell(
                      onTap: ()=> setState(() {
                        locationType = "home";
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(width: 0),
                            color: locationType=="home"?DMUtil.getRED():DMUtil.getWC()
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home_outlined,color: locationType=="home"? DMUtil.getWC(): DMUtil.getD2C().withOpacity(0.7),size: AppStyle.average.w+1,),
                            const SizedBox(width: 5,),
                            CustomText(
                              text: translate("map.home"),
                              fontWeight: FontWeight.w600,
                              color: locationType=="home"? DMUtil.getWC(): DMUtil.getD2C().withOpacity(0.8),
                              fontSize: AppStyle.small.sp,
                            ),
                          ],
                        ),
                      )
                    ),
                    const SizedBox(width: 12,),
                    InkWell(
                        onTap: ()=> setState(() {
                          locationType = "work";
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(width: 0),
                            color: locationType=="work"?DMUtil.getRED():DMUtil.getWC()
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.work,color:locationType=="work"? DMUtil.getWC(): DMUtil.getD2C().withOpacity(0.7),size: AppStyle.average.w+1,),
                              const SizedBox(width: 5,),
                              CustomText(
                                text: translate("map.work"),
                                fontWeight: FontWeight.w600,
                                color: locationType=="work"? DMUtil.getWC(): DMUtil.getD2C().withOpacity(0.8),
                                fontSize: AppStyle.small.sp,
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),

                const SizedBox(height: 22,),
                BlocBuilder<LocationsBloc,LocationsState>(
                  builder: (ctx, state){
                    var bloc = LocationsBloc.get(ctx);
                    bool isLoading = state is LocationsLoadingState;
                    return CustomButton(
                      height: 42.h,
                      width: double.infinity,
                      circular: 10,
                      widget: isLoading?const CircularProgressIndicator(color: Colors.white,):
                      CustomText(
                        color: Colors.white,
                        fontSize: AppStyle.average.sp,
                        fontWeight: FontWeight.w600,
                        text: translate("map.save_location"),
                      ),
                      color: DMUtil.getRED(),
                      onPressed: () async {
                        var type = locationEnum == LocationEnum.Shipping? "shipping":"billing";
                        if(locationEnum == LocationEnum.LOCAL) type = "local";
                        var phone = phoneTextEditingController.text.trim();
                        //flatNumberTextEditingController.text.trim().isNotEmpty&&buildingNumberTextEditingController.text.trim().isNotEmpty&&phone.isNotEmpty &&
                        //cityTextEditingController.text.trim().isNotEmpty &&
                        if(bloc.currentShippingCity!=""&&streetTextEditingController.text.trim().isNotEmpty &&
                            postCodeNumberTextEditingController.text.trim().isNotEmpty){

                          streetTextEditingController.text = "${streetTextEditingController.text},,${streetMoreDetailsTextEditingController.text.trim()}";

                          if(Util.validatePhoneInput("+966$phone", context)==false) return;

                          var data = {
                            "${type}_phone": phone,
                            "${type}_email": Util.getEmail(),
                            "${type}_country": locationMapEntity!.country,
                            "${type}_postcode": postCodeNumberTextEditingController.text.trim(),
                            "${type}_state": locationMapEntity!.street,
                            "${type}_address_2": streetTextEditingController.text.trim(),
                            "${type}_address_1": bloc.currentShippingCity.trim(),
                            "${type}_last_name": ".",
                            "${type}_first_name": Util.getName(),
                            "location_type" : locationType.toString(),
                            "type":type,
                          };
                          if(widget.locationEntity!=null){
                            if(widget.type == "local"){
                              data['id'] = widget.locationEntity!.id.toString();
                              locationsBloc.add(AddLocalLocationEvent(data: data,isUpdate: true));
                            }else{
                              locationsBloc.add(UpdateLocationEvent(data: {
                                type: data
                              }));
                            }
                          }else{

                            if(locationMapEntity==null)return SnackBarBuilder.showFeedBackMessage(context, translate("toast.select_location"), Colors.red);
                            if(widget.type == "local"){
                              locationsBloc.add(AddLocalLocationEvent(data: data));
                            }else{
                              locationsBloc.add(AddLocationEvent(data: {
                                type: data
                              }));
                            }
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


// final TextEditingController areaTextEditingController = TextEditingController();
// final TextEditingController flatNumberTextEditingController = TextEditingController();
// final TextEditingController buildingNumberTextEditingController = TextEditingController();

// CustomTextFromField(
//     hintText: "",
//     labelText: translate("map.town"),
//     onChanged: (val){},
//     maxLines: 1,
//     hasBorder: true,
//     cursorColor: kPrimary,
//     radius: 4,
//     textEditingController: cityTextEditingController,
//     validator: (){},
//     obscureText: false,
//     isLabelError: false),

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     SizedBox(
//       width: 100.w,
//       child: CustomTextFromField(
//           hintText: "",
//           labelText: translate("map.block_number"),
//           onChanged: (val){},
//           maxLines: 1,
//           hasBorder: true,
//           cursorColor: kPrimary,
//           radius: 4,
//           textEditingController: areaTextEditingController,
//           validator: (){},
//           obscureText: false,
//           isLabelError: false),
//     ),
//     SizedBox(
//       width: 100.w,
//       child: CustomTextFromField(
//           hintText: "",
//           labelText: translate("map.flat_number"),
//           onChanged: (val){},
//           maxLines: 1,
//           hasBorder: true,
//           cursorColor: kPrimary,
//           radius: 4,
//           textEditingController: flatNumberTextEditingController,
//           validator: (){},
//           obscureText: false,
//           isLabelError: false),
//     ),
//     SizedBox(
//       width: 100.w,
//       child: CustomTextFromField(
//           hintText: "",
//           labelText: translate("map.building_name"),
//           onChanged: (val){},
//           maxLines: 1,
//           hasBorder: true,
//           cursorColor: kPrimary,
//           radius: 4,
//           textEditingController: buildingNumberTextEditingController,
//           validator: (){},
//           obscureText: false,
//           isLabelError: false),
//     ),
//   ],
// ),
// const SizedBox(height: 15,),