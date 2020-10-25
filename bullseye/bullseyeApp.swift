//
//  bullseyeApp.swift
//  bullseye
//
//  Created by James Adams on 22/10/20.
//

import SwiftUI

@main
struct bullseyeApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationView {
            ContentView()
          }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
