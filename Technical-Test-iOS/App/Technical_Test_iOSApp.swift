//
//  Technical_Test_iOSApp.swift
//  Technical-Test-iOS
//
//  Created by Eduardo Herrera on 20/2/23.
//

import SwiftUI

@main
struct Technical_Test_iOSApp: App {
    
    @ObservedObject var viewModelApp = ViewModelApp()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //dependency injection to propagate the viewModel throughout the view hierarchy
                .environmentObject(viewModelApp)
        }
    }
}
