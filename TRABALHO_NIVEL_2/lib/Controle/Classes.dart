// ignore_for_file: file_names, non_constant_identifier_names

class Voo {
  String companhiaAerea;
  String de;
  String para;
  DateTime dataHoraPartida;
  int paradas;
  Duration duracao;
  int preco;

  Voo({
    required this.companhiaAerea,
    required this.de,
    required this.para,
    required this.dataHoraPartida,
    required this.paradas,
    required this.duracao,
    required this.preco,
  });

  @override
  String toString() {
    return "VOO( compania:$companhiaAerea de:$de para:$para data:$dataHoraPartida paradas:$paradas duração:$duracao preco:$preco )";
  }
}

class PacoteViagem {
  Voo ida;
  Voo volta;
  Predio? Acomodacao;

  PacoteViagem({
    required this.ida,
    required this.volta,
    this.Acomodacao,
  });

  @override
  String toString() {
    return "";
  }
}

class Filtro {
  String de;
  String para;
  DateTime DataIda;
  DateTime DataVolta;

  Filtro(
      {required this.de,
      required this.para,
      required this.DataIda,
      required this.DataVolta});

  @override
  String toString() {
    return "FILTRO(de:$de para:$para ida:$DataIda volta:$DataVolta)";
  }
}

class FiltroHotel {
  String Uf;
  double Rate;
  double Estadia;

  FiltroHotel({
    required this.Uf,
    required this.Rate,
    required this.Estadia,
  });

  @override
  String toString() {
    return "FILTRO(Rate:$Rate Estadia:$Estadia)";
  }
}

class Comentario {
  String Nome;
  String Coment;
  int Rate;
  Comentario({required this.Nome, required this.Coment, required this.Rate});
}

class Predio {
  String? image;
  double Rate = 0;
  List<Comentario> Coments = [];
  String Local;
  double Estadia;
  String Nome;

  void AddComent(Comentario Co) {
    Coments.add(Co);
  }

  void CalcRate() {
    int SomaTot = 0;
    for (var element in Coments) {
      SomaTot += element.Rate;
    }
    Rate = SomaTot / Coments.length;
  }

  Predio({
    this.image,
    required this.Local,
    required this.Estadia,
    required this.Nome,
    required this.Rate,
  });
}
