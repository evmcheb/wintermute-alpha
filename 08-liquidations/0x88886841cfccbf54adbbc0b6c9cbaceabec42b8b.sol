// Decompiled by library.dedaub.com
// 2024.01.26 23:11 UTC
// Compiled using the solidity compiler version 0.5.17


// Data structures and variables inferred from the use of storage instructions
mapping (uint256 => uint256) map_0; // STORAGE[0x0]
mapping (uint256 => uint256) _wards; // STORAGE[0x1]

// LIQUIDATION FUNCTION OF INTEREST
function 0x3743cb3f(uint256 varg0, uint256 varg1, address varg2, bytes varg3, bytes varg4) public payable { 
    // Performs validaton checks on the calldata
    require(msg.data.length - 4 >= 160);
    0x1efe(varg0);
    0x1efe(varg1);
    0x1ee1(varg2);
    require(varg3 <= uint64.max);
    require(4 + varg3 + 31 < msg.data.length);
    require(varg3.length <= uint64.max);
    v0 = new bytes[](varg3.length);
    require(!((v0 + ((~0x1f & 31 + varg3.length) + 32) > uint64.max) | (v0 + ((~0x1f & 31 + varg3.length) + 32) < v0)));
    require(varg3.data + varg3.length <= msg.data.length);
    CALLDATACOPY(v0.data, varg3.data, varg3.length);
    v0[varg3.length] = 0;
    require(varg4 <= uint64.max);
    require(4 + varg4 + 31 < msg.data.length);
    require(varg4.length <= uint64.max);
    v1 = new bytes[](varg4.length);
    require(!((v1 + ((~0x1f & 31 + varg4.length) + 32) > uint64.max) | (v1 + ((~0x1f & 31 + varg4.length) + 32) < v1)));
    require(varg4.data + varg4.length <= msg.data.length);
    CALLDATACOPY(v1.data, varg4.data, varg4.length);
    v1[varg4.length] = 0;
    // Call into the function below once the checks have passed
    v2 = 0x577(v1, v0, varg2, varg1, varg0);
    v3 = new uint256[](MEM[v2]);
    v4 = v5 = 0;
    while (v4 < MEM[v2]) {
        MEM[v4 + v3.data] = MEM[v2 + 32 + v4];
        v4 += 32;
    }
    if (v4 > MEM[v2]) {
        MEM[MEM[v2] + v3.data] = 0;
    }
    return v3;
}

// varg1 == timestamp
function 0x577(bytes bvarg4, bytes bvarg3, uint256 varg2, uint256 varg1, uint256 varg0) private { 
    require(1 == _wards[msg.sender], Error(0x61757468));
    v0 = v1 = !varg1;
    if (varg1) {
        v0 = v2 = block.timestamp < varg1;
    }
    if (!v0) {
        return 96;
    } else {
        if (varg0 & 0x3) {
            if (varg0 & 0x4) {
                v3 = v4 = address(this) ^ bytes20(this << 96);
                assert(32);
                v5 = v6 = 0;
                while (v5 < bvarg3.length >> 5) {
                    v3 += v4;
                    MEM[bvarg3 + (v5 + 1 << 5)] = v3 ^ MEM[(v5 + 1 << 5) + varg1];
                    v5 += 1;
                }
                assert(32);
                if (bvarg3.length % 32) {
                    MEM[bvarg3 + ((varg1.length >> 5) + 1 << 5)] = (v4 + v3 ^ MEM[((varg1.length >> 5) + 1 << 5) + varg1]) & ~0 << (32 - varg1.length % 32 << 3);
                }
            }
            v7 = v8 = 0;
            if (!(varg0 & 0x1)) {
                if (varg0 & 0x2) {
                    require(bvarg3.data + varg1.length - varg1.data >= 32);
                    require(MEM[bvarg3.data] <= uint64.max);
                    require(bvarg3.data + MEM[varg1.data] + 31 < varg1.data + varg1.length);
                    require(bvarg3[MEM[varg1.data]] <= uint64.max);
                    v9 = new uint256[](bvarg3[MEM[varg1.data]]);
                    require(!((v9 + ((bvarg3[MEM[varg1.data]] << 5) + 32) > uint64.max) | (v9 + ((varg1[MEM[varg1.data]] << 5) + 32) < v9)));
                    v10 = v11 = bvarg3.data + MEM[varg1.data] + 32;
                    v12 = v13 = v9.data;
                    require(v11 + (bvarg3[MEM[varg1.data]] << 6) <= varg1.data + varg1.length);
                    v14 = v15 = 0;
                    while (v14 < bvarg3[MEM[varg1.data]]) {
                        v16 = 0x14d0(v10, bvarg3.data + varg1.length);
                        MEM[v12] = v16;
                        v12 = v12 + 32;
                        v10 += 64;
                        v14 += 1;
                    }
                    v7 = v17 = 0xdd1(v9);
                }
            } else {
                MEM[MEM[64]] = 0;
                MEM[MEM[64] + 32] = 0;
                require(bvarg3.data + varg1.length - varg1.data >= 64);
                v18 = 0x14d0(bvarg3.data, varg1.data + varg1.length);
                v19 = 0xd89(v18);
                v7 = v20 = 0 != int8(v19);
            }
            if (!v7) {
                return 96;
            }
        }
        if (varg0 & 0x8) {
            if (map_0[keccak256('attempt/abort') ^ varg0 >> 192]) {
                return 96;
            }
        }
        // Decrypt the calldata..?
        if (varg0 & 0x10) {
            // This == 0x88886841CfCCBf54AdBbC0B6C9cBAceAbec42b8B
            varg2 = v21 = this ^ varg2;
            // Varg2 == 0x15135a5aac54aa5935f6254377d43750de2b8136
            v22 = v23 = address(this) ^ bytes20(this << 96);
            assert(32);
            slotN = v25 = 0;
            // Iterate over the slots
            while (slotN < bvarg4.length >> 5) {
                v22 += v23;
                MEM[bvarg4 + (slotN + 1 << 5)] = v22 ^ MEM[(slotN + 1 << 5) + bvarg4];
                slotN += 1;
            }
            assert(32);
            if (bvarg4.length % 32) {
                MEM[bvarg4 + ((bvarg4.length >> 5) + 1 << 5)] = (v23 + v22 ^ MEM[((bvarg4.length >> 5) + 1 << 5) + bvarg4]) & ~0 << (32 - bvarg4.length % 32 << 3);
            }
        }
        require(address(varg2), Error(0x7a65726f));
        v26 = v27 = 0;
        while (v26 < bvarg4.length) {
            MEM[v26 + v28.data] = bvarg4[v26];
            v26 += 32;
        }
        if (v26 > bvarg4.length) {
            MEM[bvarg4.length + v28.data] = 0;
        }
        // Calls contract2.sol
        v29, /* uint256 */ v30 = address(varg2).delegatecall(v28.data).gas(msg.gas);
        if (RETURNDATASIZE() == 0) {
            v31 = v32 = 96;
        } else {
            v31 = v33 = new bytes[](RETURNDATASIZE());
            v30 = v33.data;
            RETURNDATACOPY(v30, 0, RETURNDATASIZE());
        }
        burnGasToken(msg.gas, varg0);
        return v31;
    }
}


