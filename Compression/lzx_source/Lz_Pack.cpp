/////////////////////////////////////////////
// Lz_Packer 01 based on                   //
// Busy soft // LzePacker 01 // 01.11.2016 //
// Modified by _Dworkin     // 27.07.2023  //
/////////////////////////////////////////////

// Debug output level: 0=none, 1=small, 2=large, 3=oops, 4=WTF?!, 5=... //
#define DBG 0

#ifndef stricmp
#define stricmp strcasecmp
#endif

void DisplayPacked(int pro,int len);

#include <time.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MANY   80000
#define MAXSEK 16383
#define MAXOFF 32767
#define MAXLEN 65536

char name_out[1024];

unsigned char input_data[MAXLEN];
unsigned char packed_data[MAXLEN];

int Poff[MAXLEN];			// Offset of   packed sequecne ended in this byte
int Plen[MAXLEN];			// Length of   packed sequecne ended in this byte
int bufpck[MAXLEN];			// Total price of packed data ending in this byte
int bufnxt[MAXLEN];			// List of all found words - number of next word
int Roff[MAXLEN];			// Offset of   repeated packed sequecne ended in this byte in previous matches
int Rlen[MAXLEN];			// Length of   repeated packed sequecne ended in this byte in previous matches
int Fpos[MAXLEN];			// Locate of   future matching sekvence
int Flen[MAXLEN];			// Length of   future matching sekvence

int hash_table[0x10000];	// Hash table for quick searching of words


char GetChar(char byte)
{
	return byte >= 32 && byte <= 126 ? byte : ' ';
}


