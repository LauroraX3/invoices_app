import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:invoices_app/models/invoice.dart';

part 'invoices_list_state.dart';

class InvoicesListCubit extends Cubit<InvoicesListState> {
  InvoicesListCubit() : super(InvoicesListState());

  List<Invoice> _invoices = [];

  Future<void> init() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('invoices');

    final snapshot = await ref.get();
    if (snapshot.exists) {
      final map = snapshot.value as Map<Object?, Object?>;
      final invoicesMap = map.values.cast<Map<Object?, Object?>>().toList();
      final jsonList =
          invoicesMap.map((e) => e.cast<String, dynamic>()).toList();

      _invoices = Invoice.fromJsonList(jsonList);
      emit(state.copyWith(invoices: Invoice.fromJsonList(jsonList)));
    } else {
      print('No data available.');
    }
  }

  void onChangeSearchInvoices(String inputValue) {
    if (inputValue.isEmpty) {
      emit(state.copyWith(invoices: _invoices));
    } else {
      final invoices = state.invoices;
      final searchedInvoices = invoices
          .where((invoice) => invoice.invoiceNumber.contains(inputValue))
          .toList();
      emit(state.copyWith(invoices: searchedInvoices));
    }
  }

  void onResetSearchInvoices() {
    emit(state.copyWith(invoices: _invoices));
  }
}
