//
//  ContentView.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 4/21/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var feastHandler: CurrentFeastHandler
    var body: some View {
        VStack {
            Text("\(feastHandler.feast?.dateAsFormattedString() ?? "")")
            Text("")
            Text("\(feastHandler.feast?.title ?? "")")
                .multilineTextAlignment(.center)
                .foregroundColor(Color(feastHandler.feast?.color ?? .clear))
        }
        .padding()
        .onAppear(perform: feastHandler.update)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(feastHandler: CurrentFeastHandler(feast: Feast(title: "Third Sunday in Ordinary Time", color: UIColor.lcColor(for: LitColor.green), date: Date()), feastService: LocalTestLiturgiCalService()))
    }
}
