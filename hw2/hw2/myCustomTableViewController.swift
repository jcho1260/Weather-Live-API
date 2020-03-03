//
//  myCustomTableViewController.swift
//  hw2
//
//  Created by Jin Cho on 2/12/20.
//  Copyright © 2020 Jin Cho. All rights reserved.
//

import UIKit
import Foundation

class myCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherLab: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class myCustomTableViewController: UITableViewController {
    var allInfo: [Weather] = []
    var coord = ["42.8864,-78.8784", "35.2271,-80.8431", "35.9940,-78.8986", "36.1699,-115.1398", "38.2527,-85.7585", "39.9526,-75.1652", "35.7796,-78.6382"]
    var city = ["Buffalo", "Charlotte", "Durham", "Las Vegas", "Louisville", "Philadelphia", "Raleigh"]
    var cityImages = [UIImage(named: "Buffalo"), UIImage(named: "Charlotte"), UIImage(named: "Durham"), UIImage(named: "Las Vegas"), UIImage(named: "Louisville"), UIImage(named: "Philadelphia"), UIImage(named: "Raleigh")]
    var icons: [String] = []
    
       
    
    
    struct Current: Codable {
        var summary: String
        var icon: String
        var temperature: Double
        var precipProbability: Double
    }
    struct Weather: Codable {
        var currently: Current
    }
    
    var allWeather: [Weather] = []
//
//    var allWeather: [Weather] = []
    
    override func viewDidLoad() {
        getAllData()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //getAllData()
        
        

    }
    
    func getAllData() {
        //https://api.darksky.net/forecast/efae5963aa7409e92e07ffe278fbe3cd/37.8267,-122.4233
        let basePath = "https://api.darksky.net/forecast/efae5963aa7409e92e07ffe278fbe3cd/"
        
        for coordinates in coord{
            let url = basePath + coordinates
            let request = URLRequest(url: URL(string:url)!)
            
            // 3. MAKE THE HTTPS REQUEST task
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                guard error == nil else {
                    print ("error: \(error!)")
                    return
                }
                // ensure there is data returned from this HTTP response
                guard let jsonData = data else {
                    print("No data")
                    return
                }
                print("Got the data from network")
                               
                               // 4. DECODE THE RESULTING JSON
                let decoder = JSONDecoder()

                do {
                   // decode the JSON into our array of todoItem's
                    let weat = try decoder.decode(Weather.self, from:jsonData)
                    
                    print(weat.currently.temperature)
                    self.allInfo.append(weat)
                    self.icons.append(weat.currently.icon)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
//                    self.allInfo.append(weat)
//                    print("Summary: \(weat.summary)")
//                    print("I'm Done with \(coordinates)!")
                 } catch {
                    print("JSON Decode error")
                    print(error)
                }
            })
            // actually make the http task run.
            dataTask.resume()
        }
        
        
    }
        
        //making array of Weather structs corresponding to cities in coord
//        for locs in coord{
//            Weather.current(withLocation: locs) { (results: [Weather]?) in
//                if let weatherDat = results{
//                    self.allInfo = weatherDat
//                    print(weatherDat)
//                }
//            }
//        }
//        print(allInfo.count)
   
    
//    func getAllData() {
//        
//        // 2. BEGIN NETWORKING code
//        //
//        let mySession = URLSession(configuration: URLSessionConfiguration.default)
//        let basePath = "https://api.darksky.net/forecast/efae5963aa7409e92e07ffe278fbe3cd/"
//        
//
               
//    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           
           //Give the Section a header with some text
           return("Weather")
           
       }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return city.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! myCustomTableViewCell

        // Configure the cell...
        cell.weatherLab.text = city[indexPath.row]
        let index = city.firstIndex(of: cell.weatherLab.text!)
        //cell.weatherImg.image = UIImage(named: icons[index!])
        //cell.weatherTemp.text = String(Int(allInfo[indexPath.row].currently.temperature))
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // and cast it to the correct class type (i.e. focusAnimalViewController)
        
        let destVC = segue.destination as! weatherFocusViewController
        
        // Pass the selected object to the new view controller.
        let myRow = tableView!.indexPathForSelectedRow
        let myCurrCell = tableView!.cellForRow(at: myRow!) as! myCustomTableViewCell
        
        // set the destVC variables from the selected row
        destVC.weatherText = (myCurrCell.weatherLab!.text)!
        let index = city.firstIndex(of: myCurrCell.weatherLab.text!)
        destVC.cityImage = cityImages[index!]
        destVC.sumText = allInfo[index!].currently.summary
        destVC.tempText = "\(String(Int(allInfo[index!].currently.temperature))) °F"
        destVC.precipText = "Precipitation Probability: \(String(allInfo[index!].currently.precipProbability))"
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
