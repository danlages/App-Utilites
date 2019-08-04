//
//  TrainTimeGathering.swift
//  
//
//  Created by Dan Lages on 04/08/2019.
//

import Foundation
import SwiftSoup

func timeScrape(startPoint: String, endPoint: String) {
    
    let URLString = String("https://www.thetrainline.com/live/departures/" + startPoint + "-to-" + endPoint) //Concatinate URL
    let sourceURL = NSURL(string: URLString)
    
    let html = try! String (contentsOf: sourceURL! as URL, encoding: .utf8)
    
    do {
        let siteDocument: Document = try SwiftSoup.parseBodyFragment(html)
        let componants = try siteDocument.getAllElements() //Get all elementes ready to be filtered
        
        for i in componants {
            let arrivalTime = try i.getElementsByClass("scheduled-time").text()
            let platform = try i.getElementsByClass("platform").text()
            print(arrivalTime)
            print(platform)
        }
        
    } catch {
        print("Unable to parse URL")
    }
}
