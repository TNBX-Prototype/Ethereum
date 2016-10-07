contract Securities{
    
    uint sno;
    function Securities(){
        sno=0;
    }

    enum SecurityType { 
        SHARE,
        NOTE,
        CONVERTIBLENOTE
        }

    struct _Security{
        uint no;
        bytes32 id;
        uint security;
        uint company;
        bytes32 symbol;
        SecurityType securityType;
        bytes32 created;
        bytes32 issued;
        uint numberOutstanding;
        bool privateSecurity;
        uint primaryFeePct;
        uint secondaryFeePct;
    }
    
    

    mapping (bytes32 => _Security) SecurityDetail;
    mapping (bytes32 => _Security) SecurityDetailMappedWithID;
    mapping (uint => _Security) SecurityDetailMappedWithSNO;

    function AddSecurityDetails(uint security,uint company,bytes32 symbol,uint securityType,bytes32 created,bytes32 issued,uint numberOutstanding,bool privateSecurity,uint primaryFeePct,uint secondaryFeePct){
        sno=sno+1;
        bytes32 s_id=sha256(sha256(now));
        SecurityDetail[symbol]=_Security(sno,s_id,security,company,symbol,SecurityType(securityType),created,issued,numberOutstanding,privateSecurity,primaryFeePct,secondaryFeePct);
        SecurityDetailMappedWithID[s_id]=_Security(sno,s_id,security,company,symbol,SecurityType(securityType),created,issued,numberOutstanding,privateSecurity,primaryFeePct,secondaryFeePct);
        SecurityDetailMappedWithSNO[sno]=_Security(sno,s_id,security,company,symbol,SecurityType(securityType),created,issued,numberOutstanding,privateSecurity,primaryFeePct,secondaryFeePct);
        
    }
    
    function GetAllSecurities() constant returns (bytes32[] IDs,bytes32[] SecuritySymbols){
        bytes32[] memory SecuritiesID=new bytes32[](sno);
        bytes32[] memory Symbols=new bytes32[](sno);
        for(uint i=1;i<=sno;i++)
        {
            SecuritiesID[i-1]=SecurityDetailMappedWithSNO[i].id;
            Symbols[i-1]=SecurityDetailMappedWithSNO[i].symbol;
        }
        
        return(SecuritiesID,Symbols);
    }


    function GetSecurityDetailsById_Part1(bytes32 id) constant returns(uint security,uint company,bytes32 symbol, uint securityType,bytes32 created,bytes32 issued,uint numberOutstanding){

        return(SecurityDetailMappedWithID[id].security,SecurityDetailMappedWithID[id].company,SecurityDetailMappedWithID[id].symbol, uint(SecurityDetailMappedWithID[id].securityType), SecurityDetailMappedWithID[id].created, SecurityDetailMappedWithID[id].issued,SecurityDetailMappedWithID[id].numberOutstanding);

    }
    
    
    function GetSecurityDetailsById_Part2(bytes32 id) constant returns(bool privateSecurity,uint primaryFeePct,uint secondaryFeePct){

        return(SecurityDetailMappedWithID[id].privateSecurity,SecurityDetailMappedWithID[id].primaryFeePct,SecurityDetailMappedWithID[id].secondaryFeePct);

    }


function bytes32ToString (bytes32 data) returns (string) {
    bytes memory bytesString = new bytes(32);
    for (uint j=0; j<32; j++) {
        byte char = byte(bytes32(uint(data) * 2 ** (8 * j)));
        if (char != 0) {
            bytesString[j] = char;
        }
    }
    return string(bytesString);
}

}