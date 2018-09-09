//
//  DBVC.swift
//  Security-Demo

import UIKit
import RealmSwift

class DBVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func addDataInDb() {
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("name of dog: \(myDog.name)")
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(myDog)
        }

    }
    
    @IBAction func buttonSave(_ sender: Any) {
        addDataInDb()
    }
    
    
    @IBAction func buttonFetch(_ sender: Any) {
        let realm = try! Realm()
        let puppies = realm.objects(Dog.self)
        print("Puppies Count has \(puppies.count)")
    }
    
}

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    override static func primaryKey() -> String? {
        return "name"
    }
}

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var picture: Data? = nil // optionals supported
    let dogs = List<Dog>()
}
