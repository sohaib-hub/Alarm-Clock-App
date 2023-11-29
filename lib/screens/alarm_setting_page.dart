import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmSetting extends StatefulWidget {
  const AlarmSetting({Key? key}) : super(key: key);

  @override
  State<AlarmSetting> createState() => _AlarmSettingState();
}
class _AlarmSettingState extends State<AlarmSetting> {
  final db = FirebaseDatabase.instance.ref("_alarms").child('alarms');
  TimeOfDay time = TimeOfDay.now();
  final title = TextEditingController();
  var alarm;

  selectTime() async {
    var picked_alarm_time = await showTimePicker(
        context: context, initialTime: time);
    if (picked_alarm_time != null && picked_alarm_time != time) {
      setState(() {
        // firebasedatabase
        db.child(time.format(context).toString()).set({
          'title', title.text.toString(),
          'alarm_time', picked_alarm_time.toString(),
        });
      });
    }}
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  Colors.lightBlueAccent,
                  Colors.tealAccent,
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {},
                        child: Text('Edit',
                          style: TextStyle(fontSize: 22),)),
                    IconButton(onPressed: () {
                      selectTime();
                    },
                        icon: Icon(Icons.add, color: Colors.pink, size: 36,))
                  ],
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 2))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AlarmSetting(),));
                      },
                          child: Text('Alarms',
                            style: TextStyle(fontSize: 35),)),

                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      },
                          child: Text('Clock',
                            style: TextStyle(fontSize: 35,
                                color: Colors.white),))
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),

                Expanded(
                    child: FirebaseAnimatedList(query: db.child('alarm'),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot, animation, index) {
                          return ListTile(
                            title: Text(snapshot
                                .child('title')
                                .value
                                .toString()),
                            subtitle: Text(snapshot
                                .child('alarm_time')
                                .value
                                .toString()),
                            trailing: IconButton(
                              onPressed: (){
                                db.child('alarms').remove();
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        })
                ),


              ],
            ),
          ),
        ),

      );
    }}