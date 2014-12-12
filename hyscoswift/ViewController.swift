//
//  ViewController.swift
//  hyscoswift
//
//  Created by Joas Scicchitano on 25/11/14.
//  Copyright (c) 2014 ___informaticamilano___. All rights reserved.
//



import UIKit
import WebKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var containerView : UIView?
    
    var webView: WKWebView?
   
    var data : NSMutableDictionary!
      var people = [NSManagedObject]()

    @IBOutlet var imageView: UIImageView!
    
    override func loadView() {
        super.loadView()
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
     override func viewDidAppear(animated: Bool) {
        // Check if the table is defined
        if let err = SD.createTable("hsyco", withColumnNamesAndTypes: ["Name": .StringVal, "localUrl": .StringVal, "remoteUrl": .StringVal, "PIN": .StringVal, "PUK": .StringVal]) {
            // tabella già esistente, quindi ci sono già dei dati. Vado ad aprire la configurazione
            println("tabella già esistente")
            openhsycoconfiguration()
            
            
        } else {
            
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("newconfiguration") as UIViewController
            self.presentViewController(viewController, animated: false, completion: nil)
        }

    }
    func openhsycoconfiguration()
    {
        let creahsyco = UIButton()
        creahsyco.setTitle("Crea nuovo", forState: .Normal)
        creahsyco.setTitleColor(UIColor.blueColor(), forState: .Normal)
        creahsyco.frame = CGRectMake(155, 200, 300, 700)
        
        creahsyco.addTarget(self, action: "createnew", forControlEvents: .TouchUpInside)
        self.view.addSubview(creahsyco)
        
        
        // a seconda della configurazione decisa si aprono diverse situazioni
        // Attivo al momento: last opened e select in caso di più hsyco
        
        // Elenco hsyco
       
            let (resultSet, err) = SD.executeQuery("SELECT Name, remoteUrl FROM hsyco")
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                if let name = row["Name"]?.asString() {
                    println("The City name is: \(name)")
                }
                if let remoteurl = row["remoteUrl"]?.asString() {
                    println("The population is: \(remoteurl)")
                }
                
                let myFirstButton = UIButton()
                myFirstButton.setTitle("Open Hsyco", forState: .Normal)
                myFirstButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
                myFirstButton.frame = CGRectMake(15, 200, 300, 700)
                
                myFirstButton.addTarget(self, action: "openhsyco", forControlEvents: .TouchUpInside)
                self.view.addSubview(myFirstButton)
                
            }
        }
        
        
        var resultSet = SD.executeQuery("SELECT Name, remoteUrl FROM hsyco")
        var rollNoColumn: String = "Name"
        var nameColumn: String = "remoteUrl"
        if resultSet {
            while resultSet.next() {
                println("roll no : \(resultSet.stringForColumn(rollNoColumn))")
                println("name : \(resultSet.stringForColumn(nameColumn))")
            }
        }
        
        
        
        
        
        
        
        // Last opened, determinato dalla data / ora
        
        
        
    }
    func createnew()
    {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("newconfiguration") as UIViewController
        self.presentViewController(viewController, animated: false, completion: nil)
    }

    
 
    func openhsyco()
    {

        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("viewhsyco") as UIViewController
        self.presentViewController(viewController, animated: false, completion: nil)
        
    }
    

    
}