function 0x14d0(uint256 varg0, uint256 varg1) private { 
    require(varg1 - varg0 >= 64);
    v0 = new struct(2);
    require(!((v0 + 64 > uint64.max) | (v0 + 64 < v0)));
    0x1ee1(MEM[varg0]);
    v0.word0 = MEM[varg0];
    0x1efe(MEM[32 + varg0]);
    v0.word1 = MEM[32 + varg0];
    return v0;
}

function 0x0d201486(uint256 varg0) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    0x1efe(varg0);
    return map_0[varg0];
}

function 0x1c038d5e(address varg0, uint256 varg1, bytes varg2, uint256 varg3, bool varg4, bool varg5) public payable { 
    require(msg.data.length - 4 >= 192);
    0x1ee1(varg0);
    0x1efe(varg1);
    require(varg2 <= uint64.max);
    require(4 + varg2 + 31 < msg.data.length);
    require(varg2.length <= uint64.max);
    v0 = new bytes[](varg2.length);
    require(!((v0 + ((~0x1f & 31 + varg2.length) + 32) > uint64.max) | (v0 + ((~0x1f & 31 + varg2.length) + 32) < v0)));
    require(varg2.data + varg2.length <= msg.data.length);
    CALLDATACOPY(v0.data, varg2.data, varg2.length);
    v0[varg2.length] = 0;
    0x1efe(varg3);
    0x1ef5(varg4);
    0x1ef5(varg5);
    require(1 == _wards[msg.sender], Error(0x61757468));
    if (varg5) {
        v1 = v2 = 32;
    } else {
        v1 = v3 = 0;
    }
    if (varg4) {
        v4 = v5 = 16;
    } else {
        v4 = v6 = 0;
    }
    require(1 == _wards[msg.sender], Error(0x61757468));
    v7 = v8 = !varg3;
    if (varg3) {
        v7 = block.timestamp < varg3;
    }
    if (v7) {
        v9 = v0.length;
        if ((v4 | v1) & 0x10) {
            v10 = this ^ varg0;
            v11 = v12 = address(this) ^ bytes20(this << 96);
            assert(32);
            v13 = v14 = 0;
            while (v13 < v0.length >> 5) {
                v11 += v12;
                MEM[v0 + (v13 + 1 << 5)] = v11 ^ MEM[(v13 + 1 << 5) + v0];
                v13 += 1;
            }
            assert(32);
            if (v0.length % 32) {
                MEM[v0 + ((v0.length >> 5) + 1 << 5)] = (v12 + v11 ^ MEM[((v0.length >> 5) + 1 << 5) + v0]) & ~0 << (32 - v0.length % 32 << 3);
            }
        }
        require(address(v10), Error(0x7a65726f));
        v15 = v0.data;
        v16 = v10.call(v0.data).value(varg1).gas(msg.gas - 34710);
        require(v16);
        burnGasToken(msg.gas, v4 | v1);
    }
}

function 0x1f0fa192(bytes varg0) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    require(varg0 <= uint64.max);
    require(4 + varg0 + 31 < msg.data.length);
    require(varg0.length <= uint64.max);
    require(varg0.data + varg0.length <= msg.data.length);
    require(1 == _wards[msg.sender], Error(0x61757468));
    require(bool(0xb3f879cb30fe243b4dfee438691c04.code.size));
    v0, /* bool */ v1 = 0xb3f879cb30fe243b4dfee438691c04.free(1).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (~0x1f & RETURNDATASIZE() + 31);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    0x1ef5(v1);
}

