//
//  AlertSubject.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/20.
//

import SwiftUI
import Combine

class AlertSubject: ObservableObject {
    @Published var isShow: Bool = false
    @Published var title: String = "エラー"
    @Published var message: String = "不具合が発生しました。お手数ですが時間をおいてもう一度お試しください。"

    var alert: Alert {
        Alert(
            title: Text(title),
            message: Text(message),
            dismissButton: .default(Text("OK")))
    }

    func show(message: String) {
        self.message = message
        self.isShow.toggle()
    }

    func show(error: Error) {
        if let apiError = error as? APIError {
            self.message = apiError.message
            self.isShow.toggle()
        }
    }
}
