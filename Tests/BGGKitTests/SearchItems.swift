//
//  SearchItems.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

struct SearchItems {

    static let xmlString1 = """
    <?xml version="1.0" encoding="utf-8"?>
    <items total="1" termsofuse="https://boardgamegeek.com/xmlapi/termsofuse">
        <item type="boardgame" id="13">
            <name type="primary" value="Catan"/>
            <yearpublished value="1995"/>
        </item>
    </items>
    """

    static let xmlString2 = """
    <?xml version="1.0" encoding="utf-8"?>
    <items total="1" termsofuse="https://boardgamegeek.com/xmlapi/termsofuse">
        <item type="boardgame" id="316630">
            <name type="alternate" value="Il Signore degli Anelli: Viaggi nella Terra di Mezzo – Creature dell’Oscurità"/>
        <yearpublished value="2020" />
        </item>
    </items>
    """
}
