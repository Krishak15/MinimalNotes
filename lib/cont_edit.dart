import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContEdit extends StatefulWidget {
  const ContEdit({super.key});

  @override
  State<ContEdit> createState() => _ContEditState();
}

class _ContEditState extends State<ContEdit> {
  List<String> ti = [];
  List<String> content = [];
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var d = preferences.getStringList("title");
    var b = preferences.getStringList("notes");

    setState(() {
      ti.addAll(d!);
      content.addAll(b!);
    });
  }

  bool _isEditingText = false;
  TextEditingController _editingController = TextEditingController();
  String initialText = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _editingController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 206, 59),
        height: MediaQuery.of(context).size.height / 1.8,
        width: MediaQuery.of(context).size.width / 1.2,
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      ),
    );
  }
}
