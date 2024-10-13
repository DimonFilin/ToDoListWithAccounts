import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/edit_note.dart';

import '../model/notes_model.dart';

class Task_Widget extends StatefulWidget {
  Task_Widget(this._note, {super.key});

  Note _note;

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}

class _Task_WidgetState extends State<Task_Widget> {

  @override
  Widget build(BuildContext context) {
    String timeInStr = widget._note
      .getTimeRemaining(widget._note.timetodo);
    bool isDone = widget._note.isDone;
    double timelength;
    if(timeInStr.length< 4){timelength = timeInStr.length * 15+40;}
    else{timelength = timeInStr.length * 11+40;}
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 11, 5, 0),
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2)),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SizedBox(width: 20),
            //title and subtitle
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget._note.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(

                            // Цвет, когда чекбокс активен (отмечен)
                            activeColor: Colors.green,
                            // Цвет галочки внутри чекбокса, когда он активен
                            checkColor: Colors.white,
                            /*fillColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      // Цвет, когда чекбокс отключен
                                      return Colors.grey;
                                    }
                                    if (states.contains(MaterialState.selected)) {
                                      // Цвет, когда чекбокс активен (отмечен)
                                      return Colors.green;
                                    }
                                    // Цвет, когда чекбокс неактивен (не отмечен)
                                    return Colors.blue;
                                  },
                                ),*/
                            // Делаем форму чекбокса круглой
                            shape: CircleBorder(),
                            value: isDone,
                            onChanged: (value) {
                              setState(() {
                                isDone = !isDone;
                              });
                              FireStore_Database()
                                  .IsDone(widget._note.id, isDone);
                            },
                          ),
                        ),
                      ],
                    ),

                    Text(
                      widget._note.subtitle,
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade400),
                    ),
                    // Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(

                        children: [
                          Container(
                            width: timelength,
                            height: 25,
                            decoration: BoxDecoration(
                              color: timeInStr ==
                                      'Просрочено'
                                  ? Colors.red
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                             // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer_sharp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  timeInStr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 280 - timelength,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditNote_Screen(widget._note)));
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 29),
                                        Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
