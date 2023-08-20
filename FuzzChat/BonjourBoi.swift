//
//  BonjourBoi.swift
//  FuzzChat
//
//  Created by Teymur Kazakov on 7/4/22.
//

/*import Foundation
import UIKit
import CoreMIDI



class Bonjour: NSObject {
    let bonjourBrowser = NetServiceBrowser()
    var discoveredService: NetService?
    override init() {
        super.init()
        bonjourBrowser.delegate = self
 startDiscovery()
    }
    func startDiscovery() {
        self.bonjourBrowser.searchForServices(ofType:  MIDINetworkBonjourServiceType, inDomain: "local")
       
    }
}


extension Bonjour: NetServiceBrowserDelegate, NetServiceDelegate {
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        discoveredService = service
        discoveredService?.delegate = self
        discoveredService?.resolve(withTimeout: 3)
    }
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        print(errorDict)
    }
   
    func netServiceDidResolveAddress(_ sender: NetService) {
        if let data = sender.txtRecordData() {
            _ = NetService.dictionary(fromTXTRecord: data)
 
            discoveredService = nil
        }
    }
}
*/




