//
//  DataVC.swift
//  Reference
//
//  Created by Alexey Davletshin on 05.02.2021.
//

import UIKit

class DataVC: UIViewController {
    
    @IBOutlet weak var loadedCarsField: UITextField!
    @IBOutlet weak var emptyCarsField: UITextField!
    @IBOutlet weak var passengerCarsField: UITextField!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showReference" else { return }
        
        guard let reference = segue.destination as? ReferenceVC else { return }
        
        reference.loadedCars = Int(self.loadedCarsField.text ?? "")
        reference.emptyCars = Int(self.emptyCarsField.text ?? "")
        reference.passengersCars = Int(self.passengerCarsField.text ?? "")
    }
    
}

