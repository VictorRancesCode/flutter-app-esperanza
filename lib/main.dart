import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_esperanza/Person.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new clsMain(),
  ));
}

final List<Person> list_person = new List<Person>();

class PersonItem extends StatelessWidget {
  PersonItem({Key key, @required this.person})
      : assert(person != null && person.isValid),
        super(key: key);
  static final height = 390.0;
  final Person person;

  Color getColor() {
    if (person.type_publication == "missing") {
      return Colors.redAccent;
    }
    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(5.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0),
                color: getColor(),
              ),
              child: new Center(
                child: new Text(
                  person.type_publication.toUpperCase(),
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              margin: const EdgeInsets.only(top:0.0),
            ),
            new Image.network(person.photo, fit: BoxFit.cover),
            new Expanded(
              child: new Container(
                padding: const EdgeInsets.all(5.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      person.first_name + " " + person.last_name,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    new Text("Place: " + person.place),
                    new Text("Date: " + person.date),
                    new Text("Age: " + person.age.toString()),
                    new Text("Gender: " + person.gender.toString())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const jsonCodec = const JsonCodec();

class clsMain extends StatefulWidget {
  @override
  clsMainList createState() => new clsMainList();
}

class clsMainList extends State<clsMain> {
  List<Map> datos;

  Future<String> getData() async {
    var url = "http://0.0.0.0:8000/api/persons/"; //Domain or Ip localhost
    var httpClient = createHttpClient();
    var response = await httpClient.get(url, headers: {
      "Accept": "application/json",
    });
    this.setState(() {
      datos = JSON.decode(response.body);
    });
    for (var i = 0; i < datos.length; i++) {
      Map dat = datos[i];
      int id = dat['id'];
      String email = dat['email'];
      String first_name = dat['first_name'];
      String last_name = dat['last_name'];
      String nickname = dat['nickname'];
      String place = dat['place'];
      String date = dat['date'];
      String photo = dat['photo'];
      String comment_photo = dat['comment_photo'];
      int age = dat['age'];
      String gender = dat['gender'];
      String detail = dat['detail'];
      String type_publication = dat['type_publication'];
      list_person.add(new Person(
          id,
          email,
          first_name,
          last_name,
          nickname,
          place,
          date,
          photo,
          comment_photo,
          age,
          gender,
          detail,
          type_publication));
    }

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: const Text('Victor Rances'),
            accountEmail: const Text('victordevcode@gmail.com'),
            currentAccountPicture: const CircleAvatar(
                backgroundImage: const AssetImage('img/perfil.jpg')),
            onDetailsPressed: () {},
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('img/header.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.person),
            title: new Text('CodigoPanda'),
            onTap: () {},
          ),
          new Divider(),
          new ListTile(
            leading: const Icon(Icons.account_circle),
            title: new Text('About'),
            onTap: () {},
          ),
          new ListTile(
            leading: const Icon(Icons.settings_power),
            title: new Text('exit'),
            onTap: () {},
          ),
        ],
      )),
      appBar: new AppBar(
          title: new Text("Flutter App Esperanza"),
          backgroundColor: Colors.green),
      body: new RefreshIndicator(
        child: new GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.53,
            ),
            itemCount: list_person == null ? 0 : list_person.length,
            padding: const EdgeInsets.only(
                top: 2.0, left: 2.0, right: 2.0, bottom: 2.0),
            itemBuilder: _itemBuilder),
        onRefresh: _onRefresh,
      ),
    );
  }

  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();
    Timer timer = new Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    Person todo = list_person[index];
    return new PersonItem(person: todo);
  }
}
