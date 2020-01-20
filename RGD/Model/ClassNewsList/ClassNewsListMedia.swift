//
//	ClassNewsListMedia.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ClassNewsListMedia : NSObject, NSCoding{

	var imageName : String!
    var videoName : String!
	var imgType : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		imageName = json["imageName"].stringValue
        videoName = json["videoName"].stringValue
		imgType = json["imgType"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if imageName != nil{
			dictionary["imageName"] = imageName
		}
        if videoName != nil{
            dictionary["videoName"] = videoName
        }
		if imgType != nil{
			dictionary["imgType"] = imgType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         imageName = aDecoder.decodeObject(forKey: "imageName") as? String
        videoName = aDecoder.decodeObject(forKey: "videoName") as? String
         imgType = aDecoder.decodeObject(forKey: "imgType") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if imageName != nil{
			aCoder.encode(imageName, forKey: "imageName")
		}
        if videoName != nil{
            aCoder.encode(videoName, forKey: "videoName")
        }
		if imgType != nil{
			aCoder.encode(imgType, forKey: "imgType")
		}

	}

}
