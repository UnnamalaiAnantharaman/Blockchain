//SPDX-License-Identifier:MIT 

pragma solidity ^0.8.0;

contract Government{
    address[] public citizens;
    address[] public officials;
    address payable owner;
    mapping(address => bool) public isOfficial;

    constructor() {
        owner = payable(msg.sender);
    }

    function registerAsCitizen() public{
        require(!isOfficial[msg.sender], "Cannot register as citizen, already registered as official");
        citizens.push(msg.sender);
    }

    function registerAsOfficial() public{
        require(!isOfficial[msg.sender], "Cannot register as official, already registered as offficial");
        officials.push(msg.sender);
        isOfficial[msg.sender] = true;
    }

    function vote(address candidate) public view{
        require(!isOfficial[msg.sender], "Officials cannot vote");
        require(isOfficial[candidate], "Candidate must be registered as official");
    }

    function proposeLaw(string memory proposal) public view returns(string memory){
        require(isOfficial[msg.sender], "Only officials can propose laws");
        return proposal;
    }

    function enactLaw(string memory proposal) public view returns(string memory){
        require(msg.sender == owner, "Only owner can enact law");
        return proposal;
    }

    function getOfficials() public view returns(address[] memory){
        return officials;
    }

    function getCitizens() public view returns(address[] memory){
        return citizens;
    }

    function grantAccess(address payable user) public{
        require(msg.sender == owner, "Only owner can grant access");
        owner = user;
    }

    function revokeAccess(address payable user) public{
        require(msg.sender == owner, "Only owner can revoke access");
        require(user != owner, "Cannot revoke access for the current owner");
        owner = payable(msg.sender);
    }

}
