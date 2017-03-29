//
//  ViewController.swift
//  Calculator
//
//  Created by 呂明峻 on 2017/2/14.
//  Copyright © 2017年 呂明峻. All rights reserved.
//

import UIKit

enum Sign{
    case nothing
    case plus
    case minus
    case multi
    case division
}
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 0.85
        )
    }
}

class ViewController: UIViewController {
    
    var firstNumber: Decimal = 0.0
    var secondNumber: Decimal = 0.0
    var currentSign = Sign.nothing
    var counting: Bool = false
    var second: Bool = false
    var equaling: Bool = false
    var math: Bool = false
    var finalNumber: Decimal = 0.0
    var temp: String = ""
    let formatter = NumberFormatter()
    
    
    
    @IBOutlet weak var resultBar: UILabel!
    @IBOutlet weak var double: UIButton!
    @IBOutlet weak var num0: UIButton!
    @IBOutlet weak var num: UIButton!
    @IBOutlet weak var num2: UIButton!
    @IBOutlet weak var num3: UIButton!
    @IBOutlet weak var num4: UIButton!
    @IBOutlet weak var num5: UIButton!
    @IBOutlet weak var num6: UIButton!
    @IBOutlet weak var num7: UIButton!
    @IBOutlet weak var num8: UIButton!
    @IBOutlet weak var num9: UIButton!
    @IBOutlet weak var AC: UIButton!
    @IBOutlet weak var pm: UIButton!
    @IBOutlet weak var percent: UIButton!
    @IBOutlet weak var division: UIButton!
    @IBOutlet weak var multi: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var equal: UIButton!
    
