import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/home/bar_graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thuAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
      sunAmount: sunAmount,
    );
    myBarData.initializeBarData();

    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            //-----------------------------------TO DO-----------------------------------
            ////implementar los titulos superiores con los valores totales

            // showTitles: true,
            // reservedSize: 35,
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 65,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
              reservedSize: 40),
        ),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: myBarData.barData
          .map(
            (data) => BarChartGroupData(x: data.x, barRods: [
              BarChartRodData(
                toY: data.y,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    SweetCakeTheme.pink1,
                    SweetCakeTheme.pink2,
                    Colors.pink.shade300,
                  ],
                ),
                width: 30,
                borderRadius: BorderRadius.circular(10),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  fromY: maxY,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.shade900,
                      Colors.black45,
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    ));
  }
}

// Widget getTopTitles(double value, TitleMeta meta, totalLunes, totalMartes,
//     totalMiercoles, totalJueves, totalViernes, totalSabado, totalDomingo) {
//   Widget text;
//   switch (value.toInt()) {
//     case 0:
//       text = Text(
//         totalLunes,
//         style: const TextStyle(
//           fontWeight: FontWeight.normal,
//         ),
//       );
//       break;
//     case 1:
//       text = Text(
//         totalMartes,
//         style: const TextStyle(
//           fontWeight: FontWeight.normal,
//         ),
//       );
//       break;
//     case 2:
//       text = Text(
//         totalMiercoles,
//         style: const TextStyle(
//           fontWeight: FontWeight.normal,
//         ),
//       );
//       break;
//     case 3:
//       text = Text(
//         totalJueves,
//         style: const TextStyle(
//           fontWeight: FontWeight.normal,
//         ),
//       );
//       break;
//     case 4:
//       text = Text(
//         totalViernes,
//         style: const TextStyle(
//           fontWeight: FontWeight.normal,
//         ),
//       );
//       break;
//     case 5:
//       text = Text(
//         totalSabado,
//         style: const TextStyle(
//           fontWeight: FontWeight.normal,
//         ),
//       );
//       break;
//     case 6:
//       text = Text(
//         totalDomingo,
//         style: const TextStyle(
//           fontWeight: FontWeight.normal,
//         ),
//       );
//       break;
//   }
// }

Widget getBottomTitles(double value, TitleMeta meta) {
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "Lun",
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      );
      break;
    case 1:
      text = const Text(
        "Mar",
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      );
      break;
    case 2:
      text = const Text(
        "Mie",
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      );
      break;
    case 3:
      text = const Text(
        "Jue",
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      );
      break;
    case 4:
      text = const Text(
        "Vie",
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      );
      break;
    case 5:
      text = const Text(
        "Sab",
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      );
      break;
    case 6:
      text = const Text(
        "Dom",
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      );
      break;
    default:
      text = const Text(
        "",
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      );
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
