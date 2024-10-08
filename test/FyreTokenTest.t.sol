// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Test} from "lib/forge-std/src/Test.sol";
import {FyreToken} from "../src/FyreToken.sol";

contract FyreTokenTest is Test {
    FyreToken fyreToken;
    address owner = address(0xABCD);
    address addr1 = address(0x1234);
    address addr2 = address(0x5678);
    uint256 initialSupply = 1_000_000 ether; // 1 million tokens

    function setUp() public {
        fyreToken = new FyreToken(owner, initialSupply);
    }

    function testInitialSupply() public {
        assertEq(fyreToken.totalSupply(), initialSupply);
        assertEq(fyreToken.balanceOf(owner), initialSupply);
    }

    function testTransfer() public {
        uint256 transferAmount = 100 ether;
        vm.prank(owner); // Make owner execute this function
        fyreToken.transfer(addr1, transferAmount);
        assertEq(fyreToken.balanceOf(addr1), transferAmount);
        assertEq(fyreToken.balanceOf(owner), initialSupply - transferAmount);
    }

    function testMint() public {
        uint256 mintAmount = 500 ether;
        vm.prank(owner); // Make owner execute this function
        fyreToken.mint(addr1, mintAmount);
        assertEq(fyreToken.balanceOf(addr1), mintAmount);
        assertEq(fyreToken.totalSupply(), initialSupply + mintAmount);
    }

    function testBurn() public {
        uint256 burnAmount = 200 ether;
        vm.prank(owner); // Make owner execute this function
        fyreToken.mint(addr1, burnAmount); // Mint first to test burn
        vm.prank(owner); // Owner burns from addr1
        fyreToken.burn(addr1, burnAmount);
        assertEq(fyreToken.balanceOf(addr1), 0);
        assertEq(fyreToken.totalSupply(), initialSupply);
    }
}
