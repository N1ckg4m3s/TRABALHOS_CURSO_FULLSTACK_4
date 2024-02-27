// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names, file_names

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_app_test/Components/Filtro.dart';
import 'package:my_app_test/Controle/Classes.dart';
import 'package:my_app_test/Controle/ControlerClasses.dart';
import '/Components/HeaderBar.dart';

class DestinosPage extends StatefulWidget {
  const DestinosPage({super.key});

  @override
  _DestinosPageState createState() => _DestinosPageState();
}

List<Voo> OpcoesVoo = [];
List<Voo> OpcoesVooFiltrado = [];
String ClaseParaSet = "FINALIZAR";
Voo? VooIda;
Voo? VooVolta;
Filtro? FiltroGenerico;

Voo ItemTeste = Voo(
  companhiaAerea: "GOL",
  de: "UF",
  para: 'UF',
  dataHoraPartida: DateTime(2024, 20, 12),
  paradas: 0,
  duracao: const Duration(hours: 2, minutes: 30),
  preco: 0,
);

class _DestinosPageState extends State<DestinosPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args['TravelChoice'] == "IDA") {
        OpcoesVoo.clear();
        OpcoesVoo = ControlerVoo().Filtrar(Filtro(
            de: args['Origem'],
            para: args['Destino'],
            DataIda: DateFormat('yyyy/MM/dd').parse(args['DataIda']),
            DataVolta: DateTime(0)));
      } else {
        FiltroGenerico = Filtro(
            de: args['Origem'],
            para: args['Destino'],
            DataIda: DateFormat('yyyy/MM/dd').parse(args['DataIda']),
            DataVolta: DateFormat('yyyy/MM/dd').parse(args['DataVolta']));
      }
    } else {
      ClaseParaSet = "FINALIZAR";
      FiltroGenerico = Filtro(
          de: 'AC',
          para: 'AL',
          DataIda: DateTime(2024, 02, 27),
          DataVolta: DateTime(2024, 02, 29));
      // Navigator.pushNamed(context, routeName)
    }

    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderBar(),
            args != null && args['TravelChoice'] != "IDA"
                ? maxWidth > 550
                    ? CardResumoOutros(maxWidth, (Claset, Fil) {
                        setState(() {
                          ClaseParaSet = Claset;
                          OpcoesVoo.clear();
                          OpcoesVoo = ControlerVoo().Filtrar(Fil);
                        });
                      })
                    : CardResumoCel(maxWidth, (Claset, Fil) {
                        setState(() {
                          ClaseParaSet = Claset;
                          OpcoesVoo.clear();
                          OpcoesVoo = ControlerVoo().Filtrar(Fil);
                        });
                      })
                : Container(),
            const SizedBox(height: 10),
            SizedBox(
              width: maxWidth > 875 ? 850 : maxWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OpcoesVoo.isNotEmpty
                      ? Filtro_Bar_VOO(
                          opcoesVoo: OpcoesVoo,
                          onChanged: (List<dynamic> Comps, String Ordem) {
                            List<Voo> voosFiltrados = OpcoesVoo.where((voo) {
                              return Comps.any((comp) =>
                                  comp['Op'] == voo.companhiaAerea &&
                                  comp['Abilitado']);
                            }).toList();
                            switch (Ordem) {
                              case 'Maior valor':
                                voosFiltrados
                                    .sort((a, b) => b.preco.compareTo(a.preco));
                                break;
                              case 'Menor valor':
                                voosFiltrados
                                    .sort((a, b) => a.preco.compareTo(b.preco));
                                break;
                              case 'Menor tempo':
                                voosFiltrados.sort(
                                    (a, b) => a.duracao.compareTo(b.duracao));
                                break;
                              default:
                                break;
                            }

                            setState(() {
                              OpcoesVooFiltrado = voosFiltrados;
                            });
                          })
                      : Container(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: maxWidth >= 645 ? 640 : maxWidth - 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GerarLista(
                            context,
                            maxWidth,
                            (Selecionado) => {
                              setState(
                                () {
                                  ClaseParaSet == "IDA"
                                      ? VooIda = Selecionado
                                      : VooVolta = Selecionado;
                                },
                              )
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CARD NOVOS

  SizedBox CardResumoCel(double maxWidth, SetS) {
    return SizedBox(
      width: maxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          VooFrame(SetS, maxWidth),
          ValueFrame(VooIda, VooVolta, context)
        ],
      ),
    );
  }

  SizedBox CardResumoOutros(double maxWidth, SetS) {
    return SizedBox(
      width: 700,
      height: 291,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          VooFrame(SetS, maxWidth),
          ValueFrame(VooIda, VooVolta, context)
        ],
      ),
    );
  }
}

