
///////////////////////////////////////////////////////////////
// Lz_List 01 based on                                       //
// Busy soft // LzxList 01 (depacker & dumper) // 31.01.2017 //
// Modified by _Dworkin                       // 16.07.2023  //
///////////////////////////////////////////////////////////////

// Debug output level: 0=none, 1=small, 2=large, 3=oops, 4=WTF?!, 5=... //
#define DBG 0

#ifndef stricmp
#define stricmp strcasecmp
#endif


///////////////////////////
// Types of compressions //
///////////////////////////

// Systems for coding length and unpacked data:

#define TYPLZM 1	// Standart LZM compression - 7 bit length for both - sekvence and unpacked block
#define TYPLZE 2	// Standart LZE compression - 6/14 bit length for both - sekvence and unpacked block
#define TYPLZ_ 3	// Standart LZ_ compression - 6/14 bit length for both - sekvence and unpacked block
#define TYPZX7 4	// Original ZX7 compression - 1 bit for each unpacked byte and 1 bit + elias-gama length for sekvence
#define TYPBLK 5	// Bitstream BLK first simple - elias-gama length for both sekvence and unpacked block + 1 bit for sekvence / unpacked
#define TYPBS1 6	// Bitstream LZX standart 1 - 0=unpack byte, 10=2 byte sek, 110=3 byte sek, 1110 + EG length = sekvence, 1111 + EG length = unpacked block
#define TYPZX0 7	// Original ZX0 compression - 1 bit for each unpacked byte and 1 bit + elias-gama length for sekvence

// Systems for coding offsets:

#define POSLZM 1	// Standart for LZM compression - one byte (8 bit) offset
#define POSLZE 2	// Standart for LZE compression - one or two byte (7 or 15 bit) offset
#define POSLZ_ 3	// Standart for LZ_ compression - like LZE with binary incompatibility for flags and negative offset
#define POSOF4 4	// Four step offsets (1,2,3,4 or 2,4,6,8 or 3,6,9,12 or 4,8,12,16 bits)
#define POSOF1 5	// One fixed offset used for all sekvences
#define POSOF2 6	// Two fixed offsets (similar than ZX7)
#define POSOFD 7	// Simple elias-gama coding offset
#define POSZX0 8	// Elias(MSB(offset)+1)  LSB(offset)  Elias(length-1)


///////////////////////////////////////////////////////////////////////////////

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>

// int _CRT_glob = 0; //

#define MAXLEN 80000

int bits; // every file start with 0x80;
int first_zx0_literal; // 0 = false
int last_zx0_literal; // 0 = repeat offset, 1 = new offset, 2 = unpack
int last_zx0_offset;
int data_len;
int over_len;
int overhead;

int packed_index;
int unpack_index;

int compress_type;
int compress_posi;
int offset1bits;
int offset2bits;

int show_length;
int show_packed;
int show_unpack;

char  unpack_name[1024];
char *packed_name = NULL;
unsigned char packed_data[MAXLEN];
unsigned char unpack_data[MAXLEN];

void ShowUnpacked(void);

int GetBit(void)
{
	bits <<= 1;
	if (!(bits & 0xFF))
	{
		bits = (packed_data[packed_index++] << 1) | 1;
		over_len++;
	}
	overhead++;
	if (DBG > 1) printf(" %c ", ((bits >> 8) & 0x01) + '0');
	return (bits >> 8) & 0x01;
}


int GetByte(void)
{
	if (DBG > 1) printf(" %02X ", packed_data[packed_index]);
	overhead += 8;
	return packed_data[packed_index++];
}

int StandaloneFirstByte()
{
	switch (compress_type)
	{
	case TYPLZM:
	case TYPLZE:
	case TYPLZ_:
	case TYPBLK: return 0;
	case TYPZX0:
	case TYPZX7:
	case TYPBS1: return 1;
	default: return -1;
	}
}