int main(int number_of_params, char **parameters)
{
	puts("LZ_ Packer 01 based on Busy soft LZE Packer 01");

	if (number_of_params < 2 || number_of_params > 4)
	{
		puts("Use: Lz_Pack <filename> -p <prolog_name>\n");
		exit(1);
	}

	int input_size = 0;
	int prolog_size = 0;
	FILE *file_inp = NULL;
	
	if ( number_of_params == 4 )
	{
		printf("Input prolog file: %s\n",parameters[3]);

		file_inp = fopen(parameters[3],"rb"); if (!file_inp) {perror(parameters[3]);exit(1);}

		prolog_size = fread(input_data,1,MAXLEN,file_inp);
		fclose(file_inp);
	}

	char *name_inp = parameters[1];
	strcpy(name_out,name_inp);
	int txtlen = strlen(name_out);
	if (txtlen > 5)
	{
		char * dotpos = strrchr(name_out + txtlen - 5,'.');
		if (dotpos) {*dotpos = 0; txtlen = dotpos - name_out;}
	}
	strcpy(name_out + txtlen, ".lz_");

	printf("Input file: %s  Output file: %s\n",name_inp,name_out);

	file_inp = fopen(name_inp,"rb"); if (!file_inp) {perror(name_inp);exit(1);}

	input_size = prolog_size + fread(&(input_data[prolog_size]),1,MAXLEN,file_inp);
	fclose(file_inp);

	if (input_size==prolog_size) {puts("Zero length of input file !");exit(1);}

	if (DBG) printf("\nDebug level %c\n",DBG+'0');

	///////////////////////

	clock_t run_begin = clock();

	int cmps;
	if (DBG) cmps = 0;
	if (DBG) putchar('\n');
	unsigned char byte = input_data[0];
	
	int idx = 0;
	int unpacked = 0;	// number of unpacked bytes outside of sekvences

	if (DBG > 2) 
		printf("   idx  idx\n");

		
	if (DBG > 2) printf("%+6d %04X  input_data[idx]: 0x%02X = '%c'\n",
		idx,idx,
		input_data[idx],GetChar(input_data[idx]));

	Roff[0] = 0;		// Offset of   repeated packed sequecne ended in this byte in previous matches
	Rlen[0] = 0;		// Length of   repeated packed sequecne ended in this byte in previous matches
	bufnxt[0] = 0;		// List of all found words - number of next word
	Plen[0] = 0;		// Length of   packed sequecne ended in this byte
	bufpck[0] = 2;		// Price of first byte (assumed as unpacked sekvence)		
	unpacked = 1;		// number of unpacked bytes outside of sekvences
		
	for(idx=1; idx < input_size; idx++)
	{
		if (DBG > 2) printf("%+6d %04X  input_data[idx]: 0x%02X = '%c'\n",
				idx,idx,
				input_data[idx],GetChar(input_data[idx]));

		if (unpacked == MAXSEK) unpacked = 0;
		Plen[idx] = 0;
		
		// celkovy pocet bajtu na vystupu k aktualnimu znaku vstupu pro pripad ze aktualni znak bude jen kopitrovany
		// = predchozi + 1 + 1 pro token pokud je to prvni bajt + 1 pokud zrovna prelezam na dvoubajtovy token
		bufpck[idx] = bufpck[idx - 1] + (unpacked ? 1:2) + (unpacked == 64 ? 1:0);
		unpacked++;
		// dale se budeme snazit najit kopii, ktera bude mit lepsi vysledky
		// pokud ji najdeme tak se hodnota bufpck[idx] nastavi na novou nizsi hodnotu a unpacked vynuluje

		int hash_idx = input_data[idx] | (input_data[idx-1] << 8);
		int locate = hash_table[hash_idx];
		bufnxt[idx] = locate;
		hash_table[hash_idx] = idx;
		if (DBG > 2)
		{
			unsigned char byte = input_data[idx];

			printf("             (create) hash_idx: 0x%04X  (price) bufpck[%5d]: %-5u  bufnxt[%5d]: %-5u (locate)\n",
				hash_idx,
				idx,bufpck[idx],
				idx,bufnxt[idx]);

			int nxt = bufnxt[idx];
			int max = 8;	// max vypsanych
			while(nxt && max)
			{
				printf("                                             (next hashes at offsets) bufnxt[%5d]: %-5u\n", nxt, bufnxt[nxt]);
				nxt = bufnxt[nxt];
				max--;
			}
			if (nxt) 
				printf("                                             (next hashes at offsets) bufnxt[%5d]: %-5u...\n", nxt, bufnxt[nxt]);
			putchar('\n');
		}

		int best_price = MANY;
		int best_offset = 0;
		int best_len = 0;
		int info_length = 0;
		int info_offset = 0;
		int max_loc = MAXLEN;
		int noend = idx?1:0;

		while(locate && noend)
		{
			if (DBG > 4)
				printf("             (test hash) locate:%-5u"
								"  (offset) locate-idx: %-5d  (Poff[loc]:%-3d Plen[loc]:%-3u Roff[loc]:%-3d Rlen[loc]:%-3u)   best_len: %u\n",
					locate,locate-idx,
					Poff[locate],Plen[locate],
					Roff[locate],Rlen[locate],
					best_len);

			if (locate < best_len)
			{
				if (DBG > 3) printf("             Skip all next hashes (loc < best_len)\n");
				break;
			}
			int offset = idx - locate;
			if (offset > MAXOFF)
			{
				if (DBG > 3) printf("             Skip all next hashes (offset > MAXOFF)\n");
				break;
			}
			if (locate > max_loc) {locate = bufnxt[locate];continue;}
			

			int maxlen = locate >= MAXSEK ? MAXSEK : locate+1;
			
			int length;
			///////////////////////
			if (Plen[idx-1] && Poff[idx-1] == offset)
			{
				noend = 0;
				length = Plen[idx-1]+1; if (length > maxlen) length = maxlen;
				if (DBG > 3) printf("             Detected sekvence at %d  Poff[idx-1]:%d Plen[idx-1]:%u  =>  Set length: %u (max_loc: %i)\n",
										idx-1, Poff[idx-1], Plen[idx-1], length, max_loc);
			}
			///////////////////////
			else if (Fpos[locate-1] == idx-1)
			{
				length = Flen[locate-1] + 1; if (length > maxlen) length = maxlen;
				if (DBG > 3) printf("             Previous sekvence at %d  Fpos[loc-1]:%u Flen[loc-1]:%u  =>  Set length: %u\n",
										locate-1, Fpos[locate-1], Flen[locate-1], length);
			}
			////////////////////////
			else
			{
				//////////////////////////////////////////////////////////////////////////
				int limit = Roff[locate];
				int subsub = idx-limit;
				if (DBG > 4) printf("                                                   Info: Loc:%5d (Poff[loc]:%-3d Plen[loc]:%-3u Roff[loc]:%-3d Rlen[loc]:%-3u)\n"
									"                                                         Sub:%5d (Poff[sub]:%-3d Plen[sub]:%-3u Roff[sub]:%-3d Rlen[sub]:%-3u)\n",
					locate, Poff[locate], Plen[locate], Roff[locate], Rlen[locate],
					subsub, Poff[subsub], Plen[subsub], Roff[subsub], Rlen[subsub]);
				///////////////////////////////////////////////////////////////////////////
				if (limit && limit == Roff[subsub])
				{
					if (DBG > 4) printf("                   Speed-up comparision enabled (Limit:%u)\n",limit);
					length = limit;
					if (limit > 2) for(length = 2; length < limit; length++)
					{
						if (DBG > 4) printf("                   Compare before %+6d 0x%02X   %+6d 0x%02X"
											"   Len:%-5u   Maxlen: %-5u   (loc-len=pos:%-3u Poff[pos]:%-3d Plen[pos]:%-3u)\n",
												locate-length,input_data[locate-length],
												idx-length,input_data[idx-length],
												length,maxlen,locate-length,Poff[locate-length],Plen[locate-length]);
						if (DBG) cmps++;
						if (input_data[locate-length] != input_data[idx-length]) break;
					}
					if (length == limit)
					{
						int limit2 = limit << 1; if (limit2 > MAXSEK) limit2 = MAXSEK;
						while(length < limit2)
						{
							if (DBG > 4) printf("                        Compare repeat %+6d 0x%02X   %+6d 0x%02X"
												"   Len:%-5u   Maxlen: %-5u   (Pos:%-3u off:%-3d len:%-3u)\n",
													locate-length,input_data[locate-length],
													idx-length,input_data[idx-length],
													length,maxlen,locate-length,Poff[locate-length],Plen[locate-length]);
							if (DBG) cmps++;
							if (input_data[locate-length] != input_data[idx-length]) break;
							length++;
						}
						if (length == limit2)
						{
							length = limit + Rlen[subsub];
							if (length > Rlen[locate]) length = Rlen[locate];
							if (length > maxlen) length = maxlen;
							max_loc = idx - length + 1;
							if (DBG > 4) printf("                        Set length to %u   Max loc: %u\n",
								length,max_loc);

							while(length < maxlen)
							{
								if (DBG > 4) printf("                        Compare after  %+6d 0x%02X   %+6d 0x%02X"
													"   Len:%-5u   Maxlen: %-5u   (Pos:%-3u off:%-3d len:%-3u)\n",
														locate-length,input_data[locate-length],
														idx-length,input_data[idx-length],
														length,maxlen,locate-length,Poff[locate-length],Plen[locate-length]);
								if (DBG) cmps++;
								if (input_data[locate-length] != input_data[idx-length]) break;
								length++;
							}
						}
					}
				}

				else for(length = 2; length < maxlen; length++)
				{
					if (DBG > 4) printf("                        Compare normal %+6d 0x%02X   %+6d 0x%02X"
										"   Len:%-5u   Maxlen: %-5u   (Pos:%-3u off:%-3d len:%-3u)\n",
											locate-length,input_data[locate-length],
											idx-length,input_data[idx-length],
											length,maxlen,locate-length,Poff[locate-length],Plen[locate-length]);
					if (DBG) cmps++;
					if (input_data[locate-length] != input_data[idx-length]) break;
				}
			}
			if (DBG > 4) printf("                        Result  length: %u\n",length);
			////////////////////////////
			Fpos[locate] = idx;
			Flen[locate] = length;
			////////////////////////////
			int price = bufpck[idx - length] + (length < 64 ? 1 : 2) + (offset < 128 ? 1 : 2);
			if ((price < best_price) || (price == best_price) && (best_len < length))
			{
				best_price = price;
				best_len = length;
				best_offset = offset;
			}
			if (DBG > 3) printf("                      Found sekv.  Loc:%-+5d  "
								"Offset:%-5d Length:%-5u  Roff:%-5d Rlen:%-5u  Fpos:%-5d Flen:%-5u  NewPrice:%-5u\n",
								locate,offset,length,Roff[locate],Rlen[locate],Fpos[locate],Flen[locate],price);
			////////////////////////////
			if (Roff[locate])
			{
				int xxxoff = Roff[locate];
				int xxxlen = Rlen[locate]; if (xxxlen > length) xxxlen = length;
				if (xxxlen && (xxxlen - xxxoff > info_length - info_offset) && xxxlen > (xxxoff << 1))
				{
					info_length = xxxlen;
					info_offset = xxxoff;
					if (DBG > 3) printf("                      New repeat info ... Loc:%-+5d Roff:%-5d Rlen:%-5u\n",
										locate,-info_offset,info_length);
				}
			}
			////////////////////////////
			if (best_len >= MAXSEK)
			{
				if (DBG > 3) printf("                      Skip all next hashes (len = max)\n");
				break;
			}
			locate = bufnxt[locate];
		}
		if (best_len)
		{
			if (best_len > MAXSEK) {printf("Error: Best length = %u\n",best_len); exit(5);}

			int old_price = bufpck[idx];
			int accepted = (best_price < old_price) && (idx>=prolog_size);

			if (accepted)
			{
				Poff[idx] = best_offset;
				Plen[idx] = best_len;
				bufpck[idx] = best_price;
				unpacked = 0;
			}
			/////////////////////////////////////
			if (best_len > best_offset)
			{
				Roff[idx] = best_offset;
				Rlen[idx] = best_len + best_offset;
			}
			else
			{
				if (info_length > best_len) info_length = best_len;
				if (info_length <= info_offset << 1) {info_length=0; info_offset=0;}
				Roff[idx] = info_offset;
				Rlen[idx] = info_length;
			}
			/////////////////////////////////////

			if (DBG > 1)
			{
				unsigned char byte = input_data[idx];
				printf("%+6d %04X  ",idx, idx);
				if (DBG == 2)
					printf("Byte: 0x%02X '%c'",byte,GetChar(byte));
				else
					printf("..............");
				printf("    Best sekvence  Loc:%5d  Offset:%-5d"
					" Length:%-5u  Roff:%-5d Rlen:%-5u  NewPrice:%-5u OldPrice:%-5u %s\n",
							idx-best_offset, best_offset, best_len,
							Roff[idx],Rlen[idx],
							best_price, old_price,
							accepted ? "Accepted":"Refused");
			}
		}

	
	} // idx

	if (DBG > 2)
	{
		for(idx = prolog_size; idx < input_size; idx++)
		{
			unsigned char byte = input_data[idx];
			printf("%+6d %04X  Byte: 0x%02X '%c'  ",idx,idx,byte,GetChar(byte));
			if (Plen[idx])
				printf("Sekvence  Location: %+-6d  Offset: %-6d  Length: %-5u",
					idx - Poff[idx], -Poff[idx], Plen[idx]);
			putchar('\n');
		}
		putchar('\n');
	}

	if (DBG > 5)
		printf("\nUnreverse sekvences:\n");

	// Unreverse sekvences //
	idx = input_size - 1;
	while(idx >= prolog_size)
	{
		int length = Plen[idx];
		if (length)
		{
			int sekzac = idx - length + 1;
			if (sekzac < 1) {printf("\nError: Unreverse failed. Index: %u  Len: %u  Zac: %u\n",idx,length,sekzac);exit(3);}
			
			if (sekzac <= prolog_size) {
				sekzac = prolog_size;
				length = idx + 1 - sekzac;
			}
			
			Plen[sekzac] = length;
			Poff[sekzac] = Poff[idx];
			for(int i = sekzac + 1; i < idx; i++) {Plen[i]=0;Poff[i]=0;}

			if (DBG > 1) printf("Unreverse sequence %5u-%-5u %04X-%04X  Length: %-5u  Offset: %d \n",
							sekzac,idx,sekzac,idx,length,Poff[sekzac]);

			idx -= length;
		}
		else
		{
			if (DBG > 2)
			{
				unsigned char byte = input_data[idx];
				printf("Unreverse byte %5u %04X   Byte: 0x%02X '%c'\n",
					idx,idx,byte,
					GetChar(byte));
			}
			Plen[idx] = 1;
			idx--;
		}
	}

	// if (DBG > 1) putchar('\n');
	if (DBG) DisplayPacked(prolog_size,input_size);
	
	if (DBG > 5)
		printf("Optimize short sequences with overhead bigger or the same as saved data:\n");

	// Optimize short sequences with overhead bigger or the same as saved data //
	int len = 0;
	for (int idx = prolog_size; idx < input_size - 1; idx ++)
	{
		// if (DBG > 2) printf("%+6d %04X  Test  Len: %-3u  Unpacked: %u\n",idx,idx,Plen[idx],len);
		switch (Plen[idx])
		{
		case 0:
			if (DBG > 2) printf("%+6d %04X  Test  Plen[%5d]: %-5u  Unpacked: %u\n",idx,idx,idx,Plen[idx],len);
			printf("\nError: Optimize 1 failed. Index: %u  Len: %u\n",idx,len);exit(4);
			break;
		case 1:
			len++;
			if (DBG > 2) printf("%+6d %04X  Test  Unpacked %u\n",idx,idx,len);
			if (len > MAXSEK) len=0;
			break;
		default:
			int seklen = Plen[idx];
			int sekoff = Poff[idx];
			int newlen = len + seklen;
			int sekove = (seklen < 64 ? 1 : 2) + (sekoff < 128 ? 1 : 2);
			int newove = (newlen < 64 ? 1 : 2) + (newlen < MAXSEK ? 0 : 1);
			int unpove = len ? (len < 64 ? 1 : 2) : 0;
			if (DBG > 1) printf("%+6d %04X  Test  Sequence %5u-%-5u Off:%-4d Len:%-4u "
								"Ovh:%-2u + Unpack Len:%-3u Ovh:%-2u = Tot: %-3d => Ovh:%-2u Tot:%-3u",
				idx,idx,idx,idx+seklen-1,-sekoff,seklen,
				sekove,len,unpove, sekove+len+unpove, newove,newlen+newove);
			if (newove + seklen <= unpove + sekove)
			{
				for(int i = 0; i < seklen; i++) Plen[idx + i] = 1;
				if (DBG > 1) printf(" => Optimize %d",unpove + sekove - newove - seklen);
				idx --;
			}
			else
			{
				len = 0;
				idx += seklen - 1;
			}
			if (DBG > 1) printf("\n");
		}
	}

	if (DBG) DisplayPacked(prolog_size,input_size);
	
	if (DBG > 5)
		printf("Optimize 2:\n");


	len = 0;
	for (int idx = input_size - 1; idx >= prolog_size; idx --)
	{
		// if (DBG > 2) printf("%+6d %04X  Test  Len: %-3u  Unpacked: %u\n",idx,idx,Plen[idx],len);
		switch (Plen[idx])
		{
		case 0:
			if (DBG > 2) printf("%+6d %04X  Test  Plen[%5d]: %-3u  Unpacked: %u\n",idx,idx,idx,Plen[idx],len);
			printf("\nError: Optimize 2 failed. Index: %u  Len: %u\n",idx,len);exit(4);
			break;
		case 1:
			len++;
			if (DBG > 2) printf("%+6d %04X  Test  Unpacked data  %u\n",idx,idx,len);
			if (len > MAXSEK) len=0;
			break;
		default:
			int seklen = Plen[idx];
			int sekoff = Poff[idx];
			int newlen = len + seklen;
			int sekove = (seklen < 64 ? 1 : 2) + (sekoff < 128 ? 1 : 2);
			int newove = (newlen < 64 ? 1 : 2) + (newlen < MAXSEK ? 0 : 1);
			int unpove = len ? (len < 64 ? 1 : 2) : 0;
			if (DBG > 1) printf("%+6d %04X  Test  Sequence %5u-%-5u Off:%-4d Len:%-4u "
								"Ovh:%-2u + Unpack Len:%-3u Ovh:%-2u = Tot: %-3d => Ovh:%-2u Tot:%-3u",
				idx,idx,idx-seklen+1,idx,-sekoff,seklen,
				sekove,len,unpove, sekove+len+unpove, newove,newlen+newove);
			if (newove + seklen <= unpove + sekove)
			{
				for(int i = 0; i < seklen; i++) Plen[idx - i] = 1;
				if (DBG > 1) printf(" => Optimize %d",unpove + sekove - newove - seklen);
				idx ++;
			}
			else
			{
				len = 0;
				idx -= seklen - 1;
			}
			if (DBG > 1) printf("\n");
		}
	}

	if (DBG) DisplayPacked(prolog_size,input_size);

	// Generating output data //
	int totove = 1;
	int totdat = 0;
	int idxout = 0;
	for (int idx = prolog_size; idx < input_size;)
	{
		int off = Poff[idx];
		int len = Plen[idx];
		if (!len) {printf("\nError at +%6u %04X   Offset:%u Len:%u\n",idx-prolog_size,idx-prolog_size,off,len);exit(4);}
		if (len > 1)
		{
			if (DBG > 1) printf("Output data %+6d %04X  Packed %+6d %04X    Length: %-5u  Overhead: %u  Offset: %-6d\n",
				idx-prolog_size,idx-prolog_size,idxout,idxout,len,(len < 64 ? 1 : 2) + (off < 128 ? 1 : 2),-off);
			if (len > MAXSEK || off > MAXOFF) {printf("\nError at +%6u %04X   Offset:%u Len:%u\n",idx-prolog_size,idx-prolog_size,off,len);exit(4);}
			
			if (len < 64)
			{	
				// Packed = 1
				// Double = 0
				// D0 5. 4. 3. 2. 1. 0. P1 
				totove++;
				packed_data[idxout++] = 2*len + 1;
			}
			else
			{
				// Packed = 1
				// Double = 1
				// D1 d. c. b. a. 9. 8. P1   +   7. 6. 5. 4. 3. 2. 1. 0. 
				totove += 2;
				packed_data[idxout++] = ((len & 0x3F00)>> 7) | 0x81;
				packed_data[idxout++] =  len & 0xFF;
			}

			if (off < 128)
			{
				totove++;
				packed_data[idxout++] = -2*off & 0xFE;
			}
			else
			{
				totove += 2;
				packed_data[idxout++] = ((-off & 0x7F00) >> 7) | 0x01;
				packed_data[idxout++] =  -off & 0xFF;
			}
			idx += len;
		}
		else
		{
			int i;
			int maxlim = idx + MAXSEK; if (maxlim > input_size) maxlim = input_size;
			for(i = idx; i < maxlim && Plen[i] == 1; i++);
			len = i - idx;
			if (DBG > 1)
			{
				printf("Output data %+6d %04X  Unpack %+6d %04X    Length: %-5u  Overhead: %u  Data:",
					idx-prolog_size,idx-prolog_size,idxout,idxout,(len < 64 ? 1 : 2),len);
				int j;
				for(j = 0; (j < len) && (j < 16); j++) printf(" %02X",input_data[idx+j]);
				if (j < len) printf(" ...");
				putchar('\n');
			}
			
			if (len > MAXSEK) {printf("\nError at +%6u %04X   Offset:%u Len:%u\n",idx-prolog_size,idx-prolog_size,off,len);exit(4);}

			if (len < 64)
			{
				// Packed = 0 --> unpacked
				// Double = 0
				// D0 5. 4. 3. 2. 1. 0. P0 
				totove++;
				packed_data[idxout++] = 2*len;
			}
			else
			{
				// Packed = 0 --> unpacked
				// Double = 1
				// D1 d. c. b. a. 9. 8. P0   +   7. 6. 5. 4. 3. 2. 1. 0. 
				totove += 2;
				packed_data[idxout++] = ((len & 0x3F00) >> 7) | 0x80;
				packed_data[idxout++] =  len & 0xFF;
			}
			
			memcpy(packed_data+idxout, input_data+idx, len);
			totdat += len;
			idxout += len;
			idx += len;
		}
	}
	if (DBG > 1) printf("Output data %+6d %04X  ...... %+6d %04X    End mark 0x00  Overhead: 1\n",input_size,input_size,idxout,idxout);


	// Store end mark //
	packed_data[idxout++] = 0;

	clock_t run_end = clock();

	int length_out = idxout;

	FILE *file_out = fopen(name_out,"wb"); if (!file_out) {perror(name_out);exit(1);}
	fwrite(packed_data,1,length_out,file_out);
	fclose(file_out);

	if (DBG > 1) putchar('\n');
	printf("Packed: %5u => %-5u    Data: %-5u  Overhead: %-5u\n",input_size-prolog_size,length_out,totdat,totove);

	if (DBG) printf("   Compares: %u   ",cmps);
	if (CLOCKS_PER_SEC == 1000)		// (should be defined as 1000 in time.h) //
	{
		int time_diff = run_end - run_begin;
		if (DBG || time_diff > 0) printf("   Time: %u.%03u seconds", time_diff / 1000, time_diff % 1000);
	}

	if (DBG) putchar('\n');
	return 0;
}

