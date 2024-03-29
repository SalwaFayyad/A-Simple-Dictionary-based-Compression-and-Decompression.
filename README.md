# A Simple Dictionary-based Compression and Decompression.
The ENCS3130 Linux Lab project using shell.
# Project Overview

In this project, the task is to implement a simple dictionary-based compression and decompression tool in shell scripting. This compression technique is lossless and relies on finding patterns in data. The tool operates with the following assumptions and specifications:

1. Each word in the uncompressed file is assigned a unique 16-bit binary code in the compressed file.
2. The code size is fixed at 16 bits, allowing encoding of up to 65,536 unique words.
3. The uncompressed file contains Unicode characters, with each character represented as 16 bits.
4. The compression/decompression tool utilizes a dictionary stored in a text file named "dictionary.txt".
5. The dictionary starts with binary codes ranging from 0x0000, and it is filled over time with new words encountered during compression operations.
6. The tool is case-sensitive, and special characters (e.g., spaces, punctuation) are treated as words.
7. Compression and decompression operations are triggered based on user input.

## Program Menu (Program usage flow):

1. Check if "dictionary.txt" file exists.
2. If the file exists, prompt the user to enter the file path and load the dictionary into the appropriate data structure. If not, create a new empty "dictionary.txt".
3. Ask the user whether they want to compress or decompress a file.
4. If compression is chosen:
   - Prompt the user to enter the path of the file to be compressed.
   - Read the file and compress it by substituting appropriate codes from the dictionary.
   - If a word is encountered that does not exist in the dictionary, append it to the dictionary and use its new code in the compression operation.
   - Compute the compression ratio and print it on the screen.
   - Write the compressed data to a compressed file.
   - Save changes to the dictionary.
5. If decompression is chosen:
   - Prompt the user to enter the path of the file to be decompressed.
   - If the file contains codes not found in the dictionary, display an appropriate error message.
   - Decompress the file by substituting correct words from the dictionary.
   - Write the decompressed data to an uncompressed file.
     
