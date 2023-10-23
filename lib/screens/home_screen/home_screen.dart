import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:invoices_app/style/app_color.dart';
import 'package:invoices_app/widgets/custom_app_bar.dart';
import 'package:path/path.dart';

import 'package:invoices_app/widgets/custom_dropdown_button.dart';
import 'package:invoices_app/widgets/custom_form_field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Dodawanie faktury',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    icon: const Icon(
                      Icons.save_outlined,
                    ),
                    iconSize: 30,
                    onPressed: () async {
                      _formKey.currentState?.validate();
                      if (_formKey.currentState!.validate()) {
                        await context.read<HomeCubit>().saveData();
                      }
                    }),
              ),
            ],
          ),
          body: InvoiceForm(formKey: _formKey),
        );
      }),
    );
  }
}

class InvoiceForm extends StatefulWidget {
  InvoiceForm({required this.formKey});

  final GlobalKey<FormState> formKey;
  @override
  State<InvoiceForm> createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final TextEditingController _grossNumberController = TextEditingController();
  final TextEditingController _netNumberController =
      TextEditingController(text: '0.00');

  void clearText() {
    if (_netNumberController.text == '0.00') {
      _netNumberController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = '';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (_, state) {
          if (_grossNumberController.text != state.grossAmount) {
            _grossNumberController.text = state.grossAmount;
          }
        },
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              CustomFormField(
                labelText: 'Nr faktury',
                textCapitalization: TextCapitalization.sentences,
                maxLength: 50,
                onChanged: (value) =>
                    context.read<HomeCubit>().onChangeInvoiceNumber(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'To pole jest wymagane';
                  }

                  if (value.trim().length <= 3 || value.trim().length > 50) {
                    return 'Musi być pomiędzy 3 a 50 znaków.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                labelText: 'Nazwa kontrahenta',
                textCapitalization: TextCapitalization.sentences,
                maxLength: 100,
                onChanged: (value) =>
                    context.read<HomeCubit>().onChangeContractorsName(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'To pole jest wymagane';
                  }

                  if (value.trim().length <= 3 || value.trim().length > 1000) {
                    return 'Musi być pomiędzy 3 a 100 znaków.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                  labelText: 'Kwota netto',
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      context.read<HomeCubit>().onChangeNetAmount(value),
                  controller: _netNumberController,
                  onTap: clearText,
                  onFocusChanged: (hasFocus) {
                    if (!hasFocus && _netNumberController.text.isEmpty) {
                      _netNumberController.text = '0.00';
                    }
                  },
                  validator: (value) {
                    if (double.parse(value!) == 0 || double.parse(value!) < 0) {
                      return 'Wartość musi być większa od 0';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomDropdownButton(
                labelText: 'Stawka VAT',
                items: <String>['0%', '7%', '23%'],
                onChanged: (value) {
                  if (value != null) {
                    context.read<HomeCubit>().onChangeVatRate(value);
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                controller: _grossNumberController,
                labelText: 'Kwota brutto',
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    context.read<HomeCubit>().onChangeGrossAmount(value),
                isEnabled: false,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'png', 'pdf'],
                      );

                      if (result?.files.single.path != null) {
                        File file = File(result!.files.single.path!);
                        context.read<HomeCubit>().onChangeAttachment(file);
                      } else {}
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                      foregroundColor: AppColor.navy,
                    ),
                    child: Column(
                      children: [
                        Text('Załącz plik (pdf,jpg,png)'),
                        const SizedBox(
                          height: 6,
                        ),
                        if (state.attachment?.path != null)
                          Text(
                            'Załączono ${basename(state.attachment!.path)}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.blue,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
