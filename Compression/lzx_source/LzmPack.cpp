/////////////////////////////////////////////
// Busy soft // LzmPacker 01 // 01.11.2016 //
// Modified by _Dworkin     // 23.07.2023  //
/////////////////////////////////////////////

// Debug output level: 0=none, 1=small, 2=large, 3=oops, 4=WTF?!, 5=... //
#define DBG 0

void DisplayPacked(int from, int to);

#include <time.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MANY 80000
#define MAXSEK 127
#define MAXLEN 65536

char name_out[1024];

unsigned char input_data[MAXLEN];
unsigned char packed_data[MAXLEN];

int bufoff[MAXLEN];			// Offset of   packed sequecne ended in this byte
int buflen[MAXLEN];			// Length of   packed sequecne ended in this byte
int bufpck[MAXLEN];			// Total price of packed data ending in this byte
int bufnxt[MAXLEN];			// List of all found words - number of next word
int bufxoo[MAXLEN];			// Offset of   repeated packed sequecne ended in this byte in previous matches
int bufxll[MAXLEN];			// Length of   repeated packed sequecne ended in this byte in previous matches
int bufzii[MAXLEN];			// Locate of   future matching sekvence
int bufzll[MAXLEN];			// Length of   future matching sekvence

int hash_table[0x10000];	// Hash table for quick searching of words

