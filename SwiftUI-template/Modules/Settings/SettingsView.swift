import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var viewModel: SettingsViewModel

    private let items = SettingsViewModel.Item.allCases.map { $0.rawValue }
    @State private var selectedItem: String?

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        buildContent()
            .navigationTitle("Settings")
    }

    @ViewBuilder
    private func buildContent() -> some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        } else {
            VStack {
                List(items, id: \.self) { item in
                    createListItem(text: item)
                        .onTapGesture {
                            guard let value = SettingsViewModel.Item(rawValue: item) else { return }
                            viewModel.selectedItem(value)
                        }
                        .onLongPressGesture(minimumDuration: 0.2,
                                            perform: {
                            selectedItem = nil
                        }, onPressingChanged: { isPressing in
                            if isPressing {
                                selectedItem = item
                            } else {
                                selectedItem = nil
                            }
                        })
                }
            }
        }
    }

    @ViewBuilder
    private func createListItem(text: String) -> some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .listRowBackground(selectedItem == text ? Color.blue.opacity(0.2) : Color.white)
    }
}

#Preview {
    SettingsBuilder.setup(coordinator: AppCoordinator())
}
