    cd $env:DocsRoot\$env:TITLE\public
	hugo 		# building public version
	
	git add -A								# push
	git commit -m "Uploaded @ $(Get-Date)"
	git push -u origin master -f 