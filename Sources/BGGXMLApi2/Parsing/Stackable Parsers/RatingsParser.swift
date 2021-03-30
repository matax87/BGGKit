//
//  RatingsParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 14/10/2020.
//

import Foundation
import StackParsing

final class RatingsParser: NSObject, NodeParser {
    private let tagName: String

    private let usersRatedParser = IntElementAttributeValueParser(tagName: "usersrated")
    private let averageParser = DoubleElementAttributeValueParser(tagName: "average")
    private let bayesAverageParser = DoubleElementAttributeValueParser(tagName: "bayesaverage")
    private let ranksParser: ArrayParser<RankParser>
    private let stddevParser = DoubleElementAttributeValueParser(tagName: "stddev")
    private let medianParser = DoubleElementAttributeValueParser(tagName: "median")
    private let ownedParser = IntElementAttributeValueParser(tagName: "owned")
    private let tradingParser = IntElementAttributeValueParser(tagName: "trading")
    private let wantingParser = IntElementAttributeValueParser(tagName: "wanting")
    private let wishingParser = IntElementAttributeValueParser(tagName: "wishing")
    private let numberOfCommentsParser = IntElementAttributeValueParser(tagName: "numcomments")
    private let numberOfWeightsParser = IntElementAttributeValueParser(tagName: "numweights")
    private let averageWeightParser = DoubleElementAttributeValueParser(tagName: "averageweight")

    var stack: ParsersStack?
    var result: ThingItem.Statistics.Ratings?

    init(tagName: String) {
        self.tagName = tagName
        ranksParser = ArrayParser(tagName: "ranks") { tag in
            guard tag == "rank" else { return nil }
            return RankParser(tagName: tag)
        }
    }

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String: String] = [:]) {
        if elementName == tagName {
            return
        }

        switch elementName {
        case "usersrated":
            stack?.push(usersRatedParser)
            usersRatedParser.parser(parser,
                                    didStartElement: elementName,
                                    namespaceURI: namespaceURI,
                                    qualifiedName: qName,
                                    attributes: attributeDict)
        case "average":
            stack?.push(averageParser)
            averageParser.parser(parser,
                                 didStartElement: elementName,
                                 namespaceURI: namespaceURI,
                                 qualifiedName: qName,
                                 attributes: attributeDict)
        case "bayesaverage":
            stack?.push(bayesAverageParser)
            bayesAverageParser.parser(parser,
                                      didStartElement: elementName,
                                      namespaceURI: namespaceURI,
                                      qualifiedName: qName,
                                      attributes: attributeDict)
        case "stddev":
            stack?.push(stddevParser)
            stddevParser.parser(parser,
                                didStartElement: elementName,
                                namespaceURI: namespaceURI,
                                qualifiedName: qName,
                                attributes: attributeDict)
        case "ranks":
            stack?.push(ranksParser)
            ranksParser.parser(parser,
                               didStartElement: elementName,
                               namespaceURI: namespaceURI,
                               qualifiedName: qName,
                               attributes: attributeDict)
        case "median":
            stack?.push(medianParser)
            medianParser.parser(parser,
                                didStartElement: elementName,
                                namespaceURI: namespaceURI,
                                qualifiedName: qName,
                                attributes: attributeDict)
        case "owned":
            stack?.push(ownedParser); ownedParser.parser(parser,
                                                         didStartElement: elementName,
                                                         namespaceURI: namespaceURI,
                                                         qualifiedName: qName,
                                                         attributes: attributeDict)
        case "trading":
            stack?.push(tradingParser); tradingParser.parser(parser,
                                                             didStartElement: elementName,
                                                             namespaceURI: namespaceURI,
                                                             qualifiedName: qName,
                                                             attributes: attributeDict)
        case "wanting":
            stack?.push(wantingParser); wantingParser.parser(parser,
                                                             didStartElement: elementName,
                                                             namespaceURI: namespaceURI,
                                                             qualifiedName: qName,
                                                             attributes: attributeDict)
        case "wishing":
            stack?.push(wishingParser); wishingParser.parser(parser,
                                                             didStartElement: elementName,
                                                             namespaceURI: namespaceURI,
                                                             qualifiedName: qName,
                                                             attributes: attributeDict)
        case "numcomments":
            stack?.push(numberOfCommentsParser)
            numberOfCommentsParser.parser(parser,
                                          didStartElement: elementName,
                                          namespaceURI: namespaceURI,
                                          qualifiedName: qName,
                                          attributes: attributeDict)
        case "numweights":
            stack?.push(numberOfWeightsParser)
            numberOfWeightsParser.parser(parser,
                                         didStartElement: elementName,
                                         namespaceURI: namespaceURI,
                                         qualifiedName: qName,
                                         attributes: attributeDict)
        case "averageweight":
            stack?.push(averageWeightParser); averageWeightParser.parser(parser,
                                                                         didStartElement: elementName,
                                                                         namespaceURI: namespaceURI,
                                                                         qualifiedName: qName,
                                                                         attributes: attributeDict)
        default:
            break
        }
    }

    func parser(_: XMLParser, didEndElement elementName: String, namespaceURI _: String?, qualifiedName _: String?) {
        if elementName == tagName {
            result = ThingItem.Statistics.Ratings(usersRated: usersRatedParser.result!,
                                                  average: averageParser.result!,
                                                  bayesAverage: bayesAverageParser.result!,
                                                  ranks: ranksParser.result!.items,
                                                  stddev: stddevParser.result!,
                                                  median: medianParser.result!,
                                                  owned: ownedParser.result!,
                                                  trading: tradingParser.result!,
                                                  wanting: wantingParser.result!,
                                                  wishing: wishingParser.result!,
                                                  numberOfComments: numberOfCommentsParser.result!,
                                                  numberOfWeights: numberOfWeightsParser.result!,
                                                  averageWeight: averageWeightParser.result!)
            stack?.pop()
        }
    }
}
