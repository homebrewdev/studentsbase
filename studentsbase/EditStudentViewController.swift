//
//  EditViewController.swift
//  studentsbase
//
//  Created by Egor Devyatov on 16.05.2019.
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
    
    // метод вывода алертов при валидации полей
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
        
        // выводим вспылывающее окно
        self.present(alertController, animated: true, completion: nil)
    }
    
    // функция проверки полей на правильность заполнения
    func validation() -> Bool {
        var alertType = 0
        var alertMessage = ""
        let alertTitle = "Ошибка заполнения поля"
        let score = Float(textScore.text!)
        
        // если поле 'Фамилия' пустое
        if textSoname.text == "" {
            alertType = 1
        }
            // если поле 'имя' пустое
        else if textName.text == "" {
            alertType = 2
        }
            // если поле 'Средний балл' пустое
        else if textScore.text == "" {
            alertType = 3
        }
            // если поле 'Средний балл' заполнено, но его значение не в диапазоне от 1.0 до 5.0 то выведем сообщение о несоответствии диапазону значений
        else if (score! < 1.0) || (score! > 5.0) {
            alertType = 4
        }
        
        // в зависимости от типа ошибки allertType будем выводит разные тексты алерта
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
        // если все валидации прошли успешно, то выводим сообщение
        default:
            alertMessage = "Новая запись успешно добавлена в базу"
            showAlert(title: "Отлично!", message: alertMessage)
            return true // и  функция validation возвращает true
        }
    }
    
    // передаем данные из этого View в главный контроллер StudentsViewController
    // и добавляем в массив нового студента Student
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // получаем View Controller, который является конечным пунктом для segue
        let destinationVC = segue.destination as! StudentsViewController
        // добавляем в массив нового студента Students массив находится в главном view контроллере StudentsViewController
        destinationVC.allData.append(Student(name: textName.text!,
                                             soname: textSoname.text!,
                                             score: textScore.text!))
    }
    
    // при нажатии на кнопку Сохранить будет происходить валидация полей
    // передача заполненных полей в главный View
    // а также переход обратно на главный экран с таблицей студентов
    @IBAction func saveStudent(_ sender: Any) {

        // если валидация проша успешно значение функции validation -> true
        // то переходим в главный RootViewController
        if validation() {
            //prepare(for: UIStoryboardSegue, sender: EditStudentViewController.self)
        }
        
    }
    
}
