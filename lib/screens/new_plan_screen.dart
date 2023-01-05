import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_app/screens/main_screen.dart';
import '../main.dart';
import '../models/todo_model.dart';
import '../utils/projectColors.dart';

class NewPlanScreen extends StatefulWidget {
  const NewPlanScreen({Key? key}) : super(key: key);

  @override
  State<NewPlanScreen> createState() => _NewPlanScreenState();
}

class _NewPlanScreenState extends State<NewPlanScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool date = false;
  String? selectedDate;
  bool createNewPlan() {
    TodoModel details = TodoModel.autoId(
        title: titleController.text,
        body: bodyController.text,
        date:
            date ? selectedDate! : DateTime.now().toString().substring(0, 10));

    objectBox.insertTodoModel(details);
    Navigator.of(context).pop();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 237, 225),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 20,
            )),
        actions: [
          IconButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shadowColor: Colors.amberAccent,
                      backgroundColor: ProjectColors.main_screen_bgc_color,
                      title: const Text(
                        'Select Date',
                        style: TextStyle(fontFamily: "Josefin Sans"),
                      ),
                      content: Container(
                        height: height * 0.5,
                        // margin: EdgeInsets.only(
                        //     top: height * 0.1, bottom: height * 0.1),
                        child: SfDateRangePicker(
                          view: DateRangePickerView.month,

                          allowViewNavigation: true,
                          headerHeight: 50,
                          navigationMode: DateRangePickerNavigationMode.snap,
                          selectionColor: Colors.yellow,
                          selectionMode: DateRangePickerSelectionMode.single,
                          selectionRadius: 10,
                          selectionShape: DateRangePickerSelectionShape.circle,
                          // showActionButtons: true,
                          selectionTextStyle:
                              TextStyle(fontStyle: FontStyle.italic),
                          headerStyle: DateRangePickerHeaderStyle(
                              backgroundColor:
                                  ProjectColors.main_screen_bgc_color,
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Josefin Sans",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                          backgroundColor: ProjectColors.main_screen_bgc_color,
                          // showActionButtons: true,
                          showNavigationArrow: true,
                          todayHighlightColor: Colors.black,
                          showTodayButton: true,
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs args) {
                            if (args.value is DateTime) {
                              setState(() {
                                selectedDate =
                                    args.value.toString().substring(0, 10);
                                date = true;
                                print(selectedDate);
                              });
                              Navigator.pop(context);
                            }
                          },
                          onCancel: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                CupertinoIcons.calendar_badge_plus,
                color: Colors.black,
              ))
        ],
        backgroundColor: ProjectColors.splash_background,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        centerTitle: true,
        title: const Text(
          'New Todo',
          style: TextStyle(
              fontFamily: "Syncopate",
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ProjectColors.splash_background,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var status = createNewPlan();
            HapticFeedback.vibrate();
            var snackbar = SnackBar(
                backgroundColor: ProjectColors.splash_background,
                duration: Duration(seconds: 3),
                content: Text(
                  status ? "Plan is Added" : "Error",
                  style: TextStyle(
                      fontFamily: "Josefin Sans", color: Colors.black),
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        label: Row(
          children: [
            Text(
              "GO",
              style: TextStyle(
                  fontFamily: "Syncopate", fontSize: 25, color: Colors.black),
            ),
            Icon(
              Icons.mode_edit_outline_outlined,
              color: Colors.black,
            ),
            // Text(
            //   "Go",
            //   style: TextStyle(
            //       fontFamily: "Pacifico", fontSize: 25, color: Colors.black),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Container(
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Color.fromARGB(255, 249, 249, 168),
                    //       offset: Offset(0, 2),
                    //       spreadRadius: 0.1,
                    //       blurRadius: 1)
                    // ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextFormField(
                    maxLength: 100,
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You Must decide the Title";
                      }
                      return null;
                    },
                    cursorColor: ProjectColors.main_screen_bgc_color,
                    cursorHeight: 20,
                    autofocus: true,
                    style: TextStyle(
                        fontFamily: "Josefin Sans",
                        color: Colors.black,
                        fontSize: 20),
                    decoration: InputDecoration(
                      counterStyle: TextStyle(
                          fontFamily: "Josefin Sans", color: Colors.black),
                      hintStyle: TextStyle(
                          fontFamily: "Josefin Sans", color: Colors.black),
                      semanticCounterText: selectedDate,
                      filled: true,
                      fillColor: ProjectColors.splash_background,
                      hintText: "Title",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            width: 2,
                            color: ProjectColors.splash_background,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  style: TextStyle(
                      fontFamily: "Josefin Sans",
                      color: Colors.black,
                      fontSize: 18),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 400,
                  controller: bodyController,
                  decoration: InputDecoration(
                    counterStyle: TextStyle(
                        fontFamily: "Josefin Sans", color: Colors.black),
                    hintText: "Description",
                    hintStyle: TextStyle(
                        fontFamily: "Josefin Sans", color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          width: 2,
                          color: ProjectColors.splash_background,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 1, color: Colors.grey)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 1, color: Colors.red)),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                selectedDate != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Date:  ${selectedDate.toString()}",
                              style: TextStyle(
                                  fontFamily: "Josefin Sans",
                                  color: Colors.black,
                                  fontSize: 20)),
                        ],
                      )
                    : Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
