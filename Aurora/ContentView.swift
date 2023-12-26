import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .predictions
    
    enum Tab {
        case foryou
        case predictions
        case weather
        case observations
    }
    
    var body: some View {
        TabView(selection: $selection) {
            PredictionsView()
                .tabItem {
//                    Label("For you", systemImage: "heart.text.square")
                    Label("Data Graphs", systemImage: "newspaper")
                }
                .tag(Tab.foryou)
            
//            PredictionsView()
//                .tabItem {
//                    Label("Predictions", systemImage: "newspaper")
//                }
//                .tag(Tab.predictions)
            
            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud")
                }
                .tag(Tab.weather)

//            PredictionsView()
//                .tabItem {
//                    Label("Observations", systemImage: "photo")
//                }
//                .tag(Tab.observations)
        }
    }
}

#Preview {
    ContentView()
}
