import 'dart:ffi';

import 'package:equatable/equatable.dart';

class Invoice extends Equatable {
  const Invoice({
    this.id = '',
    required this.invoiceNumber,
    required this.contractorsName,
    required this.netAmount,
    required this.vatRate,
    required this.grossAmount,
    this.attachment,
    this.attachmentName,
    this.attachmentExt,
  });

  final String id;
  final String invoiceNumber;
  final String contractorsName;
  final double netAmount;
  final int vatRate;
  final double grossAmount;
  final String? attachment;
  final String? attachmentName;
  final String? attachmentExt;

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      contractorsName: json['contractorsName'] as String,
      netAmount: double.parse(json['netAmount'].toString()),
      vatRate: json['vatRate'] as int,
      grossAmount: double.parse(json['grossAmount'].toString()),
      attachment: json['attachment'] as String?,
      attachmentName: json['attachmentName'] as String?,
      attachmentExt: json['attachmentExt'] as String?,
    );
  }

  static List<Invoice> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => Invoice.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoiceNumber': invoiceNumber,
        'contractorsName': contractorsName,
        'netAmount': netAmount,
        'vatRate': vatRate,
        'grossAmount': double.parse(grossAmount.toStringAsFixed(2)),
        'attachment': attachment,
        'attachmentName': attachmentName,
        'attachmentExt': attachmentExt,
      };

  Invoice copyWith({
    String? id,
    String? invoiceNumber,
    String? contractorsName,
    double? netAmount,
    int? vatRate,
    double? grossAmount,
    String? attachment,
    String? attachmentName,
    String? attachmentExt,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      contractorsName: contractorsName ?? this.contractorsName,
      netAmount: netAmount ?? this.netAmount,
      grossAmount: grossAmount ?? this.grossAmount,
      vatRate: vatRate ?? this.vatRate,
      attachment: attachment ?? this.attachment,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentExt: attachmentExt ?? this.attachmentExt,
    );
  }

  bool get isAttachmentExists =>
      attachment != null && attachmentName != null && attachmentExt != null;

  @override
  List<Object?> get props => [
        id,
        invoiceNumber,
        contractorsName,
        netAmount,
        vatRate,
        grossAmount,
        attachment,
        attachmentName,
        attachmentExt,
      ];
}
