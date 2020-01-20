//
//	MyDataOnMapWorkingTime.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MyDataOnMapWorkingTime : NSObject, NSCoding{

	var workingDays : String!
	var workingEndTime : String!
	var workingStartTime : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		workingDays = json["working_days"].stringValue
		workingEndTime = json["working_end_time"].stringValue
		workingStartTime = json["working_start_time"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if workingDays != nil{
			dictionary["working_days"] = workingDays
		}
		if workingEndTime != nil{
			dictionary["working_end_time"] = workingEndTime
		}
		if workingStartTime != nil{
			dictionary["working_start_time"] = workingStartTime
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         workingDays = aDecoder.decodeObject(forKey: "working_days") as? String
         workingEndTime = aDecoder.decodeObject(forKey: "working_end_time") as? String
         workingStartTime = aDecoder.decodeObject(forKey: "working_start_time") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if workingDays != nil{
			aCoder.encode(workingDays, forKey: "working_days")
		}
		if workingEndTime != nil{
			aCoder.encode(workingEndTime, forKey: "working_end_time")
		}
		if workingStartTime != nil{
			aCoder.encode(workingStartTime, forKey: "working_start_time")
		}

	}

}