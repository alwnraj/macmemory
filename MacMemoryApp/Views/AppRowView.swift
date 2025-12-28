//
//  AppRowView.swift
//  MacMemoryApp
//
//  Individual row component for displaying app memory usage
//

import SwiftUI

struct AppRowView: View {
    let app: AppMemoryInfo
    
    // Pre-calculate progress width to avoid GeometryReader overhead
    private var progressWidth: CGFloat {
        min(CGFloat(app.percentage / 100.0), 1.0)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // App icon - optimized rendering
            Group {
                if let icon = app.icon {
                    Image(nsImage: icon)
                        .resizable()
                        .interpolation(.high)
                        .antialiased(true)
                } else {
                    Image(systemName: "app.fill")
                        .resizable()
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 32, height: 32)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            // App details
            VStack(alignment: .leading, spacing: 4) {
                Text(app.name)
                    .font(.system(size: 13, weight: .medium))
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                HStack(spacing: 8) {
                    Text(String(format: "%.2f GB", app.memoryGB))
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                    
                    Text("•")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                    
                    Text(String(format: "%.1f%%", app.percentage))
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                
                // Optimized progress bar using scaleEffect instead of GeometryReader
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 4)
                    
                    // Progress - using scaleEffect for efficient rendering
                    RoundedRectangle(cornerRadius: 2)
                        .fill(progressColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .scaleEffect(x: progressWidth, anchor: .leading)
                }
                .frame(height: 4)
            }
        }
        .padding(.vertical, 4)
        .drawingGroup() // Optimize rendering by flattening the view hierarchy
    }
    
    private var progressColor: Color {
        if app.percentage > 10 {
            return .red
        } else if app.percentage > 5 {
            return .orange
        } else {
            return .blue
        }
    }
}

