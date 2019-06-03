//
//  Model.swift
//  test
//
//  Created by Анна Чаховская on 02/06/2019.
//  Copyright © 2019 Анна Чаховская. All rights reserved.
//

import RealmSwift

class Sections: Object {
    @objc dynamic var name = ""
    let rows = List<Rows>()
}

class Rows: Object {
    @objc dynamic var name = ""
    @objc dynamic var secondName = ""
    
}

