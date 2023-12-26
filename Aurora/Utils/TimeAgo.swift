import SwiftUI

struct TimeAgo: View {
    @State private var timer: Timer?
    @State private var timeAgoPhrase: String = "Last updated a few seconds ago"

    var savedTime = Date()
    
    var body: some View {
        
        VStack {
            Text(timeAgoPhrase)
                .onAppear {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        updateTime()
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                    timer = nil
                }
        }
    }
    
    func updateTime() {
        timeAgoPhrase = timeAgo(savedTime: savedTime)
    }
    
    func timeAgo(savedTime: Date) -> String {
        let currentTime = Date()
        let timeInterval = currentTime.timeIntervalSince(savedTime)
        
        if timeInterval < 60 {
            let seconds = Int(timeInterval)
            return "Last updated \(seconds) second\(seconds == 1 ? "" : "s") ago"
//            return "Last updated a few seconds ago"
        } else if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            return "Last updated \(minutes) minute\(minutes == 1 ? "" : "s") ago"
        } else {
            let hours = Int(timeInterval / 3600)
            return "Last updated \(hours) hour\(hours == 1 ? "" : "s") ago"
        }
    }
}

#Preview {
    TimeAgo()
}

