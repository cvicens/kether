pragma solidity >=0.4.22 <0.6.0;

contract MultiApprovalTransfer {
    address public requester;
    address public receiver;
    approval[] public approvers;
    
    constructor(address[] _approvers, address _receiver) public {
        requester = msg.sender;
        receiver = _receiver;
        for(uint256 i = 0;i < _approvers.length; i++) {
            approval memory a;
            a.approver = _approvers[i];
            a.isApproved = false;
            
            approvers.push(a);
        }
    } 
    
    function approve() public payable {
        bool isAllApproved = true;
        for(uint256 i = 0; i < approvers.length; i++) {
            if(approvers[i].approver == msg.sender)
                approvers[i].isApproved = true;
            
            if(!approvers[i].isApproved)
                isAllApproved = false;
        }

        require(address(this).balance >= 10000, "You have to have balance...");
        if (isAllApproved)   
            receiver.transfer(address (this).balance);
    } 
    
    function getContractBalance() public view returns(uint) {
        return requester.balance;
    }
    
    struct approval{
        address approver;
        bool isApproved;
    }
}