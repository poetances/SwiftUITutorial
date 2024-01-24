//
//  SceneTutorail.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/21.
//

import SwiftUI

struct SceneTutorail: View {
    var body: some View {
        ScrollView {
            Text(
"""
public protocol Scene {

    /// The type of scene that represents the body of this scene.
    ///
    /// When you create a custom scene, Swift infers this type from your
    /// implementation of the required ``SwiftUI/Scene/body-swift.property``
    /// property.
    associatedtype Body : Scene

    /// The content and behavior of the scene.
    ///
    /// For any scene that you create, provide a computed `body` property that
    /// defines the scene as a composition of other scenes. You can assemble a
    /// scene from built-in scenes that SwiftUI provides, as well as other
    /// scenes that you've defined.
    ///
    /// Swift infers the scene's ``SwiftUI/Scene/Body-swift.associatedtype``
    /// associated type based on the contents of the `body` property.
    @SceneBuilder @MainActor var body: Self.Body { get }
}
""")
        }
    }
}

#Preview {
    SceneTutorail()
}
