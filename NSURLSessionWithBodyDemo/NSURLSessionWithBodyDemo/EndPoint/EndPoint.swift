//
//  EndPoint.swift
//  NSURLSessionWithBodyDemo
//
//  Created by mkumar on 07/03/21.
//  Copyright © 2021 mkumar. All rights reserved.
//

import UIKit

struct ResponseData: Codable {
    let head: head?
    let body: body?
    
    enum CodingKeys: String, CodingKey {
        case head = "head"
        case body = "body"
    }
}

struct head: Codable {
    let StatusValue: Int?
    let StatusText: String?
    
    enum CodingKeys: String, CodingKey {
        case StatusText = "StatusText"
        case StatusValue = "StatusValue"
    }
}

struct body : Codable {
    let data: [Data]?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

struct Data: Codable {
    let med_id: Int?
    let med_name: String?
    let med_desc: String?
    let medt_start_date: String?
    let med_createdon: String?
    let med_createdby: String?
    let prescribed_by: String?
    let is_self_prescribed: Int?
    let medDetails: [medDetails]?
    
    enum CodingKeys: String, CodingKey {
        case med_id = "med_id"
        case med_name = "med_name"
        case med_desc = "med_desc"
        case medt_start_date = "medt_start_date"
        case med_createdon = "med_createdon"
        case med_createdby = "med_createdby"
        case prescribed_by = "prescribed_by"
        case is_self_prescribed = "is_self_prescribed"
        case medDetails = "medDetails"
    }
}

struct medDetails: Codable {
    let _med_date: String?
    let med_status: Int?
    let title: String?
    let medDateDetails: [medDateDetails]?
    
    enum CodingKeys: String, CodingKey {
        case _med_date = "_med_date"
        case med_status = "med_status"
        case title = "title"
        case medDateDetails = "medDateDetails"
    }
}

struct medDateDetails: Codable {
    let _med_time: String?
    let med_taken_status: Int?
    let med_status: Int?
    let medTimeDetails: [medTimeDetails]?
}

struct medTimeDetails: Codable {
    let event_id: Int?
    let patient_mpi: String?
    let event_name: String?
    let event_desc: String?
    let event_item_name: String?
    let event_duration_desc: String?
    let event_start_date: String?
    let event_time: String?
    let event_end_date: String?
    let order_by: String?
    let order_id: Int?
    let event_alarm_status: Int?
    let order_name: String?
    let order_on: String?
    let food_intake_name: String?
    let food_intake_id: Int?
    let med_taken_status: Int?
    let med_qty: String?
    let med_duration: Int?
    let med_duration_details: String?
    let dose_details: String?
    let med_status: Int?
    let is_combination: Bool?
    let med_strength: String?
    let med_strength_unit: String?
    let med_dose_unit_name: String?
    let prescribed_by: String?
    let is_self_prescribed: Int?
}

class NetworkManager {
    
    func getDataFromHttpCall(completionHandler: @escaping (ResponseData, Bool) -> Void) {
        
        // prepare json data
        let json: [String: Any] = ["body": ["eventStartDate":"2021-01-01", "eventEndDate":"2021-03-04", "eventType": 2,"patientMpi": "3000000100000008"]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let jsonURLString = "https://app.mysafeguardfamily.com/Services/web/app.php/portal/prescribe/mob/medical/prescription/details/fetch"
        
        guard let url = URL(string: jsonURLString) else { print("URL is invalid"); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil, response != nil else {
                print("Something went wrong")
                return
            }
            
            /// Get data using Decodeable
            do {
                let httpResponseData = try JSONDecoder().decode(ResponseData.self, from: data)
                completionHandler(httpResponseData, true)
            } catch {
                print("error:- \(error)")
            }
        }).resume()
    }
}


