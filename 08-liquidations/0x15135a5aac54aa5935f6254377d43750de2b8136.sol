// Decompiled by library.dedaub.com
// 2024.08.21 23:19 UTC
// Compiled using the solidity compiler version 0.5.17


// Data structures and variables inferred from the use of storage instructions
mapping (uint256 => uint256) map_0; // STORAGE[0x0]

// FUNCTION CALLED BY 0x88886841cfccbf54adbbc0b6c9cbaceabec42b8b

/* Calldata: varg0 to varg10
    0000000000000000000000005d3a536e4d6dbd6114cc1ead35777bab948e3643
    0000000000000000000000004ddc2d193948926d02f9b1fe9e1daa0718270ed5
    00000000000000000000000026db83c03f408135933b3cff8b7adc6a7e0adebc
    6afae951000000000000000000000000000000000000000000000000000400c0
    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    0000000000000000000000000000000000000000000000000000000000000160
    0000000000000000000000000000000000000000000000000000000000000180
    00000000000000000000000000000000000000000000000000000000000001a0
    00000000000000000000000000000000000000000000000000000000000001c0
*/
function 0x389eee82(address varg0, address varg1, address varg2, uint256 varg3, uint256 varg4, uint256 varg5, uint256 varg6, uint256 varg7, uint256 varg8, uint256 varg9, uint256 varg10) public payable { 
    require(msg.data.length - 4 >= 352);
    require(msg.data.length - 132 >= 96);
    v0 = new struct(3);
    require(!((v0 + 96 < v0) | (v0 + 96 > uint64.max)));
    v0.word0 = varg4;
    v0.word1 = varg5;
    v0.word2 = varg6;
    require(varg7 <= uint64.max);
    require(4 + varg7 + 31 < msg.data.length);
    require(varg7.length <= uint64.max);
    v1 = new uint256[](varg7.length);
    require(!((v1 + ((varg7.length << 5) + 32) < v1) | (v1 + ((varg7.length << 5) + 32) > uint64.max)));
    v2 = v3 = varg7.data;
    v4 = v5 = v1.data;
    require(v3 + (varg7.length << 6) <= msg.data.length);
    v6 = v7 = 0;
    while (v6 < varg7.length) {
        require(msg.data.length - v2 >= 64);
        v8 = new struct(2);
        require(!((v8 + 64 < v8) | (v8 + 64 > uint64.max)));
        require(msg.data[v2] == address(msg.data[v2]));
        v8.word0 = msg.data[v2];
        require(msg.data[32 + v2] == msg.data[32 + v2]);
        v8.word1 = msg.data[32 + v2];
        MEM[v4] = v8;
        v4 = v4 + 32;
        v2 += 64;
        v6 += 1;
    }
    require(varg8 <= uint64.max);
    require(4 + varg8 + 31 < msg.data.length);
    require(varg8.length <= uint64.max);
    v9 = new uint256[](varg8.length);
    require(!((v9 + ((varg8.length << 5) + 32) < v9) | (v9 + ((varg8.length << 5) + 32) > uint64.max)));
    v10 = v11 = varg8.data;
    v12 = v13 = v9.data;
    require(v11 + (varg8.length << 6) <= msg.data.length);
    v14 = v15 = 0;
    while (v14 < varg8.length) {
        require(msg.data.length - v10 >= 64);
        v16 = new struct(2);
        require(!((v16 + 64 < v16) | (v16 + 64 > uint64.max)));
        require(msg.data[v10] == msg.data[v10]);
        v16.word0 = msg.data[v10];
        require(msg.data[32 + v10] == msg.data[32 + v10]);
        v16.word1 = msg.data[32 + v10];
        MEM[v12] = v16;
        v12 = v12 + 32;
        v10 += 64;
        v14 += 1;
    }
    require(varg9 <= uint64.max);
    require(4 + varg9 + 31 < msg.data.length);
    require(varg9.length <= uint64.max);
    v17 = new uint256[](varg9.length);
    require(!((v17 + ((varg9.length << 5) + 32) < v17) | (v17 + ((varg9.length << 5) + 32) > uint64.max)));
    v18 = v19 = varg9.data;
    v20 = v21 = v17.data;
    require(v19 + varg9.length * 96 <= msg.data.length);
    v22 = v23 = 0;
    while (v22 < varg9.length) {
        require(msg.data.length - v18 >= 96);
        v24 = new struct(3);
        require(!((v24 + 96 < v24) | (v24 + 96 > uint64.max)));
        require(msg.data[v18] == address(msg.data[v18]));
        v24.word0 = msg.data[v18];
        require(msg.data[32 + v18] == uint128(msg.data[32 + v18]));
        v24.word1 = msg.data[32 + v18];
        require(msg.data[v18 + 64] == uint128(msg.data[v18 + 64]));
        v24.word2 = msg.data[v18 + 64];
        MEM[v20] = v24;
        v20 = v20 + 32;
        v18 += 96;
        v22 += 1;
    }
    require(varg10 <= uint64.max);
    require(4 + varg10 + 31 < msg.data.length);
    require(varg10.length <= uint64.max);
    v25 = new uint256[](varg10.length);
    require(!((v25 + ((varg10.length << 5) + 32) < v25) | (v25 + ((varg10.length << 5) + 32) > uint64.max)));
    v26 = v27 = varg10.data;
    v28 = v29 = v25.data;
    v30 = v31 = 0;
    while (v30 < varg10.length) {
        require(msg.data.length - (v27 + msg.data[v26]) >= 96);
        v32 = new struct(3);
        require(!((v32 + 96 < v32) | (v32 + 96 > uint64.max)));
        require(msg.data[v27 + msg.data[v26]] <= uint64.max);
        require(v27 + msg.data[v26] + msg.data[v27 + msg.data[v26]] + 31 < msg.data.length);
        require(msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26]]] <= uint64.max);
        v33 = new uint256[](msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26]]]);
        require(!((v33 + ((msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26]]] << 5) + 32) < v33) | (v33 + ((msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26]]] << 5) + 32) > uint64.max)));
        v34 = v35 = 32 + (v27 + msg.data[v26] + msg.data[v27 + msg.data[v26]]);
        v36 = v37 = v33.data;
        v38 = v39 = 0;
        while (v38 < msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26]]]) {
            require(v35 + msg.data[v34] + 31 < msg.data.length);
            require(msg.data[v35 + msg.data[v34]] <= uint64.max);
            v40 = new bytes[](msg.data[v35 + msg.data[v34]]);
            require(!((v40 + ((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + msg.data[v35 + msg.data[v34]]) + 32) < v40) | (v40 + ((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + msg.data[v35 + msg.data[v34]]) + 32) > uint64.max)));
            require(v35 + msg.data[v34] + 32 + msg.data[v35 + msg.data[v34]] <= msg.data.length);
            CALLDATACOPY(v40.data, v35 + msg.data[v34] + 32, msg.data[v35 + msg.data[v34]]);
            v40[msg.data[v35 + msg.data[v34]]] = 0;
            MEM[v36] = v40;
            v36 += 32;
            v34 += 32;
            v38 += 1;
        }
        v32.word0 = v33;
        require(msg.data[v27 + msg.data[v26] + 32] <= uint64.max);
        require(v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 32] + 31 < msg.data.length);
        require(msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 32]] <= uint64.max);
        v41 = new uint256[](msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 32]]);
        require(!((v41 + ((msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 32]] << 5) + 32) < v41) | (v41 + ((msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 32]] << 5) + 32) > uint64.max)));
        v42 = v43 = 32 + (v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 32]);
        v44 = v45 = v41.data;
        v46 = v47 = 0;
        while (v46 < msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 32]]) {
            require(v43 + msg.data[v42] + 31 < msg.data.length);
            require(msg.data[v43 + msg.data[v42]] <= uint64.max);
            v48 = new bytes[](msg.data[v43 + msg.data[v42]]);
            require(!((v48 + ((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + msg.data[v43 + msg.data[v42]]) + 32) < v48) | (v48 + ((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + msg.data[v43 + msg.data[v42]]) + 32) > uint64.max)));
            require(v43 + msg.data[v42] + 32 + msg.data[v43 + msg.data[v42]] <= msg.data.length);
            CALLDATACOPY(v48.data, v43 + msg.data[v42] + 32, msg.data[v43 + msg.data[v42]]);
            v48[msg.data[v43 + msg.data[v42]]] = 0;
            MEM[v44] = v48;
            v44 += 32;
            v42 += 32;
            v46 += 1;
        }
        v32.word1 = v41;
        require(msg.data[v27 + msg.data[v26] + 64] <= uint64.max);
        require(v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 64] + 31 < msg.data.length);
        require(msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 64]] <= uint64.max);
        v49 = new uint256[](msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 64]]);
        require(!((v49 + ((msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 64]] << 5) + 32) < v49) | (v49 + ((msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 64]] << 5) + 32) > uint64.max)));
        v50 = v51 = 32 + (v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 64]);
        v52 = v53 = v49.data;
        v54 = v55 = 0;
        while (v54 < msg.data[v27 + msg.data[v26] + msg.data[v27 + msg.data[v26] + 64]]) {
            require(v51 + msg.data[v50] + 31 < msg.data.length);
            require(msg.data[v51 + msg.data[v50]] <= uint64.max);
            v56 = new bytes[](msg.data[v51 + msg.data[v50]]);
            require(!((v56 + ((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + msg.data[v51 + msg.data[v50]]) + 32) < v56) | (v56 + ((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + msg.data[v51 + msg.data[v50]]) + 32) > uint64.max)));
            require(v51 + msg.data[v50] + 32 + msg.data[v51 + msg.data[v50]] <= msg.data.length);
            CALLDATACOPY(v56.data, v51 + msg.data[v50] + 32, msg.data[v51 + msg.data[v50]]);
            v56[msg.data[v51 + msg.data[v50]]] = 0;
            MEM[v52] = v56;
            v52 += 32;
            v50 += 32;
            v54 += 1;
        }
        v32.word2 = v49;
        MEM[v28] = v32;
        v28 += 32;
        v26 += 32;
        v30 += 1;
    }
    v57 = postPrices(v25, v17, v9, v1, varg3, varg2, varg1, varg0);
    if (v57) {
        if (varg3 & 0x100) {
            require(bool(varg1.code.size));
            v58, /* uint256 */ v59 = varg1.balanceOf(address(this)).gas(msg.gas);
            require(bool(v58), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
            MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
            require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        } else {
            v59 = v60 = 0;
        }
        v61, v62 = 0x8f1(v0, varg2, varg1, varg0);
        if (v62) {
            if (!v61) {
                if (!bool(!(varg3 & 0x100))) {
                    v63 = 0x492(v59, varg1);
                }
            } else {
                require(!(varg3 & 0x800), Error(0x6c697166));
                if (!(varg3 & 0x8000)) {
                    if (varg3 & 0x10000) {
                        v64 = v65 = v1.length > 0;
                        if (v65) {
                            v64 = 0xa2f(v1);
                        }
                        if (v64) {
                            0x9e3(uint16.max + 1, varg3);
                        }
                    }
                } else {
                    0x9e3(32768, varg3);
                }
                if (varg3 & 0x20000) {
                    v66 = 0xa7c(v17, varg2);
                    if (v66) {
                        0x9e3(0x20000, varg3);
                    }
                }
            }
        }
        if (varg3 & 0x200) {
            0x268(uint256.max, varg0);
            0x268(uint256.max, varg1);
        }
    }
}