int main(int number_of_params, char **parameters)
{
	puts("\nBusy soft: LZM Packer 01");

	if (number_of_params < 2 || number_of_params > 4)
	{
		puts("Use: LzmPack <filename> -p <prolog_name>\n");
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
	strcpy(name_out + txtlen, ".lzm");

	printf("Input file: %s  Output file: %s\n",name_inp,name_out);

	file_inp = fopen(name_inp,"rb"); if (!file_inp) {perror(name_inp);exit(1);}

	input_size = prolog_size + fread(input_data + prolog_size,1,MAXLEN,file_inp);
	fclose(file_inp);

	if (input_size==prolog_size) {puts("Zero length of input file !");exit(1);}

	if (DBG) printf("\nDebug level %c\n",DBG+'0');

	///////////////////////

	clock_t run_begin = clock();

	int cmps;
	if (DBG) cmps = 0;
	if (DBG) putchar('\n');
	unsigned char byte = input_data[0];
	if (DBG > 2) printf("    +0 0000  Byte: 0x%02X '%c'  First byte\n",byte,byte >= 32 && byte <= 126 ? byte : ' ');

	int index;

	int unpacked = 1;	// number of unpacked bytes outside of sekvences
	bufxoo[0] = 0;
	bufxll[0] = 0;
	bufnxt[0] = 0;
	buflen[0] = 0;		// Length of   packed sequecne ended in this byte
	bufpck[0] = 2;		// Price of first byte (assumed as unpacked sekvence)

	for(index = 1; index < input_size; index++)
	{
		if (unpacked == MAXSEK) unpacked = 0;
		buflen[index] = 0;
		bufpck[index] = bufpck[index - 1] + (unpacked ? 1:2);
		unpacked++;

		int hash_index = input_data[index] | (input_data[index-1] << 8);
		int locate = hash_table[hash_index];
		bufnxt[index] = locate;
		hash_table[hash_index] = index;
		if (DBG > 2)
		{
			int max = 8;
			unsigned char byte = input_data[index];
			printf("%+6d %04X  Byte: 0x%02X '%c'  Create hash: 0x%04X  Price: %-5u  ",
				index,index,byte,
				byte >= 32 && byte <= 126 ? byte : ' ',
				hash_index,bufpck[index]);
			int nxt = bufnxt[index];
			if (nxt) printf("  Next hashes at offsets:");
			while(nxt && max)
			{
				printf(" %u",nxt);
				nxt = bufnxt[nxt];
				max--;
			}
			if (nxt) printf(" ...");
			putchar('\n');
		}

		int best_price = MANY;
		int best_offset = 0;
		int best_length = 0;
		int info_length = 0;
		int info_offset = 0;
		int max_loc = MAXLEN;
		int noend = 1;
		while(locate && noend)
		{
			if (DBG > 4) printf("%+6d %04X                      Test hash:  Locate: %-5u"
								"  Offset: %-5d  (Soff:%-3d Slen:%-3u Xoff:%-3d Xlen:%-3u)   Bestlen: %u\n",
								index,index,locate,locate-index,
								-bufoff[locate],buflen[locate],
								-bufxoo[locate],bufxll[locate],
								best_length);
			if (locate < best_length)
			{
				if (DBG > 3) printf("%+6d %04X                      Skip all next hashes (loc < best len)\n",index,index);
				break;
			}
			int offset = index - locate;
			if (offset > 255)
			{
				if (DBG > 3) printf("%+6d %04X                      Skip all next hashes (offset > max)\n",index,index);
				break;
			}
			if (locate > max_loc) {locate = bufnxt[locate];continue;}
			int maxlen = locate >= MAXSEK ? MAXSEK : locate+1;
			int length;
			///////////////////////
			if (buflen[index-1] && bufoff[index-1] == offset)
			{
				noend = 0;
				length = buflen[index-1]+1; if (length > maxlen) length = maxlen;
				if (DBG > 3) printf("%+6d %04X                      Detected sekvence at %+d  Off:%d Len:%u  =>  Set length: %u (max_loc:%i)\n",
										index, index, index-1, -bufoff[index-1], buflen[index-1], length, max_loc);
			}
			///////////////////////
			else if (bufzii[locate-1] == index-1)
			{
				length = bufzll[locate-1] + 1; if (length > maxlen) length = maxlen;
				if (DBG > 3) printf("%+6d %04X                      Previous sekvence at %+d  Zpos:%u Zlen:%u  =>  Set length: %u\n",
										index, index, locate-1, bufzii[locate-1], bufzll[locate-1], length);
			}
			////////////////////////
			else
			{
				//////////////////////////////////////////////////////////////////////////
				int limit = bufxoo[locate];
				int subsub = index-limit;
				if (DBG > 4) printf("%+6d %04X                        Info: "
					"Loc:%+d (Soff:%+d Slen:%u Xoff:%+d Xlen:%u)   "
					"Sub:%+d (Soff:%+d Slen:%u Xoff:%+d Xlen:%u)\n",
					index, index,
					locate, -bufoff[locate], buflen[locate], -bufxoo[locate], bufxll[locate],
					subsub, -bufoff[subsub], buflen[subsub], -bufxoo[subsub], bufxll[subsub]);
				///////////////////////////////////////////////////////////////////////////
				if (limit && limit == bufxoo[subsub])
				{
					if (DBG > 4) printf("%+6d %04X                        Speed-up comparision enabled (Limit:%u)\n",index,index,limit);
					length = limit;
					if (limit > 2) for(length = 2; length < limit; length++)
					{
						if (DBG > 4) printf("%+6d %04X                        Compare before %+6d 0x%02X   %+6d 0x%02X"
											"   Len:%-5u   Maxlen: %-5u   (Pos:%-3u off:%-3d len:%-3u)\n",
												index,index,
												locate-length,input_data[locate-length],
												index-length,input_data[index-length],
												length,maxlen,locate-length,-bufoff[locate-length],buflen[locate-length]);
						if (DBG) cmps++;
						if (input_data[locate-length] != input_data[index-length]) break;
					}
					if (length == limit)
					{
						int limit2 = limit << 1; if (limit2 > MAXSEK) limit2 = MAXSEK;
						while(length < limit2)
						{
							if (DBG > 4) printf("%+6d %04X                        Compare repeat %+6d 0x%02X   %+6d 0x%02X"
												"   Len:%-5u   Maxlen: %-5u   (Pos:%-3u off:%-3d len:%-3u)\n",
													index,index,
													locate-length,input_data[locate-length],
													index-length,input_data[index-length],
													length,maxlen,locate-length,-bufoff[locate-length],buflen[locate-length]);
							if (DBG) cmps++;
							if (input_data[locate-length] != input_data[index-length]) break;
							length++;
						}
						if (length == limit2)
						{
							length = limit + bufxll[subsub];
							if (length > bufxll[locate]) length = bufxll[locate];
							if (length > maxlen) length = maxlen;
							max_loc = index - length + 1;
							if (DBG > 4) printf("%+6d %04X                        Set length to %u   Max loc: %u\n",
								index,index,length,max_loc);

							while(length < maxlen)
							{
								if (DBG > 4) printf("%+6d %04X                        Compare after  %+6d 0x%02X   %+6d 0x%02X"
													"   Len:%-5u   Maxlen: %-5u   (Pos:%-3u off:%-3d len:%-3u)\n",
														index,index,
														locate-length,input_data[locate-length],
														index-length,input_data[index-length],
														length,maxlen,locate-length,-bufoff[locate-length],buflen[locate-length]);
								if (DBG) cmps++;
								if (input_data[locate-length] != input_data[index-length]) break;
								length++;
							}
						}
					}
				}

				else for(length = 2; length < maxlen; length++)
				{
					if (DBG > 4) printf("%+6d %04X                        Compare normal %+6d 0x%02X   %+6d 0x%02X"
										"   Len:%-5u   Maxlen: %-5u   (Pos:%-3u off:%-3d len:%-3u)\n",
											index,index,
											locate-length,input_data[locate-length],
											index-length,input_data[index-length],
											length,maxlen,locate-length,-bufoff[locate-length],buflen[locate-length]);
					if (DBG) cmps++;
					if (input_data[locate-length] != input_data[index-length]) break;
				}
			}
			if (DBG > 4) printf("%+6d %04X                        Result  length: %u\n",index,index,length);
			////////////////////////////
			bufzii[locate] = index;
			bufzll[locate] = length;
			////////////////////////////
			int price = bufpck[index - length] + 2;
			if ((price < best_price) || (price == best_price) && (best_length < length))
			{
				best_price = price;
				best_length = length;
				best_offset = offset;
			}
			if (DBG > 3) printf("%+6d %04X                      Found sekv.  Loc:%-+5d  "
								"Offset:%-5d Length:%-5u  Xoff:%-5d Xlen:%-5u  Zpos:%-5d Zlen:%-5u  NewPrice:%-5u\n",
								index,index,locate,-offset,length,-bufxoo[locate],bufxll[locate],bufzii[locate],bufzll[locate],price);
			////////////////////////////
			if (bufxoo[locate])
			{
				int xxxoff = bufxoo[locate];
				int xxxlen = bufxll[locate]; if (xxxlen > length) xxxlen = length;
				if (xxxlen && (xxxlen - xxxoff > info_length - info_offset) && xxxlen > (xxxoff << 1))
				{
					info_length = xxxlen;
					info_offset = xxxoff;
					if (DBG > 3) printf("%+6d %04X                      New repeat info ... Loc:%-+5d Xoff:%-5d Xlen:%-5u\n",
										index,index,locate,-info_offset,info_length);
				}
			}
			////////////////////////////
			if (best_length >= MAXSEK)
			{
				if (DBG > 3) printf("%+6d %04X                      Skip all next hashes (len = max)\n",index,index);
				break;
			}
			locate = bufnxt[locate];
		}
		if (best_length)
		{
			if (best_length > MAXSEK) {printf("Error: Best length = %u\n",best_length); exit(5);}

			int old_price = bufpck[index];
			int accepted = (best_price < old_price) && (index>=prolog_size);

			if (accepted)
			{
				bufoff[index] = best_offset;
				buflen[index] = best_length;
				bufpck[index] = best_price;
				unpacked = 0;
			}
			/////////////////////////////////////
			if (best_length > best_offset)
			{
				bufxoo[index] = best_offset;
				bufxll[index] = best_length + best_offset;
			}
			else
			{
				if (info_length > best_length) info_length = best_length;
				if (info_length <= info_offset << 1) {info_length=0; info_offset=0;}
				bufxoo[index] = info_offset;
				bufxll[index] = info_length;
			}
			/////////////////////////////////////

			if (DBG > 1)
			{
				unsigned char byte = input_data[index];
				printf("%+6d %04X  ",index, index);
				if (DBG == 2)
					printf("Byte: 0x%02X '%c'",byte,byte >= 32 && byte <= 126 ? byte : ' ');
				else
					printf("..............");
				printf("    Best sekvence  Loc:%-+5d  Offset:%-5d"
					" Length:%-5u  Xoff:%-5d Xlen:%-5u  NewPrice:%-5u OldPrice:%-5u %s\n",
							index-best_offset, -best_offset, best_length,
							-bufxoo[index],bufxll[index],
							best_price, old_price,
							accepted ? "Accepted":"Refused");
			}
		}
	}
	if (DBG > 1) printf("%+6d %04X  End of file\n\n",input_size,input_size);

	if (DBG > 2)
	{
		for(index = prolog_size; index < input_size; index++)
		{
			unsigned char byte = input_data[index];
			printf("%+6d %04X  Byte: 0x%02X '%c'  ",index,index,byte,byte >= 32 && byte <= 126 ? byte : ' ');
			if (buflen[index])
				printf("Sekvence  Location: %+-6d  Offset: %-6d  Length: %-5u",
					index - bufoff[index], -bufoff[index], buflen[index]);
			putchar('\n');
		}
		putchar('\n');
	}

	// Unreverse sekvences //
	index = input_size - 1;
	while(index >= prolog_size)
	{
		int length = buflen[index];
		if (length)
		{
			int sekzac = index - length + 1;
			if (sekzac < 1) {printf("\nError: Unreverse failed. Index: %u  Len: %u  Zac: %u\n",index,length,sekzac);exit(3);}
			
			if (sekzac <= prolog_size) {
				sekzac = prolog_size;
				length = index + 1 - sekzac;
			}

			buflen[sekzac] = length;
			bufoff[sekzac] = bufoff[index];
			for(int i = sekzac + 1; i < index; i++) {buflen[i]=0;bufoff[i]=0;}

			if (DBG > 1) printf("Unreverse sequence %5u-%-5u %04X-%04X  Length: %-5u  Offset: %d \n",
							sekzac,index,sekzac,index,length,-bufoff[sekzac]);

			index -= length;
		}
		else
		{
			if (DBG > 2)
			{
				unsigned char byte = input_data[index];
				printf("Unreverse byte %5u %04X   Byte: 0x%02X '%c'\n",
					index,index,byte,
					byte >= 32 && byte <= 126 ? byte : ' ');
			}
			buflen[index] = 1;
			index --;
		}
	}

	// if (DBG > 1) putchar('\n');
	if (DBG) DisplayPacked(prolog_size,input_size);

	// Optimize short sequences with overhead bigger or the same as saved data //
	int len = 0;
	for (int index = prolog_size; index < input_size - 1; index ++)
	{
		if (DBG > 2) printf("%+6d %04X  Test  Len: %-3u  Unpacked: %u\n",index,index,buflen[index],len);
		switch (buflen[index])
		{
		case 0:
			printf("\nError: Optimize 1 failed. Index: %u  Len: %u\n",index,len);exit(4);
			break;
		case 1:
			len++;
			if (len > MAXSEK) len=0;
			break;
		case 2:
			if (len && len < 126)
			{
				buflen[index+0] = 1;
				buflen[index+1] = 1;
				if (DBG > 1) printf("%+6d %04X  Optimize sequence   Unpack: %-3u   Packed:%5u-%-5u ->  Unpack: %u\n",
							index,index,len,index,index+1,len+2);
				len++;
			}
			else
				len = 0;
			break;
		default:
			len = 0;
			index += buflen[index] - 1;
		}
	}

	if (DBG) DisplayPacked(prolog_size,input_size);

	len = 0;
	for (int index = input_size - 1; index > prolog_size + 1; index --)
	{
		if (DBG > 2) printf("%+6d %04X  Test  Len: %-3u  Unpacked: %u\n",index,index,buflen[index],len);
		switch (buflen[index])
		{
		case 0:
			printf("\nError: Optimize 2 failed. Index: %u  Len: %u\n",index,len);exit(4);
			break;
		case 1:
			len++;
			if (len > MAXSEK) len=0;
			break;
		case 2:
			if (len && len < 126)
			{
				buflen[index-0] = 1;
				buflen[index-1] = 1;
				if (DBG > 1) printf("%+6d %04X  Optimize sequence   Packed:%5u-%-5u Unpack: %-3u   =>  Unpack: %u\n",
							index,index,index-1,index,len,len+2);
				len += 2;
			}
			else
				len = 0;
			break;
		default:
			len = 0;
			index -= buflen[index] - 1;
		}
	}

	if (DBG) DisplayPacked(prolog_size,input_size);

	// Generating output data //
	int idxout = 0;
	for (int index = prolog_size; index < input_size;)
	{
		int len = buflen[index];
		if (!len) {
			printf("\nError at %5u %04X  Len:0 Offset:%u\n",index,index,bufoff[index]);
			exit(4);
		}
		if (len > 1)
		{
			int offset = bufoff[index];
			if (DBG > 1) printf("Output data %+6d %04X  Packed %+6d %04X    Length: %-3u  Offset: %-4d\n",
				index,index,idxout,idxout,len,-bufoff[index]);
			if (offset > 255 || len > MAXSEK) {printf("\nError: Out of range - offset: %u  length: %u\n",offset,len);exit(5);}
			packed_data[idxout++] = (len << 1) | 0x01;
			packed_data[idxout++] = bufoff[index];
			index += len;
		}
		else
		{
			int i;
			int maxlim = index + MAXSEK > input_size ? input_size : index + MAXSEK;
			for(i = index; i < maxlim && buflen[i] == 1; i++);
			len = i - index;
			if (DBG > 1)
			{
				printf("Output data %+6d %04X  Unpack %+6d %04X    Length: %-3u  Data:",
					index,index,idxout,idxout,len);
				int j;
				for(j = 0; (j < len) && (j < 16); j++) printf(" %02X",input_data[index+j]);
				if (j < len) printf(" ...");
				putchar('\n');
			}
			if (len > MAXSEK) {printf("\nError: Out of range - length: %u\n",len);exit(5);}
			packed_data[idxout++] = len << 1;
			memcpy(packed_data+idxout, input_data+index, len);
			idxout += len;
			index += len;
		}
	}
	if (DBG > 1) printf("Output data %+6d %04X  ...... %+6d %04X    End mark 0x00\n",input_size,input_size,idxout,idxout);

	// Store end mark //
	packed_data[idxout++] = 0;

	clock_t run_end = clock();

	int length_out = idxout;

	FILE *file_out = fopen(name_out,"wb"); if (!file_out) {perror(name_out);exit(1);}
	fwrite(packed_data,1,length_out,file_out);
	fclose(file_out);

	// Final statistics //
	int totdat = 0;
	int totove = 0;
	for (int index = 0; index < length_out;)
	{
		unsigned char pck = packed_data[index];
		int len = pck >> 1;
		if (pck & 0x01)
		{
			totove += 2;
			index += 2;
		}
		else
		{
			totove ++;
			totdat += len;
			index += len + 1;
		}
	}
	if (DBG > 1) putchar('\n');
	printf("Packed: %5u => %-5u    Data: %-5u  Overhead: %-5u\n",input_size-prolog_size,length_out,totdat,totove);

	if (DBG) printf("   Compares: %u",cmps);
	if (CLOCKS_PER_SEC == 1000)		// (should be defined as 1000 in time.h) //
	{
		int time_diff = run_end - run_begin;
		if (DBG || time_diff > 0) printf("   Time: %u.%03u seconds", time_diff / 1000, time_diff % 1000);
	}
	if (DBG) putchar('\n');
	return 0;
}

void DisplayPacked(int from, int to)
{
	if (!DBG) return;
	int packed = 0;
	int locdat = 0;
	int totdat = 0;
	int totove = 1;
	int locsek = 0;
	if (DBG > 1) putchar('\n');
	for(int index = from; index < to; index++)
	{
		unsigned char byte = input_data[index];
		int len = buflen[index];
		switch (len)
		{
		case 0:
			if (DBG > 2) printf("%+6d %04X  Byte: 0x%02X '%c'    Sekvence\n",index,index,byte,byte >= 32 && byte <= 126 ? byte : ' ');
			packed = 1;
			break;
		case 1:
			if(locdat >= 128 || packed)
			{
				locdat = 0;
				packed = 0;
			}
			if (!locdat) totove++;
			locdat++;
			totdat++;
			locsek = 0;
			if (DBG > 2) printf("%+6d %04X  Byte: 0x%02X '%c'  %u\n",index,index,byte,byte >= 32 && byte <= 126 ? byte : ' ',locdat);
			break;
		default:
			locdat = 0;
			packed = 1;
			totove += 1;
			locsek = !locsek;

			if (DBG > 2)
				printf("%+6d %04X  Byte: 0x%02X '%c'    Sekvence %s  Offset: %-4d  Length: %-3u\n",
					index,index,byte,
					byte >= 32 && byte <= 126 ? byte : ' ',
					locsek ? "zac":"end",
					-bufoff[index],buflen[index]);
		}
	}
	if (DBG > 2) putchar('\n');
	printf("Packed: %5u => %-5u    Data: %-5u  Overhead: %-5u\n",to-from,totdat+totove,totdat,totove);
	if (DBG > 1) putchar('\n');
}
