import 'dart:async';

import 'package:masjid_tv/models/prayer_time_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tablePrayerTime = 'prayer_times';
final String columnDate = 'date';
final String columnImsak = 'imsak';
final String columnSubuh = 'subuh';
final String columnTerbit = 'terbit';
final String columnDhuha = 'dhuha';
final String columnDzuhur = 'dzuhur';
final String columnAshar = 'ashar';
final String columnMaghrib = 'maghrib';
final String columnIsya = 'isya';

class DBProvider {
	DBProvider._();
	
	static final DBProvider db = DBProvider._();
	
	Database _database;
	
	Future<Database> get database async {
		if (_database != null) return _database;
		
		_database = await initDb();
		return _database;
	}
	
	initDb() async {
		var _databasesPath = await getDatabasesPath();
		String path = join(_databasesPath, "my.db");
		return await openDatabase(path, version: 1, onCreate: populateDb);
	}
	
	void populateDb(Database database, int version) async {
		await database.execute(
			'''
				CREATE TABLE $tablePrayerTime(
					$columnDate STRING PRIMARY KEY ON CONFLICT REPLACE,
					$columnImsak STRING,
					$columnSubuh STRING,
					$columnTerbit STRING,
					$columnDhuha STRING,
					$columnDzuhur STRING,
					$columnAshar STRING,
					$columnMaghrib STRING,
					$columnIsya STRING
				)
			'''
		);
	}
	
	selectPrayerTime() async {
		final db = await database;
		var _result = await db.query(tablePrayerTime);
		
		List<PrayerTime> _list = _result.isNotEmpty
			? _result.map((c) => PrayerTime.fromJson(c)).toList() : [];
		
		return _list;
	}
	
	insertPrayerTime(PrayerTime prayerTime) async {
		final db = await database;
		await db.insert(tablePrayerTime, prayerTime.toMap());
	}
}