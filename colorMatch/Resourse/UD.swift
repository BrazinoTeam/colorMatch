//
//  UD.swift

import Foundation
class UD {
    
    static let shared = UD()
    
    private let defaults = UserDefaults.standard
    
    var scoreCoints: Int {
        get {
            return defaults.integer(forKey: "scoreCoints", defaultValue: 0)
        }
        set {
            defaults.set(newValue, forKey: "scoreCoints")
        }
    }
    
    var scorePlayed: Int {
        get {
            return defaults.integer(forKey: "scorePlayed", defaultValue: 0)
        }
        set {
            defaults.set(newValue, forKey: "scorePlayed")
        }
    }
    
    var scoreBonuses: Int {
        get {
            return defaults.integer(forKey: "scoreBonuses", defaultValue: 0)
        }
        set {
            defaults.set(newValue, forKey: "scoreBonuses")
        }
    }
    
    var beginner: Bool {
        get {
            return defaults.bool(forKey: "beginner")
        }
        set {
            defaults.set(newValue, forKey: "beginner")
        }
    }
    
    var sharpshooter: Bool {
        get {
            return defaults.bool(forKey: "sharpshooter")
        }
        set {
            defaults.set(newValue, forKey: "sharpshooter")
        }
    }
    
    var collectingCombo: Bool {
        get {
            return defaults.bool(forKey: "collectingCombo")
        }
        set {
            defaults.set(newValue, forKey: "collectingCombo")
        }
    }
    
    var dedicated: Bool {
        get {
            return defaults.bool(forKey: "dedicated")
        }
        set {
            defaults.set(newValue, forKey: "dedicated")
        }
    }
    
    var pointGiant: Bool {
        get {
            return defaults.bool(forKey: "pointGiant")
        }
        set {
            defaults.set(newValue, forKey: "pointGiant")
        }
    }
    
    var lastBonusDate: Date? {
        get {
            return defaults.object(forKey: "lastBonusDate") as? Date
        }
        set {
            defaults.set(newValue, forKey: "lastBonusDate")
        }
    }
    
    var firstLaunchDate: Date? {
        get {
            return defaults.object(forKey: "firstLaunchDate") as? Date
        }
        set {
            defaults.set(newValue, forKey: "firstLaunchDate")
        }
    }
    
    var userName: String? {
        get {
            return defaults.string(forKey: "userName")
        }
        set {
            defaults.set(newValue, forKey: "userName")
        }
    }
    
    var userID: Int? {
        get {
            return defaults.object(forKey: "userID") as? Int
        }
        set {
            defaults.set(newValue, forKey: "userID")
        }
    }
    
}

extension UserDefaults {
    func integer(forKey key: String, defaultValue: Int) -> Int {
        return self.object(forKey: key) as? Int ?? defaultValue
    }
}
