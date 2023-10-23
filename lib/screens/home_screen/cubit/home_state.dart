part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.invoiceNumber = '',
    this.contractorsName = '',
    this.netAmount = '',
    this.grossAmount = '',
    this.vatRate = '0%',
    this.attachment,
  });

  final String invoiceNumber;
  final String contractorsName;
  final String netAmount;
  final String grossAmount;
  final String vatRate;
  final File? attachment;

  HomeState copyWith({
    String? invoiceNumber,
    String? contractorsName,
    String? netAmount,
    String? grossAmount,
    String? vatRate,
    File? attachment,
  }) {
    return HomeState(
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      contractorsName: contractorsName ?? this.contractorsName,
      netAmount: netAmount ?? this.netAmount,
      grossAmount: grossAmount ?? this.grossAmount,
      vatRate: vatRate ?? this.vatRate,
      attachment: attachment ?? this.attachment,
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
      ];
}
