import 'package:awad_nahas/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/order/domain/entities/transaction.dart';
import 'package:awad_nahas/features/order/domain/repositories/wallet_repository.dart';

class GetAllTransactionsUseCase{
  final WalletRepository walletRepository;
  GetAllTransactionsUseCase({required this.walletRepository});

  Future<Either<Failure,List<TransactionEntity>>> call() async{
    return await walletRepository.getAllTransactions();
  }
}