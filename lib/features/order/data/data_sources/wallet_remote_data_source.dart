import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/order/data/models/transaction_model.dart';
import 'package:awad_nahas/features/order/domain/entities/transaction.dart';

abstract class WalletRemoteDataSourceImpl{
  Future<List<TransactionEntity>> getAllTransactions();
}

class WalletRemoteDataSource extends WalletRemoteDataSourceImpl{
  final http.Client client;
  WalletRemoteDataSource({required this.client});

  @override
  Future<List<TransactionEntity>> getAllTransactions() async{
    var response = await client.get(Uri.parse("${ApiUrl.UPDATE_USER_PROFILE}${Util.getUserID()}"),headers: ApiUrl.headerAuth);
    // debugPrint("getAllTransactions ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return TransactionModel.transactionListFromJson(jsonEncode(body['data']));
    } else {
      throw ServerException();
    }
  }



}