function postPrices(uint256 varg0, uint256 varg1, uint256 varg2, uint256 varg3, uint256 varg4, uint256 varg5, uint256 varg6, uint256 varg7) private { 
    v0 = v1 = bool(varg4 & 0x1);
    if (varg4 & 0x1) {
        v2 = 0x1069(varg3);
        v0 = v3 = !v2;
    }
    if (!v0) {
        v4 = v5 = bool(varg4 & 0x2);
        if (varg4 & 0x2) {
            v6 = 0x10a8(varg2);
            v4 = v7 = !v6;
        }
        if (!v4) {
            v8 = v9 = bool(varg4 & 0x4);
            if (varg4 & 0x4) {
                v8 = v10 = 0xa7c(varg1, varg5);
            }
            if (!v8) {
                v11 = v12 = bool(varg4 & 0x20);
                if (varg4 & 0x20) {
                    v13 = 0x1136(varg6, varg7);
                    v11 = v14 = !v13;
                }
                if (!v11) {
                    v15 = v16 = bool(varg4 & 0x40000);
                    if (varg4 & 0x40000) {
                        v15 = v17 = varg0.length > 0;
                    }
                    if (v15) {
                        v18 = v19 = 0;
                        while (v18 < varg0.length) {
                            assert(v18 < varg0.length);
                            assert(v18 < varg0.length);
                            assert(v18 < varg0.length);
                            v20 = new uint256[](MEM[MEM[varg0[v18]]]);
                            v21 = v20.data;
                            v22 = v23 = v21 + (MEM[MEM[varg0[v18]]] << 5);
                            v24 = v25 = 32 + MEM[varg0[v18]];
                            v26 = v27 = 0;
                            while (v26 < MEM[MEM[varg0[v18]]]) {
                                MEM[v21] = v22 - v21;
                                MEM[v22] = MEM[MEM[v24]];
                                v28 = v29 = 0;
                                while (v28 < MEM[MEM[v24]]) {
                                    MEM[v28 + (32 + v22)] = MEM[v28 + (MEM[v24] + 32)];
                                    v28 += 32;
                                }
                                if (v28 > MEM[MEM[v24]]) {
                                    MEM[32 + v22 + MEM[MEM[v24]]] = 0;
                                }
                                v22 = 32 + v22 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + MEM[MEM[v24]]);
                                v24 += 32;
                                v21 += 32;
                                v26 += 1;
                            }
                            v22 = new uint256[](MEM[MEM[32 + varg0[v18]]]);
                            v30 = v22.data;
                            v31 = v32 = v30 + (MEM[MEM[32 + varg0[v18]]] << 5);
                            v33 = v34 = 32 + MEM[32 + varg0[v18]];
                            v35 = v36 = 0;
                            while (v35 < MEM[MEM[32 + varg0[v18]]]) {
                                MEM[v30] = v31 - v30;
                                MEM[v31] = MEM[MEM[v33]];
                                v37 = v38 = 0;
                                while (v37 < MEM[MEM[v33]]) {
                                    MEM[v37 + (32 + v31)] = MEM[v37 + (MEM[v33] + 32)];
                                    v37 += 32;
                                }
                                if (v37 > MEM[MEM[v33]]) {
                                    MEM[32 + v31 + MEM[MEM[v33]]] = 0;
                                }
                                v31 = 32 + v31 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + MEM[MEM[v33]]);
                                v33 += 32;
                                v30 += 32;
                                v35 += 1;
                            }
                            v31 = new uint256[](MEM[MEM[64 + varg0[v18]]]);
                            v39 = v31.data;
                            v40 = v41 = v39 + (MEM[MEM[64 + varg0[v18]]] << 5);
                            v42 = v43 = 32 + MEM[64 + varg0[v18]];
                            v44 = v45 = 0;
                            while (v44 < MEM[MEM[64 + varg0[v18]]]) {
                                MEM[v39] = v40 - v39;
                                MEM[v40] = MEM[MEM[v42]];
                                v46 = v47 = 0;
                                while (v46 < MEM[MEM[v42]]) {
                                    MEM[v46 + (32 + v40)] = MEM[v46 + (MEM[v42] + 32)];
                                    v46 += 32;
                                }
                                if (v46 > MEM[MEM[v42]]) {
                                    MEM[32 + v40 + MEM[MEM[v42]]] = 0;
                                }
                                v40 = 32 + v40 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + MEM[MEM[v42]]);
                                v42 += 32;
                                v39 += 32;
                                v44 += 1;
                            }
                            require(bool((address(0x9b8eb8b3d6e2e0db36f41455185fef7049a35cae)).code.size));
                            v48 = address(0x9b8eb8b3d6e2e0db36f41455185fef7049a35cae).postPrices(v20, v22, v31).gas(msg.gas);
                            require(bool(v48), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
                            v18 = v18 + 1;
                        }
                    }
                    if (varg4 & 0x10) {
                        if (varg4 & 0x8) {
                            0x145b(address(varg7));
                            0x145b(address(varg6));
                        }
                        v49 = 0x1548(varg5);
                        if (!v49) {
                            if (!(varg4 & 0x1000)) {
                                if (varg4 & 0x2000) {
                                    v50 = v51 = varg3.length > 0;
                                    if (v51) {
                                        v50 = v52 = 0xa2f(varg3);
                                    }
                                    if (v50) {
                                        0x9e3(8192, varg4);
                                    }
                                }
                            } else {
                                0x9e3(4096, varg4);
                            }
                            emit 0xd3548b71d404fe7dff3cc06e16bc168fdc2a25f3dc1fe207725f7720b1f5c1b9(16);
                            return 0;
                        }
                    }
                    return 1;
                } else {
                    emit 0xd3548b71d404fe7dff3cc06e16bc168fdc2a25f3dc1fe207725f7720b1f5c1b9(32);
                    return 0;
                }
            } else {
                if (varg4 & 0x4000) {
                    0x9e3(16384, varg4);
                }
                emit 0xd3548b71d404fe7dff3cc06e16bc168fdc2a25f3dc1fe207725f7720b1f5c1b9(4);
                return 0;
            }
        } else {
            emit 0xd3548b71d404fe7dff3cc06e16bc168fdc2a25f3dc1fe207725f7720b1f5c1b9(2);
            return 0;
        }
    } else {
        emit 0xd3548b71d404fe7dff3cc06e16bc168fdc2a25f3dc1fe207725f7720b1f5c1b9(1);
        return 0;
    }
}
function 0x1cab(address varg0, uint256 varg1, address varg2, address varg3) private { 
    if (0x4ddc2d193948926d02f9b1fe9e1daa0718270ed5 != varg3) {
        require(bool(varg3.code.size));
        v0, /* uint256 */ v1 = varg3.liquidateBorrow(varg2, varg1, varg0).gas(msg.gas);
        require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        return v1;
    } else {
        require(bool(varg3.code.size));
        v2 = varg3.liquidateBorrow(varg2, varg0).value(varg1).gas(msg.gas);
        require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        return 0;
    }
}