int GetNumberOffsets()
{
	switch (compress_posi)
	{
	case POSOF4:
	case POSOF1: return 1;
	case POSOF2: return 2;
	case POSLZM:
	case POSLZE:
	case POSOFD: return 0;
	default: return -1;
	}
}

int GetValue(int bitwide)
{
	if (DBG > 1) printf(" (Val:%u) ", bitwide);
	int value = 0;
	for (int i = 0; i < bitwide; i++) value = (value << 1) | GetBit();
	if (DBG > 1) printf(" (%u) ", value);
	return value;
}

// bitwide je inicializovana hodnota s pocatecnim poctem nulovych bitu
int GetEliasGama(int bitwide)
{
	if (DBG > 1) printf(" (EG:%u) ", bitwide);
	while (!GetBit() && (bitwide < 18)) bitwide++;
	if (bitwide > 15) { if (DBG > 1) printf(" (End mark) "); return 0; }
	if (DBG > 1) printf(" (B:%u) ", bitwide);
	int value = 1;
	for (int i = 0; i < bitwide; i++) value = (value << 1) | GetBit();
	if (DBG > 1) printf(" (%u) ", value);
	return value;
}


// origin je pocatecni nastaveni hodnoty
// 0x0001 pro delku
// 0x??FE pro ofset
int GetInterlacedEliasGama(int origin)
{
	if (DBG > 1) printf(" (IEG:%u) ", origin);
	while (!GetBit())
	{ 
		origin <<= 1;
		origin += GetBit();
	}
	return origin;
}


// origin je pocatecni nastaveni hodnoty
// 0x0001 pro delku
// 0x??FE pro ofset
int GetInterlacedEliasGama_no_first_check(int origin)
{	
	return GetInterlacedEliasGama(2*origin + GetBit());
}


