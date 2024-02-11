import 'package:flutter/material.dart';

void main() {
  // runApp(GestureWidget());
  // runApp(ListWidget());
  runApp(DynamicListWidget());
}

class GestureWidget extends StatelessWidget {
  const GestureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                print('On Tap Happened!');
              },
              onDoubleTap: () {
                print('On DoubleTap Happened!');
              },
              onLongPress: () {
                print('On LongPressed Happened!');
              },
              child: Container(
                height: 150,
                width: 150,
                color: Colors.redAccent,
                child: Text('My Container'),
              ),
            ),
            SizedBox(height: 50),
            InkWell(
              onLongPress: () {
                print('On LongPressed Happened!');
              },
              splashColor: Colors.amber,
              radius: 50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Click Me!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class ListWidget extends StatelessWidget {
//   ListWidget({super.key});
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> sampleNames = [
//       'Alice', 'Bob', 'Charlie', 'Diana', 'Evan',
//       'Fiona', 'George', 'Hannah', 'Ian', 'Jenna',
//       'Kyle', 'Luna', 'Mike', 'Nora', 'Oliver'
//     ];
//
//     List<Student> students = List.generate(sampleNames.length, (index) {
//       return Student(name: sampleNames[index], roll: index + 1);
//     });
//
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: true,
//       home: SafeArea(
//         child: Scaffold(
//           body: ListView(
//             children: [
//               ListTile(
//                 onTap: () {
//                   print('On tap student!');
//                 },
//                 leading: Icon(Icons.abc),
//                 title: Text('Student Name: ${studentNames[0]}'),
//                 subtitle: Text('Student Roll: 42'),
//                 style: ListTileStyle.list,
//               ),
//               ListTile(
//                 onTap: () {
//                   print('On tap student!');
//                 },
//                 leading: Icon(Icons.abc),
//                 title: Text('Student Name: ${studentNames[1]}'),
//                 subtitle: Text('Student Roll: 43'),
//                 style: ListTileStyle.list,
//               ),
//               ListTile(
//                 onTap: () {
//                   print('On tap student!');
//                 },
//                 leading: Icon(Icons.abc),
//                 title: Text('Student Name: ${studentNames[2]}'),
//                 subtitle: Text('Student Roll: 32'),
//                 style: ListTileStyle.list,
//               ),
//               ListTile(
//                 onTap: () {
//                   print('On tap student!');
//                 },
//                 leading: Icon(Icons.abc),
//                 title: Text('Student Name: ${studentNames[3]}'),
//                 subtitle: Text('Student Roll: 67'),
//                 style: ListTileStyle.list,
//               ),
//               ListTile(
//                 onTap: () {
//                   print('On tap student!');
//                 },
//                 leading: Icon(Icons.abc),
//                 title: Text('Student Name: ${studentNames[4]}'),
//                 subtitle: Text('Student Roll: 72'),
//                 style: ListTileStyle.list,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class DynamicListWidget extends StatelessWidget {
  DynamicListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> sampleNames = [
      'Alice',
      'Bob',
      'Charlie',
      'Diana',
      'Evan',
      'Fiona',
      'George',
      'Hannah',
      'Ian',
      'Jenna',
      'Kyle',
      'Luna',
      'Mike',
      'Nora',
      'Oliver'
    ];

    List<Student> students = List.generate(sampleNames.length, (index) {
      return Student(name: sampleNames[index], roll: index + 1);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: SafeArea(
        child: Scaffold(
          body: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Student: ${students[index].name} & Roll: ${students[index].roll}'),
                    ));
                  },
                  leading: Icon(Icons.abc),
                  title: Text('Student Name: ${students[index].name}'),
                  subtitle: Text('Student Roll: ${students[index].roll}'),
                  style: ListTileStyle.list,
                );
              }),
        ),
      ),
    );
  }
}

class Student {
  String name;
  int roll;

  Student({required this.name, required this.roll});
}
