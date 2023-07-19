
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ReviewsWidget extends StatelessWidget {
  final int amount;
  final Color color;
  const ReviewsWidget({Key? key,required this.amount,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(amount <= 10){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Icon(Icons.star,size: 12.w,color: color,),
        ],
      );
    }else if (amount <= 50 && amount >10){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
        ],
      );
    }else if (amount <= 100 && amount > 50){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
        ],
      );
    }else if (amount <= 150 && amount >100){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
        ],
      );
    }else if (amount <= 200 && amount >150){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
          Icon(Icons.star,size: 12.w,color: color,),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

// alertSetRate(BuildContext context){
//   Widget cancelButton = FlatButton(
//     child: Text(translate("button.cancel")),
//     onPressed: () async {
//       Navigator.of(context, rootNavigator: true).pop();
//     },
//   );
//   Widget okButton = new Align(
//     alignment: Alignment.center,
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//       child: FlatButton(
//         color: color,
//         child: Text(
//           translate("button.ok"),
//           style: TextStyle(
//               color: colorawad_nahas,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2.0),
//         ),
//         onPressed: ()  {
//
//         },
//       ),
//     ),
//   );
//   AlertDialog alert=AlertDialog(
//     title: Text(translate("app_bar.your_review")),
//     content:SizedBox(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           RatingBar.builder(
//             initialRating: 3,
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: true,
//             itemCount: 5,
//             itemBuilder: (context, _) => Icon(
//               Icons.star,
//               color: color,
//             ),
//             onRatingUpdate: (rating) {
//               print(rating);
//             },
//           ),
//         ],
//       ),
//     ),
//     actions: [
//       okButton,
//       cancelButton,
//     ],
//   );
//   showDialog(
//     barrierDismissible: false,
//     context:context,
//     builder:(BuildContext context){
//       return alert;
//     },
//   );
//
// }
