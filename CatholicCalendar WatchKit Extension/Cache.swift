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
    
    var litCalService: LiturgicalCalendarService
    
    init(litCalService: LiturgicalCalendarService) {
        self.litCalService = litCalService
    }
    
    /**
    Examples
    UserDefaults.standard.set("TEST", forKey: "Key")
     UserDefaults.standard.string(forKey: "Key")
     UserDefaults.standard.removeObject(forKey: "Key")
     if let appDomain = Bundle.main.bundleIdentifier {
     UserDefaults.standard.removePersistentDomain(forName: appDomain)
      }
     */
    
    private static var isCacheStaleForToday: Bool = {
        guard let allegedTodayFeast = UserDefaults.standard.object(forKey: todayKey) as? Feast else { return true }
        let cal = Calendar(identifier: .gregorian)
        return !cal.isDateInToday(allegedTodayFeast.date)
    }()
    
    private static var isCacheStaleForTomorrow: Bool = {
        guard let allegedTmrwFeast = UserDefaults.standard.object(forKey: tomorrowKey) as? Feast else { return true }
        let cal = Calendar(identifier: .gregorian)
        return !cal.isDateInTomorrow(allegedTmrwFeast.date)
    }()
    
    private static var isTomorrowToday: Bool = {
        guard let allegedTmrwFeast = UserDefaults.standard.object(forKey: tomorrowKey) as? Feast else { return false }
        let cal = Calendar(identifier: .gregorian)
        return cal.isDateInToday(allegedTmrwFeast.date)
    }()
    
    // TODO ???? still need to think abot this. how does swiftui tie in with updates? should I poll?
    func todayFeast() -> Feast? {
        // check if can use tomorrow's
        // updateCache()
        // TODO block on that ^
        guard let theFeast = UserDefaults.standard.object(forKey: Cache.todayKey) as? Feast else { return nil }
        return theFeast
    }
    
    func updateCache() {
        if Cache.isCacheStaleForToday {
            self.litCalService.fetchCelebration(for: Date()) { feast, error in
                if let error = error {
                    print(error)
                } else {
                    UserDefaults.standard.set(feast, forKey: Cache.todayKey)
                }
            }
        }
        
        // Also check to see if tomorrow is stale
        if Cache.isCacheStaleForTomorrow {
            if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
                self.litCalService.fetchCelebration(for: tomorrow) { feast, error in
                    if let error = error {
                        print(error)
                    } else {
                        UserDefaults.standard.set(feast, forKey: Cache.tomorrowKey)
                    }
                }
            }
        }

        return feast
    }
}
