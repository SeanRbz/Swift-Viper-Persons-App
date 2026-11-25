//
//  ViperArchitectureApp.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

import SwiftUI

@main
struct VIPERApp: App {
    var body: some Scene {
        WindowGroup {
            HomeRouter.makeHomeView()
        }
    }
}
