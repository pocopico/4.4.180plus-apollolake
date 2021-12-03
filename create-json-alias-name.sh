function createjsonfrommods(){


echo "{"
echo "\"modules\" : [" 

for module in `ls *.ko`
do
echo "{"
	if [ `modinfo ./$module --field alias |grep -ie pci -ie usb | wc -l` -ge 1 ] ; then 
	echo "\"name\" : \"${module}\","
	modinfo ./$module --field alias |grep -ie pci -ie usb | awk '{ print "\"alias\" : \"" $1 "\" ,"}' | sed '$ s/,//'
	else
	echo "\"name\" : \"${module}\""
	fi

echo "},"
done |  sed '$ s/,//'

echo "]"
echo "}"

}

createjsonfrommods > modules.alias.json
