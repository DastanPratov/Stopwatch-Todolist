//
//  TimerViewController.swift
//  S&T
//
//  Created by Dastan on 28/6/22.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UITextView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var textLabel: UITextView!
    
    var timer = Timer()
    var seconds = 0
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.alpha = 0.5
        resetButton.isHidden = true
        pauseButton.isHidden = true
        
        title = "Таймер"
    }
    
    
    @IBAction func startTimer(_ sender: Any) {
        
        guard let timerInfo = timerLabel.text else
        {
            Alert.showBasicAlert(title: "Ошибка!", message: "Произошла какая-то ошибка при попытке обратного отсчета, бро!", on: self)
            return
        }
        
        do
        {
            seconds = try timeToSecond(for: timerInfo)
        } catch {
            Alert.showBasicAlert(title: "Неверный формат времени!", message: "Брат, пожалуйста, убедись, что ввел верный формат времени. Нужно вначале ввести час, далее минуты, а затем секунды. Например: 1 час, 47 минут и 0 секунд -> 01:47:00", on: self)
            timerLabel.text = "00:00:00"
        }
        
        guard seconds > 0 else
        {
            Alert.showBasicAlert(title: "Неверный формат времени!", message: "Братан, убедись, что ввел верный формат времени.", on: self)
            return
        }
            
        timerLabel.isEditable = false
        resetButton.isHidden = false
        pauseButton.isHidden = false
        textLabel.isHidden = true
        
        startButton.alpha = 0.5
        pauseButton.alpha = 1
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
    }
    
    @objc func count()
    {
        seconds -= 1
        timerLabel.text = secondsToTime(for: seconds)
        
        if timerLabel.text == "24:00:00" || timerLabel.text == "00:00:00"
        {
            reset()
            Alert.showBasicAlert(title: "Время истекло!", message: "Братаньо, таймер закончил обратный отсчет от указанного периода времени", on: self)
        }
        
        if timerLabel.text >= "24:60:60"
        {
            Alert.showBasicAlert(title: "Неверный формат времени!", message: "Бро, убедись, что ввел верный формат времени. ЧЧ:ММ:СС", on: self)
            reset()
        }
    }
    
    @IBAction func pauseTimer(_ sender: Any) {
        
        timer.invalidate()
        startButton.isEnabled = true
        
        pauseButton.alpha = 0.5
        startButton.alpha = 1
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        reset()
    }

    func reset()
    {
        timer.invalidate()
        seconds = 0
        timerLabel.text = "00:00:00"
        
        pauseButton.isHidden = true
        resetButton.isHidden = true
        timerLabel.isEditable = true
        textLabel.isHidden = false
        
        startButton.alpha = 1
        
        
    }
}
