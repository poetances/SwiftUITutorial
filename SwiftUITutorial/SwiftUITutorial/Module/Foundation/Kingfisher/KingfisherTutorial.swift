//
//  KingfisherTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/7/15.
//

import SwiftUI

/*
 Kingfisher非常强大的图片加载库。其加载方式可以分为三种：
 KF.url(url).set(to: imageview)

 imageview.kf.setImage(with: url)

 KingfisherManager.shared.retrieveImage(with: url) { result in
 }

 对于SwiftUI。可以直接使用KFImage

 */

struct KingfisherTutorial: View {

    var body: some View {
        List {
            Button("Load image") {

            }
        }
    }
}

#Preview {
    KingfisherTutorial()
}