    @IBAction func number0(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "0"
            if !(resultBar.text!.contains(".")){
                resultBar.text! = checkNumber(resultBar.text!)
            }
        }
    }
    @IBAction func number1(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "1"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func number2(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "2"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func number3(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "3"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func number4(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "4"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func number5(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "5"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func number6(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "6"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func number7(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "7"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func number8(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "8"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func number9(_ sender: Any) {
        checkCounting()
        checkEqual()
        checkE()
        changeC()
        math = false
        if resultBar.text!.characters.count < 8{
            resultBar.text! += "9"
            resultBar.text! = checkNumber(resultBar.text!)
        }
    }
    @IBAction func AC(_ sender: UIButton) {
        if sender.titleLabel?.text == "C"{
            resultBar.text! = "0"
            sender.setTitle("AC", for: .normal)
        }
        else{
            firstNumber = 0.0
            secondNumber = 0.0
            finalNumber = 0.0
            currentSign = Sign.nothing
            counting = false
            second = false
            equaling = false
            resultBar.text! = "0"
            plus.layer.borderWidth = 1.0
            plus.backgroundColor = UIColor(hex:"ff8000")
            minus.layer.borderWidth = 1.0
            minus.backgroundColor = UIColor(hex:"ff8000")
            multi.layer.borderWidth = 1.0
            multi.backgroundColor = UIColor(hex:"ff8000")
            division.layer.borderWidth = 1.0
            division.backgroundColor = UIColor(hex:"ff8000")
        }
    }
    @IBAction func division(_ sender: UIButton) {
        
        checkComma()
        checkSecond()
        math = true
        //sender button
        sender.backgroundColor = UIColor(displayP3Red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        sender.layer.borderWidth = 2.0
        
        //else button
        plus.layer.borderWidth = 1.0
        plus.backgroundColor = UIColor(hex:"ff8000")
        minus.layer.borderWidth = 1.0
        minus.backgroundColor = UIColor(hex:"ff8000")
        multi.layer.borderWidth = 1.0
        multi.backgroundColor = UIColor(hex:"ff8000")
        
        //change sign
        currentSign = Sign.division
    }
    @IBAction func multi(_ sender: UIButton) {
        
        checkComma()
        checkSecond()
        math = true
        currentSign = Sign.multi
        
        //sender button
        sender.backgroundColor = UIColor(displayP3Red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        sender.layer.borderWidth = 2.0

        division.layer.borderWidth = 1.0
        division.backgroundColor = UIColor(hex:"ff8000")
        plus.layer.borderWidth = 1.0
        plus.backgroundColor = UIColor(hex:"ff8000")
        minus.layer.borderWidth = 1.0
        minus.backgroundColor = UIColor(hex:"ff8000")

    }
    @IBAction func minus(_ sender: UIButton) {
        
        checkComma()
        checkSecond()
        math = true
        currentSign = Sign.minus
        
        //sender button
        sender.backgroundColor = UIColor(displayP3Red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        sender.layer.borderWidth = 2.0
        
        division.layer.borderWidth = 1.0
        division.backgroundColor = UIColor(hex:"ff8000")
        plus.layer.borderWidth = 1.0
        plus.backgroundColor = UIColor(hex:"ff8000")
        multi.layer.borderWidth = 1.0
        multi.backgroundColor = UIColor(hex:"ff8000")

    }
    @IBAction func plus(_ sender: UIButton) {
        
        checkComma()
        checkSecond()
        math = true
        currentSign = Sign.plus
        
        //sender button
        sender.backgroundColor = UIColor(displayP3Red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        sender.layer.borderWidth = 2.0
        
        division.layer.borderWidth = 1.0
        division.backgroundColor = UIColor(hex:"ff8000")
        multi.layer.borderWidth = 1.0
        multi.backgroundColor = UIColor(hex:"ff8000")
        minus.layer.borderWidth = 1.0
        minus.backgroundColor = UIColor(hex:"ff8000")
        
    }
    @IBAction func equal(_ sender: Any) {
        math = true
        checkComma()
        
        plus.layer.borderWidth = 1.0
        plus.backgroundColor = UIColor(hex:"ff8000")
        minus.layer.borderWidth = 1.0
        minus.backgroundColor = UIColor(hex:"ff8000")
        multi.layer.borderWidth = 1.0
        multi.backgroundColor = UIColor(hex:"ff8000")
        division.layer.borderWidth = 1.0
        division.backgroundColor = UIColor(hex:"ff8000")
        equalize()
        second = false
        counting = false
        equaling = true
    }
    @IBAction func point(_ sender: Any) {
        checkCounting()
        checkEqual()
        changeC()
        if !(resultBar.text!.contains(".")){
           resultBar.text! += "."
        }
    }
    
    @IBAction func Pm(_ sender: UIButton) {
        checkComma()
        math = true
        let temp2 = Decimal(string: temp)!
        let final = 0 - temp2
        resultBar.text! = checkNumber(String(describing: final))
    }
    
    @IBAction func Percent(_ sender: UIButton) {
        checkComma()
        math = true
        let temp1 = Decimal(string: temp)!
        let final = temp1 / 100
        resultBar.text! = checkNumber(String(describing: final))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        num.layer.borderWidth = 1.0
        num.layer.borderColor = UIColor.black.cgColor
        num0.layer.borderWidth = 1.0
        num0.layer.borderColor = UIColor.black.cgColor
        num2.layer.borderWidth = 1.0
        num2.layer.borderColor = UIColor.black.cgColor
        num3.layer.borderWidth = 1.0
        num3.layer.borderColor = UIColor.black.cgColor
        num4.layer.borderWidth = 1.0
        num4.layer.borderColor = UIColor.black.cgColor
        num5.layer.borderWidth = 1.0
        num5.layer.borderColor = UIColor.black.cgColor
        num6.layer.borderWidth = 1.0
        num6.layer.borderColor = UIColor.black.cgColor
        num7.layer.borderWidth = 1.0
        num7.layer.borderColor = UIColor.black.cgColor
        num8.layer.borderWidth = 1.0
        num8.layer.borderColor = UIColor.black.cgColor
        num9.layer.borderWidth = 1.0
        num9.layer.borderColor = UIColor.black.cgColor
        double.layer.borderWidth = 1.0
        double.layer.borderColor = UIColor.black.cgColor
        AC.layer.borderWidth = 1.0
        AC.layer.borderColor = UIColor.black.cgColor
        division.layer.borderWidth = 1.0
        division.layer.borderColor = UIColor.black.cgColor
        multi.layer.borderWidth = 1.0
        multi.layer.borderColor = UIColor.black.cgColor
        minus.layer.borderWidth = 1.0
        minus.layer.borderColor = UIColor.black.cgColor
        plus.layer.borderWidth = 1.0
        plus.layer.borderColor = UIColor.black.cgColor
        equal.layer.borderWidth = 1.0
        equal.layer.borderColor = UIColor.black.cgColor
        pm.layer.borderWidth = 1.0
        pm.layer.borderColor = UIColor.black.cgColor
        percent.layer.borderWidth = 1.0
        percent.layer.borderColor = UIColor.black.cgColor
        resultBar.text! = "0"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkNumber (_ labelText: String) -> String{
        var stringOfNumber: NSNumber
        var label:String
        
        if labelText.contains(","){
            label = labelText.replacingOccurrences(of: ",", with: "")
        }
        else{
            label = labelText
        }
        if labelText.characters.count > 7 && math == true{
            formatter.numberStyle = .scientific
            formatter.positiveFormat = "0.##E+0"
            formatter.exponentSymbol = "e"
            stringOfNumber = formatter.number(from: label)!
            print("over")
        }
        else{
            formatter.numberStyle = .decimal
            formatter.positiveFormat = ","
            formatter.negativeFormat = ","
            stringOfNumber = formatter.number(from: label)!
            print("not")
        }
        print(stringOfNumber)
        if formatter.string(from: stringOfNumber)!.contains("e"){
            print("op")
            return formatter.string(from: stringOfNumber)!
        }
        else if label.contains(".") && label != "0.0"{
            print("af: "+(label))
            return label
        }
        else{
            print("to")
            return formatter.string(from: stringOfNumber)!
        }
        
    }
    
    func checkEqual() -> (){
        if equaling == true{
            resultBar.text! = "0"
            equaling = false
        }
    }
    
    func checkCounting() -> (){
        if counting == true{
            resultBar.text! = "0"
            counting = false
            second = true
        }
        
    }
    
    func checkSecond() -> (){
        if second == true{
            equalize()
            second = false
            firstNumber = finalNumber
        }
        else{
            firstNumber = Decimal(string: temp)!
        }
        counting = true
    }
    
    func checkComma() -> (){
        if resultBar.text!.contains(","){
            temp = resultBar.text!.replacingOccurrences(of: ",", with: "")
        }
        else{
            temp = resultBar.text!
        }
    }
    
    func equalize()->(){
        switch currentSign{
        case .division:
            secondNumber = Decimal(string: temp)!
            if secondNumber != 0{
                finalNumber = firstNumber / secondNumber
                resultBar.text! = checkNumber(String(describing: finalNumber))
            }
            else{
                resultBar.text! = "錯誤"
            }
            currentSign = Sign.nothing
        case .minus:
            secondNumber = Decimal(string: temp)!
            finalNumber = firstNumber - secondNumber
            print("\(firstNumber)  -  \(secondNumber) = \(finalNumber)")
            resultBar.text! = checkNumber(String(describing: finalNumber))
            currentSign = Sign.nothing
        case .plus:
            secondNumber = Decimal(string: temp)!
            finalNumber = firstNumber + secondNumber
            resultBar.text! = checkNumber(String(describing: finalNumber))
            currentSign = Sign.nothing
        case .multi:
            secondNumber = Decimal(string: temp)!
            finalNumber = firstNumber * secondNumber
            resultBar.text! = checkNumber(String(describing: finalNumber))
            currentSign = Sign.nothing
        case .nothing:
            break
            
        }
    }
    
    func checkE() -> (){
        if resultBar.text!.contains("e"){
            resultBar.text = "0"
        }
    }
    func changeC () -> (){
        AC.setTitle("C", for: .normal)
    }


}

