//
//  AppMemoryInfo.swift
//  MacMemoryApp
//
//  Data model for application memory information
//

import AppKit
import Foundation

struct AppMemoryInfo: Identifiable {
    let id: Int32 // PID serves as unique identifier
    let name: String
    let icon: NSImage?
    let memoryBytes: UInt64
    let memoryGB: Double
    let percentage: Double
    
    init(pid: Int32, name: String, icon: NSImage?, memoryBytes: UInt64, totalSystemMemory: UInt64) {
        self.id = pid
        self.name = name
        self.icon = icon
        self.memoryBytes = memoryBytes
        self.memoryGB = Double(memoryBytes) / 1_073_741_824.0 // Convert to GB
        self.percentage = (Double(memoryBytes) / Double(totalSystemMemory)) * 100.0
    }
}

