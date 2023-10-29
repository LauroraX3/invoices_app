part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.invoiceNumber = '',
    this.contractorsName = '',
    this.netAmount = 0.00,
    this.grossAmount = 0.00,
    this.vatRate = 0,
    this.attachment,
    this.isDataSent,
  });

  final String invoiceNumber;
  final String contractorsName;
  final double netAmount;
  final double grossAmount;
  final int vatRate;
  final File? attachment;
  final bool? isDataSent;

  HomeState copyWith({
    String? invoiceNumber,
    String? contractorsName,
    double? netAmount,
    double? grossAmount,
    int? vatRate,
    ValueWrapped<File?>? attachment,
    ValueWrapped<bool?>? isDataSent,
  }) {
    return HomeState(
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      contractorsName: contractorsName ?? this.contractorsName,
      netAmount: netAmount ?? this.netAmount,
      grossAmount: grossAmount ?? this.grossAmount,
      vatRate: vatRate ?? this.vatRate,
      attachment: attachment != null ? attachment.value : this.attachment,
      isDataSent: isDataSent != null ? isDataSent.value : this.isDataSent,
    );
  }

  @override
  List<Object?> get props => [
        invoiceNumber,
        contractorsName,
        netAmount,
        grossAmount,
        vatRate,
        attachment,
        isDataSent,
      ];
}
