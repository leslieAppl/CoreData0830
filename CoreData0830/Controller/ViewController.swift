//
//  ViewController.swift
//  CoreData0830
//
//  Created by leslie on 8/30/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext?
    var listOfNames: [Mood] = []    		// [NSManagedObject]

    @IBOutlet weak var inputColors: UITextField!
    @IBOutlet weak var inputDate: UITextField!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showDate: UILabel!
    @IBOutlet weak var showColor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? MoodsTableViewController {
            nextVC.managedObjectContext = self.managedObjectContext
        }
    }

    @IBAction func saveColorsBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func saveDateBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func saveNameBtnPressed(_ sender: UIButton) {
        guard let name = inputName.text?.trimmingCharacters(in: .whitespaces) else { return }
//        showName.text = name
//        inputName.text = ""
        
        if name != "" {
            guard let moc = managedObjectContext else { return }
            let newMood = Mood(context: moc)
            newMood.name = name
            newMood.date = Date()
            
            do {
                try managedObjectContext?.save()
            } catch {
                print("saving core data error")
            }
            
            inputName.text = ""
        }
    }
    
    @IBAction func requestBtnPressed(_ sender: UIButton) {
//        let request = NSFetchRequest<Mood>(entityName: "Mood")
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
//        request.sortDescriptors = [sortDescriptor]
//        request.fetchBatchSize = 3
        
        /// working with the 'Mood' extension and 'Managed' Protocol.
        let request = Mood.sortedFetchRequest
        request.fetchBatchSize = 20
        
        let requestNumber = try! managedObjectContext?.count(for: request)
        print("Total Data Model count: \(requestNumber)")
        
        do {
            try listOfNames = managedObjectContext!.fetch(request)
            if listOfNames != [] {
                let mood = listOfNames[0]
                showName.text = mood.name
                
                guard let date = mood.date else { return }
                let formater = DateFormatter()
                //            formater.dateStyle = .long
                formater.dateFormat = "HH:mm E, d MMM y"
                showDate.text = formater.string(from: date)
            }
        } catch {
            print("error")
        }
    }
}

