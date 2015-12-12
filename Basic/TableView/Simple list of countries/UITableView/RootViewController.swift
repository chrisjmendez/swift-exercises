//
//  RootViewController.swift
//  UITableView
//
//  http://stackoverflow.com/questions/27920612/swift-uitableview-didselectrowatindexpath-not-being-called
//  http://stackoverflow.com/questions/29065219/swift-uitableview-didselectrowatindexpath-not-getting-called

//  Created by Chris on 4/2/15.
//  Copyright (c) 2015 Skyground Media. All rights reserved.
//

import Foundation
import UIKit

class RootViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{

    let SEGUE_ITEM_DETAIL = "showDetailSegue"
    
    let data:[String] = ["United States", "United Kingdom", "Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, The Democratic Republic of The", "Cook Islands", "Costa Rica", "Cote D'ivoire", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-bissau", "Guyana", "Haiti", "Heard Island and Mcdonald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran, Islamic Republic of", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Palestinian Territory, Occupied", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia", "Saint Pierre and Miquelon", "Saint Vincent and The Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and The South Sandwich Islands", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Republic of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Timor-leste", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Viet Nam", "Virgin Islands, British", "Virgin Islands, U.S.", "Wallis and Futuna", "Western Sahara", "Yemen", "Zambia", "Zimbabwe"]

    var itemDetail:Int?
    
    //Populates the tableview with rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //You have to set the delegate property of the UITableView to get the 
    //didSelectRowAtIndexPath function to fire. Just declaring the class as 
    //supporting the UITableViewDelegate protocol is not enough
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       //println("You selected cell #\(indexPath.row)!")

       self.itemDetail = indexPath.row as Int!
       self.performSegueWithIdentifier(SEGUE_ITEM_DETAIL, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_ITEM_DETAIL {
            let indexPath = self.itemDetail!
            (segue.destinationViewController as! DetailViewController).detailItem = data[indexPath]
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row:Int = indexPath.row
        let section:Int = indexPath.section

        //Get the index of this cell
        let cellData = self.data[row]
        
        //Create the cell itself
        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style:.Default, reuseIdentifier: reuseIdentifier)
        }
        //Populate the cell with data
        cell.textLabel?.text = cellData
        cell.backgroundColor = UIColor.clearColor()
        cell.accessoryType   = UITableViewCellAccessoryType.DetailDisclosureButton
        cell.selectionStyle  = UITableViewCellSelectionStyle.Default
        //cell.imageView.image = createThumbnail("")
        
        return cell
    }
    
    //User can delete items in the array
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func viewDidLoad() {
        initTableView()
        super.viewDidLoad()
    }
    
    func initTableView(){
        //A. Create the boundaries for the iPhone screen
        let rect:CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: view.bounds.width, height: view.bounds.height))
        
        //B. Add a table view
        let uiTableView:UITableView = UITableView(frame: rect, style: .Plain)
            uiTableView.separatorStyle = .None
            //C. Hook up a Data Source
            uiTableView.dataSource = self
        uiTableView.delegate = self
        
        //D. Add the table view to the view
        self.view.addSubview( uiTableView )
    }
    
    func createThumbnail(string:String) -> UIImage{
        let image:UIImage = UIImage(named: string)!
        return image
    }
}