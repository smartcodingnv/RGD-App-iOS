//
//	ClassWachtdienst.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ClassWachtdienst : NSObject, NSCoding{

	var descriptionField : String!
	var endDateTime : String!
	var id : Int!
	var image : String!
	var startDateTime : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		descriptionField = json["description"].stringValue
		endDateTime = json["end_date_time"].stringValue
		id = json["id"].intValue
		image = json["image"].stringValue
		startDateTime = json["start_date_time"].stringValue
		title = json["title"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if endDateTime != nil{
			dictionary["end_date_time"] = endDateTime
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if startDateTime != nil{
			dictionary["start_date_time"] = startDateTime
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         endDateTime = aDecoder.decodeObject(forKey: "end_date_time") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         startDateTime = aDecoder.decodeObject(forKey: "start_date_time") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if endDateTime != nil{
			aCoder.encode(endDateTime, forKey: "end_date_time")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if startDateTime != nil{
			aCoder.encode(startDateTime, forKey: "start_date_time")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}