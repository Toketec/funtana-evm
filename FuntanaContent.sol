// SPDX-License-Identifier: MIT
// This contract defines a GameItem that is an ERC721 token with URI storage and is Ownable.
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FuntanaContent is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    // 构造函数初始化 ERC721 代币，名称为 "FuntanaContent"，符号为 "FCT"
    constructor() ERC721("FuntanaContent", "FCT") Ownable(msg.sender) {}

    // 玩家自己将token URI对应的物品授予自己
    function mintNFT(string memory tokenURI) public returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return tokenId;
    }

    // // 向玩家授予指定 token URI 的物品的函数，只能由所有者调用。
    // function awardItem(address player, string memory tokenURI) public onlyOwner returns (uint256) {
    //     uint256 tokenId = _nextTokenId++;
    //     _mint(player, tokenId);
    //     _setTokenURI(tokenId, tokenURI);
    //     return tokenId;
    // }
}