int GetBlockParams(int *resoff, int *reslen)
{
	int packed = 0;
	int length = 0;

	*resoff = 0;
	*reslen = 0;

	switch (compress_type)
	{
	case TYPLZM:
		packed = GetByte();	
		if (packed == 1 ) fprintf(stderr,"\nWarning in: False Zero packed! Length=0 && Packed bit=1\n");
		if (!packed) return 0; // End mark //
		length = packed >> 1;
		packed &= 0x01;
		break;
	case TYPLZE:
		packed = GetByte();	if (!packed) return 0; // End mark //
		length = packed & 0x3F;	if (packed & 0x80) length = (length << 8) | GetByte();
		packed &= 0x40;
		break;
	case TYPLZ_:
		// Dxxx xxxP
		packed = GetByte();	if (!packed) return 0; // End mark //
		length = (packed & 0x7E)>>1;	if (packed & 0x80) length = (length << 8) | GetByte();
		packed &= 0x01;
		break;
	case TYPBLK:
		length = GetEliasGama(0);	if (!length) return 0; // End mark //
		if (DBG > 1) printf(" - ");
		packed = !GetBit();	if (packed) length++;
		break;
	case TYPZX0:
		if (first_zx0_literal)
		{
			first_zx0_literal = 0;
			last_zx0_literal = 2; // unpacked
		} 
		else
		{
			if (last_zx0_literal < 2)
			{
				last_zx0_literal = GetBit();
				if (!last_zx0_literal) 
					last_zx0_literal = 2;
			}
			else 
			{
				last_zx0_literal = GetBit();
			}
		}
		if ( last_zx0_literal == 2 )
			length = GetInterlacedEliasGama(1);
		else
		{
			length = 0;
			packed = 1;
		}
		
		if (DBG>2)
			printf("\nnew literal: %i\n",last_zx0_literal);
		break;
	case TYPZX7:
		length = 1;
		packed = !GetBit();
		if (packed) {length = GetEliasGama(0) + 1; if (length == 1) return 0;} // End mark //
		break;
	case TYPBS1:
		if(GetBit())
		{ // 1x
			if(GetBit())
			{ // 11x
				if(GetBit())
				{ // 111x
					if(GetBit())
					{ // 1111
						length = GetEliasGama(3);
						if (!length) return 0; // End mark //
					} 
					else
					{ // 1110
						packed = 1;
						length = GetEliasGama(2);
					}
				} 
				else
				{ // 110
					packed = 1;
					length = 3;
				}
			} 
			else
			{ // 10
				packed = 1;
				length = 2;
			}
		} 
		else
		{ // 0
			length = 1;
		}
		break;

	default:
		printf("\nError in %s: Unknown compression type %u\n", packed_name, compress_type);
		return 1;
	}

	*reslen = length;
	if (!packed) return 0;

	if (DBG > 1) printf(" - ");

	int width = 0;
	int offset = 0;

	switch (compress_posi)
	{
	case POSLZM:
		offset = GetByte();
		if (offset) break;
		printf("\nError in %s: Zero LZM offset. Index=%u Length=%u\n", packed_name, packed_index, length);
		return 1;
	case POSLZE:
		offset = GetByte();
		if (offset & 0x80) offset = ((offset & 0x7F) << 8) | GetByte();
		if (offset) break;
		printf("\nError in %s: Zero LZE offset. Index=%u Length=%u\n", packed_name, packed_index, length);
		return 1;
	case POSLZ_:
		// xxxx xxxxD negative offset		
		offset = GetByte();
		if (offset & 0x01) 
			offset = 0x8000 - (((offset >> 1) << 8) | GetByte());
		else
			offset = 128 - (offset >> 1);			
		if (offset) break;
		printf("\nError in %s: Zero LZ_ offset. Index=%u Length=%u\n", packed_name, packed_index, length);
		return 1;
	case POSOFD:
		offset = GetEliasGama(0);
		break;
	case POSOF1:
		offset = GetValue(offset1bits) + 1;
		break;
	case POSOF2:
		width = GetBit();
		offset = GetValue(width ? offset1bits : offset2bits) + 1;
		if (!width) offset += 1 << offset1bits;
		break;
	case POSOF4:
		width = GetBit() << 1;
		width |= GetBit();
		offset = GetValue(offset1bits * (width + 1));
		for (int adds = width; adds >= 0; adds--) offset += 1 << (adds * offset1bits);
		break;
	case POSZX0:
		// packed
		if ( last_zx0_literal == 0 ) // same offset
		{
			offset = last_zx0_offset;
			*reslen = GetInterlacedEliasGama(1);
			offset = last_zx0_offset;
		}
		else
		{
			offset = GetInterlacedEliasGama(0x00FE);
						
			offset++;
			offset &= 0xFF;
			
			if (!offset) // End mark //
			{
				*reslen = 0;
				*resoff = 0;
				break;
			}

			offset <<= 8;
			offset += GetByte();

			if (offset & 1)
				*reslen = 2;
			else
				*reslen = GetInterlacedEliasGama_no_first_check(1) + 1;
			
			offset >>= 1;
			offset ^= 0x7FFF;
			offset++;

			last_zx0_offset = offset;
		}
		break;
	default:
		printf("\nError in %s: Unknown offset coding %u\n", packed_name, compress_posi);
		return 1;
	}

	*resoff = offset;
	return 0;
}

void DisplayCompression()
{
	int z = 0;

	switch (compress_type)
	{
	case TYPLZM: printf("LZM"); break;
	case TYPLZE: printf("LZE"); break;
	case TYPLZ_: printf("LZ_"); break;
	case TYPZX0: printf("ZX0"); break;
	case TYPZX7: printf("ZX7"); break;
	case TYPBLK: printf("BLK"); break;
	case TYPBS1: printf("BS1"); break;
	default: printf("???");
	}

	putchar(' ');

	switch (compress_posi)
	{
	case POSLZM: z = printf("offset 1 byte"); break;
	case POSLZE: z = printf("offset 2 bytes"); break;
	case POSLZ_: z = printf("negative offset 2 bytes"); break;
	case POSOF4: z = printf("4 offs: %u %u %u %u", offset1bits, 2 * offset1bits, 3 * offset1bits, 4 * offset1bits); break;
	case POSOF1: z = printf("fixed offset %2u", offset1bits); break;
	case POSOF2: z = printf("two offsets %2u %u", offset1bits, offset2bits); break;
	case POSOFD: z = printf("elias-gama offset"); break;
	case POSZX0: z = printf("elias(hi(offset)+1)  lo(offset)"); break;
	default:	 z = printf("(unknown)");
	}
	printf(" %s ",          "..............................." + z);
}

