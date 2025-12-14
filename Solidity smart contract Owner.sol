To implement a Solidity smart contract Owner.sol where only the contract owner can update data, deploy it using Remix IDE, and observe the transactions generated on the blockchain.


me it: Owner.sol

----------------------------------------------------------
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Owner {
    // State variable to store owner's address
    address public owner;
    // State variable to store some data (only owner can update it)
    string private data;
    // Event to log whenever data is updated
    event DataUpdated(string oldData, string newData, address updatedBy);
    // Constructor: runs only once at deployment
    // Sets the deployer as the owner
    constructor() {
        owner = msg.sender;
    }
// Modifier to restrict functions to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    // Function to update the data - only owner can call this
    function updateData(string memory _newData) public onlyOwner {
        string memory old = data;
        data = _newData;
        emit DataUpdated(old, _newData, msg.sender);
    }
    // Public view function to read current data
    function getData() public view returns (string memory) {
        return data;
    }
    // Optional: transfer ownership to a new address (for demo)
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid new owner");
        owner = _newOwner;
    }
}
----------------------------------------------------------------------

1)	Click the Deploy & Run Transactions icon (Ethereum logo).
2)	Under Environment, select: Remix VM (Prague) (or similar).
3)	You’ll see several test accounts with some fake ETH (e.g., 100 ether).
4)	Ensure Contract dropdown is set to Owner – Owner.sol.
5)	Click Deploy.


STEP 5: Interact with the Contract (Owner vs non-Owner)
1)	Deploy the contract using Remix VM.
2)	In the Deployed Contracts panel, click owner to verify the deployer address.
3)	As the owner account, call updateData("First Value") — transaction succeeds and getData() returns updated data.

Switch to another account and try updateData("Unauthorized") — transaction fails due to onlyOwner modifier, proving access control.
