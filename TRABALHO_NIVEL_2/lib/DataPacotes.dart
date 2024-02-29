// ignore_for_file: file_names, depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app_test/Components/Filtro.dart';
import 'package:my_app_test/Controle/Classes.dart';
import 'package:my_app_test/Controle/ControlerClasses.dart';
import '/Components/HeaderBar.dart';

class DataPacotes extends StatefulWidget {
  const DataPacotes({super.key});

  @override
  _DataPacotesState createState() => _DataPacotesState();
}

List<Voo> OpcoesVoo = [];
List<Voo> OpcoesVooFiltrado = [];

List<Predio> OpcoesHotel = [];
List<Predio> OpcoesHotelFiltrado = [];

String ClaseParaSet = "PACOTE";
Voo? VooIda;
Voo? VooVolta;

Predio? Hotel;

Filtro? FiltroGenerico;

class _DataPacotesState extends State<DataPacotes> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      FiltroGenerico = Filtro(
          de: args['Origem'],
          para: args['Destino'],
          DataIda: DateFormat('yyyy/MM/dd').parse(args['DataIda']),
          DataVolta: DateFormat('yyyy/MM/dd').parse(args['DataVolta']));
    } else {
      FiltroGenerico = Filtro(
          de: 'AC',
          para: 'AL',
          DataIda: DateTime(2024, 03, 01),
          DataVolta: DateTime(2024, 03, 03));
    }

    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      HeaderBar(),
      maxWidth > 900
          ? CardResumoOutros(maxWidth, (Claset, Filtro Fil) {
              setState(() {
                OpcoesVoo.clear();
                OpcoesHotel.clear();
                ClaseParaSet = Claset;
                Claset != "ACOMOD"
                    ? OpcoesVoo = ControlerVoo().Filtrar(Fil)
                    : OpcoesHotel = ControlerPredio().Filtrar(FiltroHotel(
                        Uf: Fil.para,
                        Rate: 0,
                        Estadia: 10000,
                      ));
              });
            })
          : CardResumoCel(maxWidth, (Claset, Filtro Fil) {
              setState(() {
                OpcoesVoo.clear();
                OpcoesHotel.clear();
                ClaseParaSet = Claset;
                Claset != "ACOMOD"
                    ? OpcoesVoo = ControlerVoo().Filtrar(Fil)
                    : OpcoesHotel = ControlerPredio().Filtrar(FiltroHotel(
                        Uf: Fil.para,
                        Rate: 0,
                        Estadia: 10000,
                      ));
              });
            }),
      const SizedBox(height: 10),
      maxWidth < 875
          ? Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: maxWidth - 50,
                height: 1,
                color: Colors.black,
              ),
            )
          : Container(),
      SizedBox(
          width: maxWidth > 875 ? 850 : maxWidth,
          child: maxWidth > 875
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClaseParaSet == "ACOMOD" && OpcoesHotel.isNotEmpty
                        ? Filtro_Bar_HOTEL(
                            opcoesPredio: OpcoesHotel,
                            onChanged: (List<dynamic> Comps, String Ordem) {
                              List<Predio> voosFiltrados =
                                  OpcoesHotel.where((voo) {
                                return Comps.any((comp) =>
                                    comp['Op'] == voo.Rate.toInt() &&
                                    comp['Abilitado']);
                              }).toList();
                              switch (Ordem) {
                                case 'Maior valor':
                                  voosFiltrados.sort(
                                      (a, b) => b.Estadia.compareTo(a.Estadia));
                                  break;
                                case 'Menor valor':
                                  voosFiltrados.sort(
                                      (a, b) => a.Estadia.compareTo(b.Estadia));
                                  break;
                                default:
                                  break;
                              }

                              setState(() {
                                OpcoesHotelFiltrado = voosFiltrados;
                              });
                            })
                        : OpcoesVoo.isNotEmpty
                            ? Filtro_Bar_VOO(
                                opcoesVoo: OpcoesVoo,
                                onChanged: (List<dynamic> Comps, String Ordem) {
                                  List<Voo> voosFiltrados =
                                      OpcoesVoo.where((voo) {
                                    return Comps.any((comp) =>
                                        comp['Op'] == voo.companhiaAerea &&
                                        comp['Abilitado']);
                                  }).toList();
                                  switch (Ordem) {
                                    case 'Maior valor':
                                      voosFiltrados.sort(
                                          (a, b) => b.preco.compareTo(a.preco));
                                      break;
                                    case 'Menor valor':
                                      voosFiltrados.sort(
                                          (a, b) => a.preco.compareTo(b.preco));
                                      break;
                                    case 'Menor tempo':
                                      voosFiltrados.sort((a, b) =>
                                          a.duracao.compareTo(b.duracao));
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
                                        setState(() {
                                          ClaseParaSet == "ACOMOD"
                                              ? Hotel = Selecionado
                                              : ClaseParaSet == "IDA"
                                                  ? VooIda = Selecionado
                                                  : VooVolta = Selecionado;
                                        })
                                      })),
                        ],
                      ),
                    )
                  ],
                )
              : Column(mainAxisSize: MainAxisSize.min, children: [
                  ClaseParaSet == "ACOMOD" && OpcoesHotel.isNotEmpty
                      ? Filtro_Bar_HOTEL(
                          opcoesPredio: OpcoesHotel,
                          onChanged: (List<dynamic> Comps, String Ordem) {
                            List<Predio> voosFiltrados =
                                OpcoesHotel.where((voo) {
                              return Comps.any((comp) =>
                                  comp['Op'] == voo.Rate.toInt() &&
                                  comp['Abilitado']);
                            }).toList();
                            switch (Ordem) {
                              case 'Maior valor':
                                voosFiltrados.sort(
                                    (a, b) => b.Estadia.compareTo(a.Estadia));
                                break;
                              case 'Menor valor':
                                voosFiltrados.sort(
                                    (a, b) => a.Estadia.compareTo(b.Estadia));
                                break;
                              default:
                                break;
                            }

                            setState(() {
                              OpcoesHotelFiltrado = voosFiltrados;
                            });
                          })
                      : OpcoesVoo.isNotEmpty
                          ? Filtro_Bar_VOO(
                              opcoesVoo: OpcoesVoo,
                              onChanged: (List<dynamic> Comps, String Ordem) {
                                List<Voo> voosFiltrados =
                                    OpcoesVoo.where((voo) {
                                  return Comps.any((comp) =>
                                      comp['Op'] == voo.companhiaAerea &&
                                      comp['Abilitado']);
                                }).toList();
                                switch (Ordem) {
                                  case 'Maior valor':
                                    voosFiltrados.sort(
                                        (a, b) => b.preco.compareTo(a.preco));
                                    break;
                                  case 'Menor valor':
                                    voosFiltrados.sort(
                                        (a, b) => a.preco.compareTo(b.preco));
                                    break;
                                  case 'Menor tempo':
                                    voosFiltrados.sort((a, b) =>
                                        a.duracao.compareTo(b.duracao));
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
                  GerarLista(
                      context,
                      maxWidth,
                      (Selecionado) => {
                            setState(() {
                              ClaseParaSet == "ACOMOD"
                                  ? Hotel = Selecionado
                                  : ClaseParaSet == "IDA"
                                      ? VooIda = Selecionado
                                      : VooVolta = Selecionado;
                            })
                          })
                ]))
    ])));
  }

  SizedBox CardResumoCel(double maxWidth, SetS) {
    return SizedBox(
      width: maxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          VooFrame(SetS, maxWidth),
          AcomodFrame(Hotel, SetS),
          ValueFrame(VooIda, VooVolta, Hotel, context, maxWidth)
        ],
      ),
    );
  }

  SizedBox CardResumoOutros(double maxWidth, SetS) {
    return SizedBox(
      width: 820,
      height: 291,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          VooFrame(SetS, maxWidth),
          AcomodFrame(Hotel, SetS),
          ValueFrame(VooIda, VooVolta, Hotel, context, maxWidth)
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
      ClaseParaSet == "ACOMOD" && OpcoesHotelFiltrado.isNotEmpty
          ? OpcoesHotelFiltrado.length
          : ClaseParaSet == "ACOMOD"
              ? OpcoesHotel.length
              : OpcoesVooFiltrado.isNotEmpty
                  ? OpcoesVooFiltrado.length
                  : OpcoesVoo.length,
      (index) => ClaseParaSet == "ACOMOD"
          ? maxWidth > 660
              ? CardSimplesAcomodOutros(
                  OpcoesHotelFiltrado.isNotEmpty
                      ? OpcoesHotelFiltrado[index]
                      : OpcoesHotel[index],
                  (Predio Selecionado) => {Sess(Selecionado)},
                  ClaseParaSet,
                  maxWidth,
                )
              : CardSimplesAcomodCel(
                  OpcoesHotelFiltrado.isNotEmpty
                      ? OpcoesHotelFiltrado[index]
                      : OpcoesHotel[index],
                  (Predio Selecionado) => {Sess(Selecionado)},
                  ClaseParaSet,
                  maxWidth,
                )
          : maxWidth > 650
              ? CardSimplesOutros(
                  OpcoesVooFiltrado.isNotEmpty
                      ? OpcoesVooFiltrado[index]
                      : OpcoesVoo[index],
                  (Voo Selecionado) => {Sess(Selecionado)},
                  ClaseParaSet,
                  maxWidth,
                )
              : CardSimplesCel(
                  OpcoesVooFiltrado.isNotEmpty
                      ? OpcoesVooFiltrado[index]
                      : OpcoesVoo[index],
                  (Voo Selecionado) => {
                    if (ClaseParaSet == "FINALIZAR")
                      {CheckToSend(context)}
                    else
                      {Sess(Selecionado)}
                  },
                  ClaseParaSet,
                  maxWidth,
                ),
    ),
  );
}

