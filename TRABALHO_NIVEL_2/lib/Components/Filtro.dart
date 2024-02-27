// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app_test/Controle/Classes.dart';

class Filtro_Bar_VOO extends StatefulWidget {
  final List<Voo> opcoesVoo;
  final void Function(List<dynamic>, String) onChanged;

  const Filtro_Bar_VOO({
    super.key,
    required this.opcoesVoo,
    required this.onChanged,
  });
  @override
  FiltroBarVooState createState() => FiltroBarVooState();
}

class FiltroBarVooState extends State<Filtro_Bar_VOO> {
  var Companias = [];
  var Ordens = ["SELECIONAR", "Maior valor", "Menor valor", "Menor tempo"];
  String OrdemSelec = "SELECIONAR";
  void ColocarDadosCompania() {
    List<String> companhiasFiltradas = [];
    for (var voo in widget.opcoesVoo) {
      if (!companhiasFiltradas.contains(voo.companhiaAerea)) {
        companhiasFiltradas.add(voo.companhiaAerea);
      }
    }
    Companias.removeWhere(
        (compania) => !companhiasFiltradas.contains(compania['Op']));
    for (var compania in companhiasFiltradas) {
      if (!Companias.any((element) => element['Op'] == compania)) {
        Companias.add({
          'Op': compania,
          'Abilitado': true,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ColocarDadosCompania();
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.black)),
        width: 190,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text("FILTRA VOO",
                  style: GoogleFonts.irishGrover(
                      textStyle: const TextStyle(fontSize: 20),
                      color: const Color.fromRGBO(0, 0, 0, 1))),
              hr(180, 1),
              SizedBox(
                  width: 190,
                  child: Column(
                    children: [
                      const Text("Companias"),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          Companias.length,
                          (index) => CheckBox(
                            Opcaoes: Companias,
                            index: index,
                            onChanged: (index, Value) =>
                                {Companias[index]['Abilitado'] = Value},
                          ),
                        ),
                      )
                    ],
                  )),
              hr(180, 1),
              DropList("ORDENAR POR:", Ordens, OrdemSelec, (String Choice) {
                setState(() {
                  OrdemSelec = Choice;
                });
              }),
              TextButton(
                onPressed: () {
                  widget.onChanged(Companias, OrdemSelec);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.black;
                    },
                  ),
                ),
                child: Container(
                  width: 175,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(25, 255, 0, 1),
                  ),
                  child: const Center(child: Text("filtrar")),
                ),
              ),
            ],
          ),
        ));
  }
}

class Filtro_Bar_HOTEL extends StatefulWidget {
  final List<Predio> opcoesPredio;
  final void Function(List<dynamic>, String) onChanged;

  const Filtro_Bar_HOTEL({
    super.key,
    required this.opcoesPredio,
    required this.onChanged,
  });
  @override
  FiltroBarHotelState createState() => FiltroBarHotelState();
}

class FiltroBarHotelState extends State<Filtro_Bar_HOTEL> {
  var Companias = [];
  var Ordens = ["SELECIONAR", "Maior valor", "Menor valor"];
  String OrdemSelec = "SELECIONAR";

  void ColocarDadosCompania() {
    List<int> companhiasFiltradas = [];
    for (var predio in widget.opcoesPredio) {
      if (!companhiasFiltradas.contains(predio.Rate.toInt())) {
        companhiasFiltradas.add(predio.Rate.toInt());
      }
    }
    Companias.removeWhere(
        (compania) => !companhiasFiltradas.contains(compania['Op']));
    for (var compania in companhiasFiltradas) {
      if (!Companias.any((element) => element['Op'] == compania)) {
        Companias.add({
          'Op': compania,
          'Abilitado': true,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ColocarDadosCompania();
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.black)),
        width: 190,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text("FILTRA HOTEL",
                  style: GoogleFonts.irishGrover(
                      textStyle: const TextStyle(fontSize: 20),
                      color: const Color.fromRGBO(0, 0, 0, 1))),
              hr(180, 1),
              SizedBox(
                  width: 190,
                  child: Column(
                    children: [
                      const Text("Companias"),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          Companias.length,
                          (index) => CheckBox(
                            Opcaoes: Companias,
                            index: index,
                            onChanged: (index, Value) =>
                                {Companias[index]['Abilitado'] = Value},
                          ),
                        ),
                      )
                    ],
                  )),
              hr(180, 1),
              DropList("ORDENAR POR:", Ordens, OrdemSelec, (String Choice) {
                setState(() {
                  OrdemSelec = Choice;
                });
              }),
              TextButton(
                onPressed: () {
                  widget.onChanged(Companias, OrdemSelec);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.black;
                    },
                  ),
                ),
                child: Container(
                  width: 175,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(25, 255, 0, 1),
                  ),
                  child: const Center(child: Text("filtrar")),
                ),
              ),
            ],
          ),
        ));
  }
}

Container hr(double W, double H) {
  return Container(
    width: W,
    height: H,
    color: Colors.black,
  );
}

class CheckBox extends StatefulWidget {
  final Opcaoes;
  final int index;
  final Function(int, bool) onChanged;

  const CheckBox({
    super.key,
    required this.Opcaoes,
    required this.index,
    required this.onChanged,
  });

  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<CheckBox> {
  bool _Checked = true;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => setState(() {
              _Checked = !_Checked;
              widget.Opcaoes[widget.index]['Abilitado'] =
                  !widget.Opcaoes[widget.index]['Abilitado'];
            }),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Colors.black;
            },
          ),
        ),
        child: SizedBox(
          width: 75,
          height: 15,
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                color: Colors.grey,
                child: Container(
                  color: _Checked == true ? Colors.blue : Colors.grey,
                  width: 8,
                  height: 8,
                ),
              ),
              Container(
                width: 64,
                height: 15,
                alignment: Alignment.center,
                child: Text(' ${widget.Opcaoes[widget.index]['Op']}'),
              )
            ],
          ),
        ));
  }
}

Widget DropList(String label, List<String> options, String selectedValue,
    void Function(String) onChanged) {
  return DropdownButton<String>(
    value: selectedValue,
    onChanged: (String? value) {
      onChanged(value!);
    },
    items: options.map((option) {
      return DropdownMenuItem<String>(
        value: option,
        child: Text(option),
      );
    }).toList(),
    hint: Text(label),
  );
}
