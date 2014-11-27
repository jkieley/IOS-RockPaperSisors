//
//  DatabaseService.swift
//  Homework1
//
//  Created by Kieley, James P on 11/25/14.
//  Copyright (c) 2014 Kieley, James P. All rights reserved.
//

import Foundation
import Squeal

public class DatabaseService{
    
    
    public func createUserTable(){
        let db = getDb()
        db.createTable("users",
            definitions:[
                "user_id INTEGER PRIMARY KEY",
                "username TEXT",
                "sex TEXT",
                "age INTEGER",
                "wins INTEGER",
                "looses INTEGER",
                "ties INTEGER",
                "UNIQUE(username)"
            ])
    }
    
    public func createUser(user: User){
        let db = getDb();
        
        var error: NSError?
        if let rowId = db.insertInto("users", values:[
            
            "username":user.username,
            "sex":user.sex,
            "age":user.age,
            "wins":user.wins,
            "looses":user.looses,
            "ties":user.ties
            
            ], error:&error) {
                // success
        } else {
            // failure
            if(error?.code == 19){ // code 19 is a contraint violation, our only constrait is a unquie username, so this means DUPLICATE USER
                // if they already exist, update them!
                updateUser(user);
            }
        }
    }
    
    public func updateUser(user: User){
        var db = getDb();
        var error: NSError?
        if let updateCount = db.update("users",
            set:[
                "sex":user.sex,
                "age":user.age,
                "wins":user.wins,
                "looses":user.looses,
                "ties":user.ties
            ],
            whereExpr: "username = ?",
            parameters:[user.username],
            error:&error) {
        } else {
            // handle error
        }
    }
    
    private func getDb() -> Database {
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true) as? [String]
        var documentsDirectory = dirs![0]
        let db = Database(path:documentsDirectory.stringByAppendingPathComponent("/data.db"))!
        return db
    }
    
    
}