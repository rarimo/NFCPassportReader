//
//  DataGroup14.swift
//
//  Created by Andy Qua on 01/02/2021.
//

import Foundation

// SecurityInfos ::= SET of SecurityInfo
// SecurityInfo ::= SEQUENCE {
//    protocol OBJECT IDENTIFIER,
//    requiredData ANY DEFINED BY protocol,
//    optionalData ANY DEFINED BY protocol OPTIONAL
@available(iOS 13, macOS 10.15, *)
public class DataGroup14 : DataGroup {
    public var asn1 : ASN1Item!
    public var securityInfos : [SecurityInfo] = [SecurityInfo]()

    public override var datagroupType: DataGroupId { .DG14 }
    
    public required init( _ data : [UInt8] ) throws {
        try super.init(data)
    }
    
    override func parse(_ data: [UInt8]) throws {
        let p = SimpleASN1DumpParser()
        asn1 = try p.parse(data: Data(body))
        
        // Bit of a hack at the moment - passing in the body - if we had a decent ASN1 parser then this would be better! ;)
        for i in 0 ..< asn1.getNumberOfChildren() {
            if let child = asn1.getChild(i),
               let secInfo = SecurityInfo.getInstance( object:child, body : body ) {
                securityInfos.append(secInfo)
            }
        }
    }
}
