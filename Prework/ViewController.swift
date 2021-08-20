//
//  ViewController.swift
//  Prework
//
//  Created by Arpit Hirani on 05/08/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Easy Tip"
        self.billAmountTextField.becomeFirstResponder()
        self.billAmountTextField.keyboardType = .decimalPad
    }
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var perPersonAmount: UILabel!
    
    
    @IBAction func calculateTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        let currencySymbol = defaults.string(forKey: "selected")

        let billAmount = Double(self.billAmountTextField.text!) ?? 0
        var tipPercentageString = String(self.tipControl.titleForSegment(at: self.tipControl.selectedSegmentIndex)!)
        tipPercentageString = tipPercentageString.replacingOccurrences(of: "%", with: "")
        let tipPercentage = Double(tipPercentageString) ?? 0
        let tip = Double(billAmount * tipPercentage/100)
        let total = tip + billAmount
        
        self.tipAmountLabel.text = String(format: currencySymbol! + "%.2f",tip)
        self.totalLabel.text = String(format: currencySymbol! + "%.2f", total)

        let PartyCount = defaults.double(forKey: "PartyCount")
        let PartyAmount = Double(total/PartyCount)
        self.perPersonAmount.text = String(format: currencySymbol! + "%.2f" + " per person", PartyAmount)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = UserDefaults.standard
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        
        let Tip1 = defaults.string(forKey: "Tip1")
        let Tip2 = defaults.string(forKey: "Tip2")
        let Tip3 = defaults.string(forKey: "Tip3")
        if (Tip1 != ""){
            self.tipControl.setTitle(Tip1, forSegmentAt: 0)
        }
        if (Tip2 != ""){
            self.tipControl.setTitle(Tip2, forSegmentAt: 1)
        }
        if (Tip3 != ""){
            self.tipControl.setTitle(Tip3, forSegmentAt: 2)
        }
        
        calculateTip(animated as AnyObject)
        
    }
    
}

