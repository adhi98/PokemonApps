//
//  DBHelper.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 26/01/22.
//

import Foundation
import SQLite3

class DBHelper {
    var db : OpaquePointer?
    var path : String = "myDb.sqlite"
    
    init(){
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
        
        var db : OpaquePointer? = nil
        
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            print("there is error in creating DB")
            return nil
        }else {
            return db
        }
    }
    
    func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS item(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, nickname TEXT);"
        var statement : OpaquePointer? = nil

        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                
            }else {
                print("Table Creating Fail")
            }
        } else {
            print("preparation Fail")
        }
    }
    
    func insert(name: String, nickname: String){
        let query = "INSERT INTO item (name,nickname) VALUES (?,?);"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK{
            sqlite3_bind_text(statement, 1,(name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2,(nickname as NSString).utf8String, -1, nil)
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Data inserted successfully")
            }else {
                print("Data is not inserted in table")
            }
        }else {
            print("query is not as per requirement")
        }
    }
    
    func read() -> [ItemModel]{
        let query = "SELECT * FROM item;"
        var statement: OpaquePointer? = nil
        var mainList = [ItemModel]()
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK{
            
            while(sqlite3_step(statement) == SQLITE_ROW){
                let id = sqlite3_column_int(statement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                let nickname = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                
                let itemModel = ItemModel(id: Int(id), name: name, nickname: nickname)
                mainList.append(itemModel)
            }
            print("success read in Database")
            
        }else {
            print("query is not as per requirement")
        }
        return mainList
    }
    
    func delete(id: Int){
        let query = "DELETE FROM item where id = \(id);"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE{
                print("success delete data in Database")
            }else {
                print("failed delete data in Database")
            }
        
        }else {
            print("query is not as per requirement")
        }
    }
    
    func update(id: Int, name: String){
        let query = "UPDATE item SET name = '\(name)' WHERE id = \(id);"
        var statement: OpaquePointer? =  nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                print("success update data")
            }else {
                print("failed update data")
            }
        }else {
            print("query is not as per requirement")
        }
        
    }
    
}
