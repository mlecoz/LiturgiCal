//
//  Cache.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 5/21/21.
//

import Foundation

class Cache {
    // UserDefaults is backing store
    // Stores:
    // todayDate:Feast
    // tomorrowDate:Feast
    
    static let todayKey = "todayKey"
    static let tomorrowKey = "tomorrowKey"
    
    static var isCacheStaleForToday: Bool = {
        guard let allegedTodayFeast = UserDefaults.standard.object(forKey: todayKey) as? Feast else { return true }
        let cal = Calendar(identifier: .gregorian)
        return !cal.isDateInToday(allegedTodayFeast.date)
    }()
    
    static var isCacheStaleForTomorrow: Bool = {
        guard let allegedTmrwFeast = UserDefaults.standard.object(forKey: tomorrowKey) as? Feast else { return true }
        let cal = Calendar(identifier: .gregorian)
        return !cal.isDateInTomorrow(allegedTmrwFeast.date)
    }()
    
    static var isTomorrowToday: Bool = {
        guard let allegedTmrwFeast = UserDefaults.standard.object(forKey: tomorrowKey) as? Feast else { return false }
        let cal = Calendar(identifier: .gregorian)
        return cal.isDateInToday(allegedTmrwFeast.date)
    }()
    
    private static func put(feast: Feast, for key: String) {
        UserDefaults.standard.set(feast, forKey: key)
    }
    
    static func putToday(feast: Feast) {
        put(feast: feast, for: Cache.todayKey)
    }
    
    static func putTomorrow(feast: Feast) {
        put(feast: feast, for: Cache.tomorrowKey)
    }
    
    private static func get(key: String) -> Feast? {
        guard let feast = UserDefaults.standard.object(forKey: key) as? Feast else { return nil }
        return feast
    }
    
    static func getTodayFeastFromCache() -> Feast? {
        return get(key: Cache.todayKey)
    }
    
    static func getTomorrowFeastFromCache() -> Feast? {
        return get(key: Cache.tomorrowKey)
    }
}