// CARD VOO ACOMOD
TextButton CardSimplesAcomodOutros(
    Predio predio, Function CalBack, String Tipo, double maxWidth) {
  return TextButton(
    onPressed: () => {CalBack(predio)},
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
      width: 645,
      height: 259,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      predio.Nome,
                      style: GoogleFonts.irishGrover(
                          textStyle: const TextStyle(fontSize: 20)),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,
                            size: 15,
                            color:
                                predio.Rate >= 1 ? Colors.amber : Colors.grey),
                        Icon(Icons.star,
                            size: 15,
                            color:
                                predio.Rate >= 2 ? Colors.amber : Colors.grey),
                        Icon(Icons.star,
                            size: 15,
                            color:
                                predio.Rate >= 3 ? Colors.amber : Colors.grey),
                        Icon(Icons.star,
                            size: 15,
                            color:
                                predio.Rate >= 4 ? Colors.amber : Colors.grey),
                        Icon(Icons.star,
                            size: 15,
                            color:
                                predio.Rate >= 5 ? Colors.amber : Colors.grey),
                      ],
                    )
                  ],
                )),
          ),
          Container(
            width: 645,
            height: 222,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (predio.image != null)
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          predio.image!,
                          width: 158,
                          height: 222,
                          fit: BoxFit.cover,
                        ))
                  else
                    Container(
                        // IMAGEM
                        width: 158,
                        height: 222,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10))),
                  Container(
                    width: 300,
                    height: 222,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: const Text("info+"),
                  ),
                  Container(
                    width: 168,
                    height: 222,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 164,
                          height: 185,
                          child: Text(
                            '''Valor Quarto:${predio.Estadia - 75}\nTaxa de serviço:${75}
                          ''',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: 164,
                          height: 25,
                          child: Text("TOTAL:${predio.Estadia}"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

TextButton CardSimplesAcomodCel(
    Predio predio, Function CalBack, String Tipo, double maxWidth) {
  return TextButton(
      onPressed: () => {CalBack(predio)},
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
          width: maxWidth - 20,
          height: 390,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
            color: const Color.fromRGBO(200, 200, 200, 1),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                  width: maxWidth - 20,
                  height: 27,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        predio.Nome,
                        style: GoogleFonts.irishGrover(
                            textStyle: const TextStyle(fontSize: 20)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              size: 15,
                              color: predio.Rate >= 1
                                  ? Colors.amber
                                  : Colors.grey),
                          Icon(Icons.star,
                              size: 15,
                              color: predio.Rate >= 2
                                  ? Colors.amber
                                  : Colors.grey),
                          Icon(Icons.star,
                              size: 15,
                              color: predio.Rate >= 3
                                  ? Colors.amber
                                  : Colors.grey),
                          Icon(Icons.star,
                              size: 15,
                              color: predio.Rate >= 4
                                  ? Colors.amber
                                  : Colors.grey),
                          Icon(Icons.star,
                              size: 15,
                              color: predio.Rate >= 5
                                  ? Colors.amber
                                  : Colors.grey),
                        ],
                      )
                    ],
                  )),
            ),
            Container(
                width: maxWidth - 20,
                height: 353,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (predio.image != null)
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    predio.image!,
                                    width: 138,
                                    height: 222,
                                    fit: BoxFit.cover,
                                  ))
                            else
                              Container(
                                  width: 138,
                                  height: 222,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10))),
                            Container(
                              width: maxWidth - 166,
                              height: 222,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: const Text("info+"),
                            ),
                          ]),
                      Container(
                        width: maxWidth,
                        height: 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: maxWidth,
                              height: 100,
                              child: Text(
                                '''Valor Quarto:${predio.Estadia - 75}\nTaxa de serviço:${75}
                          ''',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              width: 164,
                              height: 25,
                              child: Center(
                                child: Text("TOTAL:${predio.Estadia}"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ])));
}

