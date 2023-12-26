import SwiftUI
import AVKit

struct WeatherView: View {
    @State private var player = AVPlayer()
    
    var body: some View {
        let weatherVideoUrl = "http://auroralights.ru/mp4/sat_5063_latest.mp4"
        
        NavigationStack {
            VStack {
                VideoPlayer(player: player)
//                    .edgesIgnoringSafeArea(.all)
//                    .navigationBarBackButtonHidden()
                    .onAppear {
                        let url = URL(string: weatherVideoUrl)!
                        
                        player = AVPlayer(url: url)
                        player.play()
                        
                    }
                    .onDisappear {
                        player.pause()
                    }
            }
            .navigationTitle("Weather")
        }
    }
}

#Preview {
    WeatherView()
}