int main(int number_of_params, char **parameters)
{
	if (number_of_params < 2)
	{
		puts(
			"\nUniversal LZ_ Lister and Depacker 01 based by\n"
			"\nBusy soft: Universal LZX Lister and Depacker 01\n\n"
			"  Use: Lz_List <options> file1 file2 ...\n\n"
			"Options:\n"
			" -l ........ write listing of pack model of file(s) to stdout (default option)\n"
			" -d ........ depack and write to output file with extension 'out' (or set by the -e)\n"
			" -u ........ the same as -d with removing compress info -tXX.. from output filename\n"
			" -e<ext> ... set extension for output files (default extension is 'out')\n\n"
			"You can use wildcards in filenames to list or depack more files together.\n"
		);
		exit(1);
	}

	char *extension = (char*)"out";
	char *prolog_name = NULL;
	int make_depack = 0;
	int number_of_files = 0;
	for(int param = 1; param < number_of_params; param++)
	{
		if (parameters[param][0] == '-')
		{
			char * xx = parameters[param] + 1;
			switch (*xx)
			{
			case 'L':
			case 'l':
				if (DBG) puts("Option -L found");
				make_depack = 0;
				break;
			case 'D':
			case 'd':
				if (DBG) puts("Option -D found");
				make_depack = 1;
				break;
			case 'U':
			case 'u':
				if (DBG) puts("Option -U found");
				make_depack = 2;
				break;
			case 'E':
			case 'e':
				extension = xx + 1;
				if (DBG) printf("Option -E set extension to %s\n", *extension ? extension : "(none)");
				break;
			case 'P':
			case 'p':
				prolog_name = xx + 1;
				if (DBG) printf("Option -P set extension to %s\n", *prolog_name ? prolog_name : "(none)");
				break;
			default:
				printf("Error: Invalid option %s\n", parameters[param]);
			}
			continue;
		}

		if (DBG || !make_depack) putchar('\n');
		number_of_files++;

		packed_name = parameters[param];
		strcpy(unpack_name,packed_name);
		int name_length = strlen(unpack_name);
		int end_of_name = name_length;
		if (end_of_name > 5)
		{
			char * dotpos = strrchr(unpack_name + end_of_name - 5,'.');
			if (dotpos) {*dotpos = 0; end_of_name = dotpos - unpack_name;}
		}

		////////////////////////////////////////////

		offset1bits = 0;
		offset2bits = 0;
		int stand1stbyte = 0;
		int offsetnumber = 0;

		int begin_type = end_of_name;
		int idx;
		for(idx = end_of_name - 1; idx > 0; idx--) if (packed_name[idx] == '-') break;
		if (!idx || idx > end_of_name - 4 || packed_name[idx + 1] != 't')
		{
			if      (name_length > 4 && !stricmp(packed_name + name_length - 4, ".lzm"))
			{
				compress_type = TYPLZM;
				compress_posi = POSLZM;
				if (DBG) puts("Compress type: LZM");
			}
			else if (name_length > 4 && !stricmp(packed_name + name_length - 4, ".lze"))
			{
				compress_type = TYPLZE;
				compress_posi = POSLZE;
				if (DBG) puts("Compress type: LZE");
			}
			else if (name_length > 4 && !stricmp(packed_name + name_length - 4, ".lz_"))
			{
				compress_type = TYPLZ_;
				compress_posi = POSLZ_;
				if (DBG) puts("Compress type: LZ_");
			}
			else if (name_length > 4 && !stricmp(packed_name + name_length - 4, ".zx0"))
			{
				compress_type = TYPZX0;
				compress_posi = POSZX0;
				if (DBG) puts("Compress type: ZX0");
			}
			else
			{
				printf("Cannot determine compress type for file %s\n", packed_name); continue;
			}
		}
		else
		{
			begin_type = idx;

			if (DBG)
			{
				printf("Compress type: ");
				for (int i = idx; i < end_of_name; i++) putchar(packed_name[i]);
				putchar('\n');
			}

			compress_type = packed_name[idx + 2] - '0';
			compress_posi = packed_name[idx + 3] - '0';

			stand1stbyte = StandaloneFirstByte();
			offsetnumber = GetNumberOffsets();

			if (stand1stbyte < 0) { printf("Unknown compress type %d for file %s\n", compress_type, packed_name); continue; }
			if (offsetnumber < 0) { printf("Unknown offset coding %d for file %s\n", compress_posi, packed_name); continue; }
			if (offsetnumber > 0)
			{
				if (idx < end_of_name - 5 && packed_name[idx + 4] == 'o') offset1bits = atoi(packed_name + idx + 5);
				if (!offset1bits) { printf("Cannot determine offset1 for file %s\n", packed_name); continue; }
				if (offsetnumber == 2)
				{
					for (idx += 6; idx < end_of_name; idx++) if (packed_name[idx] == 'o') break;

					if (DBG)
					{
						printf("Offset2 value: ");
						for (int i = idx; i < end_of_name; i++) putchar(packed_name[i]);
						putchar('\n');
					}

					if (idx < end_of_name - 1) offset2bits = atoi(packed_name + idx + 1);
					if (!offset2bits) { printf("Cannot determine offset2 for file %s\n", packed_name); continue; }
				}
			}
		}

		////////////////////////////////////////////

		if (make_depack == 2) end_of_name = begin_type;
		unpack_name[end_of_name] = '.';
		strcpy(unpack_name + end_of_name + 1, extension);

		if (DBG)
		{
			printf("Mode: %u  Extension: %s  Prolog file: %s  Output file: %s\n", make_depack, extension, (prolog_name)?prolog_name:"(none)",unpack_name);
			DisplayCompression();
			printf("Com:%u  Pos:%u  Off1:%u  Off2:%u  %s\n\n",
				compress_type, compress_posi, offset1bits, offset2bits, packed_name);
		}

		FILE *prolog_file = NULL;
		int prolog_size = 0;
		if (prolog_name)
		{
			prolog_file = fopen(prolog_name,"rb"); if (!prolog_file) {perror(prolog_name);continue;}
			prolog_size = fread(unpack_data,1,MAXLEN,prolog_file);
			fclose(prolog_file);
		}
		
		FILE *packed_file = fopen(packed_name,"rb"); if (!packed_file) {perror(packed_name);continue;}
		int packed_size = fread(packed_data,1,MAXLEN,packed_file);
		fclose(packed_file);
		
		if (!make_depack)
		{
			printf(
				"List of file ... %s  (%u bytes)\n"
				"Compression .... ",
				packed_name, packed_size);
			DisplayCompression();
			puts("\n");
		}

		bits = 0x80;
		first_zx0_literal=1;
		last_zx0_offset=1;
		overhead = 0;
		packed_index = 0;
		unpack_index = prolog_size;

		int packed_count = 0;
		int unpack_count = 0;
		
		if (DBG>1)
		{
			printf("packed_index:%+6d\n",packed_index);
			printf("unpack_index:%+6d\n",unpack_index);
		}
		
		if (stand1stbyte)
		{
			if (!make_depack)
				printf("Pack:%+6d   Unpack:%+6d  ...  First byte 0x%02X\n",
					packed_index, unpack_index, *packed_data);

			unpack_data[unpack_index++] = packed_data[packed_index++];
		}

		show_length = 0;
		show_packed = 0;
		show_unpack = 0;

		int err = 0;
		int numsek = 0;
		int offset,length;
		int blok_packed = 0;
		int blok_unpack = 0;
		while(packed_index < packed_size)
		{
			blok_packed = packed_index;
			blok_unpack = unpack_index;

			if (GetBlockParams( & offset, & length)) {err++; break; }
			if (DBG > 1) putchar('\n');
			if (!length)
			{
				if (DBG || !make_depack)
				{
					ShowUnpacked();
					printf("Pack:%+6d   Unpack:%+6d  ...  End mark\n", blok_packed, blok_unpack);
				}
				break;
			}
			if (length + unpack_index > MAXLEN) { printf("\nError in %s at +%u: Unpack %u + length %u > buffer %u\n",
						packed_name, packed_index, unpack_index, length, MAXLEN); err++; break; }

			if (offset)
			{
				if (DBG || !make_depack)
				{
					ShowUnpacked();
					printf("Pack:%+6d   Unpack:%+6d  ...  Sekvence ... Length: %-5u  Offset: %-5u \n",
						blok_packed, blok_unpack, length, offset);
				}

				if (unpack_index < offset)
				{
					printf("\nError in %s at +%u: Unpack %u - offset %u < 0\n",
						packed_name, packed_index, unpack_index, offset); err++;
					break;
				}

				if (make_depack)
					for (int i = 0; i < length; i++)
						unpack_data[unpack_index + i] = unpack_data[unpack_index - offset + i];

				unpack_index += length;
				packed_count += length;
				numsek++;
				show_length = 0;
			}
			else
			{
				if (!show_length)
				{
					show_packed = blok_packed;
					show_unpack = blok_unpack;
					if (DBG) printf("Set unpack block addresses: Pack: +%u  Unpack: +%u\n", show_packed, show_unpack);
				}

				if (DBG)
				{
					int i;
					printf("Pack:%+6d   Unpack:%+6d  ...  TempBlok ... Length: %-5u    Data: ", blok_packed, blok_unpack, length);
					for (i = 0; (i < length) && (i < 16) && (i + packed_index < packed_size); i++) printf(" %02X", packed_data[packed_index + i]);
					if (i < length) printf(" ...");
					putchar('\n');
				}

				if (length + packed_index > packed_size)
				{
					printf("\nError in %s at +%u: Source index + length %u > size %u\n",
						packed_name, packed_index, length, packed_size); err++;
					break;
				}

				if (make_depack || show_length < 16)
					memcpy(unpack_data + unpack_index, packed_data + packed_index, length);

				unpack_index += length;
				packed_index += length;
				unpack_count += length;
				show_length += length;
			}
		}
		if (err) continue;
		if (DBG || !make_depack) putchar('\n');

		printf("%-32s \n\t%5u => %-5u  NumSek: %-4u  Packed: %-5u  NoPack: %-5u  Overhead: %-5u (%u bits)\n",
			packed_name, packed_index, unpack_index, numsek, packed_count, unpack_count, (overhead + 7) >> 3, overhead);

		if (make_depack)
		{
			FILE *unpack_file = fopen(unpack_name, "wb"); if (!unpack_file) { perror(unpack_name); continue; }
			if ((unsigned int) unpack_index-prolog_size != fwrite(unpack_data+prolog_size, 1, unpack_index-prolog_size, unpack_file)) printf("Can't write %s\n", unpack_name);
			fclose(unpack_file);
		}

		if (DBG || !make_depack) putchar('\n');
	}
	if (!number_of_files) puts("Error: No input files");
	return 0;
}

void ShowUnpacked(void)
{
	if (show_length)
	{
		int i;
		printf("Pack:%+6d   Unpack:%+6d  ...  Unpacked ... Length: %-5u      Data: ", show_packed, show_unpack, show_length);
		for (i = 0; i < show_length && i < 16; i++) printf(" %02X", unpack_data[show_unpack + i]);
		if (i < show_length) printf(" ...");
		putchar('\n');
		show_length = 0;
	}
}
