//
//  HostingViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 14/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine
extension HostingView {
class HostingViewModel: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    // MARK: OUTPUT
    @Published private(set) var accommodations: [Accommodation] = []
    
    func loadAccommodations() {
        FirDatabaseManager.shared.fetchAccommodations { accommodations in
            self.accommodations.removeAll()
            for accom in accommodations {
                if accom.ownerID == FirAuthManager.shared.session?.uid {
                    self.accommodations.append(accom)
                }
            }
        }
    }
    func stopLoadingAccommodations() {
        FirDatabaseManager.shared.removeAllActiveObservers()
    }
}

}
