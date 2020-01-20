//
//	MyDataOnMap.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MyDataOnMap : NSObject, NSCoding{
    
    var address : String!
    var clinicHasServiceId : Int!
    var latitude : String!
    var locationName : String!
    var longitude : String!
    var name : String!
    var phone : [String]!
    var workingTimes : [MyDataOnMapWorkingTime]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = json["address"].stringValue
        clinicHasServiceId = json["clinic_has_service_id"].intValue
        latitude = json["latitude"].stringValue
        locationName = json["location_name"].stringValue
        longitude = json["longitude"].stringValue
        name = json["name"].stringValue
        phone = [String]()
        let phoneArray = json["phone"].arrayValue
        for phoneJson in phoneArray{
            phone.append(phoneJson.stringValue)
        }
        workingTimes = [MyDataOnMapWorkingTime]()
        let workingTimesArray = json["working_times"].arrayValue
        for workingTimesJson in workingTimesArray{
            let value = MyDataOnMapWorkingTime(fromJson: workingTimesJson)
            workingTimes.append(value)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if clinicHasServiceId != nil{
            dictionary["clinic_has_service_id"] = clinicHasServiceId
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if locationName != nil{
            dictionary["location_name"] = locationName
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if name != nil{
            dictionary["name"] = name
        }
        if phone != nil{
            var dictionaryElements = [String]()
            for phoneElement in phone {
                dictionaryElements.append(phoneElement)
            }
            dictionary["phone"] = dictionaryElements
        }
        if workingTimes != nil{
            var dictionaryElements = [[String:Any]]()
            for workingTimesElement in workingTimes {
                dictionaryElements.append(workingTimesElement.toDictionary())
            }
            dictionary["working_times"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? String
        clinicHasServiceId = aDecoder.decodeObject(forKey: "clinic_has_service_id") as? Int
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String
        locationName = aDecoder.decodeObject(forKey: "location_name") as? String
        longitude = aDecoder.decodeObject(forKey: "longitude") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? [String]
        workingTimes = aDecoder.decodeObject(forKey: "working_times") as? [MyDataOnMapWorkingTime]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if clinicHasServiceId != nil{
            aCoder.encode(clinicHasServiceId, forKey: "clinic_has_service_id")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if locationName != nil{
            aCoder.encode(locationName, forKey: "location_name")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if workingTimes != nil{
            aCoder.encode(workingTimes, forKey: "working_times")
        }
        
    }
    
}