function 0x300f8970(address varg0, bytes varg1) public payable { 
    require(msg.data.length - 4 >= 64);
    0x1ee1(varg0);
    require(varg1 <= uint64.max);
    require(4 + varg1 + 31 < msg.data.length);
    require(varg1.length <= uint64.max);
    v0 = new bytes[](varg1.length);
    require(!((v0 + ((~0x1f & 31 + varg1.length) + 32) > uint64.max) | (v0 + ((~0x1f & 31 + varg1.length) + 32) < v0)));
    require(varg1.data + varg1.length <= msg.data.length);
    CALLDATACOPY(v0.data, varg1.data, varg1.length);
    v0[varg1.length] = 0;
    require(1 == _wards[msg.sender], Error(0x61757468));
    require(varg0, Error(0x7a65726f));
    v1 = v2 = 0;
    while (v1 < v0.length) {
        MEM[v1 + v3.data] = v0[v1];
        v1 += 32;
    }
    if (v1 > v0.length) {
        MEM[v0.length + v3.data] = 0;
    }
    v4, /* uint256 */ v5, /* uint256 */ v6 = varg0.delegatecall(v3.data).gas(msg.gas);
    if (RETURNDATASIZE() == 0) {
        v7 = v8 = 96;
    } else {
        v7 = v9 = new bytes[](RETURNDATASIZE());
        RETURNDATACOPY(v9.data, 0, RETURNDATASIZE());
    }
    v10 = new uint256[](MEM[v7]);
    v11 = v12 = 0;
    while (v11 < MEM[v7]) {
        MEM[v11 + v10.data] = MEM[v7 + 32 + v11];
        v11 += 32;
    }
    if (v11 > MEM[v7]) {
        MEM[MEM[v7] + v10.data] = 0;
    }
    return v10;
}


function 0x1ee1(address varg0) private { 
    return ;
}

function 0x1ef5(bool varg0) private { 
    return ;
}

function 0x1efe(uint256 varg0) private { 
    return ;
}

function function_selector() public payable { 
}

function 0x3c6a295d(address[] varg0, bytes varg1, uint256[] varg2, uint256[] varg3) public payable { 
    require(msg.data.length - 4 >= 128);
    require(varg0 <= uint64.max);
    require(4 + varg0 + 31 < msg.data.length);
    require(varg0.length <= uint64.max);
    v0 = new address[](varg0.length);
    require(!((v0 + ((varg0.length << 5) + 32) > uint64.max) | (v0 + ((varg0.length << 5) + 32) < v0)));
    v1 = v2 = varg0.data;
    v3 = v4 = v0.data;
    require(v2 + (varg0.length << 5) <= msg.data.length);
    v5 = v6 = 0;
    while (v5 < varg0.length) {
        0x1ee1(msg.data[v1]);
        MEM[v3] = msg.data[v1];
        v3 += 32;
        v1 += 32;
        v5 += 1;
    }
    require(varg1 <= uint64.max);
    require(4 + varg1 + 31 < msg.data.length);
    require(varg1.length <= uint64.max);
    v7 = new bytes[](varg1.length);
    require(!((v7 + ((~0x1f & 31 + varg1.length) + 32) > uint64.max) | (v7 + ((~0x1f & 31 + varg1.length) + 32) < v7)));
    require(varg1.data + varg1.length <= msg.data.length);
    CALLDATACOPY(v7.data, varg1.data, varg1.length);
    v7[varg1.length] = 0;
    require(varg2 <= uint64.max);
    require(4 + varg2 + 31 < msg.data.length);
    require(varg2.length <= uint64.max);
    v8 = new uint256[](varg2.length);
    require(!((v8 + ((varg2.length << 5) + 32) > uint64.max) | (v8 + ((varg2.length << 5) + 32) < v8)));
    v9 = v10 = varg2.data;
    v11 = v12 = v8.data;
    require(v10 + (varg2.length << 5) <= msg.data.length);
    v13 = v14 = 0;
    while (v13 < varg2.length) {
        0x1efe(msg.data[v9]);
        MEM[v11] = msg.data[v9];
        v11 += 32;
        v9 += 32;
        v13 += 1;
    }
    require(varg3 <= uint64.max);
    require(4 + varg3 + 31 < msg.data.length);
    require(varg3.length <= uint64.max);
    v15 = new uint256[](varg3.length);
    require(!((v15 + ((varg3.length << 5) + 32) > uint64.max) | (v15 + ((varg3.length << 5) + 32) < v15)));
    v16 = v17 = varg3.data;
    v18 = v19 = v15.data;
    require(v17 + (varg3.length << 5) <= msg.data.length);
    v20 = v21 = 0;
    while (v20 < varg3.length) {
        0x1efe(msg.data[v16]);
        MEM[v18] = msg.data[v16];
        v18 += 32;
        v16 += 32;
        v20 += 1;
    }
    require(1 == _wards[msg.sender], Error(0x61757468));
    require(v0.length > 0, Error(0x6c656e30));
    require(v8.length == v0.length, Error(0x6c656e31));
    require(v15.length == v0.length, Error(0x6c656e32));
    if (0) {
        v22 = v23 = 0;
        while (v22 < v0.length) {
            assert(v22 < v0.length);
            assert(v22 < v0.length);
            v0[v22] = address(this ^ v0[v22]);
            v22 += 1;
        }
        v24 = v25 = address(this) ^ bytes20(this << 96);
        assert(32);
        v26 = v27 = 0;
        while (v26 < v7.length >> 5) {
            v24 += v25;
            MEM[v7 + (v26 + 1 << 5)] = v24 ^ MEM[(v26 + 1 << 5) + v7];
            v26 += 1;
        }
        assert(32);
        if (v7.length % 32) {
            MEM[v7 + ((v7.length >> 5) + 1 << 5)] = (v25 + v24 ^ MEM[((v7.length >> 5) + 1 << 5) + v7]) & ~0 << (32 - v7.length % 32 << 3);
        }
    }
    v28 = v29 = 0;
    while (v28 < v0.length) {
        assert(v28 < v8.length);
        if (v28 < v0.length - 1) {
            assert(1 + v28 < v8.length);
            v30 = v31 = v8[1 + v28];
        } else {
            v30 = v7.length;
        }
        assert(v28 < v0.length);
        v32 = v33 = v0[v28];
        assert(v28 < v15.length);
        assert(v28 < v8.length);
        if (0) {
            v32 = this ^ v33;
            v34 = v35 = address(this) ^ bytes20(this << 96);
            assert(32);
            v36 = v37 = 0;
            while (v36 < v7.length >> 5) {
                v34 += v35;
                MEM[v7 + (v36 + 1 << 5)] = v34 ^ MEM[(v36 + 1 << 5) + v7];
                v36 += 1;
            }
            assert(32);
            if (v7.length % 32) {
                MEM[v7 + ((v7.length >> 5) + 1 << 5)] = (v35 + v34 ^ MEM[((v7.length >> 5) + 1 << 5) + v7]) & ~0 << (32 - v7.length % 32 << 3);
            }
        }
        require(address(v32), Error(0x7a65726f));
        v38 = v32.call(MEM[(v7.data + v8[v28]) len (v30 - v8[v28])], MEM[(MEM[64]) len 0]).value(v15[v28]).gas(msg.gas - 34710);
        require(v38);
        v28 += 1;
    }
}

