//
//  AccountViewModel.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-10.
//

import Foundation
import SwiftUI
import PhotosUI

class AccountViewModel: ObservableObject {
    @Published var avatarImage: Image?
    @Published var avatarItem: PhotosPickerItem?
}
