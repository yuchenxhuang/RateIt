//
//  LinkPresentation.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/10/21.
//

import SwiftUI
import LinkPresentation

struct LinkPresentationView: View {
    //var links: [String]
    var link: String
    var body: some View {
        if URL(string: link) != nil {
            LinkView(url: URL(string: link)!)
        }
    }
}

struct LinkView: UIViewRepresentable {
    typealias UIViewType = LPLinkView
    var url: URL

    func makeUIView(context: UIViewRepresentableContext<LinkView>) -> LinkView.UIViewType {
        return LPLinkView(url: url)
    }

    func updateUIView(_ uiView: LinkView.UIViewType, context: UIViewRepresentableContext<LinkView>) {
        if let cachedData = MetaCache.retrieve(urlString: url.absoluteString) {
            uiView.metadata = cachedData
            uiView.sizeToFit()
        } else {
            let provider = LPMetadataProvider()
            provider.startFetchingMetadata(for: url) { metadata, error in
                guard let metadata = metadata, error == nil else {
                    return
                }
                MetaCache.cache(metadata: metadata)
                DispatchQueue.main.async {
                uiView.metadata = metadata
                uiView.sizeToFit()
                }
            }
        }
    }
}


struct MetaCache {
    static func cache(metadata: LPLinkMetadata) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: metadata, requiringSecureCoding: true)
            UserDefaults.standard.setValue(data, forKey: metadata.url!.absoluteString)
        }
        catch let error {
            print("Error when cachine: \(error.localizedDescription)")
        }
    }

    static func retrieve(urlString: String) -> LPLinkMetadata? {
        do {
            guard let data = UserDefaults.standard.object(forKey: urlString) as? Data,
            let metadata = try NSKeyedUnarchiver.unarchivedObject(ofClass: LPLinkMetadata.self, from: data) else { return nil }
            return metadata
        }
        catch let error {
            print("Error when cachine: \(error.localizedDescription)")
            return nil
        }
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        List() {
            Section() {
                LinkPresentationView(link: "https://www.nytimes.com/")
                    .padding(.trailing)
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}
