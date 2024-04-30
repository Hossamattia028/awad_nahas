import 'package:equatable/equatable.dart';

class DealsEntity extends Equatable{
  final String? title;
  final List<String>? buyXGetYFree;
  final List<String>? mainProducts;
  final bool? isArabic;

  const DealsEntity({this.title, this.buyXGetYFree, this.mainProducts, this.isArabic});
  
  @override
  List<Object?> get props => [title];
}
