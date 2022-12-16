import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/view.dart';

import 'note_edit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> ti = [];
  List<String> content = [];
  List<dynamic> noti = [];
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var d = preferences.getStringList("title");
    var b = preferences.getStringList("notes");

    setState(() {
      ti.addAll(d!);
      content.addAll(b!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  // List _notes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.9,
                image: AssetImage("assets/images/sea.jpeg"),
                fit: BoxFit.cover)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Stack(children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  BlurryContainer(
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (hom) => Editt()));
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white70,
                          size: 26,
                        ),
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: Colors.transparent, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Your Notes",
                      style: GoogleFonts.jost(
                        color: Colors.white60,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ]),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: content.length,
                  itemBuilder: (context, index) {
                    final item = ti[index];
                    var c = content[index];
                    var t = ti[index];
                    return Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: InkWell(
                        onTap: () {
                          print("object");
                          final title = ti[index];
                          final notee = content[index];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (view) =>
                                  ViewNote(title: title, note: notee)));
                        },
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          key: UniqueKey(),
                          onDismissed: (direction) async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();

                            HapticFeedback.mediumImpact();
                            setState(() {
                              print("dismi");

                              ti.removeAt(index);
                              content.removeAt(index);

                              preferences.setStringList("title", ti);
                              preferences.setStringList("notes", content);
                            });
                          },
                          background: BlurryContainer(
                            blur: 5,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.white70.withOpacity(0.5),
                                      size: 40,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ),
                          child: BlurryContainer(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    t,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.comfortaa(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      c,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.comfortaa(
                                          color: Colors.white70,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                              height: 130,
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white70),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
