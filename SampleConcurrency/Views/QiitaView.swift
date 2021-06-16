//
//  QiitaView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct QiitaView: View {
    init() {
    }
    var body: some View {
        VStack {
            Button {
                print("aaa")
            } label: {
                Label("count", systemImage: "sun.dust.fill")
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.cyan, .red) // Primary, Secondary, Tertiary
            }
            Text("Swift")
                .foregroundColor(.primary)
                .font(.title3)
                .padding(.top, 2)
        }
    }
}

struct QiitaView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaView()
    }
}
