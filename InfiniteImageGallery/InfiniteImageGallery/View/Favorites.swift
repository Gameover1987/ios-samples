
import SwiftUI

struct Favorites: View {
    @EnvironmentObject var viewModel: GalleryViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                    CollectionView(gridItems: viewModel.favoriteImages, numberOfColumns: 2)
                        .navigationTitle("Favorite List")
            }
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
            .environmentObject(GalleryViewModel())
    }
}
