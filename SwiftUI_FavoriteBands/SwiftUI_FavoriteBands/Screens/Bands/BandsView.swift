
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

struct BandsView_Previews: PreviewProvider {
    static var previews: some View {
        BandsView()
    }
}
