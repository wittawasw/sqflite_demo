import 'dart:convert';
import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;

void main() async {
  const jsonFilePath = 'assets/tambons_tree.json';
  const dbFilePath = 'assets/tambons.db';

  // Read tambons.json file
  final jsonFile = File(jsonFilePath);
  if (!await jsonFile.exists()) {
    print('JSON file not found!');
    return;
  }

  // Parse JSON content
  final Map<String, dynamic> jsonData =
      json.decode(await jsonFile.readAsString());

  // Initialize the database
  final String dbPath = p.join(Directory.current.path, dbFilePath);
  final db = sqlite3.open(dbPath);

  // Create tables
  db.execute('''
    CREATE TABLE IF NOT EXISTS provinces (
      code TEXT PRIMARY KEY,
      name_th TEXT,
      name_en TEXT
    );
  ''');

  db.execute('''
    CREATE TABLE IF NOT EXISTS amphoes (
      code TEXT PRIMARY KEY,
      province_code TEXT,
      name_th TEXT,
      name_en TEXT,
      FOREIGN KEY(province_code) REFERENCES provinces(code)
    );
  ''');

  db.execute('''
    CREATE TABLE IF NOT EXISTS tambons (
      code TEXT PRIMARY KEY,
      amphoe_code TEXT,
      name_th TEXT,
      name_en TEXT,
      lat REAL,
      lng REAL,
      zipcode INTEGER,
      FOREIGN KEY(amphoe_code) REFERENCES amphoes(code)
    );
  ''');

  // Insert data
  insertData(db, jsonData);

  print('Database generated successfully at $dbPath');
  db.dispose();
}

void insertData(Database db, Map<String, dynamic> data) {
  for (var provinceCode in data.keys) {
    final province = data[provinceCode];

    // Insert into provinces table
    db.execute('''
      INSERT INTO provinces (code, name_th, name_en)
      VALUES (?, ?, ?)
    ''', [provinceCode, province['name']['th'], province['name']['en']]);

    final amphoes = province['amphoes'] as Map<String, dynamic>;
    for (var amphoeCode in amphoes.keys) {
      final amphoe = amphoes[amphoeCode];

      // Insert into amphoes table
      db.execute('''
        INSERT INTO amphoes (code, province_code, name_th, name_en)
        VALUES (?, ?, ?, ?)
      ''', [
        amphoeCode,
        provinceCode,
        amphoe['name']['th'],
        amphoe['name']['en']
      ]);

      final tambons = amphoe['tambons'] as Map<String, dynamic>;
      for (var tambonCode in tambons.keys) {
        final tambon = tambons[tambonCode];
        final coordinates = tambon['coordinates'];

        // Insert into tambons table
        db.execute('''
          INSERT INTO tambons (code, amphoe_code, name_th, name_en, lat, lng, zipcode)
          VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', [
          tambonCode,
          amphoeCode,
          tambon['name']['th'],
          tambon['name']['en'],
          coordinates?['lat'] != null
              ? double.tryParse(coordinates['lat'])
              : null,
          coordinates?['lng'] != null
              ? double.tryParse(coordinates['lng'])
              : null,
          tambon['zipcode']
        ]);
        print("Inserted: ${tambon['name']['th']}");
      }
    }
  }
}
