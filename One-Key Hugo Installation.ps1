Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install git -y  # Install dependencies


$DocsRoot = Read-Host -Prompt "Where do you want to store your Blogs? (e.g. F:\Documents\Blog)"	
cd $DocsRoot
$TITLE = Read-Host -Prompt "What's your websites name? (e.g. XX's Blog)"


	function Set-EnvironmentVariable                 # Set permanent env. variable for further use like one-key push
{
    param
    (
        [string]
        [Parameter(Mandatory)]
        $Name,

        [string]
        [AllowEmptyString()]
        [Parameter(Mandatory)]
        $Value,

        [System.EnvironmentVariableTarget]
        [Parameter(Mandatory)]
        $Target
    )

    [Environment]::SetEnvironmentVariable($Name, $Value, $Target)
}


Set-EnvironmentVariable -Name DocsRoot -Value $DocsRoot -Target User  # Set default docs root.
Set-EnvironmentVariable -Name TITLE -Value $TITLE -Target User  # Set default docs root.

choco install hugo -y     	 	# Install hugo.
hugo new site $env:TITLE 			  # Bulding site	

cd $env:TITLE\themes							 # Building  themes
$ThemeURL = Read-Host -Prompt "Choose a theme from 'https://themes.gohugo.io/' and paste the git URL here. (e.g. https://github.com/liuzc/LeaveIt.git)"

git clone $ThemeURL

echo "Configuring your site." 				# Server Configuring
cd $env:DocsRoot\$env:TITLE

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/HolgerHuo/HugoQuickInstall/master/config.toml" -OutFile config.toml			# Download Template Configuration File.

$DOMAIN = Read-Host -Prompt "What's your domain? (e.g. www.example.com)"
(Get-Content config.toml) -replace 'Domain',$DOMAIN|out-file config.toml -encoding ASCII


(Get-Content config.toml) -replace 'SiteName',$env:TITLE|out-file config.toml -encoding ASCII

$LOCALE = Read-Host -Prompt "What's your language? (e.g. en-US)"
(Get-Content config.toml) -replace 'LocaleInfo',$LOCALE|out-file config.toml -encoding ASCII

$THEMEID = Read-Host -Prompt "What's your theme? (e.g. LeaveIt)"
(Get-Content config.toml) -replace 'ThemeID',$THEMEID|out-file config.toml -encoding ASCII

$PAGES = Read-Host -Prompt "How many posts would you like to show on your homepage? (e.g. 5)"
(Get-Content config.toml) -replace 'PagesNumber',$PAGES|out-file config.toml -encoding ASCII

$GAID = Read-Host -Prompt "Insert your Google Analytics ID here or leave it blank. "
(Get-Content config.toml) -replace 'GAID',$GAID|out-file config.toml -encoding ASCII

$AN = Read-Host -Prompt "What's the author's name? (e.g. Holger)"
(Get-Content config.toml) -replace 'AUTHORNAME',$AN|out-file config.toml -encoding ASCII

$AA = Read-Host -Prompt "Insert the Avatar's URL (e.g. /pics/avatar.jpg)"
(Get-Content config.toml) -replace 'AUTHORPIC',$AA|out-file config.toml -encoding ASCII 

$ST = Read-Host -Prompt "Give a slogan or subtitle. (e.g. My special place.)"
(Get-Content config.toml) -replace 'SLOGAN',$ST|out-file config.toml -encoding ASCII

$YN = Read-Host -Prompt "The websites run since ? (e.g. 2019)"
(Get-Content config.toml) -replace 'SINCEYEAR',$YN|out-file config.toml -encoding ASCII

$CCID = Read-Host -Prompt "Which license would you like to choose for your articles? (Check it out at https://creativecommons.org/)"
(Get-Content config.toml) -replace 'LICENSENAME',$CCID|out-file config.toml -encoding ASCII

$CCURL = Read-Host -Prompt "The link for the license (e.g. https://creativecommons.org/licenses/by-nd/4.0/)"
(Get-Content config.toml) -replace 'LICENSEURL',$CCURL|out-file config.toml -encoding ASCII

$GH = Read-Host -Prompt "What's the GitHub URL? You may leave it blank"
(Get-Content config.toml) -replace 'GHID',$GH|out-file config.toml -encoding ASCII

$TT = Read-Host -Prompt "What's the Twitter URL? You may leave it blank"
(Get-Content config.toml) -replace 'TTID',$TT|out-file config.toml -encoding ASCII

$EMA = Read-Host -Prompt "What's the Email Address? You may leave it blank"
(Get-Content config.toml) -replace 'EMAD',$EMA|out-file config.toml -encoding ASCII

$INS = Read-Host -Prompt "What's the INS URL? You may leave it blank"
(Get-Content config.toml) -replace 'INSID',$INS|out-file config.toml -encoding ASCII

$FB = Read-Host -Prompt "What's the Facebook URL? You may leave it blank"
(Get-Content config.toml) -replace 'FBID',$FB|out-file config.toml -encoding ASCII

$TG = Read-Host -Prompt "What's the Telegram URL? You may leave it blank"
(Get-Content config.toml) -replace 'TGID',$TG|out-file config.toml -encoding ASCII

$QRCode = Read-Host -Prompt "What's the WeChat QRCode URL? You may leave it blank"
(Get-Content config.toml) -replace 'QRCODEURL',$QRCode|out-file config.toml -encoding ASCII

hugo new about.md #create about page

hugo 		#building public version

	cd $env:DocsRoot\$env:TITLE\public
	$GITIO = Read-Host -Prompt "Insert your github git address. (e.g. https://github.com/HolgerHuo/HugoQuickInstall.git)" # adding github info
	git init                                                                 
	git remote add origin $GITIO
	git add -A
	git commit -m "Uploaded @ $(Get-Date)"
	git push -u origin master -f 
pause