function cancel(uint256 proposalId) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    0x1efe(proposalId);
}

function 0x4c3e1624(uint256 varg0, uint256 varg1, address[] varg2, bytes varg3, uint256[] varg4, uint256[] varg5) public payable { 
    require(msg.data.length - 4 >= 192);
    0x1efe(varg0);
    0x1efe(varg1);
    require(varg2 <= uint64.max);
    require(4 + varg2 + 31 < msg.data.length);
    require(varg2.length <= uint64.max);
    v0 = new address[](varg2.length);
    require(!((v0 + ((varg2.length << 5) + 32) > uint64.max) | (v0 + ((varg2.length << 5) + 32) < v0)));
    v1 = v2 = varg2.data;
    v3 = v4 = v0.data;
    require(v2 + (varg2.length << 5) <= msg.data.length);
    v5 = v6 = 0;
    while (v5 < varg2.length) {
        0x1ee1(msg.data[v1]);
        MEM[v3] = msg.data[v1];
        v3 += 32;
        v1 += 32;
        v5 += 1;
    }
    require(varg3 <= uint64.max);
    require(4 + varg3 + 31 < msg.data.length);
    require(varg3.length <= uint64.max);
    v7 = new bytes[](varg3.length);
    require(!((v7 + ((~0x1f & 31 + varg3.length) + 32) > uint64.max) | (v7 + ((~0x1f & 31 + varg3.length) + 32) < v7)));
    require(varg3.data + varg3.length <= msg.data.length);
    CALLDATACOPY(v7.data, varg3.data, varg3.length);
    v7[varg3.length] = 0;
    require(varg4 <= uint64.max);
    require(4 + varg4 + 31 < msg.data.length);
    require(varg4.length <= uint64.max);
    v8 = new uint256[](varg4.length);
    require(!((v8 + ((varg4.length << 5) + 32) > uint64.max) | (v8 + ((varg4.length << 5) + 32) < v8)));
    v9 = v10 = varg4.data;
    v11 = v12 = v8.data;
    require(v10 + (varg4.length << 5) <= msg.data.length);
    v13 = v14 = 0;
    while (v13 < varg4.length) {
        0x1efe(msg.data[v9]);
        MEM[v11] = msg.data[v9];
        v11 += 32;
        v9 += 32;
        v13 += 1;
    }
    require(varg5 <= uint64.max);
    require(4 + varg5 + 31 < msg.data.length);
    require(varg5.length <= uint64.max);
    v15 = new uint256[](varg5.length);
    require(!((v15 + ((varg5.length << 5) + 32) > uint64.max) | (v15 + ((varg5.length << 5) + 32) < v15)));
    v16 = v17 = varg5.data;
    v18 = v19 = v15.data;
    require(v17 + (varg5.length << 5) <= msg.data.length);
    v20 = v21 = 0;
    while (v20 < varg5.length) {
        0x1efe(msg.data[v16]);
        MEM[v18] = msg.data[v16];
        v18 += 32;
        v16 += 32;
        v20 += 1;
    }
    require(1 == _wards[msg.sender], Error(0x61757468));
    v22 = v23 = !varg1;
    if (varg1) {
        v22 = block.timestamp < varg1;
    }
    if (v22) {
        require(v0.length > 0, Error(0x6c656e30));
        require(v8.length == v0.length, Error(0x6c656e31));
        require(v15.length == v0.length, Error(0x6c656e32));
        if (varg0 & 0x10) {
            v24 = v25 = 0;
            while (v24 < v0.length) {
                assert(v24 < v0.length);
                assert(v24 < v0.length);
                v0[v24] = address(this ^ v0[v24]);
                v24 += 1;
            }
            v26 = v27 = address(this) ^ bytes20(this << 96);
            assert(32);
            v28 = v29 = 0;
            while (v28 < v7.length >> 5) {
                v26 += v27;
                MEM[v7 + (v28 + 1 << 5)] = v26 ^ MEM[(v28 + 1 << 5) + v7];
                v28 += 1;
            }
            assert(32);
            if (v7.length % 32) {
                MEM[v7 + ((v7.length >> 5) + 1 << 5)] = (v27 + v26 ^ MEM[((v7.length >> 5) + 1 << 5) + v7]) & ~0 << (32 - v7.length % 32 << 3);
            }
        }
        v30 = v31 = 0;
        while (v30 < v0.length) {
            assert(v30 < v8.length);
            if (v30 < v0.length - 1) {
                assert(1 + v30 < v8.length);
                v32 = v33 = v8[1 + v30];
            } else {
                v32 = v7.length;
            }
            assert(v30 < v0.length);
            v34 = v35 = v0[v30];
            assert(v30 < v15.length);
            assert(v30 < v8.length);
            if (0) {
                v34 = this ^ v35;
                v36 = v37 = address(this) ^ bytes20(this << 96);
                assert(32);
                v38 = v39 = 0;
                while (v38 < v7.length >> 5) {
                    v36 += v37;
                    MEM[v7 + (v38 + 1 << 5)] = v36 ^ MEM[(v38 + 1 << 5) + v7];
                    v38 += 1;
                }
                assert(32);
                if (v7.length % 32) {
                    MEM[v7 + ((v7.length >> 5) + 1 << 5)] = (v37 + v36 ^ MEM[((v7.length >> 5) + 1 << 5) + v7]) & ~0 << (32 - v7.length % 32 << 3);
                }
            }
            require(address(v34), Error(0x7a65726f));
            v40 = v34.call(MEM[(v7.data + v8[v30]) len (v32 - v8[v30])], MEM[(MEM[64]) len 0]).value(v15[v30]).gas(msg.gas - 34710);
            require(v40);
            v30 += 1;
        }
        burnGasToken(msg.gas, varg0);
    }
}

