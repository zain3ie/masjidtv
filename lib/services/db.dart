import 'dart:async';

import 'package:intl/intl.dart';
import 'package:masjid_tv/models/ptime_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String _tablePrayerTime = 'prayer_times';
final String _columnDate = 'date';
final String _columnLocationId = 'location_id';
final String _columnImsak = 'imsak';
final String _columnSubuh = 'subuh';
final String _columnTerbit = 'terbit';
final String _columnDhuha = 'dhuha';
final String _columnDzuhur = 'dzuhur';
final String _columnAshar = 'ashar';
final String _columnMaghrib = 'maghrib';
final String _columnIsya = 'isya';

class DBProvider {
	DBProvider._();
	
	static final DBProvider db = DBProvider._();
	
	Database _database;
	
	Future<Database> get database async {
		if (_database != null) return _database;
		
		_database = await _initDb();
		return _database;
	}
	
	_initDb() async {
		var _databasesPath = await getDatabasesPath();
		String _path = join(_databasesPath, "my.db");
		return await openDatabase(_path, version: 1, onCreate: _populateDb);
	}
	
	void _populateDb(Database database, int version) async {
		await database.execute(
			'''
				CREATE TABLE $_tablePrayerTime(
					$_columnLocationId INTEGER,
					$_columnDate STRING,
					$_columnImsak STRING,
					$_columnSubuh STRING,
					$_columnTerbit STRING,
					$_columnDhuha STRING,
					$_columnDzuhur STRING,
					$_columnAshar STRING,
					$_columnMaghrib STRING,
					$_columnIsya STRING,
					PRIMARY KEY ( $_columnLocationId, $_columnDate) ON CONFLICT REPLACE
				)
			'''
		);
	}
	
	insertPrayerTime(PTime prayerTime) async {
		final Database _db = await database;
		await _db.insert(_tablePrayerTime, prayerTime.toMap());
	}
	
	selectPrayerTime() async {
		final Database _db = await database;
		final SharedPreferences _prefs = await SharedPreferences.getInstance();
		final int _locationId = _prefs.getInt('location_id');
		final String _date = DateFormat('MM-dd').format(DateTime.now());
		
		var _result = await _db.query(_tablePrayerTime,
			where: '$_columnLocationId = ? AND $_columnDate = ?',
			whereArgs: [_locationId, _date]
		);
		
		PTime prayerTime = _result.isNotEmpty
			? PTime.fromMap(_result.first) : new PTime();
		
		return prayerTime;
	}
	
	selectLatestPrayerTime() async {
		final Database _db = await database;
		final SharedPreferences _prefs = await SharedPreferences.getInstance();
		final int _locationId = _prefs.getInt('location_id');
		
		var _result = await _db.query(_tablePrayerTime,
			orderBy: '$_columnDate DESC',
			where: '$_columnLocationId = ?',
			whereArgs: [_locationId],
			limit: 1
		);
		
		PTime prayerTime = _result.isNotEmpty
			? PTime.fromMap(_result.first) : new PTime();
		
		return prayerTime;
	}
}
