#/bin/bash


##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
REPODIR="$REPO_ADO" ;
themeFile="$REPODIR/theme-adoria.css"
##
outDir_tmp="$DIR_Y/public-website" ; 
outDir_final="$REPODIR/public-website" ; 
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Running thumbsUp static photo album maker 
## (Get it from: https://thumbsup.github.io/docs/)
echo ">> Running thumbsup program ..." ; 
thumbsup --input "$REPODIR/drawings" --output "$outDir_tmp" --title "Personal Portfolio Of Adoria's Drawings" --large-size 1200 --sort-albums-by title --sort-albums-direction desc --theme classic --theme-style "$themeFile" ;

## Add logo to the main index page
echo ">>  Adding logo to the main index page ..." ; 
imageVar='<img src="https://adoria.xyz/media/small/0-Logos/Site-Logo-Transparent-1000Px-Lowres.png" style="align: center; width: 200px; ">' ;
##------------------------------------------------------------------------------
## RUN COMPUTER HOSTNAME SPECIFIC COMMANDS
HOSTNAME=$(uname -n) ;
echo ">> HOSTNAME IS = $HOSTNAME";
## Possible hostnames are: 
#### AP-MBP.local // LAPTOP-F0AJ6LBG // ubuntu1804-digitalocean-bangalore-droplet
if [ "$HOSTNAME" == "AP-MBP.local" ] ; then
    sed -i '' "s|<header>|<header>$imageVar<br>|g" $outDir_tmp/index.html ; 
else
    sed -i "s|<header>|<header>$imageVar<br>|g" $outDir_tmp/index.html ; 
fi
##------------------------------------------------------------------------------

## Sync the tmp and final directories
echo ">> Syncing the tmp and final directories // FROM $outDir_tmp => $outDir_final" ;
rsync -azq --delete $outDir_tmp/ $outDir_final/ ;
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
