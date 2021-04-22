//
//  DataVC.swift
//  Reference
//
//  Created by Alexey Davletshin on 05.02.2021.
//

import UIKit

class DataVC: UIViewController {
    @IBOutlet weak var calcButton: UIButton!
    
    var calcButtonIsEnabled: Bool {
        set(isEnabled) {
            calcButton.titleLabel?.isEnabled = isEnabled
            calcButton.isEnabled = isEnabled
        }
        get {
            return calcButton.isEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcButtonIsEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DataVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var loadedCarsField: UITextField!
    @IBOutlet weak var emptyCarsField: UITextField!
    @IBOutlet weak var passengerCarsField: UITextField!
    
    @IBOutlet weak var trainMassField: UITextField!
    
    @IBAction func trainFieldEdited(_ sender: Any) {
        let train = collectTrain()
        calcButtonIsEnabled = !train.isEmpty() && train.mass > 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let train = collectTrain()
        
        guard segue.identifier == "showReference" else { return }
        guard let reference = segue.destination as? ReferenceVC else { return }
        
        let builder = ReferenceVCBuilder(reference)
        builder.calcStatTables(train)
    }
    
    private func collectTrain() -> Train {
        return Train(
            emptyCars: convertToInt(self.emptyCarsField.text),
            loadedCars: convertToInt(self.loadedCarsField.text),
            passengersCars: convertToInt(self.passengerCarsField.text),
            mass: convertToInt(self.trainMassField.text)
        )
    }
    
    private func convertToInt(_ text: String?) -> Int {
        return Int(text ?? "") ?? 0;
    }
}