function rely(bytes4 function_selector, uint256 varg1, uint256 varg2) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    0x1ee1(varg1);
    require(1 == _wards[msg.sender], Error(0x61757468));
    _wards[address(varg1)] = 1;
    v0 = new uint256[](224);
    CALLDATACOPY(v0.data, 0, 224);
    emit function_selector(msg.sender, varg1, varg2, v0);
}

function 0x6fabe18c(address varg0, bytes varg1) public payable { 
    require(msg.data.length - 4 >= 64);
    0x1ee1(varg0);
    require(varg1 <= uint64.max);
    require(4 + varg1 + 31 < msg.data.length);
    require(varg1.length <= uint64.max);
    v0 = new bytes[](varg1.length);
    require(!((v0 + ((~0x1f & 31 + varg1.length) + 32) > uint64.max) | (v0 + ((~0x1f & 31 + varg1.length) + 32) < v0)));
    require(varg1.data + varg1.length <= msg.data.length);
    CALLDATACOPY(v0.data, varg1.data, varg1.length);
    v0[varg1.length] = 0;
    require(1 == _wards[msg.sender], Error(0x61757468));
    MEM[MEM[64]] = 0;
    v1 = 0x577(v0, MEM[64], varg0, 0, 32);
    v2 = new uint256[](MEM[v1]);
    v3 = v4 = 0;
    while (v3 < MEM[v1]) {
        MEM[v3 + v2.data] = MEM[v1 + 32 + v3];
        v3 += 32;
    }
    if (v3 > MEM[v1]) {
        MEM[MEM[v1] + v2.data] = 0;
    }
    return v2;
}

function 0x74e44c39(bytes4 function_selector, uint256 varg1, uint256 varg2) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    require(varg1 <= uint64.max);
    require(4 + varg1 + 31 < msg.data.length);
    require(varg1.length <= uint64.max);
    require(varg1.data + (varg1.length << 5) <= msg.data.length);
    require(1 == _wards[msg.sender], Error(0x61757468));
    v0 = v1 = 0;
    while (v0 < varg1.length) {
        assert(v0 < varg1.length);
        require((v0 << 5) + varg1.data + 32 - ((v0 << 5) + varg1.data) >= 32);
        0x1ee1(varg1[v0]);
        _wards[address(varg1[v0])] = 0;
        v0 += 1;
    }
    v2 = new bytes[](224);
    CALLDATACOPY(v2.data, 0, 224);
    emit function_selector(msg.sender, varg1, varg2, v2);
}

