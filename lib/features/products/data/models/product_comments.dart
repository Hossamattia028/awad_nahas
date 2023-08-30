import 'dart:convert';

class ProductComments {
  final int productID;
  final String commentContent;
  final String commentType;
  final String date;
  final int userID;
  final String userName;

  ProductComments({required this.productID,required this.commentContent,required this.commentType,required this.userID,required this.date,required this.userName});
  static List<ProductComments> listModelFromJson(String str) =>
      List<ProductComments>.from(
          json.decode(str).map((x) => ProductComments.fromJson(x)));


  static ProductComments fromJson(Map<String, dynamic> jsonObject) {
    return ProductComments(
      productID: int.parse(jsonObject['comment_post_ID'] ?? "0"),
      commentContent: jsonObject['comment']??"",
      commentType: jsonObject['comment_agent']??"",
      date: jsonObject['date']??DateTime.now(),
      userID: jsonObject['user_id']??0,
      userName: jsonObject['author']??"",
    );
  }

}