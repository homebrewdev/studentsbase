//
//  StudentsViewController.swift
//  studentsbase
//
//  Created by tiger on 16.05.2019.
//  Copyright © 2019 homework. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
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
        let reuseIdentifier = "cell"
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: reuseIdentifier)
        }
        
        cell!.accessoryType = UITableViewCell.AccessoryType(rawValue: 2)!
        
        // create a new cell if needed or reuse an old one
        //let cell:StudentsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell
        
        // set the text from the data mode
        let fullName = self.allData[indexPath.row].fullName + "      "
            + self.allData[indexPath.row].score
        
        let score = String(self.allData[indexPath.row].score)
        
        cell!.textLabel?.text = "\(fullName)"
        cell!.detailTextLabel?.text = "\(score)"
        
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row)")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)//главный сториборд

        let EditStudentViewController = mainStoryboard.instantiateViewController(withIdentifier: "EditStudentViewController")//View в который нужен переход
        // ну и сам переход во view собственно
        self.navigationController?.pushViewController(EditStudentViewController, animated: true)
        
        //prepare(for: UIStoryboard.Se, sender: Any?.self)
    }
    
    // название кнопки "удалить" при удалении строки таблицы
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    
    // метод удаления строки таблицы
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // удаление сущности из модели данных
            allData.remove(at: indexPath.row)
            
            // удаление строки таблицы из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем идентификатор ячейки CellReuseIdentifier
        tableView.register(StudentsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //массив из объектов типа Student массив данных по студентам
        allData += [
            Student(name: "Иван", soname: "Иванов", score: "5.0"),
            Student(name: "Петя", soname: "Петров", score: "4.5"),
            Student(name: "Алексей", soname: "Сидоров", score: "4.2"),
            Student(name: "Прохор", soname: "Семенов", score: "4.0"),
            Student(name: "Алина", soname: "Синичкина", score: "5.0"),
            Student(name: "Ольга", soname: "Грозных", score: "3.4"),
            Student(name: "Муганга", soname: "Мзумбу", score: "4.7"),
            Student(name: "Ашот", soname: "Абакунян", score: "3.9"),
            Student(name: "Гаврила", soname: "Безымянный", score: "3.6"),
            Student(name: "Федор", soname: "Прохоров", score: "4.1"),
            Student(name: "Кристина", soname: "Звездина", score: "5.0"),
            Student(name: "Оксана", soname: "Шадрина", score: "4.3"),
        ]
        
        //выводим для себя в консоль
        for student in allData {
            print("Student: \(student.fullName!) \(student.score!)")
        }
        
        // передаем данные из этого View в главный контроллер StudentsViewController
        // и добавляем в массив нового студента Student
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // получаем View Controller, который является конечным пунктом для segue
            let destinationVC = segue.destination as! EditStudentViewController
            
            destinationVC.textName.text = "редактирование"
            destinationVC.textSoname.text = "редактирование"
            // изменяем свойство, используемое для установки текста в label
            //destinationVC.textOfLabel = (textfield?.text)!
        
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // тут будет код котрый исполняется при возобновлении показа главной view
        }
        
}
