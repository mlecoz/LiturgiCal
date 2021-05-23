//
//  CurrentFeastHandler.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 5/22/21.
//

import Foundation

class CurrentFeastHandler: ObservableObject {
    @Published var feast: Feast?
    
    let feastService: LiturgicalCalendarService
    
    init(feast: Feast?, feastService: LiturgicalCalendarService) {
        self.feast = feast
        self.feastService = feastService
    }
    
    func update() {
        
        // Happens upon launch
        if nil == feast {
            // Get from cache if it's there
            if !Cache.isCacheStaleForToday {
                self.feast = Cache.getTodayFeastFromCache()
            }
        }

        // move tomorrow to today if applicable
        if Cache.isTomorrowToday {
            if let updatedTodayFeast = Cache.getTomorrowFeastFromCache() {
                Cache.putToday(feast: updatedTodayFeast)
                self.feast = updatedTodayFeast // updates UI
            }
        }
        
        // today stale => fetch, update obsobj and cache
        if Cache.isCacheStaleForToday {
            self.feastService.fetchCelebration(for: Date()) { feast, error in
                if let error = error {
                    print(error)
                } else {
                    Cache.putToday(feast: feast)
                    self.feast = feast
                }
            }
        }
        
        // tomorrow stale => fetch, update cache
        if Cache.isCacheStaleForTomorrow {
            if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
                self.feastService.fetchCelebration(for: tomorrow) { feast, error in
                    if let error = error {
                        print(error)
                    } else {
                        Cache.putTomorrow(feast: feast)
                    }
                }
            }
        }
    }
}
