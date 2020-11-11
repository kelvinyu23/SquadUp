//
//  SquadsViewController.swift
//  squadup
//
//  Created by Kelvin Yu on 10/28/20.
//

import UIKit
import Firebase
import FirebaseDatabase

class SquadsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref.child("Players").child("Swaraj")
            //.child("Name")
            .observe(DataEventType.value, with: { (snap:DataSnapshot) in
            self.txtField.text = snap.value as? String
        })
        // Do any additional setup after loading the view
    }
    
    @IBOutlet weak var SwarajValue: UILabel!
    
    @IBOutlet weak var txtField: UITextField!
    
    var ref = Database . database ().reference ()
    var counter = 0
    @IBAction func enterTxt(_ sender: Any) {
        self.counter += 1
        print(txtField.text!)
        let playersRef = self.ref.child("Players")
        let swarajRef = playersRef.child("Swaraj")
        swarajRef.updateChildValues(["Age":self.counter, "Name":txtField.text!])
        
    }
}
