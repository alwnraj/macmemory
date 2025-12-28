//
//  MacMemoryApp.swift
//  MacMemoryApp
//
//  Main app entry point with menu bar configuration
//

import SwiftUI

@main
struct MacMemoryApp: App {
    var body: some Scene {
        // Menu bar app with no window
        MenuBarExtra {
            ContentView()
        } label: {
            Image(systemName: "memorychip")
                .symbolRenderingMode(.hierarchical)
        }
        .menuBarExtraStyle(.window)
    }
}

