//
//  MessageFilterExtension.swift
//  MessagesFilter
//
//  Created by Ariela Cohen on 10/23/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import IdentityLookup

@available(iOSApplicationExtension 11.0, *)
final class MessageFilterExtension: ILMessageFilterExtension {
    
    var words:[String] = []
}



@available(iOSApplicationExtension 11.0, *)
extension MessageFilterExtension: ILMessageFilterQueryHandling {
    
    @available(iOSApplicationExtension 11.0, *)
    func handle(_ queryRequest: ILMessageFilterQueryRequest, context: ILMessageFilterExtensionContext, completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        // First, check whether to filter using offline data (if possible).
        let offlineAction = self.offlineAction(for: queryRequest)
        
        switch offlineAction {
        case .allow, .filter:
            // Based on offline data, we know this message should either be Allowed or Filtered. Send response immediately.
            let response = ILMessageFilterQueryResponse()
            response.action = offlineAction
            
            completion(response)
            
        case .none:
            // Based on offline data, we do not know whether this message should be Allowed or Filtered. Defer to network.
            // Note: Deferring requests to network requires the extension target's Info.plist to contain a key with a URL to use. See documentation for details.
            context.deferQueryRequestToNetwork() { (networkResponse, error) in
                let response = ILMessageFilterQueryResponse()
                response.action = .none
                
                if let networkResponse = networkResponse {
                    // If we received a network response, parse it to determine an action to return in our response.
                    response.action = self.action(for: networkResponse)
                } else {
                    NSLog("Error deferring query request to network: \(String(describing: error))")
                }
                
                completion(response)
            }
        }
    }
    
//    private func offlineAction(for queryRequest: ILMessageFilterQueryRequest) -> ILMessageFilterAction {
//        guard let messageBody = queryRequest.messageBody else {
//            return .none
//        }
//        return messageBody.lowercased().contains("survey") ? .filter : .none
//    }
//
    
        private func offlineAction(for queryRequest: ILMessageFilterQueryRequest) -> ILMessageFilterAction {
            guard let messageBody = queryRequest.messageBody?.lowercased() else {return .none}
           
            words = CoreDataModelExt2.shared.loadWordsForMessageExt()
            
            for word in words {
                print("words: \(word)")
                if messageBody.contains(word.lowercased()) {
                    return .filter
                }
            }
   return .allow
}
    
    
    
    private func action(for networkResponse: ILNetworkResponse) -> ILMessageFilterAction {
        // Replace with logic to parse the HTTP response and data payload of `networkResponse` to return an action.
        return .none
    }
    
}
