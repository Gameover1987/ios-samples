
import SwiftUI

struct RockBandView : View {
    private let band: Band
    
    init (band: Band) {
        self.band = band
    }
    
    var body: some View {
        VStack {
            Image(band.name)
                .resizable()
                .frame(width: 250, height: 250)
                .cornerRadius(5.0)
            
            Text(band.description)
                .multilineTextAlignment(.center)
            
            Spacer()
        }.navigationTitle(band.name)
    }
}
