//
//  ModelController.swift
//  studentsbase
//
//  Created by tiger on 16.05.2019.
//  Copyright © 2019 homework. All rights reserved.
//

import Foundation

class ModelController {
    var student = Student()
    
    var studentDictFromFile = NSDictionary()
    
    var studentsDict: [String: String] = ["Иван Иванов": "5.0", "Петя Петров": "4.2", "Федор Жиглов": "3.2"]
    
    
    //var studentDict = ["name": ["Иван Иванов", "Сидор Петров", "Федя Углов"],
    //                   "score": ["4.5", "5.0", "3.3"]]
    
    //init (){
    //}
    
    func loadStudentsDictFromFile() -> String {
        let path = Bundle.main.path(forResource: "students", ofType: "plist")
        print("path: \(String(describing: path))")
        if let path = path {
            studentDictFromFile = (NSDictionary(contentsOfFile: path))!
            return "Словарь успешно загружен!"
        }
        else {
            return "Не удалось загрузить словарь!"
        }
    }
    
    func fillStudent() {
        for (name, score) in studentsDict {
            print("\(name): \(score)")
        }
        
    }
}
