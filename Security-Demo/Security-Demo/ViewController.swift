//
//  ViewController.swift
//  Security-Demo

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    @IBAction func buttonPushTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecurityVC") as UIViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

