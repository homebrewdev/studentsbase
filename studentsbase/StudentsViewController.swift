//
//  StudentsViewController.swift
//  studentsbase
//
//  Created by Egor Devyatov on 16.05.2019.
//  Copyright © 2019 homework. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // идентификатор ячейки таблицы
    let cellReuseIdentifier = "cell"
    
    // инициализируем массив из экземляров класса Student - основная модель данных
    var allData = [Student]()
    
    var student: Student = Student(name: "", soname: "", score: "")
    
    var isEdit: Bool = false
    // номер ячейки таблицы
    var row: Int = 0
    
    // MARK: - Работа с tableView
    //задаем заголовок таблицы
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Список студентов                 Средний балл"
    }
    
    //задаем кол-во строк в таблице вычисляя кол-во элементов в массиве allData
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allData.count
    }
    
    // создаем параметры ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //устанавливаем название идентификатора ячейки
        let reuseIdentifier = "cell"
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        }
        //уставналиваем AccessoryType
        //cell!.accessoryType = UITableViewCell.AccessoryType(rawValue: 1)!
        
        // заполняем поля ячейки таблицы данными из массива студентов
        let fullName = self.allData[indexPath.row].fullName
        let score = self.allData[indexPath.row].score
        
        cell!.textLabel?.text = "\(fullName)"
        cell!.detailTextLabel?.text = "\(score)"
        
        return cell!
    }
    
    
    // метод вызываемый по нажатию на ячейку таблицы UITableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Нажата ячейка c индексом: \(indexPath.row)")
        
        // заполняем из модели данных поля соответствующие нажатой ячейке с номером indexPath.row
        student.name = self.allData[indexPath.row].name
        student.soname = self.allData[indexPath.row].soname
        student.score = self.allData[indexPath.row].score
        
        //View в который нужен переход EditStudentViewController с идентификатором
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "EditStudentViewController") as! EditStudentViewController
        
        // заполняем соответствующие поля в EditViewController полями
            destinationVC.student.name = student.name
            destinationVC.student.soname = student.soname
            destinationVC.student.score = student.score
        
        self.isEdit = true
        self.row = indexPath.row
        
        // ну и сам переход в EditStudentView собственно
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // задаем название кнопки "удалить" при удалении строки таблицы
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    
    // метод удаления строки таблицы
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // удаление сущности из модели данных
            self.allData.remove(at: indexPath.row)
            
            // удаление строки таблицы из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        // на будущее
        //if editingStyle == .insert {
        //    self.allData.insert(Student(name: "edit",
        //                                soname: "edit",
        //                                score: "5.0"), at: indexPath.row)
        //}
        
    }
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем xib файл с дизайном ячейки таблицы
        //let xib = UINib(nibName: "xibCell", bundle: Bundle.main)
        //tableView?.register(xib, forCellReuseIdentifier: "xibCell")
        
        // регистрируем идентификатор ячейки CellReuseIdentifier
        //tableView.register(StudentsTableViewCell.self, forCellReuseIdentifier: "xibCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // функция чтения данных из students.plist
        func readPlist(){
            // указываем наш students.plist
            let path = Bundle.main.path(forResource: "students", ofType: "plist")
        
            let rootArray = NSArray(contentsOfFile: path!)!
            //выдает общее количество записей типа студент в файле students.plist
            print(rootArray.count)
            
            for data in rootArray {
                let subArray = data as? NSArray ?? []
            
                // добавляем каждую запись типа Item из массива String полей
                // в нашу модель данных allData
                allData.append(Student(name: subArray[1] as! String, soname: subArray[0] as! String, score: subArray[2] as! String))
            }
            
            //выводим для себя в консоль
            for student in allData {
                print("Student: \(student.fullName) score: \(student.score)")
            }
        }
        
        // читаем данные из students.plist
        readPlist()
        
    }
    
    // при каждом появлении StudentsViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // тут будет код который исполняется при возобновлении показа главной view
        if self.isEdit == true {
            // добавляем новую запись студента
        //self.allData.insert(Student(name: student.name,
        //                               soname: student.soname,
        //                               score: student.score), at: row)
        
        self.allData.append(Student(name: student.name,
                                    soname: student.soname,
                                    score: student.score))
           // удаляем старую
        self.allData.remove(at: row)
        
        // добавляем новую ячейку таблицы
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            
        tableView.insertRows(at: [IndexPath(row: allData.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
    
        self.isEdit = false
        }
    }
    
    //func addNewStudent (name: String, soname: String, score: String) {
        //self.allData.append(Student(name, soname, score)
    //}
    
}
