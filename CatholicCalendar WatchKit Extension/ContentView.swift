//
//  ContentView.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 4/21/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var feast: Feast
    var body: some View {
        VStack {
            Text("\(feast.dateAsFormattedString())")
            Text("")
            Text("\(feast.title)")
                .multilineTextAlignment(.center)
                .foregroundColor(Color(feast.color))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(feast: Feast(title: "Third Sunday in Ordinary Time", color: UIColor.lcColor(for: LitColor.green), date: Date()))
    }
}