function 0x1069(uint256 varg0) private { 
    v0 = v1 = 0;
    while (v0 < varg0.length) {
        assert(v0 < varg0.length);
        if ((address(MEM[varg0[v0]])).balance != MEM[varg0[v0] + 32]) {
            if ((address(MEM[varg0[v0]])).balance >= MEM[32 + varg0[v0]]) {
                v2 = v3 = 1;
            } else {
                v2 = v4 = uint256.max;
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

function 0x10a8(uint256 varg0) private { 
    if (varg0.length) {
        v0 = v1 = 0;
        while (v0 < varg0.length) {
            assert(v0 < varg0.length);
            if (MEM[varg0[v0]] >> 248 != 1) {
                if (2 != uint8(MEM[varg0[v0]] >> 248)) {
                    if (3 != uint8(MEM[varg0[v0]] >> 248)) {
                        v2 = v3 = 0;
                    } else {
                        if (!address(0x0)) {
                            require(bool((address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b)).code.size));
                            v4 = address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b).oracle().gas(msg.gas);
                            if (bool(v4)) {
                                require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
                                require(MEM[MEM[64]] == address(MEM[MEM[64]]));
                                MEM[MEM[64]] = address(MEM[MEM[64]]);
                            } else {
                                RETURNDATACOPY(0, 0, RETURNDATASIZE());
                                revert(0, RETURNDATASIZE());
                            }
                        }
                        MEM[MEM[64]] = 0xfc57d4df00000000000000000000000000000000000000000000000000000000;
                        v5 = v6 = address(MEM[MEM[64]]);
                        v7 = 4 + MEM[64] + 32;
                        MEM[4 + MEM[64]] = address(MEM[varg0[v0]]);
                    }
                } else {
                    MEM[MEM[64]] = 0x5e9a523c00000000000000000000000000000000000000000000000000000000;
                    v5 = v8 = 0x2557a5e05defeffd4cae6d83ea3d173b272c904;
                    v7 = v9 = 4 + MEM[64] + 32;
                    MEM[4 + MEM[64]] = address(MEM[varg0[v0]]);
                }
            } else {
                MEM[MEM[64]] = 0x183f344400000000000000000000000000000000000000000000000000000000;
                v5 = v10 = 0x2557a5e05defeffd4cae6d83ea3d173b272c904;
                v7 = v11 = 4 + MEM[64] + 32;
                MEM[4 + MEM[64]] = address(MEM[varg0[v0]]);
            }
            require(bool(v5.code.size));
            v12 = v5.staticcall(MEM[MEM[64]:MEM[64] + v36d0V0x2042 - MEM[64]], MEM[MEM[64]:MEM[64] + 32]).gas(msg.gas);
            if (bool(v12)) {
                MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
                require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
                v2 = MEM[MEM[64]];
            } else {
                RETURNDATACOPY(0, 0, RETURNDATASIZE());
                revert(0, RETURNDATASIZE());
            }
            v13 = v14 = bool(v2);
            if (v2) {
                assert(v0 < varg0.length);
                v13 = v15 = v2 != MEM[32 + varg0[v0]];
            }
            if (!v13) {
                v0 += 1;
            } else {
                return 1;
            }
        }
    }
    return 0;
}

function 0x1136(uint256 varg0, uint256 varg1) private { 
    v0 = 0x209f();
    if (block.timestamp - v0 < 300) {
        require(bool((address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b)).code.size));
        v1, /* address */ v2 = address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b).oracle().gas(msg.gas);
        require(bool(v1), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(v2 == address(v2));
        require(bool((address(v2)).code.size));
        v3, /* uint256 */ v4 = address(v2).getUnderlyingPrice(address(varg1)).gas(msg.gas);
        require(bool(v3), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(bool((address(v2)).code.size));
        v5, /* uint256 */ v6 = address(v2).getUnderlyingPrice(address(varg0)).gas(msg.gas);
        require(bool(v5), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        v7 = 0x20c7(varg1);
        v8 = 0x20c7(varg0);
        v9 = v10 = v4 > 0;
        if (v10) {
            v9 = v11 = v6 > 0;
        }
        if (v9) {
            v9 = v12 = v7 > 0;
        }
        if (v9) {
            v9 = v13 = v8 > 0;
        }
        if (v9) {
            require(bool((address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b)).code.size));
            v14, /* uint256 */ v15 = address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b).liquidationIncentiveMantissa().gas(msg.gas);
            require(bool(v14), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
            require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
            assert(v7);
            assert(v8);
            v16 = 0x2124(10 ** 18 * v6 / v8, 10 ** 18 * v4 / v7);
            v17 = 0x2155(v16, v15);
            emit 0xafd244987898fb4c002a301a9812580c6e446d5a70efce1be2b74a14f3524751(address(varg1), address(varg0), v4, v6, v7, v8, 10 ** 18 * v4 / v7, 10 ** 18 * v6 / v8, v17);
            if (v17 < 0xe27c49886e60000) {
                return 0;
            }
        }
    }
    return 1;
}

function 0x145b(address varg0) private { 
    require(bool(varg0.code.size));
    v0, /* uint256 */ v1 = varg0.accrualBlockNumber().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    if (v1 == block.number) {
        return ;
    } else {
        require(bool(varg0.code.size));
        v2, /* uint256 */ v3 = varg0.accrueInterest().gas(msg.gas);
        require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        return ;
    }
}

function 0x1548(address varg0) private { 
    require(bool(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b.code.size));
    v0, /* uint256 */ v1, /* uint256 */ v2, /* uint256 */ v3 = 0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b.getAccountLiquidity(varg0).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 96);
    require(0 == v1, Error('bhnl:gal'));
    v4 = v5 = !v2;
    if (!bool(v2)) {
        v4 = v6 = v3 > 0;
    }
    return v4;
}

function 0x1631(uint256 varg0, struct(3) varg1, address varg2, address varg3, uint256 varg4) private { 
    v0 = v1 = 0;
    v2 = 0xd5f(this, address(varg4));
    v3 = v4 = varg1.word2 != uint256.max;
    if (varg1.word2 != uint256.max) {
        v3 = v5 = uint256.max != varg1.word0;
    }
    if (v3) {
        v3 = v6 = varg1.word1 != uint256.max;
    }
    if (!v3) {
        v7 = new struct(11);
        v7.word0 = 0;
        v7.word1 = 0;
        v7.word2 = 0;
        v7.word3 = 0;
        v7.word4 = 0;
        v7.word5 = 0;
        v7.word6 = 0;
        v7.word7 = 0;
        v7.word8 = 0;
        v7.word9 = 0;
        v7.word10 = False;
        require(bool((address(varg4)).code.size));
        v8, /* uint256 */ v9 = address(varg4).borrowBalanceStored(varg2).gas(msg.gas);
        require(bool(v8), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        v7.word0 = v9;
        v7.word1 = v9 >> 1;
        if (v9 >> 1) {
            v10 = _SafeSub(1, v7.word1);
            v7.word1 = v10;
        }
        require(bool((address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b)).code.size));
        v11, /* uint256 */ v12, /* uint256 */ v13 = address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b).liquidateCalculateSeizeTokens(address(varg4), varg3, 10 ** 18).gas(msg.gas);
        require(bool(v11), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 64);
        v7.word2 = v13;
        if (v13) {
            require(bool(varg3.code.size));
            v14, /* uint256 */ v15 = varg3.balanceOf(varg2).gas(msg.gas);
            require(bool(v14), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
            MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
            require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
            v16 = 0x27f4(10 ** 18, v15);
            require(v16 + (v7.word2 >> 1) >= v16, Error('ds-math-add-overflow'));
            assert(v7.word2);
            v7.word3 = (v16 + (v7.word2 >> 1)) / v7.word2;
            if ((v16 + (v7.word2 >> 1)) / v7.word2) {
                v17 = _SafeSub(1, v7.word3);
                v7.word3 = v17;
            }
        }
        v18 = 0xd48(v7.word3, v7.word1);
        v19 = 0xd48(v18, varg1.word2);
        v7.word4 = v19;
        if (v2 < v19) {
            v20 = _SafeSub(v2, v7.word4);
            v7.word5 = v20;
            if (v7.word4 / 20 < v20) {
                if (uint256.max == varg1.word0) {
                    require(bool((address(varg4)).code.size));
                    v21, /* uint256 */ v22 = address(varg4).balanceOf(address(this)).gas(msg.gas);
                    require(bool(v21), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
                    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
                    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
                    if (v22 >= 10) {
                        v23, v24, v25, v26 = 0x217d(varg0, varg4, this);
                        v7.word9 = v23;
                        v7.word8 = v24;
                        v7.word7 = v25;
                        v7.word6 = v26;
                        if (v7.word5 > v26) {
                            v0 = v27 = 0xd48(v7.word7, v7.word5);
                        }
                        v7.word10 = 1;
                    }
                } else {
                    v0 = v28 = 0xd48(varg1.word0, v7.word5);
                }
            }
            v29 = _SafeSub(v0, v7.word5);
            v7.word5 = v29;
            if (v7.word4 / 20 < v29) {
                if (varg1.word1 == uint256.max) {
                    if (!v7.word10) {
                        v30, v31, v32, v33 = 0x217d(varg0, varg4, this);
                        v7.word9 = v30;
                        v7.word8 = v31;
                        v7.word7 = v32;
                        v7.word6 = v33;
                    }
                    if (v0) {
                        v0 = v34 = 0xd48(v7.word9, v7.word5);
                    } else {
                        v0 = v35 = 0xd48(v7.word8, v7.word5);
                    }
                } else {
                    v0 = v36 = 0xd48(varg1.word1, v7.word5);
                }
            }
            v37 = _SafeAdd(v0, v0);
            v38 = v39 = _SafeAdd(v37, v2);
        } else {
            v38 = v40 = v7.word4;
        }
        require(v2 + v0 + v0 >= v38, Error(0x616d74));
        emit 0x65d607271aa524614901583bb91888998ecd800163848cba0f012a3dd8029c5f(address(varg4), varg1.word0, varg1.word1, varg1.word2, v7.word0, v7.word1, v7.word3, v7.word7, v7.word8, v7.word9);
        emit 0x8bb178c116f1adecd9ebf3df5d5120b833370f8832a8ca4931b0036b096375f5(v2, v0, v0, v38);
    } else {
        v0 = v41 = varg1.word1;
        v0 = v42 = varg1.word0;
        v38 = v43 = 0xd48(v2 + v41 + v42, varg1.word2);
        require(bool((address(varg4)).code.size));
        v44, /* uint256 */ v45 = address(varg4).borrowBalanceStored(varg2).gas(msg.gas);
        require(bool(v44), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        assert(2);
        v38 = v46 = v45 >> 1;
        if (v43 > v46) {
        }
    }
    return v38, v0, v0;
}

function 0x1c63(uint256 varg0, address varg1) private { 
    require(bool(varg1.code.size));
    v0, /* uint256 */ v1 = varg1.borrow(varg0).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    return v1;
}


function 0x209f() private { 
    return map_0[keccak256('cmp/time')];
}

function 0x20c7(address varg0) private { 
    if (0x4ddc2d193948926d02f9b1fe9e1daa0718270ed5 != varg0) {
        return map_0[keccak256('cmp/mark') ^ varg0];
    } else {
        return 10 ** 18;
    }
}

function 0x2124(uint256 varg0, uint256 varg1) private { 
    v0 = 0x27f4(10 ** 18, varg1);
    require(v0 + (varg0 >> 1) >= v0, Error('ds-math-add-overflow'));
    assert(varg0);
    return (v0 + (varg0 >> 1)) / varg0;
}

function 0x2140(uint256 varg0, uint256 varg1, uint256 varg2) private { 
    v0 = varg2 + varg0 / varg1;
    require(v0 >= varg2, Error('ds-math-add-overflow'));
    return v0;
}

function 0x2155(uint256 varg0, uint256 varg1) private { 
    v0 = 0x27f4(varg0, varg1);
    v1 = 0x2140(10 ** 18, 2, v0);
    assert(10 ** 18);
    return v1 / 10 ** 18;
}

function 0x217d(uint256 varg0, address varg1, address varg2) private { 
    if (varg0) {
        require(bool((address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b)).code.size));
        v0, /* address */ v1 = address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b).oracle().gas(msg.gas);
        require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(v1 == address(v1));
        v2 = new struct(22);
        v2.word0 = 0;
        v2.word1 = 0;
        v2.word2 = 0;
        v2.word3 = 0;
        v2.word4 = False;
        v2.word5 = 0;
        v2.word6 = 0;
        v2.word7 = 0;
        v2.word8 = 0;
        v2.word9 = 0;
        v2.word10 = 0;
        v2.word11 = 0;
        v2.word12 = 0;
        v2.word13 = 0;
        v2.word14 = 0;
        v2.word15 = 0;
        v2.word16 = 0;
        v2.word17 = 0;
        v2.word18 = 0;
        v2.word19 = 0;
        v2.word20 = 0;
        v2.word21 = 0;
        require(bool((address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b)).code.size));
        v3, /* uint256 */ v4 = address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b).getAssetsIn(varg2).gas(msg.gas);
        require(bool(v3), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        RETURNDATACOPY(v4, 0, RETURNDATASIZE());
        MEM[64] = v4 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & RETURNDATASIZE() + 31);
        require(v4 + RETURNDATASIZE() - v4 >= 32);
        require(MEM[v4] <= uint64.max);
        require(v4 + MEM[v4] + 31 < v4 + RETURNDATASIZE());
        require(MEM[v4 + MEM[v4]] <= uint64.max);
        v5 = new uint256[](MEM[v4 + MEM[v4]]);
        require(!((v5 + ((MEM[v4 + MEM[v4]] << 5) + 32) < v5) | (v5 + ((MEM[v4 + MEM[v4]] << 5) + 32) > uint64.max)));
        v6 = v7 = v4 + MEM[v4] + 32;
        v8 = v9 = v5.data;
        require(v7 + (MEM[v4 + MEM[v4]] << 5) <= v4 + RETURNDATASIZE());
        v10 = v11 = 0;
        while (v10 < MEM[v4 + MEM[v4]]) {
            require(MEM[v6] == address(MEM[v6]));
            MEM[v8] = MEM[v6];
            v8 += 32;
            v6 += 32;
            v10 += 1;
        }
        v12 = v13 = 0;
        while (v12 < v5.length) {
            assert(v12 < v5.length);
            require(bool((address(v5[v12])).code.size));
            v14, /* uint256 */ v15, /* uint256 */ v16, /* uint256 */ v17, /* uint256 */ v18 = address(v5[v12]).getAccountSnapshot(varg2).gas(msg.gas);
            require(bool(v14), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
            MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
            require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 128);
            v2.word3 = v18;
            v2.word2 = v17;
            v2.word1 = v16;
            v2.word0 = v15;
            if (!v15) {
                v19 = v20 = v2.word1 > 0;
                if (v2.word1 <= 0) {
                    v19 = v21 = v2.word2 > 0;
                }
                if (!v19) {
                    v19 = v22 = address(v5[v12]) == varg1;
                }
                if (v19) {
                    require(bool((address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b)).code.size));
                    v23, /* bool */ v24, /* uint256 */ v25, /* bool */ v26 = address(0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b).markets(address(v5[v12])).gas(msg.gas);
                    require(bool(v23), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
                    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
                    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 96);
                    require(v24 == bool(v24));
                    require(v26 == bool(v26));
                    v2.word5 = v25;
                    v2.word4 = bool(v24);
                    if (v24) {
                        require(bool((address(v1)).code.size));
                        v27, /* uint256 */ v28 = address(v1).getUnderlyingPrice(address(v5[v12])).gas(msg.gas);
                        require(bool(v27), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
                        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
                        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
                        v2.word6 = v28;
                        if (v28) {
                            v29 = 0x2155(v2.word6, v2.word5);
                            v2.word7 = v29;
                            v30 = 0x2155(v2.word3, v29);
                            v2.word8 = v30;
                            v31 = 0x2155(v30, v2.word1);
                            v32 = _SafeAdd(v31, v2.word9);
                            v2.word9 = v32;
                            v33 = 0x2155(v2.word6, v2.word2);
                            v34 = _SafeAdd(v33, v2.word10);
                            v2.word10 = v34;
                            if (varg1 == address(v5[v12])) {
                                v2.word11 = v2.word6;
                                v2.word12 = v2.word7;
                                v35 = 0x2155(v2.word8, v2.word1);
                                v2.word13 = v35;
                                v36 = 0x2155(v2.word3, v2.word1);
                                v2.word14 = v36;
                                v37 = 0x2155(v2.word3, 2);
                                v2.word18 = v37;
                            }
                        }
                    }
                }
                v12 += 1;
            } else {
                return 0, 0, 0, 0;
            }
        }
        v38 = 0x2155(varg0, v2.word9);
        v2.word16 = v38;
        v39 = v40 = v2.word10 < v38;
        if (v40) {
            v39 = v41 = v2.word11 > 0;
        }
        if (v39) {
            v42 = _SafeSub(v2.word10, v2.word16);
            v2.word17 = v42;
            v43 = 0x2124(v2.word11, v42);
            v2.word20 = v43;
            if (v2.word14 <= v2.word18) {
                v2.word21 = v2.word20;
            } else {
                v44 = 0x2155(varg0, v2.word13);
                v2.word15 = v44;
                if (v2.word17 <= v44) {
                    v45 = 0x2124(v2.word12, v2.word17);
                    v2.word19 = v45;
                    if (v2.word18 > v45) {
                        v2.word19 = 0;
                    }
                } else {
                    v2.word19 = v2.word14;
                    v46 = _SafeSub(v2.word15, v2.word17);
                    v47 = 0x2124(v2.word11, v46);
                    v2.word21 = v47;
                }
            }
        }
        emit 0x759f59ae1c5f93b58757b8cbf263c6d5222b08ce3a3c5e9441d73c92fc0c3dc0(varg2, varg1, varg0, v2.word9, v2.word10, v2.word16, v2.word17, v2.word15, v2.word18, v2.word19, v2.word20, v2.word21);
        return v2.word21, v2.word20, v2.word19, v2.word18;
    } else {
        return 0, 0, 0, 0;
    }
}

