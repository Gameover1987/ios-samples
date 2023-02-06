
import SwiftUI

struct BandsView: View {
    
    @StateObject private var bandsViewModel = BandsViewModel(bandsProvider: BandsProvider.shared)
    
    var body: some View {
        NavigationView {
            List(bandsViewModel.bands) { band in
                NavigationLink {
                    RockBandView(band: band)
                } label: {
                    RockBandListItemView(band: band)
                }
                .navigationTitle("Rock bands")
            }
            Text("Select a Note")
        }
    }
}

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

struct BandsView_Previews: PreviewProvider {
    static var previews: some View {
        BandsView()
    }
}
