// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title            Decompiled Contract
/// @author           Jonathan Becker <jonathan@jbecker.dev>
/// @custom:version   heimdall-rs v0.8.3
///
/// @notice           This contract was decompiled using the heimdall-rs decompiler.
///                     It was generated directly by tracing the EVM opcodes from this contract.
///                     As a result, it may not compile or even be valid solidity code.
///                     Despite this, it should be obvious what each function does. Overall
///                     logic should have been preserved throughout decompiling.
///
/// @custom:github    You can find the open-source decompiler here:
///                       https://heimdall.rs

contract DecompiledContract {
    string public constant symbol = "BTT";
    uint256 public constant decimals = 18;
    uint256 public constant CHAINID = 199;
    uint256 public constant EIP712_TOKEN_TRANSFER_ORDER_SCHEMA_HASH = 80163892485924072176119143755673229484770547314635327714706028588132877604495;
    bytes public constant networkId = 0xBytes([49, 57, 57]);
    uint256 public constant EIP712_DOMAIN_SCHEMA_HASH = 63076024560530113402979550242307453568063438748328787417531900361828837441551;
    uint256 public constant totalSupply = 10000000000000000000000000000000000;
    string public constant name = "BitTorrent Token";
    
    uint256 public currentSupply;
    bytes32 store_f;
    mapping(bytes32 => bytes32) storage_map_g;
    uint256 public EIP712_DOMAIN_HASH;
    address public owner;
    address public parent;
    address public childChain;
    address public token;
    
    event WithdrawTo(address, address, uint256);
    event ChildChainChanged(address, address);
    event Transfer(address, address, uint256);
    event Withdraw(address, address, uint256, uint256, uint256);
    event Deposit(address, address, uint256, uint256, uint256);
    event OwnershipTransferred(address, address);
    event LogTransfer(address, address, address, uint256, uint256, uint256, uint256, uint256);
    
    /// @custom:selector    0x19d27d9c
    /// @custom:signature   Unresolved_19d27d9c(uint256 arg0, uint256 arg1, uint256 arg2, uint256 arg3, address arg4) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    /// @param              arg4 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_19d27d9c(uint256 arg0, uint256 arg1, uint256 arg2, uint256 arg3, address arg4) public pure {
        require(!arg0 > 0x0100000000);
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x10;
        var_d = 0x44697361626c6564206665617475726500000000000000000000000000000000;
    }
    
    /// @custom:selector    0x205c2878
    /// @custom:signature   withdrawTo(address arg0, uint256 arg1) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function withdrawTo(address arg0, uint256 arg1) public payable {
        require(!arg1 > currentSupply);
        currentSupply = currentSupply - arg1;
        require(!arg1, "Insufficient amount");
        require(msg.value == arg1, "Insufficient amount");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x13;
        var_d = 0x496e73756666696369656e7420616d6f756e7400000000000000000000000000;
        uint256 var_a = arg1;
        address var_e = address(msg.sender).balance;
        address var_f = address(msg.sender).balance;
        emit Withdraw(address(token), address(msg.sender), arg1, address(msg.sender).balance, address(msg.sender).balance);
        var_a = arg1;
        emit WithdrawTo(address(arg0), 0, arg1);
        var_a = arg1;
        emit Transfer(address(msg.sender), 0, arg1);
        require(arg1, "Insufficient amount");
        var_a = arg1;
        var_e = address(msg.sender).balance;
        var_f = address(msg.sender).balance;
        emit Withdraw(address(token), address(msg.sender), arg1, address(msg.sender).balance, address(msg.sender).balance);
        var_a = arg1;
        emit WithdrawTo(address(arg0), 0, arg1);
        var_a = arg1;
        emit Transfer(address(msg.sender), 0, arg1);
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x13;
        var_d = 0x496e73756666696369656e7420616d6f756e7400000000000000000000000000;
    }
    
    /// @custom:selector    0xf2fde38b
    /// @custom:signature   transferOwnership(address arg0) public
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function transferOwnership(address arg0) public {
        require(msg.sender == (address(owner)));
        require(address(arg0));
        emit OwnershipTransferred(address(owner), address(arg0));
        owner = (address(arg0)) | (uint96(owner));
    }
    
    /// @custom:selector    0xed9ef524
    /// @custom:signature   changeChildChain(address arg0) public
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function changeChildChain(address arg0) public {
        require(msg.sender == (address(owner)));
        require(address(arg0), "Child token: new child address is the zero address");
        emit ChildChainChanged(address(childChain), address(arg0));
        childChain = (address(arg0)) | (uint96(childChain));
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_b = (0x20 + (0x04 + var_c)) - (0x04 + var_c);
        var_d = 0x32;
        var_e = this.code[5366:5416];
    }
    
    /// @custom:selector    0x715018a6
    /// @custom:signature   renounceOwnership() public
    function renounceOwnership() public {
        require(msg.sender == (address(owner)));
        emit OwnershipTransferred(address(owner), 0);
        owner = uint96(owner);
    }
    
    /// @custom:selector    0xb789543c
    /// @custom:signature   getTokenTransferOrderHash(address arg0, uint256 arg1, bytes32 arg2, uint256 arg3) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    function getTokenTransferOrderHash(address arg0, uint256 arg1, bytes32 arg2, uint256 arg3) public view returns (uint256) {
        uint256 var_a = 0x80 + var_a;
        var_b = 0x5b;
        var_c = this.code[5416:5507];
        require(var_a.length < 0x20);
        uint256 var_d = ((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + (0x0100 ** (0x20 - var_a.length))) & (var_e)) | (var_e & (~(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + (0x0100 ** (0x20 - var_a.length)))));
        uint256 var_f = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 + (((0x20 + var_a) + var_a.length) - var_a);
        var_a = (0x20 + var_a) + var_a.length;
        var_g = keccak256(var_c);
        address var_h = address(arg0);
        uint256 var_i = arg1;
        uint256 var_j = arg2;
        uint256 var_k = arg3;
        var_g = 0x1901000000000000000000000000000000000000000000000000000000000000;
        var_l = EIP712_DOMAIN_HASH;
        var_m = keccak256(var_n);
        var_g = keccak256(var_o);
        return keccak256(var_o);
    }
    
    /// @custom:selector    0x485cc955
    /// @custom:signature   initialize(address arg0, address arg1) public
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function initialize(address arg0, address arg1) public {
        require(!(bytes1(store_f)), "The contract is already initialized");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_b = (0x20 + (0x04 + var_c)) - (0x04 + var_c);
        var_d = 0x23;
        var_e = this.code[5214:5249];
        store_f = 0x01 | (uint248(store_f));
        token = (uint96(token)) | (address(arg1));
        require(address(arg0));
        emit OwnershipTransferred(address(owner), address(arg0));
        owner = (address(arg0)) | (uint96(owner));
    }
    
    /// @custom:selector    0xcf2c52cb
    /// @custom:signature   Unresolved_cf2c52cb(address arg0, uint256 arg1) public
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_cf2c52cb(address arg0, uint256 arg1) public {
        require(!arg1 > 0x0100000000);
        require(msg.sender == (address(owner)));
        require(!(arg1) < 0x20);
        require(!(0x20 + (arg1)) > 0);
        require(address(arg0));
        (bool success, bytes memory ret0) = address(arg0).call{ gas: 0x08fc * (!0x20 + (arg1)), value: (0x20 + (arg1)) }(abi.encode());
        require(!((0x20 + (arg1)) + currentSupply) < currentSupply);
        currentSupply = (0x20 + (arg1)) + currentSupply;
        uint256 var_a = (0x20 + (arg1));
        address var_b = address(arg0).balance;
        address var_c = address(arg0).balance;
        emit Deposit(address(token), address(arg0), (0x20 + (arg1)), address(arg0).balance, address(arg0).balance);
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_d = (0x20 + (0x04 + var_e)) - (0x04 + var_e);
        var_f = 0x23;
        var_g = this.code[5249:5284];
    }
    
    /// @custom:selector    0x1499c592
    /// @custom:signature   setParent(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function setParent(address arg0) public pure {
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x10;
        var_d = 0x44697361626c6564206665617475726500000000000000000000000000000000;
    }
    
    /// @custom:selector    0x70a08231
    /// @custom:signature   balanceOf(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function balanceOf(address arg0) public view returns (uint256) {
        uint256 var_a = address(arg0).balance;
        return address(arg0).balance;
    }
    
    /// @custom:selector    0xacd06cb3
    /// @custom:signature   disabledHashes(bytes32 arg0) public view returns (bool)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function disabledHashes(bytes32 arg0) public view returns (bool) {
        var_a = 0x05;
        uint256 var_b = arg0;
        uint256 var_c = !(!bytes1(storage_map_g[var_b]));
        return !(!bytes1(storage_map_g[var_b]));
    }
    
    /// @custom:selector    0x2e1a7d4d
    /// @custom:signature   withdraw(uint256 arg0) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function withdraw(uint256 arg0) public payable {
        require(!arg0 > currentSupply);
        currentSupply = currentSupply - arg0;
        require(!arg0, "Insufficient amount");
        require(msg.value == arg0, "Insufficient amount");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x13;
        var_d = 0x496e73756666696369656e7420616d6f756e7400000000000000000000000000;
        uint256 var_a = arg0;
        address var_e = address(msg.sender).balance;
        address var_f = address(msg.sender).balance;
        emit Withdraw(address(token), address(msg.sender), arg0, address(msg.sender).balance, address(msg.sender).balance);
        var_a = arg0;
        emit WithdrawTo(address(msg.sender), 0, arg0);
        var_a = arg0;
        emit Transfer(address(msg.sender), 0, arg0);
        require(arg0, "Insufficient amount");
        var_a = arg0;
        var_e = address(msg.sender).balance;
        var_f = address(msg.sender).balance;
        emit Withdraw(address(token), address(msg.sender), arg0, address(msg.sender).balance, address(msg.sender).balance);
        var_a = arg0;
        emit WithdrawTo(address(msg.sender), 0, arg0);
        var_a = arg0;
        emit Transfer(address(msg.sender), 0, arg0);
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x13;
        var_d = 0x496e73756666696369656e7420616d6f756e7400000000000000000000000000;
    }
    
    /// @custom:selector    0x77d32e94
    /// @custom:signature   Unresolved_77d32e94(uint256 arg0, uint256 arg1) public returns (address)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_77d32e94(uint256 arg0, uint256 arg1) public returns (address) {
        require(!arg1 > 0x0100000000);
        uint256 var_a = var_a + (0x20 + (((0x1f + (arg1)) / 0x20) * 0x20));
        uint256 var_b = (arg1);
        var_c = msg.data[36:36];
        uint256 var_d = 0;
        require(0x41 == var_a.length);
        require(!(bytes1(var_e)) < 0x1b);
        require(0x1b == (bytes1(var_e)));
        require(0x1b == (bytes1(var_e)));
        var_d = 0;
        var_a = var_a + 0x20;
        uint256 var_f = arg0;
        bytes1 var_g = bytes1(var_e);
        var_h = var_i;
        var_j = var_k;
        address var_l = ecrecover(arg0, bytes1(var_e), var_i, var_k);
        require(var_m);
        require(address(var_n), "Error in ecrecover");
        var_f = address(var_n);
        return address(var_n);
        var_f = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_o = 0x20;
        var_p = 0x12;
        var_q = 0x4572726f7220696e2065637265636f7665720000000000000000000000000000;
        var_d = 0;
        return 0;
        require(0x1b == (bytes1(0x1b + (var_e))));
        require(0x1b == (bytes1(0x1b + (var_e))));
        var_d = 0;
        return 0;
        var_d = 0;
        var_a = var_a + 0x20;
        var_f = arg0;
        var_g = bytes1(0x1b + (var_e));
        var_h = var_i;
        var_j = var_k;
        address var_l = ecrecover(arg0, bytes1(0x1b + (var_e)), var_i, var_k);
        require(var_m);
        var_d = 0;
        return 0;
    }
    
    /// @custom:selector    0xa9059cbb
    /// @custom:signature   transfer(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function transfer(address arg0, uint256 arg1) public payable returns (bool) {
        require(msg.value == arg1);
        uint256 var_a = 0;
        return 0;
        var_a = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        address var_b = address(msg.sender);
        require(address(this).code.length);
        (bool success, bytes memory ret0) = address(this).staticcall{ gas: gasleft() }(abi.encode(0x70a0823100000000000000000000000000000000000000000000000000000000));
        require(!ret0.length < 0x20);
        var_a = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_b = address(arg0);
        require(address(this).code.length);
        (bool success, bytes memory ret0) = address(this).staticcall{ gas: gasleft() }(abi.encode(0x70a0823100000000000000000000000000000000000000000000000000000000));
        require(!ret0.length < 0x20);
        require(!address(this) == (address(arg0)));
        (bool success, bytes memory ret0) = address(arg0).call{ gas: 0x08fc * !arg1, value: arg1 }(abi.encode());
        var_a = arg1;
        emit Transfer(address(msg.sender), address(arg0), arg1);
        var_a = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_b = address(msg.sender);
        require(address(this).code.length);
        (bool success, bytes memory ret0) = address(this).staticcall{ gas: gasleft() }(abi.encode(0x70a0823100000000000000000000000000000000000000000000000000000000));
        require(!ret0.length < 0x20);
        var_a = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_b = address(arg0);
        require(address(this).code.length);
        (bool success, bytes memory ret0) = address(this).staticcall{ gas: gasleft() }(abi.encode(0x70a0823100000000000000000000000000000000000000000000000000000000));
        require(!ret0.length < 0x20);
        var_a = arg1;
        uint256 var_c = var_d.length;
        uint256 var_e = var_d.length;
        uint256 var_f = var_d.length;
        uint256 var_g = var_d.length;
        emit LogTransfer(address(token), address(msg.sender), address(arg0), arg1, var_d.length, var_d.length, var_d.length, var_d.length);
        var_a = 0x01;
        return 0x01;
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_h = 0x13;
        var_i = 0x63616e27742073656e6420746f204d5243323000000000000000000000000000;
    }
}