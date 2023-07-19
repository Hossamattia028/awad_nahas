import 'package:awad_nahas/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/order/domain/entities/transaction.dart';

abstract class WalletRepository{
  Future<Either<Failure,List<TransactionEntity>>> getAllTransactions();
}