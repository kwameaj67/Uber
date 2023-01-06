//
//  User.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/12/2022.
//

import Foundation

enum AccountType: String {
    case rider = "rider"
    case driver = "driver"
}
struct User {
    var fullname: String
    var email: String
    var accountType: AccountType?
    
    
    init(dictionary:[String: Any]) {
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? AccountType
    }
}

enum RecentLocationType{
    case work
    case random
}
struct RecentLocation {
    var name: String
    var location: String
    var icon: RecentLocationType
    
    
    static let data: [RecentLocation] = [
        RecentLocation(name: "Work", location: "Petra Trust Company Limited", icon: .work),
        RecentLocation(name: "Accra Mall", location: "Plot C11 Tetteh Quarshie Interchange, Spintex Rd, Accra", icon: .random),
        RecentLocation(name: "Labone", location: "Accra", icon: .random),
    ]
}

struct UberFeatureOption {
    var name: String
    var icon: String
    
    
    static let data: [UberFeatureOption] = [
        UberFeatureOption(name: "Ride", icon: "uber-car"),
        UberFeatureOption(name: "Package", icon: "uber-package"),
        UberFeatureOption(name: "Reserve", icon: "uber-reserve")
    ]
}

enum TripStatus{
    case cancelled
    case booked
}
struct Trip{
    var location: String
    var date: String
    var price: Double
    var status: TripStatus
    
    
    static var data: [Trip] = [
        Trip(location: "International Community School (Preschool)", date: "Dec 23 · 8:14 AM", price: 12.00, status: .cancelled),
        Trip(location: "30 Gulf St", date: "Mar 28 · 7:46 AM", price: 30.00, status: .booked),
        Trip(location: "Dolla ventures", date: "Mar 28 · 7:47 AM", price: 0.00, status: .cancelled),
        Trip(location: "Unnamed Road", date: "Feb 21 · 9:42 AM", price: 20.00, status: .booked),
        Trip(location: "25 Labone Cres", date: "Nov 10 · 11:18 AM", price: 15.00, status: .booked),
        Trip(location: "Unnamed Road", date: "Mar 10 · 6:10 PM", price: 5.00, status: .booked),
        Trip(location: "UberX", date: "Oct 12 · 8:45 AM", price: 0.00, status: .cancelled),
        Trip(location: "Unnamed Road", date: "Sept 24 · 4:09 PM", price: 8.00, status: .booked),
        Trip(location: "Unnamed Road", date: "Sept 16 · 12:01 PM", price: 12.00, status: .booked),
        Trip(location: "Accra - Tema Motoway", date: "Aug 9 · 7:46 AM", price: 18.00, status: .booked),
        Trip(location: "30 Gulf St", date: "Nov 21 · 7:36 AM", price: 0.00, status: .cancelled),
        Trip(location: "Akilagpa Sawyerr Road", date: "Nov 3 · 8:56 AM", price: 0.00, status: .booked),
    ]
}

class UserLocation {
    var lat: Double
    var lng: Double
    
    init(lat: Double,lng:Double){
        self.lat = lat
        self.lng = lng
    }
}

enum ActionOptionIconType{
    case messages
    case settings
    case earning
    case legal
}
struct AccountOption{
    var iconType: ActionOptionIconType
    var name: String
    
    
    static let data: [AccountOption] = [
        AccountOption(iconType: .messages, name: "Messages"),
        AccountOption(iconType: .settings, name: "Settings"),
        AccountOption(iconType: .earning, name: "Earn by driving or delivering"),
        AccountOption(iconType: .legal, name: "Legal"),
    ]
}

enum AccountActionType{
    case help
    case wallet
    case trips
}
struct AccountActionOption {
    var name: String
    var icon: String?
    var type: AccountActionType
    
    static let data: [AccountActionOption] = [
        AccountActionOption(name: "Help", icon: "uber-help",type: .help),
        AccountActionOption(name: "Wallet", icon: "uber-wallet",type: .wallet),
        AccountActionOption(name: "Trips", icon: nil,type: .trips)
    ]
}
