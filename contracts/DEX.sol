//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX {
    event CDTToSSVConverted(uint256 amount);
    event SSVToCDTConverted(uint256 amount);

    IERC20 public cdtToken;
    IERC20 public ssvToken;

    uint public rate;

    function initialize(IERC20 _cdtTokenAddress, IERC20 _ssvTokenAddress, uint256 _rate) public {
        cdtToken = _cdtTokenAddress;
        ssvToken = _ssvTokenAddress;
        rate = _rate;
    }

    function convertCDTToSSV(uint256 amount) public {   
        uint256 ssvAmount = amount / rate;
        cdtToken.transferFrom(msg.sender, address(this), amount);
        ssvToken.transfer(msg.sender, ssvAmount);
        emit CDTToSSVConverted(ssvAmount);
    }

    function convertSSVToCDT(uint256 amount) public {
        uint256 cdtAmount = amount * rate;
        ssvToken.transferFrom(msg.sender, address(this), amount);
        cdtToken.transfer(msg.sender, cdtAmount);
        emit SSVToCDTConverted(cdtAmount);
    }
}