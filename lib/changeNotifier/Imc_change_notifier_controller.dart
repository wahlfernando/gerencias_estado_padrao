
import 'dart:math';

import 'package:flutter/material.dart';

class ImcChangeNotifierController extends ChangeNotifier{

  var imc = 0.0;

  Future<void> calcularImc({required double altura, required double peso}) async {

    imc = 0.0;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));

    //pow é para fazer valor vezses ele mesmo e a quantidade de vezes vem logo após.
    imc = peso / pow(altura, 2);
    notifyListeners();
  }

}