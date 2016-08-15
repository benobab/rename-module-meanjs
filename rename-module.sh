var=$1
if [ -n "$var" ]; then
    CRUDNAME=$1
    CRUDNAMEUPPERCASE=`echo ${CRUDNAME:0:1} | tr  '[a-z]' '[A-Z]'`${CRUDNAME:1}
    FOLDERNAME=$CRUDNAME's'
    # Create new folder
    cp -R modules/articles modules/$FOLDERNAME
    # Do the find/replace in all the files
    find modules/$FOLDERNAME -type f -print0 | xargs -0 sed -i -e 's/Article/'$CRUDNAMEUPPERCASE'/g'
    find modules/$FOLDERNAME -type f -print0 | xargs -0 sed -i -e 's/article/'$CRUDNAME'/g'
    # Delete useless files due to sed
    rm modules/$FOLDERNAME/**/*-e
    rm modules/$FOLDERNAME/**/**/*-e
    rm modules/$FOLDERNAME/**/**/**/*-e
    # Rename all the files
    for file in modules/$FOLDERNAME/**/*article* ; do mv $file ${file//article/$CRUDNAME} ; done
    for file in modules/$FOLDERNAME/**/**/*article* ; do mv $file ${file//article/$CRUDNAME} ; done
    for file in modules/$FOLDERNAME/**/**/**/*article* ; do mv $file ${file//article/$CRUDNAME} ; done
else
    echo "Usage: sh rename-module.sh [crud-name]"
fi