function 0x7f3b2e07(uint256[] varg0, uint256[] varg1) public nonPayable { 
    require(msg.data.length - 4 >= 64);
    require(varg0 <= uint64.max);
    require(4 + varg0 + 31 < msg.data.length);
    require(varg0.length <= uint64.max);
    v0 = new uint256[](varg0.length);
    require(!((v0 + ((varg0.length << 5) + 32) > uint64.max) | (v0 + ((varg0.length << 5) + 32) < v0)));
    v1 = v2 = varg0.data;
    v3 = v4 = v0.data;
    require(v2 + (varg0.length << 5) <= msg.data.length);
    v5 = v6 = 0;
    while (v5 < varg0.length) {
        0x1efe(msg.data[v1]);
        MEM[v3] = msg.data[v1];
        v3 += 32;
        v1 += 32;
        v5 += 1;
    }
    require(varg1 <= uint64.max);
    require(4 + varg1 + 31 < msg.data.length);
    require(varg1.length <= uint64.max);
    v7 = new uint256[](varg1.length);
    require(!((v7 + ((varg1.length << 5) + 32) > uint64.max) | (v7 + ((varg1.length << 5) + 32) < v7)));
    v8 = v9 = varg1.data;
    v10 = v11 = v7.data;
    require(v9 + (varg1.length << 5) <= msg.data.length);
    v12 = v13 = 0;
    while (v12 < varg1.length) {
        0x1efe(msg.data[v8]);
        MEM[v10] = msg.data[v8];
        v10 += 32;
        v8 += 32;
        v12 += 1;
    }
    require(1 == _wards[msg.sender], Error(0x61757468));
    require(v0.length == v7.length, Error(0x6c656e));
    v14 = v15 = 0;
    while (v14 < v0.length) {
        assert(v14 < v7.length);
        assert(v14 < v0.length);
        map_0[v0[v14]] = v7[v14];
        v14 += 1;
    }
}

function deny(bytes4 function_selector, uint256 varg1, uint256 varg2) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    0x1ee1(varg1);
    require(1 == _wards[msg.sender], Error(0x61757468));
    _wards[address(varg1)] = 0;
    v0 = new uint256[](224);
    CALLDATACOPY(v0.data, 0, 224);
    emit function_selector(msg.sender, varg1, varg2, v0);
}

function 0xaba94612(address varg0, uint256 varg1, bytes varg2) public payable { 
    require(msg.data.length - 4 >= 96);
    0x1ee1(varg0);
    0x1efe(varg1);
    require(varg2 <= uint64.max);
    require(4 + varg2 + 31 < msg.data.length);
    require(varg2.length <= uint64.max);
    v0 = new bytes[](varg2.length);
    require(!((v0 + ((~0x1f & 31 + varg2.length) + 32) > uint64.max) | (v0 + ((~0x1f & 31 + varg2.length) + 32) < v0)));
    require(varg2.data + varg2.length <= msg.data.length);
    CALLDATACOPY(v0.data, varg2.data, varg2.length);
    v0[varg2.length] = 0;
    require(1 == _wards[msg.sender], Error(0x61757468));
    v1 = v0.length;
    if (0) {
        v2 = this ^ varg0;
        v3 = v4 = address(this) ^ bytes20(this << 96);
        assert(32);
        v5 = v6 = 0;
        while (v5 < v0.length >> 5) {
            v3 += v4;
            MEM[v0 + (v5 + 1 << 5)] = v3 ^ MEM[(v5 + 1 << 5) + v0];
            v5 += 1;
        }
        assert(32);
        if (v0.length % 32) {
            MEM[v0 + ((v0.length >> 5) + 1 << 5)] = (v4 + v3 ^ MEM[((v0.length >> 5) + 1 << 5) + v0]) & ~0 << (32 - v0.length % 32 << 3);
        }
    }
    require(address(v2), Error(0x7a65726f));
    v7 = v0.data;
    v8 = v2.call(v0.data).value(varg1).gas(msg.gas - 34710);
    require(v8);
}

function 0xb2d2ace9(bytes varg0) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    require(varg0 <= uint64.max);
    require(4 + varg0 + 31 < msg.data.length);
    require(varg0.length <= uint64.max);
    require(varg0.data + varg0.length <= msg.data.length);
}

function wards(address varg0) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    0x1ee1(varg0);
    return _wards[varg0];
}

