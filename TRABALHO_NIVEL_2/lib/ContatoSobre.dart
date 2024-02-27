// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_app_test/Components/HeaderBar.dart';

class ContatoSobrePage extends StatelessWidget {
  const ContatoSobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          HeaderBar(),
          SizedBox(
            width: maxWidth > 800 ? 800 : maxWidth - 50,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sobre a Explore Mundo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Bem-vindo à Explore Mundo, sua agência de viagens especializada em transformar sonhos em realidade! Nossa paixão é proporcionar experiências únicas e inesquecíveis para todos os nossos clientes. Desde destinos exóticos até serviços de excelência, estamos aqui para tornar cada jornada memorável.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Nossa Missão',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Nossa missão é oferecer uma experiência de viagem incomparável, combinando destinos emocionantes com um serviço de qualidade superior. Estamos comprometidos em fazer com que cada cliente se sinta especial e realizado durante toda a sua jornada.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Nossos Serviços',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '- Pacotes personalizados\n- Reservas fáceis\n- Informações detalhadas\n- Avaliações de estrelas',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Contato',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Quer entrar em contato conosco? Estamos aqui para ajudar! Você pode nos contatar pelos seguintes meios:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '- Telefone: +55 (99) 9 8765-4321\n- E-mail: Email@Email.com\n- Redes sociais: @Explore Mundo',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