function 0x268(uint256 varg0, address varg1) private { 
    require(bool(varg1.code.size));
    v0, /* uint256 */ v1 = varg1.borrowBalanceCurrent(address(this)).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    if (v1) {
        v2 = 0xca7(this, varg1);
        if (v2) {
            v3 = 0xd48(v1, v2);
            v4 = 0xd48(v3, varg0);
            if (v4) {
                v5 = 0xd5f(this, varg1);
                v6 = 0xe7c(v4, varg1);
                require(!v6, Error(0x726564));
                v7 = 0xd5f(this, varg1);
                if (v7 <= v5) {
                    return ;
                } else {
                    v8 = _SafeSub(v5, v7);
                    v9 = 0xd48(v1, v8);
                    v10 = 0xee7(v9, varg1);
                    require(!v10, Error(0x726570));
                    return ;
                }
            } else {
                return ;
            }
        } else {
            return ;
        }
    } else {
        return ;
    }
}

function _SafeAdd(uint256 varg0, uint256 varg1) private { 
    require(varg1 + varg0 >= varg1, Error('ds-math-add-overflow'));
    return varg1 + varg0;
}

function 0x27f4(uint256 varg0, uint256 varg1) private { 
    v0 = v1 = 0;
    v2 = v3 = !varg0;
    if (varg0) {
        v0 = v4 = varg1 * varg0;
        assert(varg0);
        v2 = v5 = v4 / varg0 == varg1;
    }
    require(v2, Error('ds-math-mul-overflow'));
    return v0;
}

