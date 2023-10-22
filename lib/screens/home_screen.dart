import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:invoices_app/style/app_color.dart';

import 'package:invoices_app/widgets/custom_dropdown_button.dart';
import 'package:invoices_app/widgets/custom_form_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dodawanie faktury',
          style: TextStyle(color: AppColor.blue),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.save_outlined),
          ),
        ],
        backgroundColor: AppColor.navy,
        actionsIconTheme: IconThemeData(color: AppColor.darkPink, size: 28),
        elevation: 10,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          children: [
            const CustomFormField(
              labelText: 'Nr faktury',
              textCapitalization: TextCapitalization.sentences,
              maxLength: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomFormField(
              labelText: 'Nazwa kontrahenta',
              textCapitalization: TextCapitalization.sentences,
              maxLength: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomFormField(
              labelText: 'Kwota netto',
              keyboardType: TextInputType.number,
              initialValue: '0.00',
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomDropdownButton(
              labelText: 'Stawka VAT',
              items: <String>['0%', '7%', '23%'],
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomFormField(
              labelText: 'Kwota brutto',
              keyboardType: TextInputType.number,
              initialValue: '0.00',
            ),
            TextButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'png', 'pdf'],
                );

                if (result?.files.single.path != null) {
                  File file = File(result!.files.single.path!);
                } else {}
              },
              child: Text('Załącz plik (pdf,jpg,png)'),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 18),
                foregroundColor: AppColor.navy,
              ),
            )
          ],
        ),
      ),
    );
  }
}
