import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        buildContent()
            .navigationTitle("Home")
    }

    @ViewBuilder
    private func buildContent() -> some View {
//        if viewModel.isLoading {
//            ProgressView()
//                .progressViewStyle(.circular)
//        } else {
            
            VStack {
                buildList()
            }
//        }
    }
    
    @ViewBuilder
    private func buildList() -> some View {
        List {
            ForEach($viewModel.repositories, id: \.self) { item in
                Text(item.wrappedValue)
            }
        }
        .listItemTint(.monochrome)
        .listStyle(.plain)
    }
}


#if swift(>=5.9)
@available(iOS 17, macOS 14, tvOS 17, watchOS 10, *)
#Preview {
    HomeBuilder.setup(coordinator: AppCoordinator())
}
#endif