// CARD VOO +
Container CardVooSelected() {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(width: 1, color: const Color.fromRGBO(0, 0, 0, 1))),
    child: Column(
      children: [
        const Text("IDA"),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          width: 300,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("COMP"),
                  Text("00:00"),
                ],
              ),
              Column(
                children: [
                  Text("3:00"),
                  Text("0 paradas"),
                ],
              ),
              Column(
                children: [
                  Text("COMP"),
                  Text("03:00"),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

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

// CARD VOO
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
      width: maxWidth > 444 ? 444 : maxWidth - 10,
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

Container ValueFrame(Voo? V1, Voo? V2, Predio? V3, context, double maxWidth) {
  return Container(
    // PREÇO TOTAL CARD
    width: maxWidth > 900 ? 200 : 300,
    height: 265,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
      color: const Color.fromRGBO(200, 200, 200, 1),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: maxWidth > 900 ? 200 : 300,
            height: 35,
            child: const Center(
              child: Text(
                'TOTAL',
                style: TextStyle(fontSize: 20),
              ),
            )),
        Container(
          width: maxWidth > 900 ? 200 : 300,
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
              if (V3 != null)
                Row(
                  children: [
                    const Text("Acomodações:", style: TextStyle(fontSize: 10)),
                    Text((V3.Estadia).toString(),
                        style: const TextStyle(fontSize: 20)),
                    Text(
                        ('(x${(FiltroGenerico?.DataVolta.difference(FiltroGenerico!.DataIda))?.inDays.toString()})'),
                        style: const TextStyle(fontSize: 10)),
                  ],
                ),
              if (V1 != null && V2 != null && V3 != null)
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
                          (V2.preco +
                                  V1.preco +
                                  V3.Estadia *
                                      (FiltroGenerico?.DataVolta.difference(
                                              FiltroGenerico!.DataIda))!
                                          .inDays)
                              .toString(),
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
            onPressed: () => CheckToSend(context),
            child: Container(
                width: 175,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(25, 255, 0, 1),
                ),
                child: const Center(child: Text("FINALIZAR"))))
      ],
    ),
  );
}

