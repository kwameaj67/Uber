//
//  User.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/12/2022.
//

import CoreLocation

enum AccountType: String {
    case rider = "rider"
    case driver = "driver"
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
        RecentLocation(name: "Work", location: "Ghana Gas Limited", icon: .work),
        RecentLocation(name: "Accra Mall", location: "Plot C11 Tetteh Quarshie Interchange, Spintex Rd, Accra", icon: .random),
        RecentLocation(name: "Labone", location: "Accra", icon: .random),
    ]
}

struct UberFeatureOption {
    var name: String
    var icon: String
    var promoActive: Bool
    
    
    static let data: [UberFeatureOption] = [
        UberFeatureOption(name: "Ride", icon: "uber-car",promoActive: true),
        UberFeatureOption(name: "Reserve", icon: "uber-reserve",promoActive: false),
        UberFeatureOption(name: "Package", icon: "uber-package",promoActive: false)
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
    case business
    case earning
    case legal
    case refer
}
struct AccountOption{
    var iconType: ActionOptionIconType
    var name: String
    
    
    static let data: [AccountOption] = [
        AccountOption(iconType: .settings, name: "Settings"),
        AccountOption(iconType: .messages, name: "Messages"),
        AccountOption(iconType: .business, name: "Business hub"),
        AccountOption(iconType: .refer, name: "Refer friends, unlock deals"),
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



// MARK: Settings data
enum DescriptionData: String {
    case home = "Unnamed Road"
    case work = "Petra Trust Company Limited"
    case shortcut =  "Managed saved location"
    case privacy = "Manage the data you share with us"
    case security = "Control your account security with 2-setup verification"
    case appearance = "Use device settings"
    case trusted_contacts = "Share your trip status with Family and friends in a single tap"
    case verify_trip = "Use a PIN to make sure you get in the right car"
    case ride_check = "Manage your RideCheck notifications"
    case setup_family = "Pay for your loved ones and get trip notifications"
    case signout = "Signout"
}
enum OptionType {
    case home
    case work
    case shortcut
    case privacy
    case security
    case appearance
    case trusted_contacts
    case verify_trip
    case ride_check
    case setup_family
    case signout
}
struct SectionOption{
    var name: String
    var icon: String?
    var description: String
    var type: OptionType
}

struct Section {
    var sectionName: String
    var sectionItems: [SectionOption]
    
    static var mainData:[SectionOption] = [
        SectionOption(name: "Home", icon: nil, description: DescriptionData.home.rawValue, type: .home),
        SectionOption(name: "Work",  icon: nil, description: DescriptionData.work.rawValue, type: .work),
        SectionOption(name: "Shortcuts", icon: nil, description: DescriptionData.shortcut.rawValue, type:.shortcut),
        SectionOption(name: "Privacy", icon: nil, description: DescriptionData.privacy.rawValue, type:.privacy),
        SectionOption(name: "Security", icon: nil, description: DescriptionData.security.rawValue, type:.security),
        SectionOption(name: "Appearance", description: DescriptionData.appearance.rawValue, type: .appearance)
    ]

    static var safetyData:[SectionOption] = [
        SectionOption(name: "Managed Trusted contacts", icon: nil, description: DescriptionData.trusted_contacts.rawValue,type: .trusted_contacts),
        SectionOption(name: "Verify your trip",  icon: nil, description: DescriptionData.verify_trip.rawValue, type: .verify_trip),
        SectionOption(name: "RideCheck", icon: nil, description: DescriptionData.ride_check.rawValue, type:.ride_check),
    ]
    
    static var familyData:[SectionOption] = [
        SectionOption(name: "Set up your family", icon: nil, description: DescriptionData.setup_family.rawValue,type: .setup_family),
    ]
    static var signoutData:[SectionOption] = [
        SectionOption(name: "Sign out", icon: nil, description:"",type: .signout),
    ]
    
    static var sectionArray = [
        Section(sectionName: "", sectionItems: mainData),
        Section(sectionName: "Safety", sectionItems: safetyData),
        Section(sectionName: "Family", sectionItems: familyData),
//        Section(sectionName: "Signout", sectionItems: signoutData)
    ]

}

