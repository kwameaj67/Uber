//
//  Enums.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 7/26/23.
//

import Foundation




enum AccountType: String {
    case rider = "rider"
    case driver = "driver"
}

enum RecentLocationType{
    case work
    case random
}

enum UberFeatureType: String, CaseIterable{
    case ride = "Ride"
    case food = "Food"
    case package = "Package"
    case reserve = "Reserve"
    case grocery = "Grocery"
    case transit = "Transit"
    case rent = "Rent"
    case more = "More"
}

enum TripStatus{
    case cancelled
    case booked
}

enum ActionOptionIconType{
    case messages
    case settings
    case business
    case earning
    case legal
    case refer
}

enum AccountActionType{
    case help
    case wallet
    case trips
}

// MARK: Settings data -
enum SettingDescription: String {
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

// MARK: EditAccount data -
enum EditAccountDataType{
    case firstname
    case lastname
    case phone
    case email
    case password
}


// MARK: Rides -

enum RideType{
    case uberX
    case uberBlack
    case uberShare
    case uberSUV
    case package
}
