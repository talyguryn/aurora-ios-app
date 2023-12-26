import SwiftUI
import Charts

func getKpColor(index: Int) -> Color {
    switch index {
        case 0...2:
            return Color(hex: "1e3731")
        case 3:
            return Color(hex: "3c6322")
        case 4:
            return Color(hex: "919733")
        case 5:
            return Color(hex: "804b19")
        case 6:
            return Color(hex: "58212a")
        case 7:
            return Color(hex: "40253b")
        case 8:
            return Color(hex: "232d40")
        case 9:
            return Color(hex: "333333")
        default:
            return Color(hex: "ffffff")
    }
}

struct PredictionFrame: Identifiable, Codable {
    var id: Int
    var time_tag: Date
    var kp: Int
    var observed: String
    var noaa_scale: String?
}

@MainActor
class PredictionModel: ObservableObject {
    @Published var graph: [PredictionFrame] = [
        PredictionFrame (
            id: 0,
            time_tag: Date(),
            kp: 5,
            observed: "observed"
        ),
        PredictionFrame (
            id: 1,
            time_tag: Date(),
            kp: 5,
            observed: "observed"
        ),
        PredictionFrame (
            id: 2,
            time_tag: Date(),
            kp: 5,
            observed: "observed"
        ),
        PredictionFrame (
            id: 3,
            time_tag: Date(),
            kp: 2,
            observed: "observed"
        ),
        PredictionFrame (
            id: 4,
            time_tag: Date(),
            kp: 5,
            observed: "observed"
        ),
        PredictionFrame (
            id: 5,
            time_tag: Date(),
            kp: 8,
            observed: "observed"
        ),
    ]

    func reload() async {
        let url = URL(string: "https://services.swpc.noaa.gov/products/noaa-planetary-k-index-forecast.json")!
        let urlSession = URLSession.shared

        do {
            let (data, _) = try await urlSession.data(from: url)
            
            var rawData = try JSONDecoder().decode([[String?]].self, from: data)
            rawData.removeFirst()
//
//            debugPrint(self.graph.count)
//
//            self.graph = self.graph.suffix(10)
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}

struct CountriesView: View {
    @StateObject var predictionModel = PredictionModel()

    var body: some View {
//        List {
        Chart {
            ForEach(predictionModel.graph) { graphItem in
                BarMark(
//                    x: .value("Date", graphItem.time_tag),
                    x: .value("Date", graphItem.id),
                    y: .value("KP Index", graphItem.kp)
                )
                .foregroundStyle(getKpColor(index: graphItem.kp))
            }
        }
        .chartYScale(domain: 0...10)
        .task {
            await self.predictionModel.reload()
        }
        .refreshable {
            await self.predictionModel.reload()
        }
        
//        List(countriesModel.countries) { country in
//            Text(country.name)
//        }
//        .task {
//            await self.countriesModel.reload()
//        }
//        .refreshable {
//            await self.countriesModel.reload()
//        }
    }
}

#Preview {
    CountriesView()
}



//struct Prediction3Days: View {
//    var body: some View {
//        Chart {
//
//
//            ForEach(0...10, id: \.self) { index in
//                BarMark(x: .value("Type", "bird \(index)"),
//                        y: .value("Population", index))
//                .foregroundStyle(.pink)
//            }
//
//            BarMark(x: .value("Type", "bird"),
//                    y: .value("Population", 1))
//            .foregroundStyle(.pink)
//
//            BarMark(x: .value("Type", "dog"),
//                    y: .value("Population", 2))
//            .foregroundStyle(.green)
//
//            BarMark(x: .value("Type", "cat"),
//                    y: .value("Population", 3))
//            .foregroundStyle(.blue)
//        }
//        .aspectRatio(1, contentMode: .fit)
//        .padding()
//
////        let imageURL = URL(string: "https://auroralights.ru/3days.png")
////
////        AsyncImage(url: imageURL) { image in
////            image
////                .resizable()
////                .aspectRatio(contentMode: .fit)
////        } placeholder: {
////            ProgressView()
////        }
//    }
//}
//
//#Preview {
//    Prediction3Days()
//}
