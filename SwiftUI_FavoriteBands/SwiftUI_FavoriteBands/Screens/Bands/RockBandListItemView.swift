
import SwiftUI

struct RockBandListItemView : View {
    private let band: Band
    
    init (band: Band) {
        self.band = band
    }
    
    var body: some View {
        HStack {
            Image(band.name)
                .resizable()
                .cornerRadius(5.0)
                .frame(width: 50.0, height: 50.0)
            
            VStack (alignment: .leading) {
                Text(band.name)
                    .frame(height: 20.0)
                    .truncationMode(Text.TruncationMode.tail)
                Text(band.description)
                    .foregroundColor(.gray)
                    .frame(height: 20.0)
                    .truncationMode(Text.TruncationMode.tail)
            }
        }
    }
}
