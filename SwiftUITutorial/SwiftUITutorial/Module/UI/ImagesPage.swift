//
//  ImagesPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/22.
//

import SwiftUI

struct ImagesPage: View {

    private let url = URL(string: "https://images.ctfassets.net/hrltx12pl8hq/1TvicFbzoxaMvy7Yk2O6Wu/84a1373f3b026fd61c6cf5a96d0bf3e0/shutterstock_1036450090_B.jpg")!
    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            image
            image_cavas
            image_resizable
            image_rending_behavior
            asyncImage
            asyncImage_phase
        }
    }
}

// MARK: - creating an image
extension ImagesPage {
    
    /*
     variableValue，SF符号时候，如果图标支持variableValue，可以设置该值

     Image(decorative: "37_icon")
     decorative装饰性资源
     init(decorative:bundle:)初始化器在SwiftUI中的Image组件里提供了一种标记和使用装饰性图像的方法，有助于提升应用的辅助功能支持，
     尤其是对于那些需要提供无障碍支持的应用来说极其重要。通过使用这个初始化器，开发者可以确保装饰性图像不会对使用辅助技术的用户产生负面影响
     */
    var image: some View {
        HStack {
            Image("37_icon")
            Image(systemName: "timelapse", variableValue: 0.4)
            Image(decorative: "37_icon")
        }
    }

    /*
     通过绘制生成一个图片
     */
    var image_cavas: some View {
        Image(size: CGSize(width: 100, height: 100), label: Text("Canvas"), colorMode: .nonLinear) { ctx in
            let path = Path(ellipseIn: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
            ctx.fill(path, with: .linearGradient(Gradient(colors: [.yellow, .orange]), startPoint: .zero, endPoint: CGPoint(x: 100, y: 100)))
        }
    }
}

// MARK: - resizable(capInsets:resizingMode:)
extension ImagesPage {

    var image_resizable: some View {
        Image("37_icon")
            .resizable()
            .frame(width: 30, height: 30)
    }
}

// MARK: - rendering behavior
extension ImagesPage {
    var image_rending_behavior: some View {
        VStack {
            Image("37_icon")
                .resizable()
                .antialiased(true)
                .frame(width: 50, height: 50)

            Image("37_icon")
                .resizable()
                .renderingMode(.original)
                .frame(width: 50, height: 50)

            HStack {
                Image(systemName: "person.crop.circle.badge.plus")
                Image(systemName: "person.crop.circle.badge.plus")
                    .renderingMode(.original)
                    .foregroundColor(.blue)
                Image(systemName: "person.crop.circle.badge.plus")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
            }
        }
    }
}

// MARK: - AsyncImage
extension ImagesPage {

    var asyncImage: some View {
        AsyncImage(url: url) { image in
            image.resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 150, height: 150)
        .border(.red)

    }

    var asyncImage_phase: some View {
        AsyncImage(url: url, scale: 1.0) { phase in
            if let image = phase.image {
                image // Displays the loaded image.
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                Color.blue // Acts as a placeholder.
            }
        }
    }
}

#Preview {
    ImagesPage()
}
