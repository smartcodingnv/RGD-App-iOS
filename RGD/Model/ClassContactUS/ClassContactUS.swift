//
//	ClassContactUS.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ClassContactUS : NSObject, NSCoding{

	var address : String!
	var email : String!
	var id : Int!
	var location : String!
	var openingTime : String!
	var phone : [ClassContactUSPhone]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		address = json["address"].stringValue
		email = json["email"].stringValue
		id = json["id"].intValue
		location = json["location"].stringValue
		openingTime = json["opening_time"].stringValue
		phone = [ClassContactUSPhone]()
		let phoneArray = json["phone"].arrayValue
		for phoneJson in phoneArray{
			let value = ClassContactUSPhone(fromJson: phoneJson)
			phone.append(value)
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
		if email != nil{
			dictionary["email"] = email
		}
		if id != nil{
			dictionary["id"] = id
		}
		if location != nil{
			dictionary["location"] = location
		}
		if openingTime != nil{
			dictionary["opening_time"] = openingTime
		}
		if phone != nil{
			var dictionaryElements = [[String:Any]]()
			for phoneElement in phone {
				dictionaryElements.append(phoneElement.toDictionary())
			}
			dictionary["phone"] = dictionaryElements
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
         email = aDecoder.decodeObject(forKey: "email") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         location = aDecoder.decodeObject(forKey: "location") as? String
         openingTime = aDecoder.decodeObject(forKey: "opening_time") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? [ClassContactUSPhone]

        
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
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if openingTime != nil{
			aCoder.encode(openingTime, forKey: "opening_time")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}

	}

}
