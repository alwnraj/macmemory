//
//  ContentView.swift
//  MacMemoryApp
//
//  Main popover view displaying list of apps and their memory usage
//

import SwiftUI

struct ContentView: View {
    @StateObject private var memoryMonitor = MemoryMonitor()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 8) {
                Text("Memory Usage")
                    .font(.system(size: 16, weight: .semibold))
                
                Text(String(format: "Total System Memory: %.1f GB", memoryMonitor.totalSystemMemoryGB))
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            Divider()
            
            // App list
            if memoryMonitor.isLoading && memoryMonitor.apps.isEmpty {
                // Loading state
                VStack(spacing: 12) {
                    ProgressView()
                        .scaleEffect(0.8)
                    
                    Text("Loading memory data...")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else if memoryMonitor.apps.isEmpty {
                // Empty state
                VStack(spacing: 12) {
                    Image(systemName: "app.dashed")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    
                    Text("No apps loaded")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    
                    Text("Click Refresh to load memory data")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                // App list with optimized rendering
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(memoryMonitor.apps) { app in
                            AppRowView(app: app)
                                .padding(.horizontal, 12)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .frame(maxHeight: 400)
            }
            
            Divider()
            
            // Footer with refresh button
            HStack {
                Spacer()
                
                Button(action: {
                    memoryMonitor.refreshMemoryData()
                }) {
                    HStack(spacing: 6) {
                        if memoryMonitor.isLoading {
                            ProgressView()
                                .scaleEffect(0.7)
                                .frame(width: 11, height: 11)
                        } else {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 11))
                        }
                        Text("Refresh")
                            .font(.system(size: 12, weight: .medium))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.borderedProminent)
                .disabled(memoryMonitor.isLoading)
                
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .frame(width: 350)
        .onAppear {
            // Only refresh on first appear to avoid unnecessary work
            if memoryMonitor.apps.isEmpty {
                memoryMonitor.refreshMemoryData()
            }
        }
    }
}

#Preview {
    ContentView()
}

