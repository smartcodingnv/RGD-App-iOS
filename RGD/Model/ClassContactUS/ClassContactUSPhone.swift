//
//	ClassContactUSPhone.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ClassContactUSPhone : NSObject, NSCoding{

	var ext : String!
	var phone : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		ext = json["ext"].stringValue
		phone = json["phone"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if ext != nil{
			dictionary["ext"] = ext
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         ext = aDecoder.decodeObject(forKey: "ext") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if ext != nil{
			aCoder.encode(ext, forKey: "ext")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}

	}

}