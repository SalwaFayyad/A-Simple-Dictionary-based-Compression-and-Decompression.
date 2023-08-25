
#Salwa Fayyad 1200430 -- Sondos Ashraf 1200905
# to compress the file use textFile.txt
# to decompress the file use textFile2.txt
####################################################


flag=0
echo "Does the dictionary.txt file exist or not? (Yes (Y,y), No (N,n))"
read answer

if [[ "$answer" =~ ^[Yy]$ ]] || [[ "$answer" =~ ^[Yy][Ee][Ss]$ ]]; then 
    echo "Please enter the path of the dictionary file..."
    read filename
    if [ "$filename" = "dictionary.txt" ]; then
        echo "The file opened successfully"
        cat dictionary.txt
        fi
    else
        echo "File does not exist or is not named dictionary.txt"
    fi
    
    #########################################################################
  
if [[ "$answer" =~ ^[Nn]$ ]] || [[ "$answer" =~ ^[Nn][Oo]$ ]]; then

    touch dic.txt
    chmod +x dic.txt
    pico dic.txt
    mv dic.txt dictionary.txt
   

# to replace the space with word 'space' and set each word in single line with non characters 
	cat dictionary.txt | sed 's/ / Space /g' | tr ' ' '\n' | sed -E 's/([[:alnum:]]+|[[:punct:]])/\1\n/g' > tmp_dict.txt





    # delete the first line
    sed '1d' tmp_dict.txt | nl -w1 -s' ' - > dictionary.txt
    mv tmp_dict.txt dictionary.txt
    
    
    #delete empty lines
    grep -v '^$' dictionary.txt > empty.txt
    mv empty.txt dictionary.txt

    
    echo "\n " >> dictionary.txt
    
    
    touch tempfile.txt
    chmod +x tempfile.txt
    

    # to move the words without repeat in temp file then move it to dictionary file
while IFS= read -r lineno; do
    match_found=false
    while IFS= read -r temp_line; do
        if [ "$lineno" = "$temp_line" ]; then
            match_found=true
            break
        fi
    done < tempfile.txt
    
    if ! "$match_found" ; then
        echo "$lineno" >> tempfile.txt
    fi
	done < dictionary.txt


   
       mv tempfile.txt dictionary.txt
       
       
       line_number=0x0000
      
      # to add hexadecimal numbers for each line
       while IFS= read -r linenew; do
         hex_line_number=$(printf "0x%04X" $line_number)
        echo "$hex_line_number $linenew" >> tempnew.txt
        
	    ((line_number++))
	done < dictionary.txt    

	   mv tempnew.txt dictionary.txt
	   
fi


 ###########################################################################################
 sleep 2
 echo "Thank you for writing...  now dictionary file is exist :) "

while true; do
    

echo "______________________________________"
echo " please choose one of the options below"
echo "-c- compress a file "
echo "-d- decompress a file"
echo "-q- Exit from the programming"

read choice

if [ "$choice" = "c" ]; then
    echo "Please enter the path of the file to be compressed"
    read pathC
    cat "$pathC" | sed ':a;N;$!ba;s/\n/\\n /g' "$pathC" | tr ' ' '\n' | sed 's/\\n/newline/g' | sed -E 's/([[:alnum:]]+|[[:punct:]])/\1\n/g' > comp.txt
    sed -i '$d' comp.txt #remove the final line
    while IFS= read -r line; do
        #echo "$line"
       if [ $flag -eq 0 ] ; then 
          if [ "$(echo "$line" | grep 'newline')" ] ; then #for (\n)
           
           word1=$(echo "$line" | sed 's/.......$//')
           grep -w "$word1" dictionary.txt | cut -d' ' -f1 >> compressed.txt
           word2=$(echo "$line" | sed 's/.*\(.......$\)/\1/')
           grep '\\n' dictionary.txt | cut -d' ' -f1 >> compressed.txt
           flag=1
           continue;
          fi

        if [ -z "$line" ]; then # for space
          grep "Space" dictionary.txt | cut -d' ' -f1 >> compressed.txt
          
          continue
        fi
        if [ -n "$(grep "$line" dictionary.txt | cut -d' ' -f1)" ]; then #any word
           if echo "$line" | grep -q '[^[:alnum:]]';then #for non characters
           case "$line" 
            in
            "." ) grep '\.' dictionary.txt | cut -d' ' -f1 >> compressed.txt;;
            "\\") grep '\\' dictionary.txt | cut -d' ' -f1 >> compressed.txt;;
            "$" ) grep '\$' dictionary.txt | cut -d' ' -f1 >> compressed.txt;;
            "," ) grep ',' dictionary.txt | cut -d' ' -f1 >> compressed.txt;;
           esac
           else #for charachters
               grep -w "$line" dictionary.txt | cut -d' ' -f1 >> compressed.txt   
           fi
        else #if word not exsist
         hex_val=$(tail -n 1 dictionary.txt | cut -d' ' -f1)
         decimal_value=$(printf '%d' "$hex_val")
         decimal_value=$((decimal_value + 1))
         new_hex_value=$(printf '0x%04x' "$decimal_value") 
         concatenated="$new_hex_value"" $line"
         echo "$concatenated" >> dictionary.txt
         echo "$new_hex_value" >> compressed.txt
        fi
         else 
          flag=0
       fi
    done < comp.txt
    rm comp.txt
fi


#############################################################################################
if [ "$choice" = "d" ]; then
    echo "Please enter the path of the file to be decompressed:"
    read pathCd
    

    > decompressed.txt
    

    while IFS= read -r line2; do
    
       #to check if the line is exist in dictionary file to decompress
       
        if grep -q "$line2" "$pathCd" && grep -q "$(echo "$line2" | cut -d' ' -f1)" dictionary.txt; then
            word=$(grep "$(echo "$line2" | cut -d' ' -f1)" dictionary.txt | cut -d' ' -f2 | sed 's/Space/''/g' | sed 's/\\n/\n/g' )
            
            newLine=$(grep "$line2" dictionary.txt | cut -d' ' -f2)
            if [ $newLine == "\n" ];then
              echo "" >> decompressed.txt
            elif  [ -z "$word" ];then
            echo -n " " >> decompressed.txt
            else
            echo -n "$word" >> decompressed.txt
            fi
   
        
        else
         echo "word $line2 does not match in dictionary file :( "
        break
            echo " File Decompress was succssesfully done :) "
        fi
        
    done < "$pathCd"

fi



if [ "$choice" = "q" ];then
exit 1
fi 

done


    
    
    
    
