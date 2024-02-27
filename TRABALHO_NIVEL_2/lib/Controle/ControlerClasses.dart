// ignore_for_file: file_names, non_constant_identifier_names, unrelated_type_equality_checks, unnecessary_null_comparison

import 'Classes.dart';

List<Voo> ListaVoos = [];

class ControlerVoo {
  void Adicionar(Voo voo) {
    ListaVoos.add(voo);
  }

  List<Voo> Filtrar(Filtro filtro) {
    return ListaVoos.where((voo) {
      if (filtro.de != voo.de) return false;
      if (filtro.para != voo.para) return false;
      if (filtro.DataIda.day != voo.dataHoraPartida.day ||
          filtro.DataIda.month != voo.dataHoraPartida.month) return false;
      return true;
    }).toList();
  }

  List<Voo> ObterTodos() {
    return ListaVoos;
  }
}

List<PacoteViagem> ListaPacotes = [];

class ControlerPacotes {
  void Adicionar(PacoteViagem pacote) {
    ListaPacotes.add(pacote);
  }

  List<PacoteViagem> Filtrar(Filtro filtro) {
    return ListaPacotes.where((pacote) {
      if ((filtro.de.isNotEmpty && pacote.ida.de != filtro.de) ||
          (filtro.para.isNotEmpty && pacote.volta.para != filtro.para)) {
        return false;
      }
      return true;
    }).toList();
  }
}

List<Predio> ListaPredio = [];

class ControlerPredio {
  void Adicionar(Predio Predio) {
    ListaPredio.add(Predio);
  }

  List<Predio> Filtrar(FiltroHotel Filt) {
    return ListaPredio.where((predio) {
      bool passaFiltroUf = Filt.Uf == null || predio.Local == Filt.Uf;
      bool passaFiltroRate = Filt.Rate == null || predio.Rate >= Filt.Rate;
      bool passaFiltroEstadia =
          Filt.Estadia == null || predio.Estadia <= Filt.Estadia;

      return passaFiltroUf && passaFiltroRate && passaFiltroEstadia;
    }).toList();
    // if (Uf != null) {
    //   return ListaPredio.where((pacote) {

    //     return Uf == pacote.Local;
    //   }).toList();
    // }
    // return [];
  }
}

String TextoGrande = '''
Somos uma Agência de Viagens apaixonada por transformar sonhos em realidade. Nosso compromisso é oferecer uma experiência única e inesquecível para todos os nossos clientes, proporcionando não apenas destinos exóticos e emocionantes, mas também um serviço de excelência em cada etapa da jornada. \n
Em nossa busca contínua por melhorias, estamos sempre inovando para tornar nosso aplicativo ainda mais atrativo e funcional. Com a Explore Mundo, você tem acesso a uma ampla gama de recursos que facilitam a sua experiência de viagem. \n 
Explore destinos incríveis ao redor do mundo, consulte nossos pacotes personalizados, faça reservas com facilidade e entre em contato com nossa equipe dedicada a qualquer momento. Além disso, fornecemos informações detalhadas sobre cada localização e avaliações de estrelas para ajudá-lo a planejar sua viagem de forma inteligente e segura. \n
Na Explore Mundo, acreditamos que cada viagem é uma oportunidade de descoberta e aventura. Junte-se a nós e embarque em uma jornada extraordinária rumo aos lugares mais fascinantes do mundo! \n
Seja bem-vindo à Explore Mundo - sua porta de entrada para experiências inesquecíveis!
''';

String TextoCel = '''
Somos uma Agência de Viagens apaixonada por transformar sonhos em realidade. \n
Descubra destinos incríveis, consulte pacotes personalizados e faça reservas com facilidade. Nossa equipe dedicada está aqui para ajudá-lo em cada etapa da sua jornada. Planeje sua próxima aventura com a Explore Mundo e embarque em uma viagem inesquecível! \n
Seja bem-vindo à Explore Mundo - sua porta de entrada para experiências inesquecíveis!
''';
