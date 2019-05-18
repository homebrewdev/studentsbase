//
//  student.swift
//  studentsbase
//
//  Created by tiger on 16.05.2019.
//  Copyright © 2019 homework. All rights reserved.
//

import Foundation

// класс Студент
// поля:
//      name    - имя студента
//      soname  - фамилия
//      score   - средний балл
class Student {
    var name: String!
    var soname: String!
    var fullName: String!
    var score: String!
    
// конструктор
    convenience init(name: String, soname: String, score: String)
    {
        self.init()
        
        self.name       = name
        self.soname     = soname
        self.fullName   = soname + " " + name
        self.score      = score
    }
}
