//
//  Cache.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 5/21/21.
//

import Foundation

// TODO doesn't seem to be persisting in cache between launches
// TODO onAppear only calls when launch app for first time. Not whenever foreground: https://stackoverflow.com/questions/63423845/swiftui-onappear-only-running-once

class Cache {
    // UserDefaults is backing store
    // Stores:
    // todayDate:Feast
    // tomorrowDate:Feast
    
    static let todayKey = "todayKey"
    static let tomorrowKey = "tomorrowKey"
    
    static var isCacheStaleForToday: Bool = {
        guard let allegedTodayFeast = Cache.getTodayFeastFromCache() else { return true }
        let cal = Calendar(identifier: .gregorian)
        return !cal.isDateInToday(allegedTodayFeast.date)
    }()
    
    static var isCacheStaleForTomorrow: Bool = {
        guard let allegedTmrwFeast = Cache.getTomorrowFeastFromCache() else { return true }
        let cal = Calendar(identifier: .gregorian)
        return !cal.isDateInTomorrow(allegedTmrwFeast.date)
    }()
    
    static var isTomorrowToday: Bool = {
        guard let allegedTmrwFeast = getTomorrowFeastFromCache() else { return false }
        let cal = Calendar(identifier: .gregorian)
        return cal.isDateInToday(allegedTmrwFeast.date)
    }()
    
    private static func put(feast: Feast, for key: String) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: feast, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch (let error) {
            print(error)
        }
        
    }
    
    static func putToday(feast: Feast) {
        put(feast: feast, for: Cache.todayKey)
    }
    
    static func putTomorrow(feast: Feast) {
        put(feast: feast, for: Cache.tomorrowKey)
    }
    
    private static func get(key: String) -> Feast? {
        do {
            guard let codedFeast = UserDefaults.standard.object(forKey: key) as? Data, let feast = try NSKeyedUnarchiver.unarchivedObject(ofClass: Feast.self, from: codedFeast) else { return nil }
            return feast
        } catch (let error) {
            print(error)
        }
        return nil
    }
    
    static func getTodayFeastFromCache() -> Feast? {
        return get(key: Cache.todayKey)
    }
    
    static func getTomorrowFeastFromCache() -> Feast? {
        return get(key: Cache.tomorrowKey)
    }
}