Wrap GerarLista(context, double maxWidth, Sess) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: List.generate(
      OpcoesVooFiltrado.isNotEmpty
          ? OpcoesVooFiltrado.length
          : OpcoesVoo.length,
      (index) => maxWidth > 650
          ? CardSimplesOutros(
              OpcoesVooFiltrado.isNotEmpty
                  ? OpcoesVooFiltrado[index]
                  : OpcoesVoo[index],
              (Voo Selecionado) => {
                if (ClaseParaSet == "FINALIZAR")
                  {
                    Navigator.pushNamed(context, "/Finish",
                        arguments: {'Voo1': Selecionado})
                  }
                else
                  {Sess(Selecionado)}
              },
              ClaseParaSet,
              maxWidth,
            )
          : CardSimplesCel(
              OpcoesVoo[index],
              (Voo Selecionado) => {
                if (ClaseParaSet == "FINALIZAR")
                  {
                    Navigator.pushNamed(context, "/Finish",
                        arguments: {'Voo1': Selecionado})
                  }
                else
                  {Sess(Selecionado)}
              },
              ClaseParaSet,
              maxWidth,
            ),
    ),
  );
}

// CARD
Row TituloCard(String Comp, String Tipo) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.airplanemode_active),
      Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        child: Text(
          Comp,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      Container(
        alignment: Alignment.bottomLeft,
        height: 50,
        child: Text(
          Tipo,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      )
    ],
  );
}

