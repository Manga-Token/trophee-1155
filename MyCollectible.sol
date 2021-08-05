pragma solidity ^0.5.11;

import "./ERC1155Tradable.sol";

/**
 * @title SozoComicsCollectible
 * SozoComicsCollectible - a contract for my semi-fungible tokens.
 */
contract SozoComicsCollectible is ERC1155Tradable {
  constructor(address _proxyRegistryAddress)
  ERC1155Tradable(
    "SozoComicsCollectible",
    "SCC",
    _proxyRegistryAddress
  ) public {
    _setBaseMetadataURI("https://lottery.mangatoken.org/api/collectible/");
  }
  
  mapping(uint256 => string) public optionToSerialCode;

  function setSerialCode(string memory serialCode, uint256 _id) public creatorOnly(_id) {
    require(bytes(serialCode).length > 0, "Serial Code must not be empty");
    require(bytes(optionToSerialCode[_id]).length == 0, "Cannot update serial code after creation");    
    optionToSerialCode[_id] = serialCode;
  }

  function getTokenSerialCode(uint256 _id) public view returns (string memory) {
    string memory result = optionToSerialCode[_id];

    if (bytes(result).length > 0) {
      return result;
    }

    return "Not set";
  }
  
}

