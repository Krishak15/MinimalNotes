import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/home.dart';

class Editt extends StatefulWidget {
  const Editt({super.key});

  @override
  State<Editt> createState() => _EdittState();
}

class _EdittState extends State<Editt> {
  String sav = "Save";
  List<String> _title = [];
  List<String> _notes = [];
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var d = preferences.getStringList("title");
    var n = preferences.getStringList("notes");
    setState(() {
      _title.addAll(d!);
      _notes.addAll(n!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();

    super.initState();
  }

  final _maxLines = 5;
  @override
  Widget build(BuildContext context) {
    var siz = MediaQuery.of(context).size.height / 1.8;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.9,
                  image: AssetImage("assets/images/sea.jpeg"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 26,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 10),
                      child: SizedBox(
                        height: 50,
                        child: Text(
                          "New Notes",
                          style: GoogleFonts.jost(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 24.0),
                          child: BlurryContainer(
                            blur: 5,
                            borderRadius: BorderRadius.circular(30),
                            child: TextField(
                              //Title Field
                              controller: title,
                              style: GoogleFonts.jost(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),

                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              135, 255, 255, 255),
                                          width: 2)),
                                  hintText: "Title",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  prefixIcon: const Icon(
                                    Icons.draw_outlined,
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: BlurryContainer(
                            height: MediaQuery.of(context).size.height / 1.8,
                            borderRadius: BorderRadius.circular(30),
                            blur: 5,
                            child: TextField(
                              //Note Field

                              controller: note,
                              textAlign: TextAlign.justify,
                              cursorColor: Colors.white,
                              style: GoogleFonts.jost(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              maxLines: _maxLines * 4,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              122, 255, 255, 255),
                                          width: 2)),
                                  hintText: "       Note",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                  // prefixIcon: Icon(Icons.note),

                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (hom) => Home()));
                                  setState(() {});
                                },
                                child: BlurryContainer(
                                  blur: 5,
                                  borderRadius: BorderRadius.circular(30),
                                  height: 60,
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                      'Your Notes',
                                      style: GoogleFonts.jost(
                                          color: Color.fromARGB(
                                              255, 151, 151, 151),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    )),
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 196, 196, 196),
                                            width: 2),
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () async {
                                  HapticFeedback.mediumImpact();
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  _title.add(title.text);
                                  _notes.add(note.text);
                                  preferences.setStringList("title", _title);
                                  preferences.setStringList("notes", _notes);
                                  setState(() {
                                    final SnackBar _snackBar = SnackBar(
                                      backgroundColor: Colors.transparent,
                                      content: Center(
                                        child: Text(
                                          'Note Saved',
                                          style: GoogleFonts.jost(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      duration: const Duration(seconds: 1),
                                      behavior: SnackBarBehavior.fixed,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(_snackBar);
                                  });
                                },
                                child: BlurryContainer(
                                  blur: 5,
                                  borderRadius: BorderRadius.circular(30),
                                  height: 60,
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                      sav,
                                      style: GoogleFonts.jost(
                                          color: Color.fromARGB(
                                              255, 255, 228, 187),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    )),
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 255, 250, 239),
                                            width: 2),
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
