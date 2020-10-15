//
//  RankParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 14/10/2020.
//

import Foundation

internal final class RankParser : NSObject, NodeParser {
    private let tagName: String
    
    var type: ThingItem.Statistics.Ratings.Rank.Kind!
    var id: String!
    var name: ThingItem.Statistics.Ratings.Rank.Name!
    var friendlyName: String!
    var value: Int!
    var bayesAverage: Double!
    
    var delegateStack: ParserDelegateStack?
    var result: ThingItem.Statistics.Ratings.Rank?
    
    init(tagName: String) {
        self.tagName = tagName
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        guard elementName == tagName
        else { return }

        type = attributeDict["type"].flatMap(ThingItem.Statistics.Ratings.Rank.Kind.init)
        id = attributeDict["id"]
        name = attributeDict["name"].flatMap(ThingItem.Statistics.Ratings.Rank.Name.init)
        friendlyName = attributeDict["friendlyname"]
        value = attributeDict["value"].flatMap(Int.init)
        bayesAverage = attributeDict["bayesaverage"].flatMap(Double.init)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == tagName {
            result = ThingItem.Statistics.Ratings.Rank(type: type,
                                                       id: id,
                                                       name: name,
                                                       friendlyName: friendlyName,
                                                       value: value,
                                                       bayesAverage: bayesAverage)
            delegateStack?.pop()
        }
    }
}
