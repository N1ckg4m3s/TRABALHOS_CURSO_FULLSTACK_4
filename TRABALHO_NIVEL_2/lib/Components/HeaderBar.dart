// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, file_names, use_key_in_widget_constructors, depend_on_referenced_packages, unrelated_type_equality_checks, unnecessary_import, constant_identifier_names

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController OrigenControler = TextEditingController();
TextEditingController DestinoControler = TextEditingController();
TextEditingController IdaControler = TextEditingController();
TextEditingController VoltaControler = TextEditingController();
TextEditingController DataChoice = TextEditingController();

TextEditingController TravelChoice = TextEditingController(text: " Só ida");

class HeaderBar extends StatefulWidget {
  @override
  HeaderBarState createState() => HeaderBarState();
}

const Siglas = [
  "AC",
  "AL",
  "AP",
  "AM",
  "BA",
  "CE",
  "DF",
  "ES",
  "GO",
  "MA",
  "MT",
  "MS",
  "MG",
  "PA",
  "PB",
  "PR",
  "PE",
  "PI",
  "RJ",
  "RN",
  "RS",
  "RO",
  "RR",
  "SC",
  "SP",
  "SE",
  "TO"
];

class HeaderBarState extends State<HeaderBar> {
  bool AbrirNavBar = false;
  Future<void> selectDate(
      BuildContext context, TextEditingController Contr) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: (DataChoice.text == "Ida"
            ? DateTime.now()
            : IdaControler.text.isNotEmpty
                ? DateFormat("yyyy/MM/dd").parse(IdaControler.text)
                : DateTime.now()),
        firstDate: (DataChoice.text == "Ida"
            ? DateTime.now()
            : IdaControler.text.isNotEmpty
                ? DateFormat("yyyy/MM/dd").parse(IdaControler.text)
                : DateTime.now()),
        lastDate: DateTime(2100));
    if (picked != null && picked != DateTime.now()) {
      setState(
        () {
          Contr.text = DateFormat("yyyy/MM/dd").format(picked);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    bool ButtonNavBar = maxWidth <= 950;
    return Stack(
      children: [
        Image.asset(
          "FundoTela.jpg",
          width: maxWidth,
          height: maxWidth <= 1200 ? 500 : 370,
          fit: BoxFit.cover,
        ),
        Positioned(
          width: maxWidth,
          height: 250,
          child: Center(
            child: Text("Explore \n Mundo",
                style: GoogleFonts.irishGrover(
                    textStyle: const TextStyle(fontSize: 40))),
          ),
        ),
        Positioned(
          width: maxWidth,
          bottom: 10,
          child: Container(
            alignment: Alignment.center,
            width: maxWidth,
            child: Container(
                width: maxWidth > 1400
                    ? 900
                    : maxWidth > 1200
                        ? 450
                        : 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(127, 0, 0, 0)),
                child: maxWidth >= 1200
                    ? SearchBarOutros(maxWidth)
                    : SearchBarCel()),
          ),
        ),
        if (ButtonNavBar)
          TextButton(
              onPressed: () {
                setState(() {
                  AbrirNavBar = true;
                });
              },
              child: Icon(Icons.menu, color: Color.fromRGBO(0, 0, 0, 1))),
        if (AbrirNavBar && ButtonNavBar)
          // Stack(children: [
          NavBarCel(() => {
                setState(() {
                  AbrirNavBar = false;
                })
              }),
        if (!ButtonNavBar) NavBarOutros(maxWidth),
      ],
    );
  }

  Autocomplete<String> CompleteAuto(String texto, TextEditingController Contr) {
    List<String> options = Siglas; // Lista de opções
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        // Filtrar opções com base no texto digitado
        return options
            .where((option) => option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()))
            .toList();
      },
      onSelected: (String selection) {
        Contr.text = selection;
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextInputBuild(
            texto, textEditingController, focusNode, onFieldSubmitted, Contr);
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              height: options.length > 4 ? 200 : options.length * 50,
              width: 200,
              child: ListView.builder(
                itemCount: options.length > 4 ? 4 : options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  // COMPONENTS

  Padding TextInputBuild(
      String texto,
      TextEditingController TextEd,
      FocusNode focusNode,
      VoidCallback textEditingController,
      TextEditingController Contr) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        width: 200,
        height: 35,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
            controller: TextEd,
            focusNode: focusNode,
            onChanged: (v) => {textEditingController, Contr.text = v},
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration.collapsed(
              hintText: texto,
            )),
      ),
    );
  }

  Padding DateInputBuild(
      String texto, TextEditingController Contr, String ChoiceAt) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
          width: 200,
          height: 35,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () => {
              setState(() {
                ChoiceAt = ChoiceAt;
              }),
              selectDate(context, Contr)
            },
            child: Row(children: [
              Container(
                width: 128,
                height: 35,
                alignment: Alignment.center,
                child: Text(
                  Contr.text,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 48,
                height: 35,
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () => {
                          setState(() {
                            Contr.text = "";
                          })
                        },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.close, color: Color.fromRGBO(0, 0, 0, 1))
                      ],
                    )),
              )
            ]),
          )),
    );
  }

  //          RESPONSIVIDADE
  // TOP BAR
  Widget BotaoNavBar(String Texto, String Route) {
    return TextButton(
        onPressed: () => {Navigator.pushNamed(context, Route)},
        child: Text(Texto,
            style: GoogleFonts.irishGrover(
                textStyle: TextStyle(fontSize: 20),
                color: Color.fromRGBO(0, 0, 0, 1))));
  }

  Widget NavBarCel(CallBack) {
    return Positioned.fill(
        child: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: Color.fromRGBO(255, 255, 255, .8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BotaoNavBar("DESTINOS", "/Main"),
                BotaoNavBar("PACOTES", "/Pacotes"),
                BotaoNavBar("SOBRE/CONTATO", "CnttSobr"),
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: TextButton(
              onPressed: CallBack,
              child: Icon(Icons.close, color: Color.fromRGBO(0, 0, 0, 1))),
        ),
      ],
    ));
  }

  Widget NavBarOutros(double maxWidth) {
    return Positioned(
      top: 10,
      width: maxWidth,
      child: FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: .45,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BotaoNavBar("DESTINOS", "/Main"),
              BotaoNavBar("PACOTES", "/Pacotes"),
              BotaoNavBar("SOBRE/CONTATO", "/CnttSobr"),
            ],
          ),
        ),
      ),
    );
  }

  // Search
  Widget ChoiceInput(String Texto) {
    return SizedBox(
        child: TextButton(
      onPressed: () {
        setState(() {
          TravelChoice.text = Texto;
        });
      },
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: TravelChoice.text == Texto
                  ? Color.fromRGBO(25, 45, 200, 1)
                  : Color.fromRGBO(25, 25, 25, 1),
            ),
          ),
          Text(Texto,
              style: GoogleFonts.irishGrover(
                  textStyle: const TextStyle(
                      fontSize: 15, color: Color.fromRGBO(255, 255, 255, 1)))),
        ],
      ),
    ));
  }

  Widget SearchBarCel() {
    return Column(
      children: [
        Text("para onde vamos?",
            style: GoogleFonts.irishGrover(
                textStyle: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(0, 0, 0, 1)))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ChoiceInput(" Só ida"),
            ChoiceInput(" ida/volta"),
            ChoiceInput(" pacote"),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CompleteAuto("Origem", OrigenControler),
            CompleteAuto("Destino", DestinoControler),
            DateInputBuild("Ida", IdaControler, "Ida"),
            if (TravelChoice.text != " Só ida")
              DateInputBuild("Volta", VoltaControler, "Volta")
          ],
        ),
        ButConsult()
      ],
    );
  }

  Widget SearchBarOutros(double maxWidth) {
    return Column(
      children: [
        Text("para onde vamos?",
            style: GoogleFonts.irishGrover(
                textStyle: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(0, 0, 0, 1)))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ChoiceInput(" Só ida"),
            ChoiceInput(" ida/volta"),
            ChoiceInput(" pacote"),
          ],
        ),
        if (maxWidth <= 1400)
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CompleteAuto("Origem", OrigenControler),
                CompleteAuto("Destino", DestinoControler),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                DateInputBuild("Ida", IdaControler, "Ida"),
                if (TravelChoice.text != " Só ida")
                  DateInputBuild("Volta", VoltaControler, "Volta")
              ]),
            ],
          ),
        if (maxWidth > 1400)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CompleteAuto("Origem", OrigenControler),
            CompleteAuto("Destino", DestinoControler),
            DateInputBuild("Ida", IdaControler, "Ida"),
            if (TravelChoice.text != " Só ida")
              DateInputBuild("Volta", VoltaControler, "Volta"),
          ]),
        ButConsult()
      ],
    );
  }

  Padding ButConsult() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: 200,
        height: 35,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 20, 255, 0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () => {
            if (OrigenControler.text.isNotEmpty &&
                DestinoControler.text.isNotEmpty &&
                IdaControler.text.isNotEmpty)
              {
                if (TravelChoice.text == " Só ida")
                  {
                    Navigator.pushNamed(
                      context,
                      "/Destinos",
                      arguments: {
                        'TravelChoice': 'IDA',
                        'Origem': OrigenControler.text,
                        'Destino': DestinoControler.text,
                        'DataIda': IdaControler.text,
                      },
                    ),
                  }
                else if (TravelChoice.text == " ida/volta" &&
                    VoltaControler.text.isNotEmpty)
                  {
                    Navigator.pushNamed(
                      context,
                      "/Destinos",
                      arguments: {
                        'TravelChoice': 'IDA/VOLTA',
                        'Origem': OrigenControler.text,
                        'Destino': DestinoControler.text,
                        'DataIda': IdaControler.text,
                        'DataVolta': VoltaControler.text,
                      },
                    ),
                  }
                else if (VoltaControler.text.isNotEmpty)
                  {
                    Navigator.pushNamed(
                      context,
                      "/Pacotes",
                      arguments: {
                        'TravelChoice': 'PACOTES',
                        'Origem': OrigenControler.text,
                        'Destino': DestinoControler.text,
                        'DataIda': IdaControler.text,
                        'DataVolta': VoltaControler.text
                      },
                    )
                  }
              },
          },
          child: Text(
            "CONSULTAR",
            style: GoogleFonts.irishGrover(
              textStyle: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*

[OrigenControler.text,
DestinoControler.text,
IdaControler.text,
VoltaControler.text]

*/
