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
    @IBOutlet weak var textSoname: UITextField!
    @IBOutlet weak var textScore: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // передаем данные из этого View в главный контроллер StudentsViewController
    // и добавляем в массив нового студента Student
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // получаем View Controller, который является конечным пунктом для segue
        let destinationVC = segue.destination as! StudentsViewController
        // изменяем свойство, используемое для установки текста в label
        //destinationVC.textOfLabel = (textfield?.text)!
        destinationVC.allData.append(Student(name: textName.text!,
                                             soname: textSoname.text!,
                                             score: textScore.text!))
    }
    
    // при нажатии на кнопку Сохранить будет происходить валидация полей
    // передача заполненных полей в главный View
    // а также переход обратно на главный экран с таблицей студентов
    @IBAction func saveStudent(_ sender: Any) {
        
        func showAlert(title: String, message: String) {
            // создаем объект типа UIAlertController, описывающий модальное окно
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert)
            // создаем объекты типа UIAlertAction, описывающие кнопки
            let alertButtonOne = UIAlertAction(title: "ОК", style: .default, handler: nil)
            // добавляем созданные кнопки в модальное окно
            alertController.addAction(alertButtonOne)
            //alertController.addAction(alertButtonTwo)
            // выводим вспылывающее окно
            self.present(alertController, animated: true, completion: nil)
        }
        
        // функция проверки полей на правильность заполнения
        func validation() -> Bool {
            var alertType = 0
            var alertMessage = ""
            let alertTitle = "Ошибка заполнения поля"
            let score = Float(textScore.text!)
            
            if textSoname.text == "" {
                alertType = 1
            }
            else if textName.text == "" {
                alertType = 2
            }
            else if textScore.text == "" {
                alertType = 3
            }
            else if (score! < 1.0) || (score! > 5.0) {
                alertType = 4
            }
            
            
            // в зависимости от типа ошибки будем выводит разные тексты алерта
            switch alertType {
            case 1:
                alertMessage = "Поле 'Фамилия' не заполнено (пустое)!"
                showAlert(title: alertTitle, message: alertMessage)
                return false
            case 2:
                alertMessage = "Поле 'Имя' не заполнено (пустое)!"
                showAlert(title: alertTitle, message: alertMessage)
                return false
            case 3:
                alertMessage = "Поле 'Средний балл' не заполнено (пустое)!"
                showAlert(title: alertTitle, message: alertMessage)
                return false
            case 4:
                alertMessage = "Средний балл должен быть в диапазоне: от 1.0 до 5.0"
                showAlert(title: alertTitle, message: alertMessage)
                return false
            default:
                alertMessage = "Новая запись успешно добавлена в базу"
                showAlert(title: "Отлично!", message: alertMessage)
                return true
            }
        }
        
        if validation() {
            //prepare(for: UIStoryboardSegue, sender: EditStudentViewController.self)
        }
        // инициируем проверку правильности заполнения полей EditStudentsView
        // и если все окей validation() возвращает true -> переходим в главный RootViewController
        //let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)//главный сториборд
        //mainStoryboard.instantiateInitialViewController()
        //if validation() {
        //}
        
    }
    
}
