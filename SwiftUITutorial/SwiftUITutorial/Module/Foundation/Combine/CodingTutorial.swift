//
//  CodingTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/23.
//

import SwiftUI
import Combine

struct CodingTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    var body: some View {
        List {
            encode
            decode
        }
        .navigationTitle("Coding")
    }
}

extension CodingTutorial {

    // MARK: - func encode<Coder>(encoder: Coder) -> Publishers.Encode<Self, Coder> where Coder : TopLevelEncoder
    /// Use encode(encoder:) with a JSONDecoder (or a PropertyListDecoder for property lists) to encode an Encodable struct into Data that could be used to make a JSON string (or written to disk as a binary plist in the case of property lists).
    ///
    /// extension JSONEncoder : TopLevelEncoder {
    ///     The type this encoder produces.
    ///     public typealias Output = Data
    /// }
    struct Article: Codable {
        let title: String
        let author: String
        let pubDate: Date
    }
    var encode: some View {
        Button("Encode") {
            let dataProvider = PassthroughSubject<Article, Never>()
            dataProvider
                .encode(encoder: JSONEncoder())
                .sink { cp in
                    print("completion", cp)
                } receiveValue: { data in
                    guard let stringRepresentation = String(data: data, encoding: .utf8) else { return }
                    print("Data received \(data) string representation: \(stringRepresentation)")
                }
                .store(in: &bags)

        }
    }

    // MARK: - func decode<Item, Coder>(type: Item.Type, decoder: Coder) -> Publishers.Decode<Self, Item, Coder> where Item : Decodable, Coder : TopLevelDecoder, Self.Output == Coder.Input
    /// Decodes the output from the upstream using a specified decoder.
    ///
    /// Use decode(type:decoder:) with a JSONDecoder (or a PropertyListDecoder for property lists) to decode data received from a URLSession.DataTaskPublisher or other data source using the Decodable protocol.
    var decode: some View {
        Button("Decode") {
            let dataProvider = PassthroughSubject<Data, Never>()
            dataProvider.decode(type: Article.self, decoder: JSONDecoder())
                .sink { cp in
                    print("completion", cp)
                } receiveValue: { value in
                    print("receive value", value)
                }
                .store(in: &bags)

            dataProvider.send(Data("{\"pubDate\":1574273638.575666, \"title\" : \"My First Article\", \"author\" : \"Gita Kumar\" }".utf8))
        }
    }

}

#Preview {
    CodingTutorial()
}
