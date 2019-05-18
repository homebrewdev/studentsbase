//
//  EditViewController.swift
//  studentsbase
//
//  Created by tiger on 16.05.2019.
//  Copyright © 2019 homework. All rights reserved.
//

import UIKit

class EditStudentViewController: UIViewController {
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textScore: UITextField!
    
    //var modelController: ModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let student = modelController.student
        //textName.text = student.name
        //textScore.text = String(student.score!)
    }
    
    @IBAction func saveNewStudent(_ sender: Any) {
        // проверка на корректность данных
        //let newStudent = Student(name: textName.text!, score: Float(textScore.text!)
        //let newStudent = Student()
        //modelController.student = newStudent
        //dismiss(animated: true, completion: nil)
        //print("Student name: \(newStudent.name ?? <#default value#>)\n")
        //print("Student score: \(newStudent.score)")
    }
    
}
