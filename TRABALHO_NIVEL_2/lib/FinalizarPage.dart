// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, file_names

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app_test/Components/HeaderBar.dart';
import 'package:my_app_test/Controle/Classes.dart';

int Tip = 3;
Voo? Ida;
Voo? Volta;
Predio? Hotel;

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args['Voo1'] != null) {
        Ida = args['Voo1'];
        Tip = 1;
      }
      if (args['Voo2'] != null) {
        Volta = args['Voo2'];
        Tip = 2;
      }
      if (args['Hotel'] != null) {
        Hotel = args['Hotel'];
        Tip = 3;
      }
    } else {
      Tip = 3;
      Ida = Voo(
          companhiaAerea: "ERRO",
          de: "ERRO",
          para: "ERRO",
          dataHoraPartida: DateTime(0),
          paradas: 0,
          duracao: const Duration(hours: 0),
          preco: 0);
      Volta = Voo(
          companhiaAerea: "ERRO",
          de: "ERRO",
          para: "ERRO",
          dataHoraPartida: DateTime(0),
          paradas: 0,
          duracao: const Duration(hours: 0),
          preco: 0);
      Hotel = Predio(Local: "ERRO", Estadia: 0, Nome: "ERRO", Rate: 0);
    }
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
      width: maxWidth,
      child: Column(
        children: [
          HeaderBar(),
          const SizedBox(width: 10),
          Column(
            children: [
              SizedBox(
                width: maxWidth,
                height: 35,
                child: Text(
                  "RESUMO DA VIAGEM",
                  style: GoogleFonts.irishGrover(
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                width: maxWidth > 800 ? 800 : maxWidth,
                child: maxWidth > 830
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.airplanemode_active),
                                  Text(
                                    "VOO",
                                    style: GoogleFonts.irishGrover(
                                      textStyle: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              if (Tip >= 1) VooSelec("IDA", Ida, maxWidth),
                              const SizedBox(height: 5),
                              if (Tip >= 2) VooSelec("VOLTA", Volta, maxWidth),
                              if (Tip >= 3)
                                Row(
                                  children: [
                                    const Icon(Icons.hotel),
                                    Text(
                                      "HOSPEDAGEM",
                                      style: GoogleFonts.irishGrover(
                                        textStyle:
                                            const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              if (Tip >= 3) HotelSelec(Hotel, maxWidth),
                            ],
                          ),
                          TotalCard(Tip, Ida, Volta, Hotel, maxWidth),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.airplanemode_active),
                              Text(
                                "VOO",
                                style: GoogleFonts.irishGrover(
                                  textStyle: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          if (Tip >= 1) VooSelec("IDA", Ida, maxWidth),
                          const SizedBox(height: 5),
                          if (Tip >= 2) VooSelec("VOLTA", Volta, maxWidth),
                          if (Tip >= 3)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.hotel),
                                Text(
                                  "HOSPEDAGEM",
                                  style: GoogleFonts.irishGrover(
                                    textStyle: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          if (Tip >= 3) HotelSelec(Hotel, maxWidth),
                          TotalCard(Tip, Ida, Volta, Hotel, maxWidth),
                        ],
                      ),
              ),
              Mensagem(maxWidth),
            ],
          )
        ],
      ),
    )));
  }
}

Container VooSelec(String Tipo, Voo? voo, double maxWidth) {
  return Container(
    width: maxWidth > 610 ? 600 : maxWidth,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1, color: Colors.black),
      color: const Color.fromRGBO(200, 200, 200, 1),
    ),
    height: 100,
    child: Row(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                voo!.companhiaAerea,
                style: GoogleFonts.irishGrover(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'economica',
                style: GoogleFonts.irishGrover(
                  textStyle: const TextStyle(fontSize: 15),
                ),
              )
            ],
          )),
        ),
        Container(
          width: maxWidth > 610 ? 600 - 102 : maxWidth - 102,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black),
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Column(
            children: [
              SizedBox(
                  width: 290,
                  height: 30,
                  child: Center(
                      child: Text(
                          '$Tipo: ${DateFormat('dd/MM').format(voo.dataHoraPartida)}',
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
        ),
      ],
    ),
  );
}

