import 'package:flutter/material.dart';
import 'package:invoices_app/models/invoice.dart';
import 'package:invoices_app/style/app_color.dart';

import '../screens/invoice_details_screen/invoice_details_screen.dart';

class InvoiceTile extends StatelessWidget {
  const InvoiceTile({
    super.key,
    required this.invoice,
  });

  final Invoice invoice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.lightPink,
          border: Border.all(
            color: AppColor.navy,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Faktura nr: ${invoice.invoiceNumber}',
              style: TextStyle(color: AppColor.navy, fontSize: 20),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kontrachent: ${invoice.contractorsName}',
                style: TextStyle(color: AppColor.navy, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Kwota brutto: ${invoice.grossAmount} PLN',
                style: TextStyle(color: AppColor.navy, fontSize: 16),
              ),
            ],
          ),
          visualDensity: VisualDensity.compact,
          dense: true,
          isThreeLine: true,
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            color: AppColor.blue,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/details', arguments: invoice);
          },
        ),
      ),
    );
  }
}
