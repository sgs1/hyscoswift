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
    var textfieldname : UITextField! = nil
    var textfieldUrlLocal : UITextField! = nil
    var RemoteUrlTextField : UITextField! = nil
    var textfieldPin : UITextField! = nil
    var textfieldPuk:  UITextField! = nil
    var data : NSMutableDictionary!
      var people = [NSManagedObject]()

    @IBOutlet var imageView: UIImageView!
    
    override func loadView() {
        super.loadView()
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   // Check if the table is defined
        if let err = SD.createTable("hsyco", withColumnNamesAndTypes: ["Name": .StringVal, "localUrl": .StringVal, "remoteUrl": .StringVal, "PIN": .StringVal, "PUK": .StringVal]) {
            // tabella già esistente, quindi ci sono già dei dati. Vado ad aprire la configurazione
            println("tabella già esistente")
            openhsycoconfiguration()
            
            
        } else {
            // dati non esistenti, tabella creata , e avvio la configurazione
     createnew()
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
        
        
        
        
        
        // Last opened, determinato dalla data / ora
        
        
        
    }
    func createnew()
    {
        var labelname = UILabel(frame: CGRectMake(50,22, 50, 21))
        //  labelname.center = CGPointMake(160, 284)
        labelname.textAlignment = NSTextAlignment.Center
        labelname.text = "Name"
        self.view.addSubview(labelname)
        
        textfieldname = UITextField(frame: CGRect(x: 150, y: 22, width: 200.00, height: 40.00));
        //textfieldname.text = "Testo"
        self.view.addSubview(textfieldname)
        
        
        
        var labelUrlLocal = UILabel(frame: CGRectMake(50,72, 90, 21))
        //  labelname.center = CGPointMake(160, 284)
        labelUrlLocal.textAlignment = NSTextAlignment.Center
        labelUrlLocal.text = "URL Local"
        self.view.addSubview(labelUrlLocal)
        
        textfieldUrlLocal = UITextField(frame: CGRect(x: 150, y: 72, width: 200.00, height: 40.00));
        textfieldUrlLocal.placeholder = "URL Local text"
        self.view.addSubview(textfieldUrlLocal)
        
        var labelRemoteUrl = UILabel(frame: CGRectMake(50,102, 90, 21))
        //  labelname.center = CGPointMake(160, 284)
        labelRemoteUrl.textAlignment = NSTextAlignment.Center
        labelRemoteUrl.text = "URL remote "
        self.view.addSubview(labelRemoteUrl)
        
        RemoteUrlTextField = UITextField(frame: CGRect(x: 150, y: 102, width: 200.00, height: 40.00));
        RemoteUrlTextField.placeholder = "URL Remote text"
        self.view.addSubview(RemoteUrlTextField)
        
        
        
        var labelPuk = UILabel(frame: CGRectMake(50,122, 90, 21))
        //  labelname.center = CGPointMake(160, 284)
        labelPuk.textAlignment = NSTextAlignment.Center
        labelPuk.text = "PUK "
        self.view.addSubview(labelPuk)
        
        
        textfieldPuk = UITextField(frame: CGRect(x: 150, y: 122, width: 200.00, height: 40.00));
        textfieldPuk.placeholder = "PUK text"
        self.view.addSubview(textfieldPuk)
        
        
        
        
        var labelPin = UILabel(frame: CGRectMake(50,152, 90, 21))
        //  labelname.center = CGPointMake(160, 284)
        labelPin.textAlignment = NSTextAlignment.Center
        labelPin.text = "Pin "
        self.view.addSubview(labelPin)
        
        textfieldPin = UITextField(frame: CGRect(x: 150, y: 152, width: 200.00, height: 40.00));
        textfieldPin.placeholder = "PIN text"
        self.view.addSubview(textfieldPin)
        
        
        let myFirstButton = UIButton()
        myFirstButton.setTitle("Save", forState: .Normal)
        myFirstButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        myFirstButton.frame = CGRectMake(15, 200, 300, 700)
        myFirstButton.addTarget(self, action: "save", forControlEvents: .TouchUpInside)
        self.view.addSubview(myFirstButton)
        
        
    }
    func save()
    {
        // import the input
        println ("in save")
        var name = textfieldname.text
        var pin = textfieldPin.text
        var puk = textfieldPuk.text
        var urlremoto = RemoteUrlTextField.text
        var urllocal = textfieldUrlLocal.text
        
        if let err = SD.executeChange("INSERT INTO hsyco (Name, localUrl, remoteUrl, PIN, PUK) VALUES (?, ?, ?, ?, ?)", withArgs: [name, urllocal, urlremoto, pin, puk ]) {
            //there was an error during the insert, handle it here
            println("errore nell'inserimento dati")
        } else {
            //no error, the row was inserted successfully
            println("query ok")
            // Salvo in userdefaults e torno indietro: in realtà salvo nelle userdefaults e provo a caricare la webview
            NSUserDefaults.standardUserDefaults().setObject(urlremoto, forKey: "urlremoto")
            NSUserDefaults.standardUserDefaults().synchronize()
         
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("viewhsyco") as UIViewController
            self.presentViewController(viewController, animated: false, completion: nil)
        }
        
        
        
    }
    
 
    func openhsyco(sender: UIButton)()
    {

        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("viewhsyco") as UIViewController
        self.presentViewController(viewController, animated: false, completion: nil)
        
    }
    

    
}







