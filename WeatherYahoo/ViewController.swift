//
//  ViewController.swift
//  WeatherYahoo
//
//  Created by Luis Santamaría on 4/12/17.
//  Copyright © 2017 Santamaria Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var lblCiudad: UILabel!
    
    var ciudades : Array<Array<String>> = Array<Array<String>>()
    
    @IBOutlet weak var lblTemperatura: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ciudades.append(["Dallas, Texas", "dallas%2C%20tx"])
        ciudades.append(["Nome, Alaska", "nome%2C%20ak"])
        ciudades.append(["Maui, Hawaii", "maui%2C%20hi"])
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.ciudades.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.ciudades[row][0]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let urls = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22"
        let url = NSURL(string: urls + self.ciudades[row][1] + "%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")
        let datos = NSData (contentsOfURL: url!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dic1 = json as! NSDictionary
            let dic2 = dic1["query"] as! NSDictionary
            let dic3 = dic2["results"] as! NSDictionary
            let dic4 = dic3["channel"] as! NSDictionary
            let dic5 = dic4["location"] as! NSDictionary
            self.lblCiudad.text = dic5["city"] as! NSString as String
            let dic6 = dic4["item"] as! NSDictionary
            let dic7 = dic6["condition"] as! NSDictionary
            self.lblTemperatura.text = dic7["temp"] as! NSString as String
        }
        catch _ {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

