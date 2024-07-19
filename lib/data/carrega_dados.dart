import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> carregaEstadosJson() async {
  final String dadosStr =
      await rootBundle.loadString('assets/estados.min.json');
  final List<dynamic> dadosList = json.decode(dadosStr) as List<dynamic>;
  return dadosList.map((item) => item as Map<String, dynamic>).toList();
}

Future<List<Map<String, dynamic>>> carregaMunicipiosJson() async {
  final String dadosStr =
      await rootBundle.loadString('assets/municipios.min.json');
  final listaJson = jsonDecode(dadosStr) as Map<String, dynamic>;
  final municipios = <Map<String, dynamic>>[];

  listaJson.forEach((key, value) {
    final list = value as List<dynamic>;
    municipios.addAll(list.map((e) => e as Map<String, dynamic>));
  });

  return municipios;
}
