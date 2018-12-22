//
//  Steps.swift
//  Trippopia
//
//  Created by webwerks1 on 03/10/17.
//  Copyright © 2017 webwerks2. All rights reserved.
//

import UIKit

class Steps: NSObject {
    var step_html_string = String()
    var step_polyline = String()
    var step_travel_mode = String()
    var step_distance = Dictionary<String, Any>()
    var step_duration = Dictionary<String, Any>()
    var step_end_location = Dictionary<String, Any>()
    var step_start_location = Dictionary<String, Any>()
    var step_dict = Dictionary<String, Any>()
    init(step:Dictionary<String, Any>) {
        super.init()
        self.step_dict = step
        loadMapData()
    }
    
    func loadMapData() {
        
        saveDurationAndDictance(dict: step_dict["distance"] as! Dictionary<String, Any>, key: "distance")
        saveDurationAndDictance(dict: step_dict["duration"] as! Dictionary<String, Any>, key: "duration")
        saveLocation(dict: step_dict["end_location"] as! Dictionary<String, Any>, key: "end_location")
        saveLocation(dict: step_dict["start_location"] as! Dictionary<String, Any>, key: "start_location")
        step_html_string = step_dict["html_instructions"] as! String
    }

    func saveDurationAndDictance(dict:Dictionary<String,Any>,key:String) {
        var durationORdistance = Dictionary <String,Any> ()
        durationORdistance = ["text": dict["text"] as! String,"value":Int(dict["value"] as! Int)]
        if key == "distance" {
            step_distance = [key:durationORdistance]
        }
        if key == "duration" {
            step_duration = [key:durationORdistance]
        }
    }

    func saveLocation(dict:Dictionary<String,Any>,key:String) {
        var location = Dictionary <String,Any> ()
        location = ["lat":dict["lat"] as! Float,"lng":Int(dict["lng"] as! Float)]
        if key == "end_location" {
            step_end_location = [key:location]
        }
        if key == "start_location" {
            step_start_location = [key:location]
        }
    }
    
    
}
