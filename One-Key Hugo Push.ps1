   cd $env:DocsRoot\$env:TITLE 
   hugo 		# building public version
	
cd public
	
	git add -A								# push
	git commit -m "Uploaded @ $(Get-Date)"
	git push -u origin master -f 
