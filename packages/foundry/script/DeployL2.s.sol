// SPDX-License-Identifier: MIT
pragma solidity =0.8.12;

import "forge-std/Test.sol";
import "forge-std/Script.sol";
import "forge-std/StdJson.sol";
import "forge-std/console.sol";

import "../src/FundingPool.sol";

import "./DeployHelpers.s.sol";

// # To deploy and verify our pool contract on L2
contract DeployL2 is ScaffoldETHDeploy {
    address constant L2_CCIP_ROUTER = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59;
    address constant CHAR_TOKEN = 0xf92f74Dd03f9A9E04773cE5fF3BCeaBB2eB1dDf0;
    uint64 constant L1_CHAIN_SELECTOR = 16015286601757825753;

    function run() external {
        vm.startBroadcast();
        _deployRestakeRegenContracts();
        vm.stopBroadcast();
    }

    function _deployRestakeRegenContracts() internal {

        FundingPool fundingPool = new FundingPool(CHAR_TOKEN, L2_CCIP_ROUTER, address(0), L1_CHAIN_SELECTOR);
        deployments.push(ScaffoldETHDeploy.Deployment("FundingPool", address(fundingPool)));

        exportDeployments();
    }
}