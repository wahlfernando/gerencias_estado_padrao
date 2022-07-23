import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';




class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ValueNotifierPage> createState() => ValueNotifierPageState();
}

class ValueNotifierPageState extends State<ValueNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  var imc = ValueNotifier(0.0);
  final formKey = GlobalKey<FormState>();

  Future<void> calcularImc({required double altura, required double peso}) async {

    imc.value = 0.0;
    await Future.delayed(Duration(seconds: 1));

    //pow é para fazer valor vezses ele mesmo e a quantidade de vezes vem logo após.
    imc.value = peso / pow(altura, 2);
  }

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC ValueNotifier"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ValueListenableBuilder<double>(
                    valueListenable: imc,
                    builder: (_, imcValue, __) {
                      return ImcGauge(imc: imcValue);
                    }),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Peso'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            turnOffGrouping: true,
                            locale: "pt_BR",
                            symbol: "",
                            decimalDigits: 2,
                          )
                        ],
                        controller: pesoEC,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Peso obrigatório';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Altura'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            turnOffGrouping: true,
                            locale: "pt_BR",
                            symbol: "",
                            decimalDigits: 2,
                          )
                        ],
                        controller: alturaEC,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Altura obrigatório';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      var formValid = formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        var formatter = NumberFormat.simpleCurrency(
                            locale: "pt_BR", decimalDigits: 2);
                        double peso = formatter.parse(pesoEC.text) as double;
                        double altura =
                            formatter.parse(alturaEC.text) as double;

                        calcularImc(altura: altura, peso: peso);
                      }
                    },
                    child: Text("Calcular IMC"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