Container AcomodFrame(Predio? Acomod, SetS) {
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
                Icon(Icons.home_work_outlined),
                Text(
                  'HOTEL',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
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
            child: Acomod != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          if (Acomod.image != null)
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  Acomod.image!,
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ))
                          else
                            Container(
                                // IMAGEM
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(10))),
                          SizedBox(
                            // ESTRELAS
                            width: 176,
                            height: 110,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 176,
                                  height: 15,
                                  child: Row(
                                    children: [
                                      Icon(Icons.star,
                                          size: 15,
                                          color: Acomod.Rate >= 1
                                              ? Colors.amber
                                              : Colors.grey),
                                      Icon(Icons.star,
                                          size: 15,
                                          color: Acomod.Rate >= 2
                                              ? Colors.amber
                                              : Colors.grey),
                                      Icon(Icons.star,
                                          size: 15,
                                          color: Acomod.Rate >= 3
                                              ? Colors.amber
                                              : Colors.grey),
                                      Icon(Icons.star,
                                          size: 15,
                                          color: Acomod.Rate >= 4
                                              ? Colors.amber
                                              : Colors.grey),
                                      Icon(Icons.star,
                                          size: 15,
                                          color: Acomod.Rate >= 5
                                              ? Colors.amber
                                              : Colors.grey),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width: 176,
                                    height: 20,
                                    child: Text(Acomod.Nome)),
                                const SizedBox(
                                    width: 176,
                                    height: 65,
                                    child: Text("INFO+")),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(children: [
                              Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                        '${DateFormat.MMM().format(FiltroGenerico!.DataIda)} \n ${FiltroGenerico?.DataIda.day}',
                                        style: const TextStyle(fontSize: 12)),
                                  )),
                              const Text("Entrada")
                            ]),
                            Row(children: [
                              Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                        '${DateFormat.MMM().format(FiltroGenerico!.DataVolta)} \n ${FiltroGenerico?.DataVolta.day}',
                                        style: const TextStyle(fontSize: 12)),
                                  )),
                              const Text("Saida")
                            ]),
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            SetS(
                                "ACOMOD",
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
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.black;
                              },
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(25, 255, 0, 1),
                            ),
                            width: 250,
                            height: 35,
                            child: const Center(child: Text("Trocar")),
                          ))
                    ],
                  )
                : TextButton(
                    onPressed: () async {
                      SetS(
                          "ACOMOD",
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
                    child: const Text(
                      "SELECT",
                      style: TextStyle(fontSize: 20),
                    )),
          ),
        ),
      ],
    ),
  );
}

void CheckToSend(context) {
  if (VooIda != null && VooVolta != null && Hotel != null) {
    Navigator.pushNamed(context, "/Finish",
        arguments: {'Voo1': VooIda, 'Voo2': VooVolta, 'Hotel': Hotel});
  }
}
