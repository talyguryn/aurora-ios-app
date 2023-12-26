import SwiftUI

struct Prediction3Days: View {
    var body: some View {
        
        let imageURL = URL(string: "https://auroralights.ru/3days.png")
        
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    Prediction3Days()
}
