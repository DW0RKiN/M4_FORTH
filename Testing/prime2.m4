include(`../M4/FIRST.M4')dnl 
ORG 0x6000
INIT(0xF500)
   PUSH(1)
   PUSH2(2   ,3   )  MUL MUL PUSH2(5   ,7   ) MUL MUL PUSH2(11  ,13  ) MUL MUL PUSH2(17  ,19  ) MUL MUL PUSH2(23  ,29 )  MUL MUL 
   PUSH2(31  ,37  )  MUL MUL PUSH2(41  ,43  ) MUL MUL PUSH2(47  ,53  ) MUL MUL PUSH2(59  ,61  ) MUL MUL PUSH2(67  ,71 )  MUL MUL  
   PUSH2(73  ,79  )  MUL MUL PUSH2(83  ,89  ) MUL MUL PUSH2(97  ,101 ) MUL MUL PUSH2(103 ,107 ) MUL MUL PUSH2(109 ,113)  MUL MUL  
   PUSH2(127 ,131 )  MUL MUL PUSH2(137 ,139 ) MUL MUL PUSH2(149 ,151 ) MUL MUL PUSH2(157 ,163 ) MUL MUL PUSH2(167 ,173)  MUL MUL
   PUSH2(179 ,181 )  MUL MUL PUSH2(191 ,193 ) MUL MUL PUSH2(197 ,199 ) MUL MUL PUSH2(211 ,223 ) MUL MUL PUSH2(227 ,229)  MUL MUL
   PUSH2(233 ,239 )  MUL MUL PUSH2(241 ,251 ) MUL MUL PUSH2(257 ,263 ) MUL MUL PUSH2(269 ,271 ) MUL MUL PUSH2(277 ,281)  MUL MUL
   PUSH2(283 ,293 )  MUL MUL PUSH2(307 ,311 ) MUL MUL PUSH2(313 ,317 ) MUL MUL PUSH2(331 ,337 ) MUL MUL PUSH2(347 ,349)  MUL MUL
   PUSH2(353 ,359 )  MUL MUL PUSH2(367 ,373 ) MUL MUL PUSH2(379 ,383 ) MUL MUL PUSH2(389 ,397 ) MUL MUL PUSH2(401 ,409)  MUL MUL
   PUSH2(419 ,421 )  MUL MUL PUSH2(431 ,433 ) MUL MUL PUSH2(439 ,443 ) MUL MUL PUSH2(449 ,457 ) MUL MUL PUSH2(461 ,463)  MUL MUL
   PUSH2(467 ,479 )  MUL MUL PUSH2(487 ,491 ) MUL MUL PUSH2(499 ,503 ) MUL MUL PUSH2(509 ,521 ) MUL MUL PUSH2(523 ,541)  MUL MUL
   PUSH2(547 ,557 )  MUL MUL PUSH2(563 ,569 ) MUL MUL PUSH2(571 ,577 ) MUL MUL PUSH2(587 ,593 ) MUL MUL PUSH2(599 ,601)  MUL MUL
   PUSH2(607 ,613 )  MUL MUL PUSH2(617 ,619 ) MUL MUL PUSH2(631 ,641 ) MUL MUL PUSH2(643 ,647 ) MUL MUL PUSH2(653 ,659)  MUL MUL
   PUSH2(661 ,673 )  MUL MUL PUSH2(677 ,683 ) MUL MUL PUSH2(691 ,701 ) MUL MUL PUSH2(709 ,719 ) MUL MUL PUSH2(727 ,733)  MUL MUL
   PUSH2(739 ,743 )  MUL MUL PUSH2(751 ,757 ) MUL MUL PUSH2(761 ,769 ) MUL MUL PUSH2(773 ,787 ) MUL MUL PUSH2(797 ,809)  MUL MUL
   PUSH2(811 ,821 )  MUL MUL PUSH2(823 ,827 ) MUL MUL PUSH2(829 ,839 ) MUL MUL PUSH2(853 ,857 ) MUL MUL PUSH2(859 ,863)  MUL MUL
   PUSH2(877 ,881 )  MUL MUL PUSH2(883 ,887 ) MUL MUL PUSH2(907 ,911 ) MUL MUL PUSH2(919 ,929 ) MUL MUL PUSH2(937 ,941)  MUL MUL
   PUSH2(947 ,953 )  MUL MUL PUSH2(967 ,971 ) MUL MUL PUSH2(977 ,983 ) MUL MUL PUSH2(991 ,997 ) MUL MUL PUSH2(1009,1013) MUL MUL
   PUSH2(1019,1021)  MUL MUL PUSH2(1031,1033) MUL MUL PUSH2(1039,1049) MUL MUL PUSH2(1051,1061) MUL MUL PUSH2(1063,1069) MUL MUL
   PUSH2(1087,1091)  MUL MUL PUSH2(1093,1097) MUL MUL PUSH2(1103,1109) MUL MUL PUSH2(1117,1123) MUL MUL PUSH2(1129,1151) MUL MUL
   PUSH2(1153,1163)  MUL MUL PUSH2(1171,1181) MUL MUL PUSH2(1187,1193) MUL MUL PUSH2(1201,1213) MUL MUL PUSH2(1217,1223) MUL MUL
   PUSH2(1229,1231)  MUL MUL PUSH2(1237,1249) MUL MUL PUSH2(1259,1277) MUL MUL PUSH2(1279,1283) MUL MUL PUSH2(1289,1291) MUL MUL
   PUSH2(1297,1301)  MUL MUL PUSH2(1303,1307) MUL MUL PUSH2(1319,1321) MUL MUL PUSH2(1327,1361) MUL MUL PUSH2(1367,1373) MUL MUL
   PUSH2(1381,1399)  MUL MUL PUSH2(1409,1423) MUL MUL PUSH2(1427,1429) MUL MUL PUSH2(1433,1439) MUL MUL PUSH2(1447,1451) MUL MUL
   PUSH2(1453,1459)  MUL MUL PUSH2(1471,1481) MUL MUL PUSH2(1483,1487) MUL MUL PUSH2(1489,1493) MUL MUL PUSH2(1499,1511) MUL MUL
   PUSH2(1523,1531)  MUL MUL PUSH2(1543,1549) MUL MUL PUSH2(1553,1559) MUL MUL PUSH2(1567,1571) MUL MUL PUSH2(1579,1583) MUL MUL
   PUSH2(1597,1601)  MUL MUL PUSH2(1607,1609) MUL MUL PUSH2(1613,1619) MUL MUL PUSH2(1621,1627) MUL MUL PUSH2(1637,1657) MUL MUL
   PUSH2(1663,1667)  MUL MUL PUSH2(1669,1693) MUL MUL PUSH2(1697,1699) MUL MUL PUSH2(1709,1721) MUL MUL PUSH2(1723,1733) MUL MUL
   PUSH2(1741,1747)  MUL MUL PUSH2(1753,1759) MUL MUL PUSH2(1777,1783) MUL MUL PUSH2(1787,1789) MUL MUL PUSH2(1801,1811) MUL MUL
   PUSH2(1823,1831)  MUL MUL PUSH2(1847,1861) MUL MUL PUSH2(1867,1871) MUL MUL PUSH2(1873,1877) MUL MUL PUSH2(1879,1889) MUL MUL
   PUSH2(1901,1907)  MUL MUL PUSH2(1913,1931) MUL MUL PUSH2(1933,1949) MUL MUL PUSH2(1951,1973) MUL MUL PUSH2(1979,1987) MUL MUL
   PUSH2(1993,1997)  MUL MUL PUSH2(1999,2003) MUL MUL PUSH2(2011,2017) MUL MUL PUSH2(2027,2029) MUL MUL PUSH2(2039,2053) MUL MUL
   PUSH2(2063,2069)  MUL MUL PUSH2(2081,2083) MUL MUL PUSH2(2087,2089) MUL MUL PUSH2(2099,2111) MUL MUL PUSH2(2113,2129) MUL MUL
   PUSH2(2131,2137)  MUL MUL PUSH2(2141,2143) MUL MUL PUSH2(2153,2161) MUL MUL PUSH2(2179,2203) MUL MUL PUSH2(2207,2213) MUL MUL
   PUSH2(2221,2237)  MUL MUL PUSH2(2239,2243) MUL MUL PUSH2(2251,2267) MUL MUL PUSH2(2269,2273) MUL MUL PUSH2(2281,2287) MUL MUL
   PUSH2(2293,2297)  MUL MUL PUSH2(2309,2311) MUL MUL PUSH2(2333,2339) MUL MUL PUSH2(2341,2347) MUL MUL PUSH2(2351,2357) MUL MUL
   PUSH2(2371,2377)  MUL MUL PUSH2(2381,2383) MUL MUL PUSH2(2389,2393) MUL MUL PUSH2(2399,2411) MUL MUL PUSH2(2417,2423) MUL MUL
   PUSH2(2437,2441)  MUL MUL PUSH2(2447,2459) MUL MUL PUSH2(2467,2473) MUL MUL PUSH2(2477,2503) MUL MUL PUSH2(2521,2531) MUL MUL
   PUSH2(2539,2543)  MUL MUL PUSH2(2549,2551) MUL MUL PUSH2(2557,2579) MUL MUL PUSH2(2591,2593) MUL MUL PUSH2(2609,2617) MUL MUL
   PUSH2(2621,2633)  MUL MUL PUSH2(2647,2657) MUL MUL PUSH2(2659,2663) MUL MUL PUSH2(2671,2677) MUL MUL PUSH2(2683,2687) MUL MUL
   PUSH2(2689,2693)  MUL MUL PUSH2(2699,2707) MUL MUL PUSH2(2711,2713) MUL MUL PUSH2(2719,2729) MUL MUL PUSH2(2731,2741) MUL MUL
   PUSH2(2749,2753)  MUL MUL PUSH2(2767,2777) MUL MUL PUSH2(2789,2791) MUL MUL PUSH2(2797,2801) MUL MUL PUSH2(2803,2819) MUL MUL
   PUSH2(2833,2837)  MUL MUL PUSH2(2843,2851) MUL MUL PUSH2(2857,2861) MUL MUL PUSH2(2879,2887) MUL MUL PUSH2(2897,2903) MUL MUL
   PUSH2(2909,2917)  MUL MUL PUSH2(2927,2939) MUL MUL PUSH2(2953,2957) MUL MUL PUSH2(2963,2969) MUL MUL PUSH2(2971,2999) MUL MUL
   PUSH2(3001,3011)  MUL MUL PUSH2(3019,3023) MUL MUL PUSH2(3037,3041) MUL MUL PUSH2(3049,3061) MUL MUL PUSH2(3067,3079) MUL MUL
   PUSH2(3083,3089)  MUL MUL PUSH2(3109,3119) MUL MUL PUSH2(3121,3137) MUL MUL PUSH2(3163,3167) MUL MUL PUSH2(3169,3181) MUL MUL
   PUSH2(3187,3191)  MUL MUL PUSH2(3203,3209) MUL MUL PUSH2(3217,3221) MUL MUL PUSH2(3229,3251) MUL MUL PUSH2(3253,3257) MUL MUL
   PUSH2(3259,3271)  MUL MUL PUSH2(3299,3301) MUL MUL PUSH2(3307,3313) MUL MUL PUSH2(3319,3323) MUL MUL PUSH2(3329,3331) MUL MUL
   PUSH2(3343,3347)  MUL MUL PUSH2(3359,3361) MUL MUL PUSH2(3371,3373) MUL MUL PUSH2(3389,3391) MUL MUL PUSH2(3407,3413) MUL MUL
   PUSH2(3433,3449)  MUL MUL PUSH2(3457,3461) MUL MUL PUSH2(3463,3467) MUL MUL PUSH2(3469,3491) MUL MUL PUSH2(3499,3511) MUL MUL
   PUSH2(3517,3527)  MUL MUL PUSH2(3529,3533) MUL MUL PUSH2(3539,3541) MUL MUL PUSH2(3547,3557) MUL MUL PUSH2(3559,3571) MUL MUL
   PUSH2(3581,3583)  MUL MUL PUSH2(3593,3607) MUL MUL PUSH2(3613,3617) MUL MUL PUSH2(3623,3631) MUL MUL PUSH2(3637,3643) MUL MUL
   PUSH2(3659,3671)  MUL MUL PUSH2(3673,3677) MUL MUL PUSH2(3691,3697) MUL MUL PUSH2(3701,3709) MUL MUL PUSH2(3719,3727) MUL MUL
   PUSH2(3733,3739)  MUL MUL PUSH2(3761,3767) MUL MUL PUSH2(3769,3779) MUL MUL PUSH2(3793,3797) MUL MUL PUSH2(3803,3821) MUL MUL
   PUSH2(3823,3833)  MUL MUL PUSH2(3847,3851) MUL MUL PUSH2(3853,3863) MUL MUL PUSH2(3877,3881) MUL MUL PUSH2(3889,3907) MUL MUL
   PUSH2(3911,3917)  MUL MUL PUSH2(3919,3923) MUL MUL PUSH2(3929,3931) MUL MUL PUSH2(3943,3947) MUL MUL PUSH2(3967,3989) MUL MUL
   PUSH2(4001,4003)  MUL MUL PUSH2(4007,4013) MUL MUL PUSH2(4019,4021) MUL MUL PUSH2(4027,4049) MUL MUL PUSH2(4051,4057) MUL MUL
   PUSH2(4073,4079)  MUL MUL PUSH2(4091,4093) MUL MUL PUSH2(4099,4111) MUL MUL PUSH2(4127,4129) MUL MUL PUSH2(4133,4139) MUL MUL
   PUSH2(4153,4157)  MUL MUL PUSH2(4159,4177) MUL MUL PUSH2(4201,4211) MUL MUL PUSH2(4217,4219) MUL MUL PUSH2(4229,4231) MUL MUL
   PUSH2(4241,4243)  MUL MUL PUSH2(4253,4259) MUL MUL PUSH2(4261,4271) MUL MUL PUSH2(4273,4283) MUL MUL PUSH2(4289,4297) MUL MUL
   PUSH2(4327,4337)  MUL MUL PUSH2(4339,4349) MUL MUL PUSH2(4357,4363) MUL MUL PUSH2(4373,4391) MUL MUL PUSH2(4397,4409) MUL MUL
   PUSH2(4421,4423)  MUL MUL PUSH2(4441,4447) MUL MUL PUSH2(4451,4457) MUL MUL PUSH2(4463,4481) MUL MUL PUSH2(4483,4493) MUL MUL
   PUSH2(4507,4513)  MUL MUL PUSH2(4517,4519) MUL MUL PUSH2(4523,4547) MUL MUL PUSH2(4549,4561) MUL MUL PUSH2(4567,4583) MUL MUL
   PUSH2(4591,4597)  MUL MUL PUSH2(4603,4621) MUL MUL PUSH2(4637,4639) MUL MUL PUSH2(4643,4649) MUL MUL PUSH2(4651,4657) MUL MUL
   PUSH2(4663,4673)  MUL MUL PUSH2(4679,4691) MUL MUL PUSH2(4703,4721) MUL MUL PUSH2(4723,4729) MUL MUL PUSH2(4733,4751) MUL MUL
   PUSH2(4759,4783)  MUL MUL PUSH2(4787,4789) MUL MUL PUSH2(4793,4799) MUL MUL PUSH2(4801,4813) MUL MUL PUSH2(4817,4831) MUL MUL
   PUSH2(4861,4871)  MUL MUL PUSH2(4877,4889) MUL MUL PUSH2(4903,4909) MUL MUL PUSH2(4919,4931) MUL MUL PUSH2(4933,4937) MUL MUL
   PUSH2(4943,4951)  MUL MUL PUSH2(4957,4967) MUL MUL PUSH2(4969,4973) MUL MUL PUSH2(4987,4993) MUL MUL PUSH2(4999,5003) MUL MUL
   PUSH2(5009,5011)  MUL MUL PUSH2(5021,5023) MUL MUL PUSH2(5039,5051) MUL MUL PUSH2(5059,5077) MUL MUL PUSH2(5081,5087) MUL MUL
   PUSH2(5099,5101)  MUL MUL PUSH2(5107,5113) MUL MUL PUSH2(5119,5147) MUL MUL PUSH2(5153,5167) MUL MUL PUSH2(5171,5179) MUL MUL
   PUSH2(5189,5197)  MUL MUL PUSH2(5209,5227) MUL MUL PUSH2(5231,5233) MUL MUL PUSH2(5237,5261) MUL MUL PUSH2(5273,5279) MUL MUL
   PUSH2(5281,5297)  MUL MUL PUSH2(5303,5309) MUL MUL PUSH2(5323,5333) MUL MUL PUSH2(5347,5351) MUL MUL PUSH2(5381,5387) MUL MUL
   PUSH2(5393,5399)  MUL MUL PUSH2(5407,5413) MUL MUL PUSH2(5417,5419) MUL MUL PUSH2(5431,5437) MUL MUL PUSH2(5441,5443) MUL MUL
   PUSH2(5449,5471)  MUL MUL PUSH2(5477,5479) MUL MUL PUSH2(5483,5501) MUL MUL PUSH2(5503,5507) MUL MUL PUSH2(5519,5521) MUL MUL
   PUSH2(5527,5531)  MUL MUL PUSH2(5557,5563) MUL MUL PUSH2(5569,5573) MUL MUL PUSH2(5581,5591) MUL MUL PUSH2(5623,5639) MUL MUL
   PUSH2(5641,5647)  MUL MUL PUSH2(5651,5653) MUL MUL PUSH2(5657,5659) MUL MUL PUSH2(5669,5683) MUL MUL PUSH2(5689,5693) MUL MUL
   PUSH2(5701,5711)  MUL MUL PUSH2(5717,5737) MUL MUL PUSH2(5741,5743) MUL MUL PUSH2(5749,5779) MUL MUL PUSH2(5783,5791) MUL MUL
   PUSH2(5801,5807)  MUL MUL PUSH2(5813,5821) MUL MUL PUSH2(5827,5839) MUL MUL PUSH2(5843,5849) MUL MUL PUSH2(5851,5857) MUL MUL
   PUSH2(5861,5867)  MUL MUL PUSH2(5869,5879) MUL MUL PUSH2(5881,5897) MUL MUL PUSH2(5903,5923) MUL MUL PUSH2(5927,5939) MUL MUL
   PUSH2(5953,5981)  MUL MUL PUSH2(5987,6007) MUL MUL PUSH2(6011,6029) MUL MUL PUSH2(6037,6043) MUL MUL PUSH2(6047,6053) MUL MUL
   PUSH2(6067,6073)  MUL MUL PUSH2(6079,6089) MUL MUL PUSH2(6091,6101) MUL MUL PUSH2(6113,6121) MUL MUL PUSH2(6131,6133) MUL MUL
   PUSH2(6143,6151)  MUL MUL PUSH2(6163,6173) MUL MUL PUSH2(6197,6199) MUL MUL PUSH2(6203,6211) MUL MUL PUSH2(6217,6221) MUL MUL
   PUSH2(6229,6247)  MUL MUL PUSH2(6257,6263) MUL MUL PUSH2(6269,6271) MUL MUL PUSH2(6277,6287) MUL MUL PUSH2(6299,6301) MUL MUL
   PUSH2(6311,6317)  MUL MUL PUSH2(6323,6329) MUL MUL PUSH2(6337,6343) MUL MUL PUSH2(6353,6359) MUL MUL PUSH2(6361,6367) MUL MUL
   PUSH2(6373,6379)  MUL MUL PUSH2(6389,6397) MUL MUL PUSH2(6421,6427) MUL MUL PUSH2(6449,6451) MUL MUL PUSH2(6469,6473) MUL MUL
   PUSH2(6481,6491)  MUL MUL PUSH2(6521,6529) MUL MUL PUSH2(6547,6551) MUL MUL PUSH2(6553,6563) MUL MUL PUSH2(6569,6571) MUL MUL
   PUSH2(6577,6581)  MUL MUL PUSH2(6599,6607) MUL MUL PUSH2(6619,6637) MUL MUL PUSH2(6653,6659) MUL MUL PUSH2(6661,6673) MUL MUL
   PUSH2(6679,6689)  MUL MUL PUSH2(6691,6701) MUL MUL PUSH2(6703,6709) MUL MUL PUSH2(6719,6733) MUL MUL PUSH2(6737,6761) MUL MUL
   PUSH2(6763,6779)  MUL MUL PUSH2(6781,6791) MUL MUL PUSH2(6793,6803) MUL MUL PUSH2(6823,6827) MUL MUL PUSH2(6829,6833) MUL MUL
   PUSH2(6841,6857)  MUL MUL PUSH2(6863,6869) MUL MUL PUSH2(6871,6883) MUL MUL PUSH2(6899,6907) MUL MUL PUSH2(6911,6917) MUL MUL
   PUSH2(6947,6949)  MUL MUL PUSH2(6959,6961) MUL MUL PUSH2(6967,6971) MUL MUL PUSH2(6977,6983) MUL MUL PUSH2(6991,6997) MUL MUL
   PUSH2(7001,7013)  MUL MUL PUSH2(7019,7027) MUL MUL PUSH2(7039,7043) MUL MUL PUSH2(7057,7069) MUL MUL PUSH2(7079,7103) MUL MUL
   PUSH2(7109,7121)  MUL MUL PUSH2(7127,7129) MUL MUL PUSH2(7151,7159) MUL MUL PUSH2(7177,7187) MUL MUL PUSH2(7193,7207) MUL MUL
   PUSH2(7211,7213)  MUL MUL PUSH2(7219,7229) MUL MUL PUSH2(7237,7243) MUL MUL PUSH2(7247,7253) MUL MUL PUSH2(7283,7297) MUL MUL
   PUSH2(7307,7309)  MUL MUL PUSH2(7321,7331) MUL MUL PUSH2(7333,7349) MUL MUL PUSH2(7351,7369) MUL MUL PUSH2(7393,7411) MUL MUL
   PUSH2(7417,7433)  MUL MUL PUSH2(7451,7457) MUL MUL PUSH2(7459,7477) MUL MUL PUSH2(7481,7487) MUL MUL PUSH2(7489,7499) MUL MUL
   PUSH2(7507,7517)  MUL MUL PUSH2(7523,7529) MUL MUL PUSH2(7537,7541) MUL MUL PUSH2(7547,7549) MUL MUL PUSH2(7559,7561) MUL MUL
   PUSH2(7573,7577)  MUL MUL PUSH2(7583,7589) MUL MUL PUSH2(7591,7603) MUL MUL PUSH2(7607,7621) MUL MUL PUSH2(7639,7643) MUL MUL
   PUSH2(7649,7669)  MUL MUL PUSH2(7673,7681) MUL MUL PUSH2(7687,7691) MUL MUL PUSH2(7699,7703) MUL MUL PUSH2(7717,7723) MUL MUL
   PUSH2(7727,7741)  MUL MUL PUSH2(7753,7757) MUL MUL PUSH2(7759,7789) MUL MUL PUSH2(7793,7817) MUL MUL PUSH2(7823,7829) MUL MUL
   PUSH2(7841,7853)  MUL MUL PUSH2(7867,7873) MUL MUL PUSH2(7877,7879) MUL MUL PUSH2(7883,7901) MUL MUL PUSH2(7907,7919) MUL MUL
   PUSH2(7927,7933)  MUL MUL PUSH2(7937,7949) MUL MUL PUSH2(7951,7963) MUL MUL PUSH2(7993,8009) MUL MUL PUSH2(8011,8017) MUL MUL
   PUSH2(8039,8053)  MUL MUL PUSH2(8059,8069) MUL MUL PUSH2(8081,8087) MUL MUL PUSH2(8089,8093) MUL MUL PUSH2(8101,8111) MUL MUL
   PUSH2(8117,8123)  MUL MUL PUSH2(8147,8161) MUL MUL PUSH2(8167,8171) MUL MUL PUSH2(8179,8191) MUL MUL PUSH2(8209,8219) MUL MUL
   PUSH2(8221,8231)  MUL MUL PUSH2(8233,8237) MUL MUL PUSH2(8243,8263) MUL MUL PUSH2(8269,8273) MUL MUL PUSH2(8287,8291) MUL MUL
   PUSH2(8293,8297)  MUL MUL PUSH2(8311,8317) MUL MUL PUSH2(8329,8353) MUL MUL PUSH2(8363,8369) MUL MUL PUSH2(8377,8387) MUL MUL
   PUSH2(8389,8419)  MUL MUL PUSH2(8423,8429) MUL MUL PUSH2(8431,8443) MUL MUL PUSH2(8447,8461) MUL MUL PUSH2(8467,8501) MUL MUL
   PUSH2(8513,8521)  MUL MUL PUSH2(8527,8537) MUL MUL PUSH2(8539,8543) MUL MUL PUSH2(8563,8573) MUL MUL PUSH2(8581,8597) MUL MUL
   PUSH2(8599,8609)  MUL MUL PUSH2(8623,8627) MUL MUL PUSH2(8629,8641) MUL MUL PUSH2(8647,8663) MUL MUL PUSH2(8669,8677) MUL MUL
   PUSH2(8681,8689)  MUL MUL PUSH2(8693,8699) MUL MUL PUSH2(8707,8713) MUL MUL PUSH2(8719,8731) MUL MUL PUSH2(8737,8741) MUL MUL
   PUSH2(8747,8753)  MUL MUL PUSH2(8761,8779) MUL MUL PUSH2(8783,8803) MUL MUL PUSH2(8807,8819) MUL MUL PUSH2(8821,8831) MUL MUL
   PUSH2(8837,8839)  MUL MUL PUSH2(8849,8861) MUL MUL PUSH2(8863,8867) MUL MUL PUSH2(8887,8893) MUL MUL PUSH2(8923,8929) MUL MUL
   PUSH2(8933,8941)  MUL MUL PUSH2(8951,8963) MUL MUL PUSH2(8969,8971) MUL MUL PUSH2(8999,9001) MUL MUL PUSH2(9007,9011) MUL MUL
   PUSH2(9013,9029)  MUL MUL PUSH2(9041,9043) MUL MUL PUSH2(9049,9059) MUL MUL PUSH2(9067,9091) MUL MUL PUSH2(9103,9109) MUL MUL
   PUSH2(9127,9133)  MUL MUL PUSH2(9137,9151) MUL MUL PUSH2(9157,9161) MUL MUL PUSH2(9173,9181) MUL MUL PUSH2(9187,9199) MUL MUL
   PUSH2(9203,9209)  MUL MUL PUSH2(9221,9227) MUL MUL PUSH2(9239,9241) MUL MUL PUSH2(9257,9277) MUL MUL PUSH2(9281,9283) MUL MUL
   PUSH2(9293,9311)  MUL MUL PUSH2(9319,9323) MUL MUL PUSH2(9337,9341) MUL MUL PUSH2(9343,9349) MUL MUL PUSH2(9371,9377) MUL MUL
   PUSH2(9391,9397)  MUL MUL PUSH2(9403,9413) MUL MUL PUSH2(9419,9421) MUL MUL PUSH2(9431,9433) MUL MUL PUSH2(9437,9439) MUL MUL
   PUSH2(9461,9463)  MUL MUL PUSH2(9467,9473) MUL MUL PUSH2(9479,9491) MUL MUL PUSH2(9497,9511) MUL MUL PUSH2(9521,9533) MUL MUL
   PUSH2(9539,9547)  MUL MUL PUSH2(9551,9587) MUL MUL PUSH2(9601,9613) MUL MUL PUSH2(9619,9623) MUL MUL PUSH2(9629,9631) MUL MUL
   PUSH2(9643,9649)  MUL MUL PUSH2(9661,9677) MUL MUL PUSH2(9679,9689) MUL MUL PUSH2(9697,9719) MUL MUL PUSH2(9721,9733) MUL MUL
   PUSH2(9739,9743)  MUL MUL PUSH2(9749,9767) MUL MUL PUSH2(9769,9781) MUL MUL PUSH2(9787,9791) MUL MUL PUSH2(9803,9811) MUL MUL
   PUSH2(9817,9829)  MUL MUL PUSH2(9833,9839) MUL MUL PUSH2(9851,9857) MUL MUL PUSH2(9859,9871) MUL MUL PUSH2(9883,9887) MUL MUL
   PUSH2(9901,9907)  MUL MUL PUSH2(9923,9929) MUL MUL PUSH2(9931,9941) MUL MUL PUSH2(9949,9967) MUL MUL PUSH(9973) MUL DOT
   PRINT_Z({"=20838",0x0D})
STOP
