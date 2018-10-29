pragma solidity >=0.4.22 <0.6.0;

contract MultiApprovalTransfer {
    bool public isAllApproved;
    address public requester;
    address public receiver;
    approval[] public approvers;
    
    constructor(address[] _approvers, address _receiver) public payable {
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
        require(!isAllApproved, "This contract has already been approved");
        require(address(this).balance >= 0, "You have to have balance");
        
        bool _isAllApproved = true;
        for(uint256 i = 0; i < approvers.length; i++) {
            if(approvers[i].approver == msg.sender)
                approvers[i].isApproved = true;
            
            if(!approvers[i].isApproved)
                _isAllApproved = false;
        }

        
        if (_isAllApproved) {
            receiver.transfer(address (this).balance);
            isAllApproved = true;
        }
    } 
    
    function getContractBalance() public view returns(uint) {
        return requester.balance;
    }
    
    struct approval{
        address approver;
        bool isApproved;
    }
}