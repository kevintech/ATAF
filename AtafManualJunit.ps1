#Cleardown the folders
del C:\Selenium\Results\XML\*.htm
del C:\Selenium\Results\HTML\*.htm
del C:\Selenium\Results\ScreenShot\*.htm
del C:\Selenium\Scripts\*.htm

#Set JSON object from web service
$specObject = Invoke-WebRequest -Uri https://apex1uk.revion.com/pls/apex/selenium.suite.json/100$102 | ConvertFrom-Json

#Loop through specifications
foreach($obj in $specObject.items)
{
 #Set variables
 $testSpecId = $obj.test_spec_id
 $specFileName = "C:\Selenium\Scripts\Selenium-Suite-" + $obj.test_spec_id + ".htm"
 $caseFileName = "C:\Selenium\Scripts\" + $obj.test_spec + ".htm"

 #Download the html suite containing a single specification
 $theSpecURL = "https://apex1uk.revion.com/pls/apex/f?p=108:10:::NO:10:TEST_SPEC_ID,SELENIUM_KEY:" + $testSpecId + ",58703752098d7092a5a986709t34D8h764f510"
 
 #Download the html Case file containing all the cases in the single specification  
 $theCaseURL = "https://apex1uk.revion.com/pls/apex/f?p=108:9:::NO:9:TEST_SPEC_ID,DOMAIN,SELENIUM_KEY:" + $testSpecId + ",apex1uk.revion.com,58703752098d7092a5a986709t34D8h764f510"
 
 wget $theSpecURL -OutFile $specFileName
 wget $theCaseURL -OutFile $caseFileName
 
 java -jar selenese-runner.jar --config C:\Selenium\Server\config.txt $specFileName
}