//
//  LoadingView.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/13/22.
//

import SwiftUI

struct LoadingView: View {
    var tintColor: Color = .gray
    var scaleSize: CGFloat = 2.0
    var loadingText: String = "Getting data..."

    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
            .padding()
        Text(loadingText)
    }
}
