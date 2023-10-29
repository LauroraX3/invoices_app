import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:invoices_app/models/invoice.dart';
import 'package:invoices_app/style/app_color.dart';
import 'package:invoices_app/widgets/custom_app_bar.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key, required this.invoice});

  final Invoice invoice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightPink,
      appBar: CustomAppBar(
        title: 'Szczegóły faktury',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Faktura nr: ${invoice.invoiceNumber}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: AppColor.navy,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'PLN ${invoice.grossAmount}',
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 1.2,
                color: AppColor.navy,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kontrahent:',
                  style: _textStyle(),
                ),
                Text(
                  invoice.contractorsName,
                  style: _textStyle(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Wartość netto:',
                  style: _textStyle(),
                ),
                Text(
                  '${invoice.netAmount} PLN',
                  style: _textStyle(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Podatek VAT:',
                  style: _textStyle(),
                ),
                Text(
                  '${invoice.vatRate}%',
                  style: _textStyle(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (invoice.isAttachmentExists)
              InvoiceDetailsAttachment(
                attachment: invoice.attachment!,
                attachmentExt: invoice.attachmentExt!,
              ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontSize: 16,
      letterSpacing: 0.9,
      color: AppColor.blue,
    );
  }
}

class InvoiceDetailsAttachment extends StatelessWidget {
  const InvoiceDetailsAttachment({
    super.key,
    required this.attachment,
    required this.attachmentExt,
  });

  final String attachment;
  final String attachmentExt;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          if (attachmentExt.contains('jpg') || attachmentExt.contains('png'))
            Center(
              child: Image.memory(
                base64Decode(attachment),
              ),
            )
          else if (attachmentExt.contains('pdf'))
            PDFView(
              pdfData: base64Decode(attachment),
              swipeHorizontal: true,
            )
          else
            const SizedBox.shrink(),
          Positioned(
            right: 10,
            top: 15,
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.edit,
                      color: AppColor.darkPink,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.delete,
                      color: AppColor.darkPink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
