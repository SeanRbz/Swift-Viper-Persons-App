//
//  UserListPresenter.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

import SwiftUI
import Combine

protocol UserListPresenting: ObservableObject {
    var users: [User] { get }
    func viewDidLoad()
}

final class UserListPresenter: UserListPresenting {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    private let interactor: UserListInteracting
    private let router: UserListRouter
    
    init(interactor: UserListInteracting, router: UserListRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        guard users.isEmpty else { return }
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                self.users = try await self.interactor.fetchUsers()
                self.errorMessage = nil
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
