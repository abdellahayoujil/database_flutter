import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class basedonnee {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDatabase();
      return _db;
    } else
      return _db;
  }

  initialDatabase() async {
    String cheminBase = await getDatabasesPath();
    String nomBase = join(cheminBase, "MyBase.db");
    Database db1 = await openDatabase(nomBase,
        onCreate: _createDatabase, version: 1, onUpgrade: _EditDatabase);
    return db1;
  }

  _createDatabase(Database db, int version) {
    db.execute(
        "CREATE TABLE article (id INTEGER PRIMARY KEY AUTOINCREMENT,nom TEXT,qte INTEGER,prix INTEGER)");
    print("data base cree");
  }

  _EditDatabase(Database db, int oldvesion, int newversion) {
    db.execute("DROP TABLE article");
    _createDatabase(db, newversion);
    print("data base Modifier");
  }

  ajouterData(String requtte) async {
    Database? data = await db;
    int cpt = await data!.rawInsert(requtte);
    print("data Inserer");
    return cpt;
  }

  ModifierData(String requtte) async {
    Database? data = await db;
    int cpt = await data!.rawUpdate(requtte);
    print("data Modifier");
    return cpt;
  }

  SupprimerData(String requtte) async {
    Database? data = await db;
    int cpt = await data!.rawDelete(requtte);
    print("data supprimer");
    return cpt;
  }

  Future<List<Map>> getAllArticle(String requtte) async {
    Database? data = await db;
    List<Map> ls = await data!.rawQuery(requtte);
    return ls;
    // return List.generate(ls.length, (index) {
    //   return Artcile(ls[index]['nom'], ls[index]['prix'], ls[index]['qte']);
    // });
  }
}
