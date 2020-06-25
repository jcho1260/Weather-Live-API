//
//  Forecast.swift
//  hw2
//
//  Created by Jin Cho on 3/2/20.
//  Copyright © 2020 Jin Cho. All rights reserved.
//

//import Foundation
//
//struct Weather: Codable {
//    var summary: String
//    var icon: String
//    var precipProbability: Double
//    var temperature: Double
//    
//    
//    enum SerializationError: Error{
//        case missing(String)
//        case invalid(String, Any)
//}
//    
//init(json:[String:Any]) throws{
//    guard let summary = json["summary"] as? String else {throw SerializationError.missing("Summary is missing")}
//    guard let icon = json["icon"] as? String else {throw SerializationError.missing("Icon is missing")}
//    guard let temperature = json["temperature"] as? Double else {throw SerializationError.missing("Temperature is missing")}
//    guard let precipProbability = json["precipProbability"] as? Double else {throw SerializationError.missing("Precipitation Probability is missing")}
//    
//    self.summary = summary
//    self.icon = icon
//    self.temperature = temperature
//    self.precipProbability = precipProbability
//}
//    
//    //1. get URL
//    //https://api.darksky.net/forecast/efae5963aa7409e92e07ffe278fbe3cd/37.8267,-122.4233
//    static let basePath = "https://api.darksky.net/forecast/efae5963aa7409e92e07ffe278fbe3cd/"
//    static func current (withLocation coordinates: String, completion: @escaping([Weather]) -> ()){
//        let url = basePath + coordinates
//        let request = URLRequest(url: URL(string:url)!)
//        
//        // 3. MAKE THE HTTPS REQUEST task
//        //
//        let task = URLSession.shared.dataTask(with: request){ (data:Data?, response:URLResponse?, error:Error?) in
//            // ensure there is no error for this HTTP response
//            var currentArray:[Weather] = []
//            
//            if let data=data{
//                do{
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
//                        if let currentInfo = json["currently"] as? [String:Any]{
//                            if let weatherObject = try? Weather(json: currentInfo){
//                                    currentArray.append(weatherObject)
//                            }
//                        }
//                        
//                    }
//                }catch{
//                    print(error.localizedDescription)
//                }
//                completion(currentArray)
//            }
//            
//        // 4. DECODE THE RESULTING JSON
//        //
//           
//         }
//        
//        task.resume()
//    }
//    
//    
//}

    
/*
    {5 items
    "latitude":35.994
    "longitude":78.8986
    "timezone":"Asia/Urumqi"
    "currently":{19 items
    "time":1583012159
    "summary":"Overcast"
    "icon":"cloudy"
    "precipIntensity":0.0075
    "precipProbability":0.01
    "precipType":"snow"
    "precipAccumulation":0.026
    "temperature":-18.55
    "apparentTemperature":-23.49
    "dewPoint":-26.82
    "humidity":0.48
    "pressure":1027.8
    "windSpeed":1.73
    "windGust":2.69
    "windBearing":186
    "cloudCover":0.92
    "uvIndex":0
    "visibility":16.093
    "ozone":311.7
    }
    "offset":6
    }

*/
