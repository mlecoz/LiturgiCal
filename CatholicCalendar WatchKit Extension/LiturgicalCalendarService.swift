//
//  LiturgicalCalendarService.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 4/21/21.
//

import Foundation

protocol LiturgicalCalendarService {
    func fetchCelebration(for date: Date, completion: (Feast, Error?) -> Void)
}

class CloudKitLiturgiCalService: LiturgicalCalendarService {
    func fetchCelebration(for date: Date = Date(), completion: (Feast, Error?) -> Void) {
        let cal = Calendar(identifier: .gregorian)
        let year = cal.component(.year, from: date)
        let month = cal.component(.month, from: date)
        let day = cal.component(.day, from: date)
    }
}

class LocalTestLiturgiCalService: LiturgicalCalendarService {
    func fetchCelebration(for date: Date = Date(), completion: (Feast, Error?) -> Void) {
        completion(Feast(title: "Feast of St. John Paul II", color: .green, date: Date()), nil)
    }
    
    
}