function 0xc2a737be(address varg0, uint256 varg1, bytes varg2) public payable { 
    require(msg.data.length - 4 >= 96);
    0x1ee1(varg0);
    0x1efe(varg1);
    require(varg2 <= uint64.max);
    require(4 + varg2 + 31 < msg.data.length);
    require(varg2.length <= uint64.max);
    v0 = new bytes[](varg2.length);
    require(!((v0 + ((~0x1f & 31 + varg2.length) + 32) > uint64.max) | (v0 + ((~0x1f & 31 + varg2.length) + 32) < v0)));
    require(varg2.data + varg2.length <= msg.data.length);
    CALLDATACOPY(v0.data, varg2.data, varg2.length);
    v0[varg2.length] = 0;
    require(1 == _wards[msg.sender], Error(0x61757468));
    require(1 == _wards[msg.sender], Error(0x61757468));
    v1 = v2 = !0;
    if (0) {
        v1 = block.timestamp < 0;
    }
    if (v1) {
        v3 = v0.length;
        if (0) {
            v4 = this ^ varg0;
            v5 = v6 = address(this) ^ bytes20(this << 96);
            assert(32);
            v7 = v8 = 0;
            while (v7 < v0.length >> 5) {
                v5 += v6;
                MEM[v0 + (v7 + 1 << 5)] = v5 ^ MEM[(v7 + 1 << 5) + v0];
                v7 += 1;
            }
            assert(32);
            if (v0.length % 32) {
                MEM[v0 + ((v0.length >> 5) + 1 << 5)] = (v6 + v5 ^ MEM[((v0.length >> 5) + 1 << 5) + v0]) & ~0 << (32 - v0.length % 32 << 3);
            }
        }
        require(address(v4), Error(0x7a65726f));
        v9 = v0.data;
        v10 = v4.call(v0.data).value(varg1).gas(msg.gas - 34710);
        require(v10);
        burnGasToken(msg.gas, 32);
    }
}

function 0xd27dbffc(bytes4 function_selector, uint256 varg1, uint256 varg2) public nonPayable { 
    require(msg.data.length - 4 >= 32);
    require(varg1 <= uint64.max);
    require(4 + varg1 + 31 < msg.data.length);
    require(varg1.length <= uint64.max);
    require(varg1.data + (varg1.length << 5) <= msg.data.length);
    require(1 == _wards[msg.sender], Error(0x61757468));
    v0 = v1 = 0;
    while (v0 < varg1.length) {
        assert(v0 < varg1.length);
        require((v0 << 5) + varg1.data + 32 - ((v0 << 5) + varg1.data) >= 32);
        0x1ee1(varg1[v0]);
        _wards[address(varg1[v0])] = 1;
        v0 += 1;
    }
    v2 = new bytes[](224);
    CALLDATACOPY(v2.data, 0, 224);
    emit function_selector(msg.sender, varg1, varg2, v2);
}

function 0xe1149e5e(uint256 varg0, uint256 varg1, uint256 varg2, address varg3, bytes varg4) public payable { 
    require(msg.data.length - 4 >= 160);
    0x1efe(varg0);
    0x1efe(varg1);
    0x1efe(varg2);
    0x1ee1(varg3);
    require(varg4 <= uint64.max);
    require(4 + varg4 + 31 < msg.data.length);
    require(varg4.length <= uint64.max);
    v0 = new bytes[](varg4.length);
    require(!((v0 + ((~0x1f & 31 + varg4.length) + 32) > uint64.max) | (v0 + ((~0x1f & 31 + varg4.length) + 32) < v0)));
    require(varg4.data + varg4.length <= msg.data.length);
    CALLDATACOPY(v0.data, varg4.data, varg4.length);
    v0[varg4.length] = 0;
    require(1 == _wards[msg.sender], Error(0x61757468));
    v1 = v2 = !varg1;
    if (varg1) {
        v1 = block.timestamp < varg1;
    }
    if (v1) {
        v3 = v0.length;
        if (varg0 & 0x10) {
            v4 = this ^ varg3;
            v5 = v6 = address(this) ^ bytes20(this << 96);
            assert(32);
            v7 = v8 = 0;
            while (v7 < v0.length >> 5) {
                v5 += v6;
                MEM[v0 + (v7 + 1 << 5)] = v5 ^ MEM[(v7 + 1 << 5) + v0];
                v7 += 1;
            }
            assert(32);
            if (v0.length % 32) {
                MEM[v0 + ((v0.length >> 5) + 1 << 5)] = (v6 + v5 ^ MEM[((v0.length >> 5) + 1 << 5) + v0]) & ~0 << (32 - v0.length % 32 << 3);
            }
        }
        require(address(v4), Error(0x7a65726f));
        v9 = v0.data;
        v10 = v4.call(v0.data).value(varg2).gas(msg.gas - 34710);
        require(v10);
        burnGasToken(msg.gas, varg0);
    }
}

function 0xeab1676d(address varg0, bytes varg1, uint256 varg2, bool varg3, bool varg4) public payable { 
    require(msg.data.length - 4 >= 160);
    0x1ee1(varg0);
    require(varg1 <= uint64.max);
    require(4 + varg1 + 31 < msg.data.length);
    require(varg1.length <= uint64.max);
    v0 = new bytes[](varg1.length);
    require(!((v0 + ((~0x1f & 31 + varg1.length) + 32) > uint64.max) | (v0 + ((~0x1f & 31 + varg1.length) + 32) < v0)));
    require(varg1.data + varg1.length <= msg.data.length);
    CALLDATACOPY(v0.data, varg1.data, varg1.length);
    v0[varg1.length] = 0;
    0x1efe(varg2);
    0x1ef5(varg3);
    0x1ef5(varg4);
    require(1 == _wards[msg.sender], Error(0x61757468));
    if (varg4) {
        v1 = v2 = 32;
    } else {
        v1 = v3 = 0;
    }
    if (varg3) {
        v4 = v5 = 16;
    } else {
        v4 = v6 = 0;
    }
    MEM[64] = MEM[64] + 32;
    MEM[MEM[64]] = 0;
    v7 = 0x577(v0, MEM[64], varg0, varg2, v4 | v1);
    v8 = new uint256[](MEM[v7]);
    v9 = v10 = 0;
    while (v9 < MEM[v7]) {
        MEM[v9 + v8.data] = MEM[v7 + 32 + v9];
        v9 += 32;
    }
    if (v9 > MEM[v7]) {
        MEM[MEM[v7] + v8.data] = 0;
    }
    return v8;
}


