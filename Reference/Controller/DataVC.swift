//
//  DataVC.swift
//  Reference
//
//  Created by Alexey Davletshin on 05.02.2021.
//

import UIKit

class DataVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var calcButton: UIButton! {
        didSet { calcButtonIsEnabled = false }
    }
    
    var calcButtonIsEnabled: Bool {
        set(isEnabled) {
            calcButton.titleLabel?.isEnabled = isEnabled
            calcButton.isEnabled = isEnabled
        }
        get {
            return calcButton.isEnabled
        }
    }
    
    @IBOutlet weak var locomotiveButton: UIButton!
    @IBAction func locomotiveButtonTapped(_ sender: Any) {
        dismissKeyboard()
        locomotivePicker.isHidden = false
    }
    
    @IBOutlet weak var locomotivePicker: UIPickerView! {
        didSet { locomotivePicker.isHidden = true }
    }
    
    @IBOutlet weak var loadedCarsField: UITextField!
    @IBOutlet weak var emptyCarsField: UITextField!
    @IBOutlet weak var passengerCarsField: UITextField!
    @IBOutlet weak var trainMassField: UITextField!
    
    @IBOutlet var trainFields: [UITextField]! {
        didSet {
            trainFields.forEach() { $0.addPrevNextDoneToolbar() }
        }
    }
    
    @IBAction func trainFieldBeginEditing(_ sender: Any) {
        locomotivePicker.isHidden = true
    }
    
    @IBAction func trainFieldEdited(_ sender: Any) {
        let train = collectTrain()
        calcButtonIsEnabled = !train.isEmpty() && train.mass > 0
    }
    
    private var locomotives: [Locomotive?] = [
        nil,
        Locomotive("2М62", mass: 120, Car(brakePress: 11.0, axesCount: 6)),
        Locomotive("ЧМЭ3", mass: 123, Car(brakePress: 11.0, axesCount: 6)),
        Locomotive("ВЛ10", mass: 182, Car(brakePress: 11.0, axesCount: 8)),
        Locomotive("ВЛ10У", mass: 184, Car(brakePress: 11.0, axesCount: 8)),
        Locomotive("ВЛ11", mass: 184, Car(brakePress: 11.0, axesCount: 8)),
    ]
    
    private var pickedLocomotive: Locomotive?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locomotivePicker.delegate = self
        locomotivePicker.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func endEditing() {
        dismissKeyboard()
        locomotivePicker.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locomotives.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let locomotive = locomotives[row] {
            return "\(locomotive.name) — \(locomotive.mass)т, \(locomotive.car.axesCount) осей"
        } else {
            return "Нет"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedLocomotive = locomotives[row]
        
        let newTitle = NSMutableAttributedString(attributedString: locomotiveButton.attributedTitle(for: .normal)!)
        newTitle.mutableString.setString(pickedLocomotive?.name ?? "Нет")
        
        locomotiveButton.setAttributedTitle(newTitle, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let train = collectTrain()
        
        guard segue.identifier == "showReference" else { return }
        guard let reference = segue.destination as? ReferenceVC else { return }
        
        let builder = ReferenceVCBuilder(reference)
        builder.calcStats(train)
    }
    
    private func collectTrain() -> Train {
        let emptyCars = convertToInt(self.emptyCarsField.text)
        let loadedCars = convertToInt(self.loadedCarsField.text)
        let passengerCars = convertToInt(self.passengerCarsField.text)
        
        var mass = convertToInt(self.trainMassField.text)
        
        var cars = [(count: Int, car: Car)]()
        
        if emptyCars > 0 {
            cars.append((emptyCars, Car(brakePress: 3.5, axesCount: 4)))
        }
        if loadedCars > 0 {
            cars.append((loadedCars, Car(brakePress: 7.0, axesCount: 4)))
        }
        if passengerCars > 0 {
            cars.append((passengerCars, Car(brakePress: 10.0, axesCount: 4)))
        }
        
        if let locomotive = pickedLocomotive {
            cars.append((1, locomotive.car))
            mass += locomotive.mass
        }
        
        let hasOnlyEmptyCars = (pickedLocomotive == nil && loadedCars == 0 && passengerCars == 0)
        
        return Train(cars: cars, hasOnlyEmptyCars: hasOnlyEmptyCars, mass: mass)
    }
    
    private func convertToInt(_ text: String?) -> Int {
        return Int(text ?? "") ?? 0;
    }
}

extension UITextField {
    func addPrevNextDoneToolbar(onPrev: (target: Any, action: Selector)? = nil,
                                onNext: (target: Any, action: Selector)? = nil,
                                onDone: (target: Any, action: Selector)? = nil) {
        let onPrev = onPrev ?? (target: self, action: #selector(self.prevButtonTapped))
        let onNext = onNext ?? (target: self, action: #selector(self.nextButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(self.doneButtonTapped))
        
        let toolbar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.frame.width, height: CGFloat(44))))
        toolbar.items = [
            UIBarButtonItem(title: "Назад", style: .plain, target: onPrev.target, action: onPrev.action),
            UIBarButtonItem(title: "Далее", style: .plain, target: onNext.target, action: onNext.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Готово", style: .done, target: onDone.target, action: onDone.action)
        ]
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func prevButtonTapped() {
        self.resignFirstResponder()
        
        setFirstResponder(self.superview?.viewWithTag(self.tag - 1))
    }
    
    @objc func nextButtonTapped() {
        self.resignFirstResponder()
        
        setFirstResponder(self.superview?.viewWithTag(self.tag + 1))
    }
    
    func setFirstResponder(_ view: UIView?) {
        if let view = view {
            view.becomeFirstResponder()
        } else {
            self.endEditing(true)
        }
    }
    
    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }
}
