//
//  ThingItemParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

internal final class ThingItemParser : NSObject, NodeParser {
    private let tagName: String
    
    private var id: String!
    private var type: ThingItem.Kind!
    private var names: [(NameKind, String)] = []
    private let thumbnailParser = URLElementValueParser(tagName: "thumbnail")
    private let imageParser = URLElementValueParser(tagName: "image")
    private let nameParser = NameParser(tagName: "name")
    private let descriptionParser = StringElementValueParser(tagName: "description")
    private let yearPublishedParser = IntElementAttributeValueParser(tagName: "yearpublished")
    private let minPlayersParser = IntElementAttributeValueParser(tagName: "minplayers")
    private let maxPlayersParser = IntElementAttributeValueParser(tagName: "maxplayers")
    private let playingTimeParser = IntElementAttributeValueParser(tagName: "playingtime")
    private let minPlayTimeParser = IntElementAttributeValueParser(tagName: "minplaytime")
    private let maxPlayTimeParser = IntElementAttributeValueParser(tagName: "maxplaytime")
    private let minAgeTimeParser = IntElementAttributeValueParser(tagName: "minage")
    private let statisticsParser = StatisticsParser(tagName: "statistics")
    
    var delegateStack: ParserDelegateStack?
    private var currentParser: ParserDelegate?
    var result: ThingItem?
    
    init(tagName: String) {
        self.tagName = tagName
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        print("\(#function) \(elementName)")
        if elementName == tagName {
            id = attributeDict["id"]
            type = attributeDict["type"].flatMap(ThingItem.Kind.init)
            return
        }

        switch elementName {
        case "image":
            currentParser = imageParser
            delegateStack?.push(imageParser)
            imageParser.parser(parser,
                               didStartElement: elementName,
                               namespaceURI: namespaceURI,
                               qualifiedName: qName,
                               attributes: attributeDict)
        case "thumbnail":
            currentParser = thumbnailParser
            delegateStack?.push(thumbnailParser)
            thumbnailParser.parser(parser,
                                   didStartElement: elementName,
                                   namespaceURI: namespaceURI,
                                   qualifiedName: qName,
                                   attributes: attributeDict)
        case "name":
            currentParser = nameParser
            delegateStack?.push(nameParser)
            nameParser.parser(parser,
                              didStartElement: elementName,
                              namespaceURI: namespaceURI,
                              qualifiedName: qName,
                              attributes: attributeDict)            
        case "yearpublished":
            currentParser = yearPublishedParser
            delegateStack?.push(yearPublishedParser)
            yearPublishedParser.parser(parser,
                                       didStartElement: elementName,
                                       namespaceURI: namespaceURI,
                                       qualifiedName: qName,
                                       attributes: attributeDict)
        case "description":
            currentParser = descriptionParser
            delegateStack?.push(descriptionParser)
            descriptionParser.parser(parser,
                                     didStartElement: elementName,
                                     namespaceURI: namespaceURI,
                                     qualifiedName: qName,
                                     attributes: attributeDict)
        case "minplayers":
            currentParser = minPlayersParser
            delegateStack?.push(minPlayersParser)
            minPlayersParser.parser(parser,
                                    didStartElement: elementName,
                                    namespaceURI: namespaceURI,
                                    qualifiedName: qName,
                                    attributes: attributeDict)
        case "maxplayers":
            currentParser = maxPlayersParser
            delegateStack?.push(maxPlayersParser)
            maxPlayersParser.parser(parser,
                                    didStartElement: elementName,
                                    namespaceURI: namespaceURI,
                                    qualifiedName: qName,
                                    attributes: attributeDict)
        case "playingtime":
            currentParser = playingTimeParser
            delegateStack?.push(playingTimeParser)
            playingTimeParser.parser(parser,
                                     didStartElement: elementName,
                                     namespaceURI: namespaceURI,
                                     qualifiedName: qName,
                                     attributes: attributeDict)
        case "minplaytime":
            currentParser = minPlayTimeParser
            delegateStack?.push(minPlayTimeParser)
            minPlayTimeParser.parser(parser,
                                     didStartElement: elementName,
                                     namespaceURI: namespaceURI,
                                     qualifiedName: qName,
                                     attributes: attributeDict)
        case "maxplaytime":
            currentParser = maxPlayTimeParser
            delegateStack?.push(maxPlayTimeParser)
            maxPlayTimeParser.parser(parser,
                                     didStartElement: elementName,
                                     namespaceURI: namespaceURI,
                                     qualifiedName: qName,
                                     attributes: attributeDict)
        case "minage":
            currentParser = minAgeTimeParser
            delegateStack?.push(minAgeTimeParser)
            minAgeTimeParser.parser(parser,
                                    didStartElement: elementName,
                                    namespaceURI: namespaceURI,
                                    qualifiedName: qName,
                                    attributes: attributeDict)
        case "statistics":
            currentParser = statisticsParser
            delegateStack?.push(statisticsParser)
            statisticsParser.parser(parser,
                                    didStartElement: elementName,
                                    namespaceURI: namespaceURI,
                                    qualifiedName: qName,
                                    attributes: attributeDict)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("\(#function) \(elementName)")
        if elementName == tagName {
            result = ThingItem(id: id,
                               names: names,
                               thumbnail: thumbnailParser.result!,
                               image: imageParser.result!,
                               type: type,
                               description: descriptionParser.result!,
                               yearPublished: yearPublishedParser.result!,
                               minPlayers: minPlayersParser.result!,
                               maxPlayers: maxPlayersParser.result!,
                               playingTime: playingTimeParser.result!,
                               minPlayTime: minPlayTimeParser.result!,
                               maxPlayTime: maxPlayTimeParser.result!,
                               minAge: minAgeTimeParser.result!,
                               statistics: statisticsParser.result)
            delegateStack?.pop()
        }
    }
    
    func didBecomeActive() {
        if currentParser === nameParser,
           let name = nameParser.result {
            names.append(name)
        }
    }
}
