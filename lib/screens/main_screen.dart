import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/new_plan_screen.dart';
import 'package:todo_app/utils/projectColors.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'edit_plan_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 237, 225),
      appBar: AppBar(
        backgroundColor: ProjectColors.splash_background,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        title: const Text(
          'MY TODOS',
          style: TextStyle(
              fontFamily: "Syncopate",
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ProjectColors.splash_background,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return NewPlanScreen();
            },
          ));
        },
        label: Row(
          children: [
            Text(
              "P",
              style: TextStyle(
                  fontFamily: "Syncopate", fontSize: 25, color: Colors.black),
            ),
            Icon(
              Icons.mode_edit_outline_outlined,
              color: Colors.black,
            ),
            Text(
              "an",
              style: TextStyle(
                  fontFamily: "Syncopate", fontSize: 25, color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: width * 0.22, right: width * 0.22),
              child: Text(
                textAlign: TextAlign.center,
                "\"Hold\" to Delete the plan And swipe \"Right / left\" to Edit the plan ",
                style: TextStyle(fontFamily: "Josefin Sans", fontSize: 12),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            StreamBuilder(
              stream: objectBox.getAllTodoListStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      TodoModel data = snapshot.data![index];
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return EditPlanScreen(
                                details: snapshot.data![index],
                              );
                            },
                          ));
                        },
                        onLongPress: () {
                          HapticFeedback.vibrate();
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user mu
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 237, 225),
                                shadowColor: Colors.amberAccent,
                                title: Text(
                                  snapshot.data![index].title.toUpperCase(),
                                  style: TextStyle(fontFamily: "Josefin Sans"),
                                ),
                                content: Text(
                                  "Confirm if you want to delete permenently.",
                                  style: TextStyle(fontFamily: "Josefin Sans"),
                                ),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.045,
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Color.fromARGB(
                                              255, 219, 219, 219),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "cancel",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontFamily: "Josefin Sans"),
                                        )),
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      bool status = objectBox.deleteThePlan(
                                          snapshot.data![index].id as int);
                                      HapticFeedback.vibrate();
                                      var snackbar = SnackBar(
                                          backgroundColor:
                                              ProjectColors.splash_background,
                                          duration: Duration(seconds: 3),
                                          content: Text(
                                            status
                                                ? "Plan is deleted"
                                                : "Error",
                                            style: TextStyle(
                                                fontFamily: "Josefin Sans",
                                                color: Colors.black),
                                          ));
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    },
                                    child: Container(
                                      height: height * 0.045,
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.red,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.delete_simple,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              top: height * 0.02),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 209, 209, 209),
                                    offset: Offset(0, 1.5),
                                    spreadRadius: 1,
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 4)
                              ]),
                          child: ListTile(
                            title: Container(
                              padding: EdgeInsets.only(top: height * 0.01),
                              child: Text(
                                data.title.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "Josefin Sans", fontSize: 18),
                              ),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: height * 0.02),
                              padding: EdgeInsets.only(bottom: height * 0.01),
                              child: Text(
                                maxLines: 2,
                                data.body,
                                style: TextStyle(fontFamily: "Josefin Sans"),
                              ),
                            ),
                            trailing: Text(
                              data.date,
                              style: TextStyle(
                                fontFamily: "Josefin Sans",
                                color: Color.fromARGB(255, 193, 156, 9),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: Text(
                      "Seem's You have no upcoming plans",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
