//
//  SettingsViewController.swift
//  Prework
//
//  Created by Arpit Hirani on 06/08/21.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var tipAmountLabel1: UITextField!
    @IBOutlet weak var tipAmountLabel2: UITextField!
    @IBOutlet weak var tipAmountLabel3: UITextField!
    @IBOutlet weak var defaultTipSwitch: UISwitch!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var pickerData: [String] = ["$", "£", "€", "₹", "¥"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults=UserDefaults.standard
        // Do any additional setup after loading the view.
        self.title = "Settings"
        
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        let selected = defaults.string(forKey: "selected")

        if let row = pickerData.firstIndex(of: selected ?? "") {
            currencyPicker.selectRow(row , inComponent: 0, animated: true)
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults=UserDefaults.standard
        defaults.set(pickerData[row],forKey: "selected")
        defaults.synchronize()
    }
    
    
    @IBAction func switchChanged(_ sender: Any) {
        if(defaultTipSwitch.isOn){
            self.tipAmountLabel1.isUserInteractionEnabled=true
            self.tipAmountLabel1.backgroundColor=UIColor.lightGray
            self.tipAmountLabel2.isUserInteractionEnabled=true
            self.tipAmountLabel2.backgroundColor=UIColor.lightGray
            self.tipAmountLabel3.isUserInteractionEnabled=true
            self.tipAmountLabel3.backgroundColor=UIColor.lightGray
        }
        else{
            let defaults=UserDefaults.standard
            var Tip1Text:String=tipAmountLabel1.text!
            Tip1Text=Tip1Text.replacingOccurrences(of:"%", with: "")
            defaults.set(Tip1Text+"%", forKey: "Tip1")
            self.tipAmountLabel1.isUserInteractionEnabled=false
            self.tipAmountLabel1.backgroundColor=UIColor.darkGray
            
            var Tip2Text:String=tipAmountLabel2.text!
            Tip2Text=Tip2Text.replacingOccurrences(of:"%", with: "")
            defaults.set(Tip2Text+"%", forKey: "Tip2")
            self.tipAmountLabel2.isUserInteractionEnabled=false
            self.tipAmountLabel2.backgroundColor=UIColor.darkGray
            
            var Tip3Text:String=tipAmountLabel3.text!
            Tip3Text=Tip3Text.replacingOccurrences(of:"%", with: "")
            defaults.set(Tip3Text+"%", forKey: "Tip3")
            self.tipAmountLabel3.isUserInteractionEnabled=false
            self.tipAmountLabel3.backgroundColor=UIColor.darkGray
            
            defaults.synchronize()
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = UserDefaults.standard
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        let Tip1 = defaults.string(forKey: "Tip1")
        if (Tip1 != ""){
            self.tipAmountLabel1.text = Tip1
        }
        
        let Tip2 = defaults.string(forKey: "Tip2")
        if (Tip2 != ""){
            self.tipAmountLabel2.text = Tip2
        }
        
        let Tip3 = defaults.string(forKey: "Tip3")
        if (Tip3 != ""){
            self.tipAmountLabel3.text = Tip3
        }
        
        let PartyCount = defaults.integer(forKey: "PartyCount")
        self.PartyCount.text = String(PartyCount)
        self.PartyStepper.value = Double(PartyCount)
        
        self.tipAmountLabel1.isUserInteractionEnabled=false
        self.tipAmountLabel2.isUserInteractionEnabled=false
        self.tipAmountLabel3.isUserInteractionEnabled=false
        self.tipAmountLabel1.backgroundColor=UIColor.darkGray
        self.tipAmountLabel2.backgroundColor=UIColor.darkGray
        self.tipAmountLabel3.backgroundColor=UIColor.darkGray
        self.defaultTipSwitch.isOn = false
        
        if(UIApplication.shared.windows.first?.overrideUserInterfaceStyle == .dark){
            self.DarkModeSwitch.isOn = true
        }
        else{
            self.DarkModeSwitch.isOn = false
        }
    }
    
    
    @IBOutlet weak var DarkModeSwitch: UISwitch!
    
    @IBAction func DarkMode(_ sender: Any) {
        if(DarkModeSwitch.isOn){
            UIView.animate(withDuration: 0.5, animations: {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
            })
        }
        else{
            UIView.animate(withDuration: 0.5, animations: {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
            })
        }
    }
    
    @IBOutlet weak var PartyCount: UILabel!
    @IBOutlet weak var PartyStepper: UIStepper!
    
    
    @IBAction func StepperChanged(_ sender: Any) {
        var count = Int(self.PartyStepper.value)
        if (count == 0){
            self.PartyStepper.value = 1
            count = 1
        }
        self.PartyCount.text = String(count)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        let defaults=UserDefaults.standard
        defaults.set(Int(self.PartyCount.text!), forKey:"PartyCount")
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
