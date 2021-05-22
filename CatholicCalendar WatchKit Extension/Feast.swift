//
//  Feast.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 5/21/21.
//

import Foundation
import UIKit

class Feast: ObservableObject {
    @Published var title: String
    @Published var color: UIColor
    @Published var date: Date
    
    init(title: String, color: UIColor, date: Date) {
        self.title = title
        self.color = color
        self.date = date
    }
    
    func dateAsFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self.date)
    }
    
    static func errorFeast() -> Feast {
        return Feast(title: "Error", color: .white, date: Date())
    }
}

enum LitColor {
    case green
    case white
    case red
    case rose
    case violet
    case black
    case gold
    case silver
}

extension UIColor {
    
    static func lcColor(for litColor: LitColor) -> UIColor {
        switch litColor {
        case .green:
            return .green
        case .white:
            return .white
        case .red:
            return .red
        case .rose:
            return .magenta
        case .violet:
            return .purple
        case .black:
            return .black
        case .gold:
            return .brown
        case .silver:
            return .gray
        }
        // TODO choose custom colors
    }
}
