   hugo 		# building public version
	
   cd $env:DocsRoot\$env:TITLE\public
	
	git add -A								# push
	git commit -m "Uploaded @ $(Get-Date)"
	git push -u origin master -f 
