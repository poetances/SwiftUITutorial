//
//  MoyaPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/9/23.
//

import SwiftUI
import Moya

struct MoyaPage: View {
    var body: some View {
        VStack {

        }
    }
}

#Preview {
    MoyaPage()
}

extension TargetType {

    var baseURL: URL {
        URL(string: "")!
    }


}

enum PicWishApi: TargetType {

    var path: String {
        ""
    }

    var method: Moya.Method {
        .post
    }

    var task: Moya.Task {
        .requestParameters(parameters: ["": ""], encoding: JSONEncoding.default)
    }

    var headers: [String : String]? {
        nil
    }
}
