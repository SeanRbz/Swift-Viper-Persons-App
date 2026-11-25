//
//  GenericListView.swift
//  ViperArchitecture
//

import SwiftUI


struct GenericListView<Destination: View>: View {
    private let items: [String]
    private let navigationTitle: String
    @Binding private var errorMessage: String?
    private let onAppear: () -> Void
    private let destination: (String) -> Destination

    init(
        items: [String],
        navigationTitle: String,
        errorMessage: Binding<String?> = .constant(nil),
        onAppear: @escaping () -> Void = {},
        @ViewBuilder destination: @escaping (String) -> Destination
    ) {
        self.items = items
        self.navigationTitle = navigationTitle
        self._errorMessage = errorMessage
        self.onAppear = onAppear
        self.destination = destination
    }

    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
                NavigationLink(value: item) {
                    Text(item)
                        .padding(.vertical, Spacing.sm)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(navigationTitle)
            .navigationDestination(for: String.self) { item in
                destination(item)
            }
            .onAppear(perform: onAppear)
            .alert("Error", isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage ?? "")
            }
        }
    }
}
