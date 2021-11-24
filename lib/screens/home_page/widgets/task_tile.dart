// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controllers/to_do_controller.dart';
import 'package:mobile/screens/to_do_page/to_do_page.dart';

import 'package:mobile/utils/themes.dart';

class TaskTile extends StatelessWidget {
  ToDoController toDoController = Get.find();
  final int index;
  TaskTile(this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ToDoPage(
              index: index,
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 12),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: bluishClr,
          ),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toDoController.todos[index].title ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(height: 12),
                  Text(
                    toDoController.todos[index].note ?? "",
                    style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Row(
                children: [
                  Text(
                    toDoController.todos[index].done == true
                        ? "CONCLUIDA"
                        : "A FAZER",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Checkbox(
                      value: toDoController.todos[index].done,
                      onChanged: (value) {
                        var changed = toDoController.todos[index];
                        changed.done = value!;
                        toDoController.todos[index] = changed;
                      })
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
