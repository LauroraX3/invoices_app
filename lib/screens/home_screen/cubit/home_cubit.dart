import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:invoices_app/models/invoice.dart';
import 'package:invoices_app/utils/value_wrapper.dart';
import 'package:path/path.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void onChangeInvoiceNumber(String invoiceNumber) {
    emit(state.copyWith(invoiceNumber: invoiceNumber));
  }

  void onChangeContractorsName(String contractorsName) {
    emit(state.copyWith(contractorsName: contractorsName));
  }

  void onChangeNetAmount(String netAmountText) {
    final netAmount = double.tryParse(netAmountText) ?? 0;
    if (state.vatRate != 0 && netAmount.isNaN) {
      var grossAmount = netAmount + state.vatRate / 100 * netAmount;
      emit(state.copyWith(netAmount: netAmount, grossAmount: grossAmount));
    } else {
      emit(state.copyWith(netAmount: netAmount, grossAmount: netAmount));
    }
  }

  void onChangeGrossAmount(String grossAmountText) {
    final grossAmount = double.tryParse(grossAmountText) ?? 0;
    emit(state.copyWith(grossAmount: grossAmount));
  }

  void onChangeVatRate(String vatRateText) {
    var vatRate =
        int.tryParse(vatRateText.substring(0, vatRateText.length - 1)) ?? 0;
    var grossAmount = (state.netAmount) + vatRate / 100 * state.netAmount;
    emit(state.copyWith(vatRate: vatRate, grossAmount: grossAmount));
  }

  void onChangeAttachment(File attachment) {
    emit(state.copyWith(attachment: ValueWrapped.value(attachment)));
  }

  Future<void> saveData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('invoices');

    Invoice invoice = Invoice(
      invoiceNumber: state.invoiceNumber,
      contractorsName: state.contractorsName,
      netAmount: state.netAmount,
      vatRate: state.vatRate,
      grossAmount: state.grossAmount,
    );

    if (state.attachment != null) {
      final bytes = state.attachment!.readAsBytesSync();
      final attachment = base64Encode(bytes);
      final attachmentName = basename(state.attachment!.path);
      final attachmentExt =
          attachmentName.substring(attachmentName.indexOf('.'));

      invoice = invoice.copyWith(
        attachment: attachment,
        attachmentName: attachmentName,
        attachmentExt: attachmentExt,
      );
    }

    final pushedRef = ref.push();
    await pushedRef.set(invoice.copyWith(id: pushedRef.key).toJson());
    emit(
      state.copyWith(
        invoiceNumber: '',
        contractorsName: '',
        netAmount: 0.00,
        grossAmount: 0.00,
        vatRate: 0,
        attachment: const ValueWrapped.value(null),
        isDataSent: const ValueWrapped.value(true),
      ),
    );
    emit(state.copyWith(isDataSent: const ValueWrapped.value(null)));
  }
}
