import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';




class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  static final TextEditingController nameTextEditingController = TextEditingController();
  static final TextEditingController emailTextEditingController = TextEditingController();
  static final TextEditingController contentTextEditingController = TextEditingController();

  @override
  void initState() {
    dropDownMenu = getDropDownMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(
        title: translate("activity_setting.contact_us"),
        leadingIcon: GlobalWidgets.backArrowButton(()=> Navigator.of(context).pop(),Colors.white,Alignment.center),
        icon: null,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.phone,color: Colors.black38,size: 20,),
                const SizedBox(width: 5,),
                CustomText(
                  text: "00000000",
                  fontSize: 12.sp,
                  color: kPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10,),
            Container(
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1,color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child:  DropdownButton(
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 12.sp,),
                hint: CustomText(
                  text: translate("activity_setting.select_subject"),
                  fontSize: 12.sp,
                  color: Colors.black,
                ),
                onChanged:(val){
                  setState(() {
                    subject = val.toString();
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down),
                items:  dropDownMenu,
                value: subject,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50.h,
              child: CustomTextFromField(
                  hintText: translate("signup.username"),
                  labelText: translate("signup.username"),
                  radius: 10,
                  textEditingController: nameTextEditingController,
                  validator: () {},
                  prefixIcon: null,
                  cursorColor: kPrimary,
                  hasBorder: true,
                  suffixIcon: const SizedBox(),
                  obscureText: false,
                  isLabelError: false),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50.h,
              child: CustomTextFromField(
                  hintText: translate("login.email"),
                  labelText: translate("login.email"),
                  radius: 10,
                  textEditingController: emailTextEditingController,
                  validator: () {},
                  prefixIcon: null,
                  cursorColor: kPrimary,
                  hasBorder: true,
                  suffixIcon: const SizedBox(),
                  obscureText: false,
                  isLabelError: false),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50.h,
              child: CustomTextFromField(
                  hintText: translate("activity_setting.content"),
                  labelText: translate("activity_setting.content"),
                  radius: 10,
                  textEditingController: contentTextEditingController,
                  validator: () {},
                  prefixIcon: null,
                  cursorColor: kPrimary,
                  hasBorder: true,
                  suffixIcon: const SizedBox(),
                  obscureText: false,
                  isLabelError: false),
            ),

            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: ()async{
                if(emailTextEditingController.text.isNotEmpty&&
                    nameTextEditingController.text.isNotEmpty&&
                    contentTextEditingController.text.isNotEmpty
                ){
                  await Util.sendMailMsg(
                    subject: subject,
                    msg: "${nameTextEditingController.text.trim()}\n ${contentTextEditingController.text.trim()}",
                  );
                }else{
                  SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                }
              },
              minWidth: double.infinity,
              color: kPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child:  InkWell(
                splashColor: kPrimary,
                hoverColor: kPrimary,
                focusColor: kPrimary,
                highlightColor: kPrimary,
                child: CustomText(
                  text: translate("button.send").toUpperCase(),
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.w,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> dropDownMenu = [];
  String subject = translate("activity_setting.feedback");
  List<DropdownMenuItem<String>> getDropDownMenu() {
    List<DropdownMenuItem<String>> itemsMarketKind = [];
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.feedback"),
      child: CustomText(
        text: translate("activity_setting.feedback"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.suggestion"),
      child: CustomText(
        text: translate("activity_setting.suggestion"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.Request_quotation"),
      child: CustomText(
        text: translate("activity_setting.Request_quotation"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.sell_with_us"),
      child: CustomText(
        text: translate("activity_setting.sell_with_us"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    return itemsMarketKind;
  }
}

