//
//  DBConfig.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import Foundation

///
///  ENTRIES TABLE STATEMENTS
///
let ENTRIES_TABLE_NAME = "ENTRIES";
let ENTRIES_TABLE_CREATE = "CREATE TABLE IF NOT EXISTS ENTRIES"
	+ " (ENTRY_ID INTEGER PRIMARY KEY,"
	+ " DATE_TIME TEXT, SKILL TEXT, DESCRIPTION TEXT,"
	+ " LOCATION_LAT REAL, LOCATION_LON REAL);";
let ENTRIES_INSERT = "INSERT INTO ENTRIES"
	+ " (ENTRY_ID,DATE_TIME,SKILL,DESCRIPTION,LOCATION_LAT,LOCATION_LON)"
	+ " VALUES(NULL, ?, ?, ?, ?, ?);";
let ENTRIES_SELECT = "SELECT"
	+ " ENTRY_ID,DATE_TIME,SKILL,DESCRIPTION,LOCATION_LAT,LOCATION_LON"
	+ " FROM ENTRIES ORDER BY ENTRY_ID;"

let ENTRY_UPDATE = "UPDATE ENTRIES"
	+ " SET DESCRIPTION = (?) WHERE ENTRY_ID = (?)"

let ENTRY_WITH_ID_SELECT = "SELECT"
	+ " ENTRY_ID,DATE_TIME,SKILL,DESCRIPTION,LOCATION_LAT,LOCATION_LON"
	+ " FROM ENTRIES WHERE ENTRY_ID = (?);"
