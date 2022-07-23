import 'package:flutter/material.dart';

class ImcState {
  final double? imc;

  const ImcState({
    Key? key,
    required this.imc
  });
}

class ImcStateLoading extends ImcState{
  ImcStateLoading() : super(imc: 0);



}
