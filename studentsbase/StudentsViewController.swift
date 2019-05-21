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
    
    // инициализируем массив из экземляров класса Student
    var allData = [Student]()
    
    var student: Student = Student(name: "", soname: "", score: "")
    
    //задаем заголовок таблицы
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Список студентов               Средний балл"
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
        cell!.accessoryType = UITableViewCell.AccessoryType(rawValue: 1)!
        
        // заполняем поля ячейки таблицы данными из массива студенов
        let fullName = self.allData[indexPath.row].fullName
        
        let score = self.allData[indexPath.row].score
        
        cell!.textLabel?.text = "\(fullName!)"
        cell!.detailTextLabel?.text = "\(score ?? "0.0")"
        
        return cell!
    }
    
    
    // метод вызываемый по нажатию на ячейку таблицы UITableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Нажата ячейка номер: \(indexPath.row)")
        
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
        
        // ну и сам переход во view собственно
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
            allData.remove(at: indexPath.row)
            
            // удаление строки таблицы из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем xib файл с дизайном ячейки таблицы
        let xib = UINib(nibName: "xibCell", bundle: Bundle.main)
        tableView?.register(xib, forCellReuseIdentifier: "xibCell")
        
        // регистрируем идентификатор ячейки CellReuseIdentifier
        tableView.register(StudentsTableViewCell.self, forCellReuseIdentifier: "xibCell")
        
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
                print("Student: \(student.fullName!) score: \(student.score!)")
            }
            
        }
        
        // читаем данные из students.plist
        readPlist()
        
    }
    
    /*
    // будем заполнять студента только тогда когда мы переходим от ячейки таблицы
    
    func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        //if segue!.identifier == "fromCellToEditStudent" {
            let destinationVC: EditStudentViewController = segue!.destination as! EditStudentViewController
            
            destinationVC.student.name = (student.name)
            destinationVC.student.soname = (student.soname)
            destinationVC.student.score = (student.score)
            
        }
    */
    
    // передаем данные из этого View в главный контроллер StudentsViewController
    // и добавляем в массив нового студента Student
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //получаем View Controller, который является конечным пунктом для segue
      //  let destinationVC = segue.destination as! EditStudentViewController
        
        //destinationVC.student.name = student.name
        //destinationVC.student.soname = student.soname
        //destinationVC.student.score = student.score
        
   // }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // тут будет код который исполняется при возобновлении показа главной view
    }
    
}
