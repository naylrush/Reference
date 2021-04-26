//
//  DataVC.swift
//  Reference
//
//  Created by Alexey Davletshin on 05.02.2021.
//

import UIKit

class DataVC: UIViewController, UITextFieldDelegate {
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
    
    @IBOutlet weak var loadedCarsField: UITextField! {
        didSet { loadedCarsField.addPrevNextDoneToolbar() }
    }
    @IBOutlet weak var emptyCarsField: UITextField! {
        didSet { emptyCarsField.addPrevNextDoneToolbar() }
    }
    @IBOutlet weak var passengerCarsField: UITextField! {
        didSet { passengerCarsField.addPrevNextDoneToolbar() }
    }
    @IBOutlet weak var trainMassField: UITextField! {
        didSet { trainMassField.addPrevNextDoneToolbar() }
    }
    
    @IBAction func trainFieldEdited(_ sender: Any) {
        let train = collectTrain()
        calcButtonIsEnabled = !train.isEmpty() && train.mass > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcButtonIsEnabled = false
        
        loadedCarsField.delegate = self
        emptyCarsField.delegate = self
        passengerCarsField.delegate = self
        trainMassField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DataVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