Container HotelSelec(Predio? predio, double maxWidth) {
  if (predio == null) return Container();
  return Container(
    width: maxWidth > 610 ? 600 : maxWidth,
    height: 150,
    color: const Color.fromRGBO(200, 200, 200, 1),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: predio.image != null
              ? Image.asset(
                  predio.image!,
                  width: 125,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : const SizedBox(
                  width: 125,
                  height:
                      150), // Use um espaço reservado caso predio ou predio.image seja nulo
        ),
        Container(
          width: maxWidth > 610 ? 600 - 125 : maxWidth - 125,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black),
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 475,
                height: 25,
                child: Text("[Hotel nome]",
                    style: GoogleFonts.irishGrover(
                      textStyle: const TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                  width: 475,
                  height: 25,
                  child: Row(
                    children: [
                      Icon(Icons.star,
                          size: 15,
                          color: predio.Rate >= 1 ? Colors.amber : Colors.grey),
                      Icon(Icons.star,
                          size: 15,
                          color: predio.Rate >= 2 ? Colors.amber : Colors.grey),
                      Icon(Icons.star,
                          size: 15,
                          color: predio.Rate >= 3 ? Colors.amber : Colors.grey),
                      Icon(Icons.star,
                          size: 15,
                          color: predio.Rate >= 4 ? Colors.amber : Colors.grey),
                      Icon(Icons.star,
                          size: 15,
                          color: predio.Rate >= 5 ? Colors.amber : Colors.grey),
                    ],
                  )),
              SizedBox(
                width: 475,
                height: 63,
                child: Text("[INFO+]",
                    style: GoogleFonts.irishGrover(
                      textStyle: const TextStyle(fontSize: 12),
                    )),
              ),
              Container(
                  width: 475,
                  height: 25,
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month),
                      Text(
                        ' ${Ida!.dataHoraPartida.day}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                          ' de ${DateFormat.MMM().format(Ida!.dataHoraPartida)} á',
                          style: const TextStyle(fontSize: 11)),
                      Text(' ${Volta!.dataHoraPartida.day}',
                          style: const TextStyle(fontSize: 15)),
                      Text(
                          ' de ${DateFormat.MMM().format(Volta!.dataHoraPartida)}',
                          style: const TextStyle(fontSize: 11)),
                    ],
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

Container TotalCard(int Q, Voo? v1, Voo? v2, Predio? predio, double maxWidth) {
  return Container(
    width: maxWidth > 610 ? 150 : maxWidth * .625,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1, color: Colors.black),
      color: const Color.fromRGBO(255, 255, 255, 1),
    ),
    child: Column(
      children: [
        SizedBox(
            width: 165,
            height: 25,
            child: Center(
              child: Text("TOTAL",
                  style: GoogleFonts.irishGrover(
                    textStyle: const TextStyle(fontSize: 15),
                  )),
            )),
        Container(
          width: 165,
          height: 1,
          color: Colors.grey,
        ),
        SizedBox(
          width: 165,
          height: 125,
          child: Column(
            children: [
              if (Q >= 1)
                Row(
                  children: [
                    const Text(
                      "Voo Ida: ",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(v1!.preco.toString())
                  ],
                ),
              if (Q >= 2)
                Row(
                  children: [
                    const Text(
                      "Voo Volta: ",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(v2!.preco.toString())
                  ],
                ),
              if (Q >= 3)
                Row(
                  children: [
                    const Text(
                      "Hotelaria: ",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(Hotel!.Estadia.toString()),
                    Text(
                      ' (x ${v2!.dataHoraPartida.difference(v1!.dataHoraPartida).inDays})',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              const Row(
                children: [
                  Text(
                    "Taxa de serviço: ",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text('75'),
                ],
              )
            ],
          ),
        ),
        TextButton(
          onPressed: () => {},
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
              width: 165,
              height: 25,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 43, 204, 49),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("TOTAL: ",
                      style: GoogleFonts.irishGrover(
                        textStyle: const TextStyle(fontSize: 10),
                      )),
                  Text(
                      ((Tip >= 1 ? v1!.preco : 0) +
                              (Tip >= 2 ? v2!.preco : 0) +
                              (Tip >= 3
                                  ? Hotel!.Estadia *
                                      (v2!.dataHoraPartida
                                              .difference(v1!.dataHoraPartida))
                                          .inDays
                                  : 0) +
                              75)
                          .toString(),
                      style: GoogleFonts.irishGrover(
                        textStyle: const TextStyle(fontSize: 15),
                      )),
                ],
              )),
        )
      ],
    ),
  );
}

SizedBox Mensagem(double maxWidth) {
  return SizedBox(
    width: maxWidth > 800 ? 780 : maxWidth - 20,
    child: Column(
      children: [
        const Text("INFORMAÇÕES IMPORTANTES", style: TextStyle(fontSize: 20)),
        const Text(
            'Os serviços sitados ainda não foram reservados, as reservas só serão concluidas apos conferimento de disponibilidade e pegamento'),
        const SizedBox(width: 5, height: 5),
        CaixaTxt(maxWidth, "Chegue cedo: ",
            "Não se atrase! Chegue ao aeroporto com antecedência para evitar correrias."),
        CaixaTxt(maxWidth, "Documentação em ordem: ",
            "Tenha passaporte, visto e cartão de embarque à mão."),
        CaixaTxt(maxWidth, "Bagagem de mão organizada: ",
            "Prepare seus itens essenciais com antecedência e siga as regras de bagagem."),
        CaixaTxt(maxWidth, "Segurança em primeiro lugar: ",
            "Esteja atento às instruções e políticas de segurança do aeroporto."),
        CaixaTxt(maxWidth, "Atenção aos anúncios: ",
            "Fique atento aos avisos sobre mudanças no horário ou portão de embarque."),
        CaixaTxt(maxWidth, "Respeite as prioridades: ",
            "Permita que passageiros prioritários embarquem primeiro."),
        CaixaTxt(maxWidth, "Fique atento ao tempo: ",
            "Esteja pronto para se dirigir ao portão assim que seu voo for chamado."),
        const SizedBox(width: 5, height: 35)
      ],
    ),
  );
}

Container CaixaTxt(double maxWidth, String Tit, String Txt) {
  return Container(
    alignment: Alignment.topLeft,
    width: maxWidth > 810 ? 800 : maxWidth,
    child: Column(children: [
      RichText(
        text: TextSpan(children: [
          TextSpan(
              text: Tit,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
          TextSpan(
            text: Txt,
            style: const TextStyle(color: Colors.black),
          ),
        ]),
      ),
      const SizedBox(width: 5, height: 10)
    ]),
  );
}
