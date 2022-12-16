import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/home.dart';

class ViewNote extends StatefulWidget {
  final title;
  final note;

  ViewNote({super.key, required this.title, required this.note});

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.9,
                  image: AssetImage("assets/images/sea.jpeg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: BlurryContainer(
                        blur: 5,
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (notelist) => Home()));
                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_back,
                              size: 26,
                              color: Colors.white70,
                            ),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "Notes",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.jost(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
              const SizedBox(
                height: 30,
              ),
              BlurryContainer(
                blur: 5,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 15, right: 10, bottom: 10),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: SelectableText(
                        widget.title.toString(),
                        onTap: () {},
                        style: GoogleFonts.jost(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(195, 255, 255, 255)),
                      ),
                    ),
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.white70.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              BlurryContainer(
                blur: 5,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.white70.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20, right: 10, bottom: 10),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: SelectableText(
                        widget.note.toString(),
                        // overflow: TextOverflow.ellipsis,

                        textAlign: TextAlign.left,
                        style: GoogleFonts.jost(
                            fontSize: 26,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(205, 255, 255, 255)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
