//
//  User.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/12/2022.
//

import CoreLocation
import UIKit

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
    var type: UberFeatureType = .food
    var promoActive: Bool
    var icon: UIImage? {
        switch type{
        case .food:
            return UIImage(named: "uber-food")
        case .ride:
            return UIImage(named: "uber-ride")
        case .package:
            return UIImage(named: "uber-package")
        case .reserve:
            return UIImage(named: "uber-reserve")
        case .grocery:
            return UIImage(named: "uber-grocery")
        case .transit:
            return UIImage(named: "uber-transit")
        case .rent:
            return UIImage(named: "uber-rent")
        case .more:
            return UIImage(systemName: "ellipsis")
        }
    }
    
    static let data: [UberFeatureOption] = [
        UberFeatureOption(type: .ride, promoActive: true),
        UberFeatureOption(type: .food, promoActive: false),
        UberFeatureOption(type: .package, promoActive: false),
        UberFeatureOption(type: .reserve, promoActive: false),
        UberFeatureOption(type: .grocery, promoActive: false),
        UberFeatureOption(type: .transit, promoActive: false),
        UberFeatureOption(type: .rent, promoActive: false),
        UberFeatureOption(type: .more, promoActive: false),
    ]
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


struct AccountOption{
    var iconType: ActionOptionIconType
    var name: String
    
    
    static let data: [AccountOption] = [
        AccountOption(iconType: .settings, name: "Settings"),
        AccountOption(iconType: .messages, name: "Messages"),
        AccountOption(iconType: .earning, name: "Earn by driving or delivering"),
        AccountOption(iconType: .business, name: "Business hub"),
        AccountOption(iconType: .refer, name: "Refer friends, unlock deals"),
        AccountOption(iconType: .legal, name: "Legal"),
    ]
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

struct SectionOption{
    var name: String
    var icon: String?
    var description: String
    var type: OptionType
}

struct Section {
    var sectionName: String
    var sectionItems: [SectionOption]
    
    static var mainData: [SectionOption] = [
        SectionOption(name: "Home", icon: nil, description: SettingDescription.home.rawValue, type: .home),
        SectionOption(name: "Work",  icon: nil, description: SettingDescription.work.rawValue, type: .work),
        SectionOption(name: "Shortcuts", icon: nil, description: SettingDescription.shortcut.rawValue, type:.shortcut),
        SectionOption(name: "Privacy", icon: nil, description: SettingDescription.privacy.rawValue, type:.privacy),
        SectionOption(name: "Security", icon: nil, description: SettingDescription.security.rawValue, type:.security),
        SectionOption(name: "Appearance", description: SettingDescription.appearance.rawValue, type: .appearance)
    ]

    static var safetyData: [SectionOption] = [
        SectionOption(name: "Managed Trusted contacts", icon: nil, description: SettingDescription.trusted_contacts.rawValue,type: .trusted_contacts),
        SectionOption(name: "Verify your trip",  icon: nil, description: SettingDescription.verify_trip.rawValue, type: .verify_trip),
        SectionOption(name: "RideCheck", icon: nil, description: SettingDescription.ride_check.rawValue, type:.ride_check),
    ]
    
    static var familyData: [SectionOption] = [
        SectionOption(name: "Set up your family", icon: nil, description: SettingDescription.setup_family.rawValue,type: .setup_family)
    ]
    
    static var sectionArray = [
        Section(sectionName: "", sectionItems: mainData),
        Section(sectionName: "Safety", sectionItems: safetyData),
        Section(sectionName: "Family", sectionItems: familyData)
    ]

}

// MARK: EditAccountData -
struct EditAccountData{
    var dataType: EditAccountDataType
    
    static let data: [EditAccountData] = [
        EditAccountData(dataType: .firstname),
        EditAccountData(dataType: .lastname),
        EditAccountData(dataType: .phone),
        EditAccountData(dataType: .email),
        EditAccountData(dataType: .password),
    ]
}


// MARK: Rides -
struct Ride {
    var name: String
    var type: RideType
    var price: Double
    var duration: String
    var distance: String?
    var seats: Int?
    var icon: UIImage? {
        switch type {
        case .uberX:
            return UIImage(named: "uber-ride")
        case .uberBlack:
            return UIImage(named: "uber-black")
        case .uberShare:
            return UIImage(named: "uber-ride")
        case .uberSUV:
            return UIImage(named: "uber-black-suv")
        case .package:
            return UIImage(named: "uber-ride")
        }
    }
    
    static let data: [Ride] = [
        Ride(name:"UberX", type: .uberX, price: 10.99, duration: "12:53pm", distance: "2 min away", seats: 4),
        Ride(name:"Black SUV", type: .uberSUV, price: 32.86, duration: "12:54pm", distance: nil, seats: nil),
        Ride(name:"Black", type: .uberBlack, price: 24.98, duration: "12:53pm", distance: nil, seats: nil),
    ]
}
