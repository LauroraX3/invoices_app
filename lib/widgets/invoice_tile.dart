import 'package:flutter/material.dart';
import 'package:invoices_app/style/app_color.dart';

class InvoiceTile extends StatelessWidget {
  const InvoiceTile(
      {super.key,
      required this.invoiceNumber,
      required this.contractorsName,
      required this.grossAmount});

  final String invoiceNumber;
  final String contractorsName;
  final String grossAmount;
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
                'Faktura nr: ${invoiceNumber}',
                style: TextStyle(color: AppColor.navy, fontSize: 20),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kontrachent: ${contractorsName}',
                  style: TextStyle(color: AppColor.navy, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Kwota brutto: ${grossAmount} PLN',
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
            )),
      ),
    );
  }
}
