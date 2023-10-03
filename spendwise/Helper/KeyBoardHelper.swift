//
//  KeyBoardHelper.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-03.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { rect in
                rect.height
            }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
        
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
    }
}
