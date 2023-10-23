import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
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

  void onChangeNetAmount(String netAmount) {
    if (state.vatRate != '0%' && netAmount.isNotEmpty) {
      var vatNumber =
          int.parse(state.vatRate.substring(0, state.vatRate.length - 1));
      var grossAmount =
          double.parse(netAmount) + vatNumber / 100 * double.parse(netAmount);

      emit(state.copyWith(
          netAmount: netAmount, grossAmount: grossAmount.toString()));
    } else {
      emit(state.copyWith(netAmount: netAmount, grossAmount: netAmount));
    }
  }

  void onChangeGrossAmount(String grossAmount) {
    emit(state.copyWith(grossAmount: grossAmount));
  }

  void onChangeVatRate(String vatRate) {
    var vatNumber = int.parse(vatRate.substring(0, vatRate.length - 1));
    var grossAmount = double.parse(state.netAmount) +
        vatNumber / 100 * double.parse(state.netAmount);
    emit(state.copyWith(vatRate: vatRate, grossAmount: grossAmount.toString()));
  }

  void onChangeAttachment(File attachment) {
    emit(state.copyWith(attachment: attachment));
  }

  Future<void> saveData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('invoices');

    final invoice = {
      "invoice_number": state.invoiceNumber,
      "contractors_name": state.contractorsName,
      "net_amount": state.netAmount,
      "vat_rate": state.vatRate,
      "gross_amount": state.grossAmount,
    };

    if (state.attachment != null) {
      final bytes = state.attachment!.readAsBytesSync();
      final attachment = base64Encode(bytes);
      final attachmentName = basename(state.attachment!.path);
      final attachmentExt =
          attachmentName.substring(attachmentName.indexOf('.'));

      invoice.addAll({
        "attachment": attachment,
        "attachment_name": attachmentName,
        "attachment_ext": attachmentExt,
      });
    }

    await ref.set(invoice);

    print("state.invoiceNumber");
  }
}