TextButton CardSimplesOutros(
    Voo voo, Function CalBack, String Tipo, double maxWidth) {
  return TextButton(
    onPressed: () => {CalBack(voo)},
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
      width: 650,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
        color: const Color.fromRGBO(200, 200, 200, 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              width: 650,
              height: 27,
              child: Center(child: TituloCard(voo.companhiaAerea, 'economica')),
            ),
          ),
          Container(
              width: 650,
              height: 103,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
                color: const Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VooSelected(voo, Tipo, maxWidth),
                    Column(
                      children: [
                        SizedBox(
                          width: 175,
                          height: 56,
                          child: Row(
                            children: [
                              const Text("valor: "),
                              Text(
                                voo.preco.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 175,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(25, 255, 0, 1),
                          ),
                          child: const Center(child: Text("SELECIONAR")),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    ),
  );
}

TextButton CardSimplesCel(
    Voo voo, Function CalBack, String Tipo, double maxWidth) {
  return TextButton(
    onPressed: () => {CalBack(voo)},
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
      width: maxWidth - 2,
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
        color: const Color.fromRGBO(200, 200, 200, 1),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            width: maxWidth - 2,
            height: 27,
            child: Center(child: TituloCard(voo.companhiaAerea, 'economica')),
          ),
        ),
        Container(
          width: maxWidth - 2,
          height: 203,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VooSelected(voo, Tipo, maxWidth),
                Column(
                  children: [
                    SizedBox(
                      width: 175,
                      height: 56,
                      child: Row(
                        children: [
                          const Text("valor: "),
                          Text(
                            voo.preco.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 175,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(25, 255, 0, 1),
                      ),
                      child: const Center(child: Text("SELECIONAR")),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    ),
  );
}

Container VooSelected(Voo? voo, String Tipo, double maxWidth) {
  if (voo != null) {
    return Container(
      width: maxWidth > 444 ? 444 : maxWidth - 434,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        children: [
          SizedBox(
              width: 290,
              height: 30,
              child: Center(
                  child: Text(
                      'IDA: ${DateFormat('dd/MM').format(voo.dataHoraPartida)}',
                      style: const TextStyle(fontSize: 20)))),
          Container(
            width: 290,
            height: 1,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    voo.de,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    DateFormat('HH:mm').format(voo.dataHoraPartida),
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '${voo.duracao.inHours}:${voo.duracao.inMinutes - voo.duracao.inHours * 60}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    '${voo.paradas} Paradas',
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    voo.para,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    DateFormat('HH:mm')
                        .format(voo.dataHoraPartida.add(voo.duracao)),
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  return Container(
    width: 300,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
      color: const Color.fromRGBO(255, 255, 255, 1),
    ),
    child: const Center(
        child: Text(
      'SELECT',
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 20),
      textAlign: TextAlign.center,
    )),
  );
}

Container VooFrame(SetS, double maxWidth) {
  return Container(
    // VOO CARD
    width: 300,
    height: 259,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
      color: const Color.fromRGBO(200, 200, 200, 1),
    ),
    child: Column(
      children: [
        const SizedBox(
            width: 300,
            height: 35,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.airplanemode_active),
                  Text(
                    'VOO',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )),
        Container(
          width: 300,
          height: 222,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // QUANDO VAZIO, APARECER SELECT, AO CONTRARIO HORA DO VOO
                TextButton(
                    onPressed: () async {
                      SetS(
                          "IDA",
                          Filtro(
                              de: FiltroGenerico!.de,
                              para: FiltroGenerico!.para,
                              DataIda: FiltroGenerico!.DataIda,
                              DataVolta: DateTime(0)));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.black;
                        },
                      ),
                    ),
                    child: VooSelected(VooIda, "IDA", maxWidth)),
                TextButton(
                    onPressed: () async {
                      SetS(
                          "VOLTA",
                          Filtro(
                              de: FiltroGenerico!.para,
                              para: FiltroGenerico!.de,
                              DataIda: FiltroGenerico!.DataVolta,
                              DataVolta: DateTime(0)));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.black;
                        },
                      ),
                    ),
                    child: VooSelected(VooVolta, "VOLTA", maxWidth)),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Container ValueFrame(Voo? V1, Voo? V2, context) {
  return Container(
    // PREÇO TOTAL CARD
    width: 200,
    height: 259,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
      color: const Color.fromRGBO(200, 200, 200, 1),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
            width: 250,
            height: 35,
            child: Center(
              child: Text(
                'TOTAL',
                style: TextStyle(fontSize: 20),
              ),
            )),
        Container(
          width: 250,
          height: 177,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Column(
            children: [
              if (V1 != null)
                Row(
                  children: [
                    const Text("Voo ida:", style: TextStyle(fontSize: 10)),
                    Text(V1.preco.toString(),
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              if (V2 != null)
                Row(
                  children: [
                    const Text("Voo volta:", style: TextStyle(fontSize: 10)),
                    Text(V2.preco.toString(),
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              if (V1 != null && V2 != null)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 180,
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Total:", style: TextStyle(fontSize: 10)),
                        Text(
                          (V2.preco + V1.preco).toString(),
                          style: const TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
        TextButton(
            onPressed: () => {
                  Navigator.pushNamed(context, "/Finish",
                      arguments: {'Voo1': VooIda, 'Voo2': VooVolta})
                },
            child: Container(
                width: 175,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(25, 255, 0, 1),
                ),
                child: const Center(child: Text("SELECIONAR"))))
      ],
    ),
  );
}
