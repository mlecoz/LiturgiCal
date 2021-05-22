//
//  LiturgicalCalendarService.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 4/21/21.
//

import Foundation

protocol LiturgicalCalendarService {
    func fetchCelebration(for date: Date, completion: (String, Error) -> Void)
}

class CloudKitLiturgicalCalendarService: LiturgicalCalendarService {
    
    func fetchCelebration(for date: Date = Date(), completion: (String, Error) -> Void) {
        let cal = Calendar(identifier: .gregorian)
        let year = cal.component(.year, from: date)
        let month = cal.component(.month, from: date)
        let day = cal.component(.day, from: date)
    }
    
    private func composeRequest() {
        
    }
}
