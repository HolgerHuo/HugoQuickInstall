    cd $DocsRoot\$TITLE\public
	hugo 		# building public version
	
	git add -A								# push
	git commit -m "Uploaded @ $(Get-Date)"
	git pull origin master
	git push -u origin master