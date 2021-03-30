//
//  NetworkError.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 17/03/2021.
//

import Foundation

public enum NetworkError: Error {
    /// URL is ni
    case missingUrl
    /// Parameters were nil
    case parametersNil
    /// Parameter encoding failed
    case encodingFailed
    /// Redirection erro
    case redirectionError
    /// Client Erro
    case clientError
    /// Server Erro
    case serverError
    /// Invalid Reques
    case invalidRequest
    /// Unknown Error
    case unknownError
    /// Error getting valid data
    case dataError
}
