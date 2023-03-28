
import SwiftUI

struct InfiniteView: View {
    @EnvironmentObject var viewModel: GalleryViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                let loadMore = {
                    viewModel.fetch()
                }
                
                CollectionView(gridItems: viewModel.images, numberOfColumns: 3,
                               loadMore: loadMore)
                .navigationTitle("Infinite List")
                .onAppear {
                    viewModel.fetch()
                }

            }
        }
    }
}

struct InfiniteView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteView()
            .environmentObject(GalleryViewModel())
    }
}

