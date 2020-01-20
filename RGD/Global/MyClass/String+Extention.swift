//
//  String+Extention.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/22/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit
extension String{
    
    // ------------------------------------------------------
    
    // MARK: - Remove Whit Space
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    // ------------------------------------------------------
    
    
    func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
            }.joined(separator: separator))
    }
    
    
    // ------------------------------------------------------
    
    // MARK: - Get Height Of String
    
    
    func getHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let constraintRect = CGSize(width: width, height: 500)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    // ------------------------------------------------------
    
    // MARK: - Get Width Of The String
    
    func getWidth(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    // ------------------------------------------------------
    
    // MARK: - Lenth Of String
    
    var length:Int {
        return self.count//self.characters.count
    }
    
    
    // ------------------------------------------------------
    
    // MARK: - Index Of String
    
    func indexOf(target: String) -> Int? {
        
        let range = (self as NSString).range(of: target)
        
        guard range.toRange() != nil else {
            return nil
        }
        
        return range.location
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - Last Index Of The Screen
    
    func lastIndexOf(target: String) -> Int? {
        
        let range = (self as NSString).range(of: target, options: NSString.CompareOptions.backwards)
        
        guard range.toRange() != nil else {
            return nil
        }
        
        return self.length - range.location - 1
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - Check Contains
    
    func contains(str: String) -> Bool {
        return (self.range(of: str) != nil) ? true : false
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func myLocalise() -> String {
        var str = self
        if USERDEFAULTS.value(forKey: kCurrentLanguage) as? String == kstrEN {
            str = EnDic[self]!
        }else {
            str = DuDic[self]!
        }
        if str == nil {
            return self
        }else {
            return str
        }
    }
 
    /*
    func myLocalise() -> String {
        var str = self
        var strReturn : String!
        if USERDEFAULTS.value(forKey: kCurrentLanguage) as? String == kstrEN {
            
            let abc = EnDic.keys.filter { (strKey) -> Bool in
                return strKey == str
            }
            if abc.count > 0 {
                strReturn = EnDic[self]!
            }
            
//            str = EnDic[self]!
        }else {
            let abc = DuDic.keys.filter { (strKey) -> Bool in
                return strKey == str
            }
            if abc.count != 0 {
                strReturn = DuDic[self]!
            }
//            strReturn = DuDic[self]!
//            str = DuDic[self]!
        }
        if strReturn == nil {
            return self
        }else {
            return strReturn
        }
    }
*/
}

extension NSAttributedString {
//    internal convenience init?(html: String) {
//        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
//            // not sure which is more reliable: String.Encoding.utf16 or String.Encoding.unicode
//            return nil
//        }
//        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
//            return nil
//        }
//        self.init(attributedString: attributedString)
//    }
}


extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
}

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
}
