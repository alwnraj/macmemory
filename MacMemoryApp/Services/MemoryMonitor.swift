//
//  MemoryMonitor.swift
//  MacMemoryApp
//
//  Service to fetch memory usage information for running applications
//

import AppKit
import Foundation

class MemoryMonitor: ObservableObject {
    @Published var apps: [AppMemoryInfo] = []
    @Published var totalSystemMemoryGB: Double = 0
    @Published var isLoading: Bool = false
    
    private let totalSystemMemory: UInt64
    private let backgroundQueue = DispatchQueue(label: "com.macmemory.monitor", qos: .utility)
    private var refreshWorkItem: DispatchWorkItem?
    
    // Minimum memory threshold (1 MB) to filter out noise
    private let minimumMemoryBytes: UInt64 = 1_048_576
    
    init() {
        self.totalSystemMemory = ProcessInfo.processInfo.physicalMemory
        self.totalSystemMemoryGB = Double(totalSystemMemory) / 1_073_741_824.0
    }
    
    func refreshMemoryData() {
        // Cancel any pending refresh to debounce rapid calls
        refreshWorkItem?.cancel()
        
        // Update loading state on main thread
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        // Create work item for background processing
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            let runningApps = NSWorkspace.shared.runningApplications
            var memoryInfos: [AppMemoryInfo] = []
            
            for app in runningApps {
                // Filter to only user-visible applications
                guard app.activationPolicy == .regular else { continue }
                
                let pid = app.processIdentifier
                let appName = app.localizedName ?? "Unknown"
                
                // Get memory usage for this process
                if let memoryBytes = self.getMemoryUsage(for: pid),
                   memoryBytes >= self.minimumMemoryBytes {
                    // Only include apps above minimum threshold to reduce noise
                    let info = AppMemoryInfo(
                        pid: pid,
                        name: appName,
                        icon: app.icon, // Icon fetched on-demand, cached by NSWorkspace
                        memoryBytes: memoryBytes,
                        totalSystemMemory: self.totalSystemMemory
                    )
                    memoryInfos.append(info)
                }
            }
            
            // Sort by memory usage (highest first)
            memoryInfos.sort { $0.memoryBytes > $1.memoryBytes }
            
            // Update UI on main thread
            DispatchQueue.main.async {
                self.apps = memoryInfos
                self.isLoading = false
            }
        }
        
        refreshWorkItem = workItem
        backgroundQueue.async(execute: workItem)
    }
    
    private func getMemoryUsage(for pid: Int32) -> UInt64? {
        var info = rusage_info_v4()
        let result = withUnsafeMutableBytes(of: &info) { buffer in
            buffer.withMemoryRebound(to: rusage_info_t?.self) { pointer in
                proc_pid_rusage(pid, RUSAGE_INFO_V4, pointer.baseAddress)
            }
        }
        
        guard result == 0 else {
            return nil
        }
        
        // Return phys_footprint which represents the actual physical memory used
        return info.ri_phys_footprint
    }
}

