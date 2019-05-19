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
    
    //задаем заголовок таблицы
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Список студентов"
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
        let fullName = self.allData[indexPath.row].fullName + "      "
            + self.allData[indexPath.row].score
        
        let score = String(self.allData[indexPath.row].score)
        
        cell!.textLabel?.text = "\(fullName)"
        cell!.detailTextLabel?.text = "\(score)"
        
        return cell!
    }
    
    // метод вызываемый по нажатию на ячейку таблицы UITableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Нажата ячейка номер: \(indexPath.row)")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)//главный сториборд
        //View в который нужен переход
        let EditStudentViewController = mainStoryboard.instantiateViewController(withIdentifier: "EditStudentViewController")
        // ну и сам переход во view собственно
        self.navigationController?.pushViewController(EditStudentViewController, animated: true)
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
        
        // регистрируем идентификатор ячейки CellReuseIdentifier
        tableView.register(StudentsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    
        
        // читаем данные из students.plist
        func readPlist(){
            let path = Bundle.main.path(forResource: "students", ofType: "plist")
            let rootArray = NSArray(contentsOfFile: path!)!
            print(rootArray.count) //выдает общее количество записей студент
        
            for data in rootArray {
                let subArray = data as? NSArray ?? []
                for value in subArray {
                    print("objects are \(value)")//выводит содержимое каждого студента
                }
                // добавляем каждую запись типа Item из массива String полей
                allData.append(Student(name: subArray[0] as! String, soname: subArray[1] as! String, score: subArray[2] as! String))
            }
            
            //выводим для себя в консоль
            for student in allData {
                print("Student: \(student.fullName!) \(student.score!)")
            }
        
        }
        
        readPlist()
        
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
        // тут будет код который исполняется при возобновлении показа главной view
        }
        
}
