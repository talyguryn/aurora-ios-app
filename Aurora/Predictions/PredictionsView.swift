import SwiftUI


struct ImageData: Identifiable {
    let id: Int
    let imageUrl: URL?
}

struct PredictionsView: View {
    var imagesUrls = [
//        "https://source.unsplash.com/random",
//        "https://source.unsplash.com/random",
//        "https://source.unsplash.com/random",
        "https://auroralights.ru/3days.png",
        
        "https://auroralights.ru/renders/copyright/Bz-3h.png",
        "https://auroralights.ru/renders/copyright/Bt-3h.png",
        "https://auroralights.ru/renders/copyright/speed+arrival-3h.png",
        "https://auroralights.ru/renders/copyright/density-3h.png",
        "https://auroralights.ru/3d7.jpg",
//        "https://flux.phys.uit.no/cgi-bin/mkstackplot.cgi?GifOnly&&comp=H&fin=&Sync=&",
    ]
    
    @State private var lastUpdateDate: Date = Date()
    @State private var images: [ImageData] = []
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                //            HStack {
                //                Text("Data from satellite at L1 point")
                //                    .font(.subheadline)
                //
                //                Spacer()
                //            }
                
                //            Prediction3Days()
                
                List {
                    ForEach (images) { imageData in
                        
                        AsyncImage(url: imageData.imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    }
                    
                    Text("Last update at \(lastUpdateDate.ISO8601Format())")
                        
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .onAppear {
                    generateImagesList()
                }
            }
            .navigationTitle("Data Graphs")
            .refreshable {
                generateImagesList()
            }
        }
//        .padding()
        
    }
    
    func generateImagesList() {
        images = []
        
        var i = 0
        for imageUrl in imagesUrls {
            let newImageUrl = imageUrl + "?t=" + UUID().uuidString
            let newImage = ImageData(id: i, imageUrl: URL(string: newImageUrl))
            
            images.append(newImage)
            
            i += 1
        }
        
        lastUpdateDate = Date()
    }
}

#Preview {
    PredictionsView()
}
