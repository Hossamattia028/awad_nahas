// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/send_email.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
  final TextEditingController firstNameTextEditingController = TextEditingController();
  final TextEditingController lastNameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController subjectTextEditingController = TextEditingController();
  final TextEditingController contentTextEditingController = TextEditingController();

  bool loading  = false;
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
        leadingIcon:  const BackArrowButton(),
        icon: null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 154.w,
                  child: CustomTextFromField(
                    hintText: translate("signup.first_name"),
                    labelText: translate("signup.first_name"),
                    hasBorder: true,
                    smallPadding: true,
                    radius: 10,
                    textEditingController: firstNameTextEditingController,
                    validator: () {},
                    obscureText: false,
                    isLabelError: false,
                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  width: 154.w,
                  child: CustomTextFromField(
                    hintText: translate("signup.last_name"),
                    labelText: translate("signup.last_name"),
                    hasBorder: true,
                    smallPadding: true,
                    radius: 10,
                    textEditingController: lastNameTextEditingController,
                    validator: () {},
                    obscureText: false,
                    isLabelError: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50.h,
              child: CustomTextFromField(
                  hintText: translate("login.email"),
                  labelText: translate("login.email"),
                  radius: 10,
                  textEditingController: emailTextEditingController,
                  textInputType: TextInputType.emailAddress,
                  validator: () {},
                  prefixIcon: null,
                  hasBorder: true,
                  suffixIcon: const SizedBox(),
                  obscureText: false,
                  isLabelError: false),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                CustomText(text: "+966", fontSize: AppStyle.small.sp,),
                const SizedBox(width: 5,),
                Expanded(
                  // width: 280.w,
                  child: CustomTextFromField(
                    hintText: "502441695",
                    labelText: translate("signup.phone"),
                    hasBorder: true,
                    smallPadding: true,
                    textInputType: TextInputType.phone,
                    cursorColor: DMUtil.getRED(),
                    radius: 10,
                    textEditingController: phoneTextEditingController,
                    validator: () {},
                    obscureText: false,
                    isLabelError: false,
                    borderColor: DMUtil.getDC(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1,color: DMUtil.getOpacity()),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child:  DropdownButton(
                isExpanded: true,
                style: TextStyle(color: DMUtil.getD2C(), fontSize: 12.sp,),
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
            const SizedBox(height: 20,),
            CustomTextFromField(
                hintText: translate("activity_setting.message_title"),
                labelText: translate("activity_setting.message_title"),
                radius: 10,
                textEditingController: subjectTextEditingController,
                validator: () {},
                prefixIcon: null,
                hasBorder: true,
                suffixIcon: const SizedBox(),
                obscureText: false,
                isLabelError: false),
            const SizedBox(height: 20,),
            SizedBox(
              height: 100.h,
              child: CustomTextFromField(
                  hintText: translate("activity_setting.content"),
                  labelText: translate("activity_setting.content"),
                  radius: 10,
                  maxLines: 5,
                  textEditingController: contentTextEditingController,
                  validator: () {},
                  prefixIcon: null,
                  hasBorder: true,
                  suffixIcon: const SizedBox(),
                  obscureText: false,
                  isLabelError: false),
            ),

            const SizedBox(height: 30,),
            MaterialButton(
              onPressed: ()async{
                setState(() {
                  loading = true;
                });
                if(emailTextEditingController.text.trim().isNotEmpty&&
                    firstNameTextEditingController.text.trim().isNotEmpty&&
                    lastNameTextEditingController.text.trim().isNotEmpty&&
                    subjectTextEditingController.text.trim().isNotEmpty&&
                    contentTextEditingController.text.trim().isNotEmpty&&
                    phoneTextEditingController.text.trim().isNotEmpty
                ){
                  String phone = "+966${phoneTextEditingController.text.trim()}";
                  if(validatePhoneInput(phone, context) == false){
                    setState(() {
                      loading = false;
                    });
                    return;
                  }
                  if(!emailTextEditingController.text.trim().contains("@")){
                    setState(() {
                      loading = false;
                    });
                    SnackBarBuilder.showFeedBackMessage(context, translate("toast.email_invalid"), DMUtil.getRED());
                    return;
                  }
                  final res = await SendGmail.sendContactUs(
                      subjectTextEditingController.text.trim(),
                      contentTextEditingController.text.trim(),
                      firstNameTextEditingController.text.trim(),
                      lastNameTextEditingController.text.trim(),
                      phone,
                      emailTextEditingController.text.trim(), subject);
                  setState(() {
                    loading = false;
                  });
                  if(res){
                    var title = "${subject.toString()} \n ${subjectTextEditingController.text.trim()}";
                    Map<String,dynamic> data= {
                      "name":" ${firstNameTextEditingController.text.trim()}  ${lastNameTextEditingController.text.trim()}",
                      "email":emailTextEditingController.text.trim(),
                      "phone":phone,
                      "department":subject,
                      "subject":subjectTextEditingController.text.trim(),
                      "message":contentTextEditingController.text.trim()
                    };
                    SendGmail.sendEmailMessage(bodyMsg: _generateForm(data),userMsg: translate("toast.contact"),userEmail: emailTextEditingController.text.trim(), subject: title.toString());
                    emailTextEditingController.text = "";
                    firstNameTextEditingController.text = "";
                    lastNameTextEditingController.text = "";
                    contentTextEditingController.text = "";
                    subjectTextEditingController.text = "";
                    phoneTextEditingController.text = "";
                    SnackBarBuilder.showFeedBackMessage(context, translate("toast.gmail_send"), DMUtil.getGreen());
                  }else{
                    SnackBarBuilder.showFeedBackMessage(context, translate("toast.oops"), Colors.red);
                  }
                }else{
                  setState(() {
                    loading = false;
                  });
                  SnackBarBuilder.showFeedBackMessage(context, translate("toast.field_empty"), Colors.red);
                }
              },
              height: 32.w,
              minWidth: double.infinity,
              color: DMUtil.getRED(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: loading? const CircularProgressIndicator(color: Colors.white,) : CustomText(
                text: translate("button.send").toUpperCase(),
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.w,
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

  bool validatePhoneInput(String phone,BuildContext context){
    if(phone.isNotEmpty){
      String? txt = Util.validatePhone(phone);
      if(txt!=null){
        SnackBarBuilder.showFeedBackMessage(context, txt, DMUtil.getRED());
        return false;
      }
    }
    return true;
  }

  List<DropdownMenuItem<String>> dropDownMenu = [];
  String subject = translate("activity_setting.inquire_and_complaint");
  List<DropdownMenuItem<String>> getDropDownMenu() {
    List<DropdownMenuItem<String>> itemsMarketKind = [];
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.inquire_and_complaint"),
      child: CustomText(
        text: translate("activity_setting.inquire_and_complaint"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.service_request"),
      child: CustomText(
        text: translate("activity_setting.service_request"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.sales"),
      child: CustomText(
        text: translate("activity_setting.sales"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.become_a_partner"),
      child: CustomText(
        text: translate("activity_setting.become_a_partner"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    itemsMarketKind.add(DropdownMenuItem(
      value: translate("activity_setting.project_s"),
      child: CustomText(
        text: translate("activity_setting.project_s"),
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ));
    return itemsMarketKind;
  }

  _generateForm(Map<String,dynamic> data){
    return ''' 
      <html lang="en">
        <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact Form</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
          }
          .container {
            width: 50%;
            margin: 40px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
          }
       
          label {
            font-weight: bold;
            font-size: 18px;
            display: block;
            margin-bottom: 8px;
          }
        
          textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            height: 150px;
          }
          input[type="text"]:disabled, input[type="email"]:disabled, textarea:disabled {
            background-color: #f4f4f4;
            color: #555;
          }
          input{
            width: 60%;
            height: 10%;
            font-size:15px;
            margin-bottom:20px;
          }
        </style>
        </head>
        <body>
        
        <div class="container">
          <form>
            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="${data['name']}" disabled >
            <br/>
            <label for="email">Email</label>
            <input type="email" id="email" name="email"  value="${data['email']}" disabled >
         <br/>
            <label for="phone">Phone/Mobile</label>
            <input type="text" id="phone" name="phone" value="${data['phone']}" disabled >
         <br/>
            <label for="department">Department</label>
            <input type="text" id="department" name="department" value="${data['department']}" disabled >
         <br/>
            <label for="subject">Subject</label>
            <input type="text" id="subject" name="subject" value="${data['subject']}" disabled >
         <br/>
            <label for="message">Message</label>
            <textarea id="message" name="message" disabled>${data['message']}.</textarea>
          </form>
        </div>
        
        <h2 style="text-align: center;">©Awad Badi Nahas Trading Co. Ltd.</h2>
        
        </body>
        </html>
    ''';
  }
}

