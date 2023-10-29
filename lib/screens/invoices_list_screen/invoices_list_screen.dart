import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices_app/app.dart';
import 'package:invoices_app/models/invoice.dart';
import 'package:invoices_app/screens/invoice_details_screen/invoice_details_screen.dart';
import 'package:invoices_app/screens/invoices_list_screen/cubit/invoices_list_cubit.dart';
import 'package:invoices_app/style/app_color.dart';
import 'package:invoices_app/widgets/custom_app_bar.dart';
import 'package:invoices_app/widgets/custom_form_field.dart';
import 'package:invoices_app/widgets/invoice_tile.dart';

class InvoicesListScreen extends StatelessWidget {
  const InvoicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: invoicesListNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            switch (settings.name) {
              case '/':
                return Scaffold(
                  appBar: CustomAppBar(title: 'Lista faktur'),
                  body: BlocProvider<InvoicesListCubit>(
                    create: (context) => InvoicesListCubit()..init(),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, bottom: 10, top: 15),
                      child: InvoicesListScreenContent(),
                    ),
                  ),
                  backgroundColor: AppColor.lightPink,
                );
              case '/details':
                return InvoiceDetailsScreen(
                    invoice: settings.arguments as Invoice);
              default:
                return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}

class InvoicesListScreenContent extends StatefulWidget {
  const InvoicesListScreenContent({super.key});

  @override
  State<InvoicesListScreenContent> createState() =>
      _InvoicesListScreenContentState();
}

class _InvoicesListScreenContentState extends State<InvoicesListScreenContent> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormField(
          controller: controller,
          onChanged: (value) =>
              context.read<InvoicesListCubit>().onChangeSearchInvoices(value),
          labelText: "Szukaj",
          sufixIcon: IconButton(
            icon: Icon(
              Icons.cancel_outlined,
            ),
            onPressed: () {
              context.read<InvoicesListCubit>().onResetSearchInvoices();
              controller.text = '';
            },
            padding: EdgeInsets.only(right: 15),
          ),
        ),
        Expanded(
          child: BlocBuilder<InvoicesListCubit, InvoicesListState>(
            builder: (_, state) {
              return ListView.builder(
                itemCount: state.invoices.length,
                itemBuilder: (_, index) {
                  final invoice = state.invoices[index];
                  return InvoiceTile(invoice: invoice);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