function 0xd89(struct(2) varg0) private { 
    if ((address(varg0.word0)).balance != varg0.word1) {
        if ((address(varg0.word0)).balance >= varg0.word1) {
            return 1;
        } else {
            return ~0;
        }
    } else {
        return 0;
    }
}

function 0xdd1(uint256 varg0) private { 
    v0 = v1 = 0;
    while (v0 < varg0.length) {
        assert(v0 < varg0.length);
        if ((address(MEM[varg0[v0]])).balance != MEM[32 + varg0[v0]]) {
            if ((address(MEM[varg0[v0]])).balance >= MEM[32 + varg0[v0]]) {
                v2 = v3 = 1;
            } else {
                v2 = v4 = ~0;
            }
        } else {
            v2 = 0;
        }
        if (!int8(v2)) {
            v0 += 1;
        } else {
            return 1;
        }
    }
    return 0;
}

function burnGasToken(uint256 varg0, uint256 varg1) private { 
    v0 = v1 = bool(varg1 & 0x20);
    v0 = v2 = bool(varg1 & 0x40);
    if (!v0) {
        return ;
    } else if (msg.gas <= 32340) {
        return ;
    } else {
        if (v1) {
            v3 = v4 = 6689;
        } else {
            v3 = v5 = 6053;
        }
        if (v1) {
            // Gas token 2
            v6 = v7 = 0xb3f879cb30fe243b4dfee438691c04;
        } else {
            // Chi gas token
            v6 = v8 = 0x4946c0e9f43f4dee607b0ef1fa1c;
        }
        assert(uint16(v3));
        v9 = v10 = (msg.gas - 32340) / uint16(v3);
        v9 = v11 = (21000 + ((msg.data.length << 4) + (varg0 - msg.gas)) + 14154) / 41130 + 1;
        v12 = v13 = v10 > 0;
        if (v13) {
            v12 = v14 = v11 > 0;
        }
        if (v12) {
            if (v10 >= v11) {
            }
            require(bool((address(v6)).code.size));
            v15, /* uint256 */ v16 = address(v6).freeUpTo(v9).gas(msg.gas);
            require(bool(v15), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
            MEM[64] = MEM[64] + (~0x1f & RETURNDATASIZE() + 31);
            require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
            0x1efe(v16);
        }
        return ;
    }
}

// Note: The function selector is not present in the original solidity code.
// However, we display it for the sake of completeness.

function function_selector( function_selector) public payable { 
    MEM[64] = 128;
    if (msg.data.length < 4) {
        fallback();
    } else if (0x74e44c39 > function_selector >> 224) {
        if (0x3c6a295d > function_selector >> 224) {
            if (0x1f0fa192 > function_selector >> 224) {
                if (0xd201486 == function_selector >> 224) {
                    0x0d201486();
                } else if (0x1c038d5e == function_selector >> 224) {
                    0x1c038d5e();
                } else {
                    exit;
                }
            } else if (0x1f0fa192 == function_selector >> 224) {
                0x1f0fa192();
            } else if (0x300f8970 == function_selector >> 224) {
                0x300f8970();
            } else if (0x3743cb3f == function_selector >> 224) {
                0x3743cb3f();
            } else {
                exit;
            }
        } else if (0x4c3e1624 > function_selector >> 224) {
            if (0x3c6a295d == function_selector >> 224) {
                0x3c6a295d();
            } else if (0x40e58ee5 == function_selector >> 224) {
                cancel(uint256);
            } else {
                exit;
            }
        } else if (0x4c3e1624 == function_selector >> 224) {
            0x4c3e1624();
        } else if (0x65fae35e == function_selector >> 224) {
            rely(address);
        } else if (0x6fabe18c == function_selector >> 224) {
            0x6fabe18c();
        } else {
            exit;
        }
    } else if (0xbf353dbb > function_selector >> 224) {
        if (0x9c52a7f1 > function_selector >> 224) {
            if (0x74e44c39 == function_selector >> 224) {
                0x74e44c39();
            } else if (0x7f3b2e07 == function_selector >> 224) {
                0x7f3b2e07();
            } else {
                exit;
            }
        } else if (0x9c52a7f1 == function_selector >> 224) {
            deny(address);
        } else if (0xaba94612 == function_selector >> 224) {
            0xaba94612();
        } else if (0xb2d2ace9 == function_selector >> 224) {
            0xb2d2ace9();
        } else {
            exit;
        }
    } else if (0xd27dbffc > function_selector >> 224) {
        if (0xbf353dbb == function_selector >> 224) {
            wards(address);
        } else if (0xc2a737be == function_selector >> 224) {
            0xc2a737be();
        } else {
            exit;
        }
    } else if (0xd27dbffc == function_selector >> 224) {
        0xd27dbffc();
    } else if (0xe1149e5e == function_selector >> 224) {
        0xe1149e5e();
    } else if (0xeab1676d == function_selector >> 224) {
        0xeab1676d();
    } else {
        exit;
    }
}
