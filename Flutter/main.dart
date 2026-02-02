import 'package:/flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo'
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'List Example')
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Stare<MyHomePage> createState() => _MyHomePageState();
}

class data {
  late int id;
  late String name;
  late DataTime t;
  data(this.id, this.name, this.t);
}

class _MyHomePageState extends State<MyHomePage> {
  String txt = 'N/A';
  List<data> mylist = <data>[];
  int img = 0;
  var list = ['one', 'two', 'three', 'four'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(winget.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: img,
                onChanged: (int? value) {
                  setState(() {
                    img = 1;
                  });
                }),
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('asset/imagesif.png'),
              ),
            ],
          ),
          const Textfield(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                txt = 'Add item Success';
                mylist.add(data(img, '1', DataTime.now()));
              });
            },
            child: const Text('Add Item')),
          Text(
            txt,
            textScaleFactor: 2,
          ),
          SizeBox(
            width: double.infinity,
            height: 550,
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context,index) {
                return SizeBox(
                  width: double.infinity,
                  height: 80,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                    color:
                        Colors.primaries[index % Coloes.primaries.length],
                    child: ListTitle(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                          AssetImage('assets/imges/rocket.png'),
                      ),
                      title: Text('Title Text (${mylist[index].id})'),
                      subtitle: Text(mylist[index].t.toString()),
                      trailing: const Icon(Icons.delete_rounded),
                      onTap: () {
                        setState(() {
                          txt = "Title Text ($index) is remove";
                          mylist.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                }),
            )
          ]),
        ));
  }
}

