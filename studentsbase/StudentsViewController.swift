//
//  StudentsViewController.swift
//  studentsbase
//
//  Created by tiger on 16.05.2019.
//  Copyright © 2019 homework. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    var allData = [Student]()
    
    //задаем заголовок таблицы
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Список студентов"
    }
    
    //задаем кол-во строк в таблице вычисляя кол-во элементов в массиве allData
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allData.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell!
        
        // set the text from the data model
        //let fullName = self.allData[indexPath.row].name + " " + self.allData[indexPath.row].soname
        let fullName = self.allData[indexPath.row].fullName
        
        let score = String(self.allData[indexPath.row].score)
        
        cell.textLabel?.text = "\(fullName!)"
        cell.detailTextLabel?.text = "\(score)"
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)//главный сториборд
        
        let EditStudentViewController = mainStoryboard.instantiateViewController(withIdentifier: "EditStudentViewController")//View в который нужен переход
        // ну и сам переход во view собственно
        self.navigationController?.pushViewController(EditStudentViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        //tableView.delegate = self
        //tableView.dataSource = self
        
        
        //массив из объектов типа Student
        allData += [
            Student(name: "Иван", soname: "Иванов", score: "5.0"),
            Student(name: "Петя", soname: "Петров", score: "4.5"),
            Student(name: "Сидор", soname: "Сидоров", score: "4.2"),
            Student(name: "Прохор", soname: "Семенов", score: "4.0"),
            Student(name: "Алина", soname: "Синичкина", score: "5.0")]
        
        //выводим для себя
        for student in allData {
            print("Student: \(student.fullName!) \(student.score!)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //var student = modelController.student
        //studentNameTitle.text = student.name
        //studentScore.text = String(student.score)
        //for (name, soname, score) in allData {
            //print("\(name): \(soname): \(score)")
        }
        
}
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if let editViewController = segue.destination as? EditViewController {
    //        editViewController.modelController = modelController
    //    }
    //}

