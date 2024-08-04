import 'package:bloc/bloc.dart';
import 'package:money_flow/bloc/user_event.dart';
import 'package:money_flow/bloc/user_state.dart';
import 'package:money_flow/controller/user_controller.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiUser apiUser;
  final int userId;
  UserBloc(this.userId, {required this.apiUser}) : super(UsersInitial()){
    on<FetchData>((event, emit) async{
      emit(UserLoading());
      try {
        final result = await apiUser.getUserExpenses(userId);
        emit( UserLoaded(result));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    // on<CreateTransaction>((event, emit) async {
    //   emit(TransactionLoading());
    //   try {
    //     // Panggil API untuk membuat transaksi baru
    //     await createTransactionInApi(event.transaction);
    //     emit(TransactionSuccess("Transaction created successfully"));
    //     // Optionally, fetch transactions again to update the list
    //     final transactions = await fetchTransactionsFromApi();
    //     emit(TransactionLoaded(transactions));
    //   } catch (e) {
    //     emit(TransactionFailure(e.toString()));
    //   }
    // });

    // on<UpdateTransaction>((event, emit) async {
    //   emit(TransactionLoading());
    //   try {
    //     // Panggil API untuk memperbarui transaksi
    //     await updateTransactionInApi(event.transaction);
    //     emit(TransactionSuccess("Transaction updated successfully"));
    //     // Optionally, fetch transactions again to update the list
    //     final transactions = await fetchTransactionsFromApi();
    //     emit(TransactionLoaded(transactions));
    //   } catch (e) {
    //     emit(TransactionFailure(e.toString()));
    //   }
    // });

    // on<DeleteTransaction>((event, emit) async {
    //   emit(TransactionLoading());
    //   try {
    //     // Panggil API untuk menghapus transaksi
    //     await deleteTransactionInApi(event.transaction);
    //     emit(TransactionSuccess("Transaction deleted successfully"));
    //     // Optionally, fetch transactions again to update the list
    //     final transactions = await fetchTransactionsFromApi();
    //     emit(TransactionLoaded(transactions));
    //   } catch (e) {
    //     emit(TransactionFailure(e.toString()));
    //   }
    // });
  }
}