//
//  CallDirectoryHandler.swift
//  CallFilterDirectory
//
//  Created by Ariela Cohen on 10/21/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {
    

    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self

        if #available(iOSApplicationExtension 11.0, *) {
            if context.isIncremental {
                addOrRemoveIncrementalBlockingPhoneNumbers(to: context)
                
                addOrRemoveIncrementalIdentificationPhoneNumbers(to: context)
            } else {
                addAllBlockingPhoneNumbers(to: context)
                
                addAllIdentificationPhoneNumbers(to: context)
            }
        } else {
            // Fallback on earlier versions
        }

        context.completeRequest()
    }

    private func addAllBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        
        // Numbers must be provided in numerically ascending order.
//        let sortedArray = CoreDataModelExt.shared.blockedList.sorted { $0 < $1 }
//        let allPhoneNumbers: [CXCallDirectoryPhoneNumber] = sortedArray
        let allPhoneNumbers: [CXCallDirectoryPhoneNumber] = [1_253_950_1212]
        for phoneNumber in allPhoneNumbers {
            context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
        }
    }

    private func addOrRemoveIncrementalBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        // Retrieve any changes to the set of phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
        let phoneNumbersToAdd: [CXCallDirectoryPhoneNumber] = [ 1_253_950_1212 ]
        for phoneNumber in phoneNumbersToAdd {
            context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
        }

//        let phoneNumbersToRemove: [CXCallDirectoryPhoneNumber] = [ 1_800_555_5555 ]
//        for phoneNumber in phoneNumbersToRemove {
//            context.removeBlockingEntry(withPhoneNumber: phoneNumber)
//        }

        // Record the most-recently loaded set of blocking entries in data store for the next incremental load...
    }

    private func addAllIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        // Retrieve phone numbers to identify and their identification labels from data store. For optimal performance and memory usage when there are many phone numbers,
        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
        //
        // Numbers must be provided in numerically ascending order.
        let allPhoneNumbers: [CXCallDirectoryPhoneNumber] = [1_425_950_1212, 1_732_531_8121]
        let labels = [ "Possible Spam", "Scam" ]

        for (phoneNumber, label) in zip(allPhoneNumbers, labels) {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
        }
    }

    private func addOrRemoveIncrementalIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        // Retrieve any changes to the set of phone numbers to identify (and their identification labels) from data store. For optimal performance and memory usage when there are many phone numbers,
        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
        let phoneNumbersToAdd: [CXCallDirectoryPhoneNumber] = [ 1_425_950_1212, 17325318121]
        let labelsToAdd = [ "Possible Spam", "Scam"]

        for (phoneNumber, label) in zip(phoneNumbersToAdd, labelsToAdd) {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
        }

        let phoneNumbersToRemove: [CXCallDirectoryPhoneNumber] = [ ]

        for phoneNumber in phoneNumbersToRemove {
            if #available(iOSApplicationExtension 11.0, *) {
                context.removeIdentificationEntry(withPhoneNumber: phoneNumber)
            } else {
                // Fallback on earlier versions
            }
        }

        // Record the most-recently loaded set of identification entries in data store for the next incremental load...
    }

}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {

    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error) {
        // An error occurred while adding blocking or identification entries, check the NSError for details.
        // For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
        //
        // This may be used to store the error details in a location accessible by the extension's containing app, so that the
        // app may be notified about errors which occured while loading data even if the request to load data was initiated by
        // the user in Settings instead of via the app itself.
    }

}
