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
    @IBOutlet weak var trainMassField: UITextField!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showReference" else { return }
        
        guard let reference = segue.destination as? ReferenceVC else { return }
        
        let loadedCars = Int(self.loadedCarsField.text ?? "")
        let emptyCars = Int(self.emptyCarsField.text ?? "")
        let passengersCars = Int(self.passengerCarsField.text ?? "")
        let trainMass = Int(self.trainMassField.text ?? "")
        
        reference.calcStatTable(loadedCars: loadedCars, emptyCars: emptyCars, passengersCars: passengersCars, trainMass: trainMass)
    }
    
}

