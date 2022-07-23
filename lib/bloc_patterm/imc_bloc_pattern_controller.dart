import 'dart:async';
import 'dart:math';

import 'package:flutter_default_state_manager/bloc_patterm/imc_state.dart';

class ImcBlocPatternCopntroller {
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(const ImcState(imc: 0));

  Stream<ImcState> get imcOut => _imcStreamController.stream;


  Future<void> calcularImc({required double peso, required double altura}) async{
    _imcStreamController.add(ImcStateLoading());

    await Future.delayed(Duration(seconds: 1));

    final double imc = peso / pow(altura, 2);
    _imcStreamController.add(ImcState(imc: imc));

  }

  void dispose() {
    _imcStreamController.close();
  }
}
