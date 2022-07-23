import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gouge_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGauge extends StatelessWidget {
  final double imc;
  const ImcGauge({Key? key, required this.imc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          minimum: 12.5,
          maximum: 47.9,
          ranges: [
            ImcGougeRange(
              color: Colors.blue,
              start: 12.5,
              end: 18.5,
              label: "Magro",
            ),
            ImcGougeRange(
              color: Colors.green,
              start: 18.5,
              end: 24.5,
              label: "Normal",
            ),
            ImcGougeRange(
              color: Colors.yellow[600]!,
              start: 24.5,
              end: 29.9,
              label: "Sobrepeso",
            ),
            ImcGougeRange(
              color: Colors.red[500]!,
              start: 29.9,
              end: 39.9,
              label: "Obseidade",
            ),
            ImcGougeRange(
              color: Colors.red[900]!,
              start: 39.9,
              end: 47.9,
              label: "Obseidade Grave",
            ),
          ],
          pointers: [
            NeedlePointer(
              value: imc,
              enableAnimation: true,
            )
          ],
        )
      ],
    );
  }
}