function 0x492(uint256 varg0, address varg1) private { 
    require(bool(varg1.code.size));
    v0, /* uint256 */ v1 = varg1.balanceOf(address(this)).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    if (v1 <= varg0) {
        return 0;
    } else {
        v2 = _SafeSub(varg0, v1);
        require(bool(varg1.code.size));
        v3, /* uint256 */ v4 = varg1.redeem(v2).gas(msg.gas);
        require(bool(v3), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        return v4;
    }
}

function function_selector() public payable { 
    revert();
}


function 0x41bb257f(address varg0, uint256 varg1) public payable { 
    require(msg.data.length - 4 >= 64);
    0x268(varg1, varg0);
}

function 0x45138361(address varg0, uint256 varg1) public payable { 
    require(msg.data.length - 4 >= 64);
    v0 = 0xd5f(this, varg0);
    if (v0 <= varg1) {
        v1 = v2 = 0;
    } else {
        v3 = _SafeSub(varg1, v0);
        v1 = v4 = 0xfd0(v3, varg0);
    }
    return v1;
}

function 0x8f1(struct(3) varg0, uint256 varg1, uint256 varg2, uint256 varg3) private { 
    v0 = v1, v2, v3 = 0x1631(0xc7d713b49da0000, varg0, varg1, varg2, varg3);
    v4 = v5 = v1 > 0;
    if (v5) {
        v4 = v6 = v3 > 0;
    }
    if (v4) {
        v7 = 0xe7c(v3, address(varg3));
        if (v7) {
            v0 = v8 = _SafeSub(v3, v1);
        }
    }
    v9 = v10 = v0 > 0;
    if (v10) {
        v9 = v11 = v2 > 0;
    }
    if (v9) {
        v12 = 0x1c63(v2, address(varg3));
        if (v12) {
            v0 = v13 = _SafeSub(v2, v0);
        }
    }
    if (!v0) {
        v14 = v15 = 0;
        v16 = v17 = 0;
    } else {
        v14 = v18 = 1;
        v16 = v19 = 0x1cab(varg2, v0, varg1, address(varg3));
    }
    return v16, v14;
}

function 0x9e3(uint256 varg0, uint256 varg1) private { 
    v0 = keccak256('attempt/abort') ^ varg1 >> 192;
    if (map_0[v0] == map_0[v0] | varg0) {
        return ;
    } else {
        map_0[v0] = map_0[v0] | varg0;
        return ;
    }
}

function 0xbb04a45b(address varg0, uint256 varg1) public payable { 
    require(msg.data.length - 4 >= 64);
    v0 = 0x492(varg1, varg0);
    return v0;
}

function 0xa2f(uint256 varg0) private { 
    v0 = v1 = 0;
    while (v0 < varg0.length) {
        assert(v0 < varg0.length);
        if ((address(MEM[varg0[v0]])).balance != MEM[varg0[v0] + 32]) {
            if ((address(MEM[varg0[v0]])).balance >= MEM[32 + varg0[v0]]) {
                v2 = v3 = 1;
            } else {
                v2 = v4 = uint256.max;
            }
        } else {
            v2 = 0;
        }
        if (int8(v2)) {
            v0 += 1;
        } else {
            return 0;
        }
    }
    return 1;
}

function 0xa7c(uint256 varg0, address varg1) private { 
    v0 = v1 = 0;
    while (v0 < varg0.length) {
        assert(v0 < varg0.length);
        if (0 != uint128(MEM[32 + varg0[v0]])) {
            assert(v0 < varg0.length);
            MEM[MEM[64]] = 0x70a0823100000000000000000000000000000000000000000000000000000000;
            MEM[4 + MEM[64]] = varg1;
            require(bool((address(MEM[varg0[v0]])).code.size));
            v2 = address(MEM[varg0[v0]]).staticcall(MEM[MEM[64]:MEM[64] + 4 + MEM[64] + 32 - MEM[64]], MEM[MEM[64]:MEM[64] + 32]).gas(msg.gas);
            if (bool(v2)) {
                MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
                require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
                require(MEM[MEM[64]] == MEM[MEM[64]]);
                assert(v0 < varg0.length);
                if (MEM[MEM[64]] < uint128(MEM[32 + varg0[v0]])) {
                    return 1;
                }
            } else {
                RETURNDATACOPY(0, 0, RETURNDATASIZE());
                revert(0, RETURNDATASIZE());
            }
        }
        assert(v0 < varg0.length);
        if (0 != uint128(MEM[64 + varg0[v0]])) {
            assert(v0 < varg0.length);
            MEM[MEM[64]] = 0x95dd919300000000000000000000000000000000000000000000000000000000;
            MEM[4 + MEM[64]] = varg1;
            require(bool((address(MEM[varg0[v0]])).code.size));
            v3 = address(MEM[varg0[v0]]).staticcall(MEM[MEM[64]:MEM[64] + 4 + MEM[64] + 32 - MEM[64]], MEM[MEM[64]:MEM[64] + 32]).gas(msg.gas);
            if (bool(v3)) {
                MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
                require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
                require(MEM[MEM[64]] == MEM[MEM[64]]);
                assert(v0 < varg0.length);
                if (MEM[MEM[64]] < uint128(MEM[64 + varg0[v0]])) {
                    return 1;
                }
            } else {
                RETURNDATACOPY(0, 0, RETURNDATASIZE());
                revert(0, RETURNDATASIZE());
            }
        }
        v0 += 1;
    }
    return 0;
}

function 0xca7(address varg0, address varg1) private { 
    require(bool(varg1.code.size));
    v0, /* uint256 */ v1 = varg1.balanceOfUnderlying(varg0).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    return v1;
}

function 0xd48(uint256 varg0, uint256 varg1) private { 
    if (varg1 <= varg0) {
        return varg1;
    } else {
        return varg0;
    }
}

function 0xd5f(address varg0, address varg1) private { 
    if (0x4ddc2d193948926d02f9b1fe9e1daa0718270ed5 != varg1) {
        require(bool(varg1.code.size));
        v0, /* address */ v1 = varg1.underlying().gas(msg.gas);
        require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(v1 == address(v1));
        require(bool((address(v1)).code.size));
        v2, /* uint256 */ v3 = address(v1).balanceOf(varg0).gas(msg.gas);
        require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        return v3;
    } else {
        return varg0.balance;
    }
}

function 0xe7c(uint256 varg0, address varg1) private { 
    require(bool(varg1.code.size));
    v0, /* uint256 */ v1 = varg1.redeemUnderlying(varg0).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    return v1;
}

function _SafeSub(uint256 varg0, uint256 varg1) private { 
    require(varg1 - varg0 <= varg1, Error('ds-math-sub-underflow'));
    return varg1 - varg0;
}

function 0xee7(uint256 varg0, address varg1) private { 
    if (0x4ddc2d193948926d02f9b1fe9e1daa0718270ed5 != varg1) {
        require(bool(varg1.code.size));
        v0, /* uint256 */ v1 = varg1.repayBorrow(varg0).gas(msg.gas);
        require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        return v1;
    } else {
        require(bool(varg1.code.size));
        v2 = varg1.repayBorrow().value(varg0).gas(msg.gas);
        require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        return 0;
    }
}

function 0xfd0(uint256 varg0, address varg1) private { 
    if (0x4ddc2d193948926d02f9b1fe9e1daa0718270ed5 != varg1) {
        require(bool(varg1.code.size));
        v0, /* uint256 */ v1 = varg1.mint(varg0).gas(msg.gas);
        require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        return v1;
    } else {
        require(bool(varg1.code.size));
        v2 = varg1.mint().value(varg0).gas(msg.gas);
        require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        return 0;
    }
}

// Note: The function selector is not present in the original solidity code.
// However, we display it for the sake of completeness.

function function_selector( function_selector) public payable { 
    MEM[64] = 128;
    require(!msg.value);
    if (msg.data.length >= 4) {
        if (0x389eee82 == function_selector >> 224) {
            0x389eee82();
        } else if (0x41bb257f == function_selector >> 224) {
            0x41bb257f();
        } else if (0x45138361 == function_selector >> 224) {
            0x45138361();
        } else if (0xbb04a45b == function_selector >> 224) {
            0xbb04a45b();
        }
    }
    fallback();
}
