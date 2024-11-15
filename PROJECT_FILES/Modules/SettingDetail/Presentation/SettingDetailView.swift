import SwiftUI

struct SettingDetailView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var viewModel: SettingDetailViewModel

    private var isShowCloseButton: Bool

    init(viewModel: SettingDetailViewModel,
         isShowCloseButton: Bool = false) {
        self.viewModel = viewModel
        self.isShowCloseButton = isShowCloseButton
    }

    var body: some View {
        if isShowCloseButton {
            NavigationStack(path: $appCoordinator.path) {
                buildContent()
                    .navigationTitle("Setting Detail")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                viewModel.close()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                        }
                    }
            }
        } else {
            buildContent()
                .navigationTitle("Setting Detail")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private func buildContent() -> some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        } else {
            VStack {
                Text("Loaded")
            }
        }
    }
}

#if swift(>=5.9)
@available(iOS 17, macOS 14, tvOS 17, watchOS 10, *)
#Preview {
    SettingDetailBuilder.setup(coordinator: AppCoordinator())
}
#endif
