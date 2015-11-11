
//http://www.learnersdictionary.com/qa/parts-of-the-day-early-morning-late-morning-etc
//http://snag.gy/jSI6o.jpg
//Step 1: Build a .plist or REST API service or whatever 
//http://stackoverflow.com/questions/3910244/getting-current-device-language-in-ios
//List of Language Codes: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
//Step 2: Get the user's local time zone
//Step 3: Calculate whether the user's local time fits within these buckets of time


import Foundation

class DayParts{
    var currentHour:Int
    var localLang:String?
    
    // IDEA: Build a .plist or a REST API service or whatever that simply returns a dictiontary
    let letterCodes:[String:Array<String>] = [
        "en": ["Early Morning", "Late Morning", "Early Afternoon", "Late Afternoon", "Evening", "Night"],
        "fr": ["Tôt le matin", "Tard dans la matinée", "Début d'après-midi", "Tard dans l'après-midi", "Soir", "Nuit"],
        "es": ["Mañana Temprano", "Mañana tarde", "Temprano en la tarde", "Fin de la tarde", "Anochecer", "Noche"]
    ]
    
    init(){
        //A. Get the current time
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH"
        //B. Get the current hour
        currentHour = Int(dateFormatter.stringFromDate(date))!
        //C. Get the current phone language
        localLang = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as? String
    }
    
    func now() -> String {
        if(currentHour < 08){
            return letterCodes[localLang!]![0]
        }
        else if(currentHour < 11){
            return letterCodes[localLang!]![1]
        }
        else if( currentHour < 15){
            return letterCodes[localLang!]![2]
        }
        else if( currentHour < 17){
            return letterCodes[localLang!]![3]
        }
        else if(currentHour < 21){
            return letterCodes[localLang!]![4]
        }
        else{
            return "Night"
        }
    }
}

let dayParts = DayParts().now()


