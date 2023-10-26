part of 'invoices_list_cubit.dart';

class InvoicesListState extends Equatable {
  const InvoicesListState({this.invoices = const []});

  final List<Invoice> invoices;

  InvoicesListState copyWith({List<Invoice>? invoices}) {
    return InvoicesListState(invoices: invoices ?? this.invoices);
  }

  @override
  List<Object> get props => [invoices];
}
