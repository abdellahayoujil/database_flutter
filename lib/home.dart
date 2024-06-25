import 'package:flutter/material.dart';
import 'basedonnee.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  basedonnee database = basedonnee();
  TextEditingController txtnom = TextEditingController();
  TextEditingController idarticle = TextEditingController();
  TextEditingController txtprix = TextEditingController();
  TextEditingController txtqte = TextEditingController();
  final TextEditingController txtdate = TextEditingController();
  late List<Map> lsArticle = [];
  final List<String> items = List<String>.generate(10000, (i) => '$i');
  // getCurrentDate() {
  //   return DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now());
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chargerList();
  }

  chargerList() async {
    List<Map> ls = await database.getAllArticle("SELECT * FROM ARTICLE");
    setState(() {
      lsArticle = ls;
    });
  }
  void _clearTextField() {
    txtnom.clear();
    idarticle.clear();
    txtprix.clear();
    txtqte.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gestion de STocK' , style: TextStyle(fontSize: 30),),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: idarticle,
                    cursorColor: Colors.lightGreen,
                  decoration: InputDecoration(
                      label: Text("Id article"),
                    labelStyle: TextStyle(color: Color(0xFF579FAF)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF579FAF), width: 4.0),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF579FAF), width: 2.0),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  )),
                SizedBox(
                  height: 13,
                ),
                TextField(
                  controller: txtnom,
                    cursorColor: Colors.lightGreen,
                  decoration: InputDecoration(
                      label: Text("Nom de l'article"),
                    labelStyle: TextStyle(color: Color(0xFF579FAF)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF579FAF), width: 4.0),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF579FAF), width: 2.0),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      )
                ),
                SizedBox(
                  height: 13,
                ),
                TextField(
                  controller: txtprix,
                    cursorColor: Colors.lightGreen,
                    decoration: InputDecoration(
                      label: Text("Prix de l'article en dirhams"),
                    labelStyle: TextStyle(color: Color(0xFF579FAF)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF579FAF), width: 4.0),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF579FAF), width: 2.0),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  )),
                SizedBox(
                  height: 13,
                ),
                TextField(
                  controller: txtqte,
                    cursorColor: Colors.lightGreen,
                    decoration: InputDecoration(
                      label: Text("Quantité de l'article"),
                    labelStyle: TextStyle(color: Color(0xFF579FAF)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF579FAF), width: 4.0),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF579FAF), width: 2.0),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  )),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            shadowColor: Color.fromARGB(255, 64, 114, 206)),
                        onPressed: () async {
                          int resultat = await database.ajouterData(
                              "insert into article(nom,qte,prix) values('${txtnom.text}',${int.parse(txtqte.text)},${int.parse(txtprix.text)})");
                          print("insert $resultat ligne");
                          chargerList();
                          _clearTextField();
                        },
                        child: Text("Ajouter")),
                    SizedBox(width: 16),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            shadowColor: Color.fromARGB(255, 64, 114, 206)),
                        onPressed: () async {
                          int resultat = await database.SupprimerData(
                              "delete from article where id=${int.parse(idarticle.text)}");
                          chargerList();
                          _clearTextField();
                        },
                        child: Text("Supprimer")),
                    SizedBox(width: 16),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            shadowColor: Color.fromARGB(255, 64, 114, 206)),
                        onPressed: () async {
                          int resultat = await database.ModifierData(
                              "update article set nom='${txtnom.text}',"
                                  "prix=${int.parse(txtprix.text)},"
                                  "qte=${int.parse(txtqte.text)} where id=${int.parse(idarticle.text)}");
                          chargerList();
                          _clearTextField();
                        },
                        child: Text("Modifier")),
                  ],
                ),
                Container(
                  child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: lsArticle.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.teal, width: 2),
                          ),
                          margin: EdgeInsets.only(right: 10, top: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                              Colors.teal,
                              child: Text(items[index]),
                            ),
                            title: Text(
                                "Nom : ${lsArticle[index]['nom']} | ${lsArticle[index]['id']}",
                              style: TextStyle(
                                fontSize: 17.0, // Change this size as needed
                                color: Colors.black,
                              ),),
                            subtitle: Text(
                                "Prix : ${lsArticle[index]['prix'].toString() + "DH"}",
                              style: TextStyle(
                                fontSize: 17.0, // Change this size as needed
                                color: Colors.black,
                              ),),
                            trailing: Text(
                                "Q: ${lsArticle[index]['qte'].toString()}",
                              style: TextStyle(
                              fontSize: 20.0, // Change this size as needed
                              color: Colors.black,
                            ),
                            )

                            /*geticon(
                                int.parse(lsArticle[index]['prix'].toString())*/)

                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }

  Icon geticon(int prix) {
    if (prix > 100)
      return Icon(Icons.ac_unit);
    else
      return Icon(Icons.ad_units_rounded);
  }
}
