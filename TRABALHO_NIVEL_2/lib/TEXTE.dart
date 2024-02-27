// ignore_for_file: use_key_in_widget_constructors, file_names, non_constant_identifier_names

import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        AppBar,
        Autocomplete,
        AutocompleteOnSelected,
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Center,
        Color,
        Column,
        Container,
        EdgeInsets,
        FocusNode,
        InputBorder,
        InputDecoration,
        ListTile,
        ListView,
        MainAxisAlignment,
        Material,
        MaterialApp,
        Padding,
        Scaffold,
        SizedBox,
        StatelessWidget,
        Text,
        TextAlign,
        TextAlignVertical,
        TextEditingController,
        TextEditingValue,
        TextField,
        VoidCallback,
        Widget,
        runApp;

class MyAutoComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocomplete Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  // Aqui você pode definir suas opções de sugestão com base no texto digitado
                  return [
                    'Apple',
                    'Banana',
                    'Cherry',
                    'Date',
                    'Grape',
                    'Lemon',
                    'Mango',
                    'Orange',
                    'Pineapple',
                    'Watermelon',
                  ].where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  }).toList();
                },
                onSelected: (String selection) {
                  // Aqui você pode lidar com a seleção da sugestão
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextInputBuild('Search', textEditingController,
                      focusNode, onFieldSubmitted);
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: options.length,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding TextInputBuild(String texto, TextEditingController Contr,
      FocusNode focusNode, VoidCallback onFieldSubmitted) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 200,
        height: 35,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: Contr,
          focusNode: focusNode,
          onChanged: (value) => onFieldSubmitted(),
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: texto,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyAutoComplete(),
  ));
}
