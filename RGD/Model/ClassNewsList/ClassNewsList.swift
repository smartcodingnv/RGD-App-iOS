//
//	ClassNewsList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ClassNewsList : NSObject, NSCoding{

	var date : String!
	var descriptionField : String!
	var id : Int!
	var title : String!
    var image : [String]!
    var vides : [String]!
    var media : [ClassNewsListMedia]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		date = json["date"].stringValue
		descriptionField = json["description"].stringValue
		id = json["id"].intValue
		title = json["title"].stringValue
        image = [String]()
        let imageArray = json["image"].arrayValue
        for imageJson in imageArray{
            image.append(imageJson.stringValue)
        }
        vides = [String]()
        let videsArray = json["vides"].arrayValue
        for videsJson in videsArray{
            vides.append(videsJson.stringValue)
        }
        media = [ClassNewsListMedia]()
        for item in image {
            var objDir = JSONResponse()
            objDir["imgType"] = "I"
            objDir["imageName"] = item
            let objJson : JSON = JSON(objDir)
            let value = ClassNewsListMedia(fromJson: objJson)
            media.append(value)
        }
        for item in vides {
            var objDir = JSONResponse()
            objDir["imgType"] = "V"
            objDir["videoName"] = item
            
            let youTubeId = item.youtubeID
            //             https://img.youtube.com/vi/ZDS6pWuWJk4/maxresdefault.jpg
            objDir["imageName"] = "https://img.youtube.com/vi/" + youTubeId! + "/maxresdefault.jpg"
            
            let objJson : JSON = JSON(objDir)
            let value = ClassNewsListMedia(fromJson: objJson)
            media.append(value)
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if date != nil{
			dictionary["date"] = date
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if id != nil{
			dictionary["id"] = id
		}
		if title != nil{
			dictionary["title"] = title
		}
        if image != nil{
            var dictionaryElements = [String]()
            for galleryImagesElement in image {
                dictionaryElements.append(galleryImagesElement)
            }
            dictionary["image"] = dictionaryElements
        }
        if vides != nil{
            var dictionaryElements = [String]()
            for galleryImagesElement in vides {
                dictionaryElements.append(galleryImagesElement)
            }
            dictionary["vides"] = dictionaryElements
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         date = aDecoder.decodeObject(forKey: "date") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
        image = aDecoder.decodeObject(forKey: "image") as? [String]
        vides = aDecoder.decodeObject(forKey: "vides") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if vides != nil{
            aCoder.encode(vides, forKey: "vides")
        }

	}

}
