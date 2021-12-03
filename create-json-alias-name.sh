function createjsonfrommods(){


echo "{"
echo "\"modules\" : [" 

for module in `ls *.ko`
do
	if [ `modinfo ./$module --field alias |grep -ie pci -ie usb | wc -l` -ge 1 ] ; then 

	for alias in `modinfo ./$module --field alias |grep -ie pci -ie usb` 
        do
	echo "{"
	echo "\"name\" :  \"${module}\"",
	echo "\"alias\" :  \"${alias}\""
	echo "}",
	done
	fi
#	echo "},"

done |  sed '$ s/,//'

echo "]"
echo "}"

}

createjsonfrommods > modules.alias.json
