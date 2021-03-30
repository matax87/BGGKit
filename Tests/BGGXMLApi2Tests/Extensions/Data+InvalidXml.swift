//
//  Data+InvalidXml.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 29/03/2021.
//

import Foundation

extension Data {
    static func invalidXml() -> Data {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vel magna id purus fringilla ornare quis at nisl. Etiam varius elit ante, quis efficitur justo pellentesque eget. Nulla sollicitudin vitae enim pulvinar sodales. Cras egestas interdum imperdiet. Suspendisse finibus pulvinar magna in vulputate. Donec luctus nulla velit, vitae tincidunt nisl porttitor vel. Donec sit amet risus vitae orci viverra euismod mattis ac turpis. In vulputate lorem elit, id efficitur mauris tincidunt ac. Aenean dignissim metus lectus, a cursus libero accumsan in."
            .data(using: .utf8)!
    }
}
