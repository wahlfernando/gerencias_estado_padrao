import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/bloc_patterm/imc_bloc_pattern_controller.dart';
import 'package:flutter_default_state_manager/bloc_patterm/imc_state.dart';
import 'package:intl/intl.dart';

import '../widgets/imc_gauge.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({Key? key}) : super(key: key);

  @override
  State<ImcBlocPatternPage> createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {
  final controller = ImcBlocPatternCopntroller();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC Bloc Pattern"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                    stream: controller.imcOut,
                    builder: (context, snapshot) {
                      var imc = 0.0;
                      if (snapshot.hasData) {
                        imc = snapshot.data?.imc ?? 0;
                      }

                      return ImcGauge(imc: imc);
                    }),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<ImcState>(
                    stream: controller.imcOut,
                    builder: (context, snapshot) {
                      return Visibility(
                        visible: snapshot.data is ImcStateLoading,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Peso'),
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
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Altura'),
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
                const SizedBox(
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

                        controller.calcularImc(altura: altura, peso: peso);
                      }
                    },
                    child: const Text("Calcular IMC"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
