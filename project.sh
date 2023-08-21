#!/bin/bash

echo "Does the dictionary.txt file exist or not? (Yes (Y,y), No (N,n))"
read answer

if [[ "$answer" =~ ^[Yy]$ ]] || [[ "$answer" =~ ^[Yy][Ee][Ss]$ ]]; then
    echo "Please enter the path of the dictionary file..."
    read filename
    if [ "$filename" = "dictionary.txt" ]; then
        echo "The file opened successfully"
        cat dictionary.txt
    else
        echo "File does not exist or is not named dictionary.txt"
    fi
fi

echo "____________________________________"
echo " please choose one of the options below"
echo "-c- compress a file "
echo "-d- decompress a file"
echo "-q- Exit from the programming"

read choice
if [ "$choice" = "c" ]; then
    echo "Please enter the path of the file to be compressed"
    read pathC
    cat "$pathC" | tr ' ' '\n' | sed -E 's/([[:alnum:]]+|[[:punct:]])/\1\n/g' | tr ' ' 's' | sed 's/ /Space/' > comp.txt
    while IFS= read -r line; do 
        echo "$line"
        if [ "$(grep "$line" dictionary.txt | cut -d' ' -f1)" ]; then
            grep "$line" dictionary.txt | cut -d' ' -f1 >> compressed.txt
        elif [ $line == " " ]; then
            echo "sondos"
        fi
    done < comp.txt
fi

#!/bin/bash

if [ "$choice" = "d" ]; then
    echo "Please enter the path of the file to be decompressed:"
    read pathCd
    
    # Clear the existing content of decompressed.txt before writing new data
    > decompressed.txt
    
    # Assuming "compressed.txt" contains the compressed text and "dictionary.txt" contains the dictionary
    while IFS= read -r line2; do
        # Using grep to find corresponding entries in the dictionary and checking if they match
        if grep -q "$line2" compressed.txt && grep -q "$(echo "$line2" | cut -d' ' -f1)" dictionary.txt; then
            word=$(grep "$(echo "$line2" | cut -d' ' -f1)" dictionary.txt | cut -d' ' -f2 | sed 's/Space/''/g' | sed 's/\\n/\n/g') 
            echo -n "$word " >> decompressed.txt
        fi
    done < "$pathCd"
fi

    
    
    
    

