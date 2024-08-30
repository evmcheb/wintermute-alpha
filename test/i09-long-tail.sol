// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface Structs {
    struct Val {
        uint256 value;
    }
    enum ActionType {
      Deposit,   // supply tokens
      Withdraw,  // borrow tokens
      Transfer,  // transfer balance between accounts
      Buy,       // buy an amount of some token (externally)
      Sell,      // sell an amount of some token (externally)
      Trade,     // trade tokens against another account
      Liquidate, // liquidate an undercollateralized or expiring account
      Vaporize,  // use excess tokens to zero-out a completely negative account
      Call       // send arbitrary data to an address
    }
    enum AssetDenomination {
        Wei // the amount is denominated in wei
    }
    enum AssetReference {
        Delta // the amount is given as a delta from the current value
    }

    struct AssetAmount {
        bool sign; // true if positive
        AssetDenomination denomination;
        AssetReference ref;
        uint256 value;
    }

    struct ActionArgs {
        ActionType actionType;
        uint256 accountId;
        AssetAmount amount;
        uint256 primaryMarketId;
        uint256 secondaryMarketId;
        address otherAddress;
        uint256 otherAccountId;
        bytes data;
    }

    struct Info {
        address owner;  // The address that owns the account
        uint256 number; // A nonce that allows a single address to control many accounts
    }

    struct Wei {
        bool sign; // true if positive
        uint256 value;
    }
}

interface DyDxPool is Structs {
    function getAccountWei(Info memory account, uint256 marketId) external view returns (Wei memory);
    function operate(Info[] memory, ActionArgs[] memory) external;
}

interface ICurve {
    function exchange(int128, int128, uint256, uint256)  external payable returns (uint256);
}

interface EtherWrapper {
    function mint(uint256 amount) external;
    function burn(uint256 amount) external;
}

interface IWETH {
    function withdraw(uint wad) external;
    function deposit() external payable;
}