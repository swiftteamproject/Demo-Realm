//
//  RealmService.swift
//  test
//
//  Created by Анна Чаховская on 02/06/2019.
//  Copyright © 2019 Анна Чаховская. All rights reserved.
//

import Foundation
import RealmSwift


class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    public var realm = try! Realm()
    
    // save to database
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update<T: Object>(_ object: T) {
        do {
            try realm.write ({
                realm.add(object, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // delete object in database
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