void DisplayPacked(int prolen,int totlen)
{
	if (!DBG) return;
	int locsek = 0;
	int packed = 0;
	int totdat = 0;
	int locdat = 0;
	int locove = 0;
	int totove = 1;
	if (DBG > 1) putchar('\n');
	for(int idx = prolen; idx < totlen; idx ++)
	{
		unsigned char byte = input_data[idx];
		int off = Poff[idx];
		int len = Plen[idx];
		switch (len)
		{
		case 0:
			if (DBG > 2) printf("%+6d %04X  Byte: 0x%02X '%c'    Sekvence\n",idx,idx,byte,GetChar(byte));
			packed = 1;
			break;
		case 1:
			if(locdat > MAXSEK || packed)
			{
				locdat = 0;
				packed = 0;
			}
			if (locdat == 00) {totove++;locove=1;}
			locdat++;
			totdat++;
			locsek = 0;
			if (locdat == 64) {totove++;locove++;}
			if (DBG > 2) printf("%+6d %04X  Byte: 0x%02X '%c'  Count: %-4u Overhead: %u -> %u\n",
				idx,idx,byte,GetChar(byte),locdat,locove,totove);
			break;
		default:
			int overhead = (len < 64 ? 1 : 2) + (off < 128 ? 1 : 2);
			locdat = 0;
			packed = 1;
			locsek = !locsek;
			if (locsek) totove += overhead;
			if (DBG > 2)
				printf("%+6d %04X  Byte: 0x%02X '%c'    Sekvence %s  Offset: %-4d  Length: %-3u  Overhead: %u -> %u\n",
					idx,idx,byte,
					GetChar(byte),
					locsek ? "zac":"end",
					-off,len,overhead,totove);
		}
	}
	if (DBG > 2) putchar('\n');
	printf("Packed: %5u => %-5u    Data: %-5u  Overhead: %-5u\n",totlen-prolen,totdat+totove,totdat,totove);
	if (DBG > 1) putchar('\n');
}
