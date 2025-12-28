# Mac Memory Monitor - Architecture & Flow

## Application Flow

```mermaid
graph TD
    Start[App Launch] --> MenuBar[Menu Bar Icon Appears]
    MenuBar --> UserClick[User Clicks Icon]
    UserClick --> ShowPopover[Popover Window Opens]
    ShowPopover --> AutoLoad[ContentView.onAppear]
    AutoLoad --> FetchData[MemoryMonitor.refreshMemoryData]
    
    FetchData --> GetApps[NSWorkspace.runningApplications]
    GetApps --> FilterApps[Filter: activationPolicy == .regular]
    FilterApps --> Loop[For Each App]
    
    Loop --> GetPID[Get Process ID]
    GetPID --> CallProc[proc_pid_rusage RUSAGE_INFO_V4]
    CallProc --> GetMemory[Extract phys_footprint]
    GetMemory --> CreateModel[Create AppMemoryInfo]
    CreateModel --> NextApp{More Apps?}
    
    NextApp -->|Yes| Loop
    NextApp -->|No| SortData[Sort by Memory Descending]
    SortData --> UpdateUI[Update @Published apps]
    UpdateUI --> Display[Display in ScrollView]
    
    Display --> UserRefresh{User Clicks Refresh?}
    UserRefresh -->|Yes| FetchData
    UserRefresh -->|No| Display
```

## Component Architecture

```mermaid
graph LR
    subgraph App [MacMemoryApp]
        Entry[MacMemoryApp.swift<br/>@main entry point]
    end
    
    subgraph UI [User Interface]
        Content[ContentView<br/>Main popover view]
        Row[AppRowView<br/>Individual app row]
        Content --> Row
    end
    
    subgraph Data [Data Layer]
        Model[AppMemoryInfo<br/>Data model]
        Monitor[MemoryMonitor<br/>@ObservableObject]
    end
    
    subgraph System [System APIs]
        NS[NSWorkspace<br/>Get running apps]
        Proc[proc_pid_rusage<br/>Get memory usage]
    end
    
    Entry -->|MenuBarExtra| Content
    Content -->|@StateObject| Monitor
    Monitor -->|@Published| Model
    Monitor --> NS
    Monitor --> Proc
    Row -->|displays| Model
```

## Data Flow

```mermaid
sequenceDiagram
    participant User
    participant MenuBar as Menu Bar Icon
    participant Content as ContentView
    participant Monitor as MemoryMonitor
    participant System as macOS APIs
    
    User->>MenuBar: Click
    MenuBar->>Content: Show popover
    Content->>Monitor: onAppear()
    Monitor->>Monitor: refreshMemoryData()
    
    Monitor->>System: NSWorkspace.runningApplications
    System-->>Monitor: Array of NSRunningApplication
    
    loop For each app
        Monitor->>System: proc_pid_rusage(pid)
        System-->>Monitor: Memory footprint bytes
        Monitor->>Monitor: Create AppMemoryInfo
    end
    
    Monitor->>Monitor: Sort by memory
    Monitor->>Content: @Published update
    Content->>User: Display app list
    
    User->>Content: Click Refresh
    Content->>Monitor: refreshMemoryData()
    Note over Monitor,System: Repeat data fetch cycle
```

## Memory Calculation

```mermaid
graph LR
    subgraph Input [System Data]
        TotalRAM[Total System RAM<br/>ProcessInfo.physicalMemory]
        AppBytes[App Memory Footprint<br/>proc_pid_rusage]
    end
    
    subgraph Calculation [Calculations]
        ToGB[Bytes ÷ 1073741824<br/>= GB]
        ToPercent[AppBytes ÷ TotalRAM × 100<br/>= Percentage]
    end
    
    subgraph Output [Display]
        Display1[2.4 GB]
        Display2[15.2%]
        Color[Color Code<br/>Blue/Orange/Red]
    end
    
    AppBytes --> ToGB --> Display1
    AppBytes --> ToPercent --> Display2
    ToPercent --> Color
    TotalRAM --> ToPercent
```

## Key Technologies

| Component | Technology | Purpose |
|-----------|-----------|---------|
| UI Framework | SwiftUI | Modern declarative UI |
| Menu Bar | MenuBarExtra | Native menu bar integration |
| Data Flow | ObservableObject + @Published | Reactive updates |
| Process List | NSWorkspace | Get running applications |
| Memory Data | proc_pid_rusage | Accurate memory footprint |
| Memory Calc | ProcessInfo | Total system memory |
| App Info | NSRunningApplication | App name, icon, PID |

## Configuration Details

### Info.plist
- `LSUIElement = YES` - No Dock icon (agent app)
- Minimum macOS version: 13.0

### Entitlements
- `com.apple.security.app-sandbox = false` - Disabled to read process memory
- Required for `proc_pid_rusage()` on other processes

### Build Settings
- Swift 5.0
- macOS 13.0+ deployment target
- Hardened Runtime enabled
- SwiftUI Previews enabled

