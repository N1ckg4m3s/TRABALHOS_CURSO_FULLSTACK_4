// ignore_for_file: file_names, prefer_const_constructors, unused_import, non_constant_identifier_names

import 'dart:math';
import 'package:my_app_test/Controle/Classes.dart';

import 'ControlerClasses.dart';

GerarDadosTeste() {
  final List<String> companias = [
    'GOL',
    'LATAM',
    'AZUL',
    'VOE',
    'TAM',
    'AVIANCA'
  ];
  final List<String> estados = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];

  // GERAR REGISTROS DE VOOS

  for (int day = 0; day < 10; day++) {
    for (var de in estados) {
      for (var para in estados) {
        if (de != para) {
          for (int j = 0; j < 2; j++) {
            ControlerVoo().Adicionar(Voo(
              companhiaAerea: companias[Random().nextInt(companias.length)],
              de: de,
              para: para,
              dataHoraPartida: DateTime.now()
                  .add(Duration(days: day, minutes: Random().nextInt(4) * 15)),
              paradas: Random().nextInt(2),
              duracao: Duration(hours: Random().nextInt(5) + 1),
              preco: Random().nextInt(1000) + 100,
            ));
          }
        }
      }
    }
  }

  // GERAR REGISTROS DE COMPANIAS

  final List<String> PrediosFName = [
    'Residencial',
    'Condominio',
    'Fundação',
    'Mondial',
    'Aguas',
  ];
  final List<String> PrediosSName = [
    'Vermelho',
    'Azul',
    'Verde',
    'Amarelo',
    'Branco',
    'Preto',
    'Grande',
    'Pequeno',
    'Moderno',
    'Clássico'
  ];

  for (var Est in estados) {
    for (var i = 0; i < 3; i++) {
      String Nome =
          "${PrediosFName[Random().nextInt(PrediosFName.length)]} ${PrediosSName[Random().nextInt(PrediosSName.length)]}";
      double Estadia = Random().nextInt(250) + 120;
      Predio P = Predio(
        image: 'assets/Foto_Hoteis/Hotel_ (${Random().nextInt(6) + 1}).webp',
        Local: Est,
        Estadia: Estadia,
        Nome: Nome,
        Rate: Random().nextDouble() * 5,
      );
      for (int i = 0; i < Random().nextInt(5); i++) {
        P.AddComent(Comentario(
          Nome: "Nome pessoa",
          Coment: "Coment",
          Rate: Random().nextInt(5),
        ));
        P.CalcRate();
      }
      ControlerPredio().Adicionar(P);
    }
  }
}
