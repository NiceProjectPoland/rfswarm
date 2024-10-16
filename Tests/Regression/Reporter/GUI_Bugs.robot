*** Settings ***
Resource 	GUI_Common.robot
Library 	XML 	use_lxml=True

Test Teardown 	Close GUI

*** Test Cases ***
First Run
	[Tags]	ubuntu-latest 	macos-latest 	windows-latest 	Issue #147
	Log To Console 	${\n}TAGS: ${TEST TAGS}
	${testdata}= 	Set Variable    Issue-#147
	${resultdata}= 	Set Variable    20230320_185055_demo
	${basefolder}= 	Set Variable    ${CURDIR}${/}testdata${/}${testdata}
	Should Exist	${basefolder}
	Log to console 	basefolder: ${basefolder} 	console=True
	${resultfolder}= 	Set Variable    ${basefolder}${/}${resultdata}
	Should Exist	${resultfolder}
	Log 	resultfolder: ${resultfolder} 	console=True
	${epoch}=	Get Time	epoch
	Open GUI	-i 	blank_${epoch}.ini 	-d 	${resultfolder}
	# Run Keyword And Continue On Failure 	Wait For Status 	PreviewLoaded 	120
	Run Keyword And Continue On Failure 	Wait For Status 	PreviewLoaded
	# Close GUI

New Data Table Section
	[Tags]	ubuntu-latest 	macos-latest 	windows-latest 	Issue #149 	Issue #150
	Log To Console 	${\n}TAGS: ${TEST TAGS}
	Open GUI
	Wait For Status 	PreviewLoaded
	# Click Section			toc
	# This should click Report
	Click Section			Report
	# Click Text			toc 	0 	-20
	# Click To The Below Of Image 	reporter_${platform}_button_removesection.png 	20

	Take A Screenshot

	Click Button 			AddSection

	Click To The Below Of Image 	reporter_${platform}_label_sectionname.png 	20
	Type 	Issue #149
	Click Button 			OK
	Take A Screenshot
	Click Section			Issue#149

	Select Field With Label 	Type

	Select Option 	DataTable

	Run Keyword And Continue On Failure 	Wait For Status 	PreviewLoaded

	Select Field With Label 	ShowGraphColours

	Select Field With Label 	DataType

	Select Option 	Result

	Select Field With Label 	ResultType

	Select Option 	ResponseTime

	Run Keyword And Continue On Failure 	Wait For Status 	PreviewLoaded

	# click Generate HTML as partial regression test for Issue #150
	Click Button 	GenerateHTML

	# Wait For Status 	GeneratingXHTMLReport

	Wait For Status 	SavedXHTMLReport

	# Close GUI


Template with Start and End Dates
	[Tags]	ubuntu-latest 	macos-latest 	windows-latest 	Issue #250
	Log To Console 	${\n}TAGS: ${TEST TAGS}

	${testdata}=		Set Variable	Issue-#250
	${basefolder}=		Set Variable	${CURDIR}${/}testdata${/}${testdata}

	${resultdata0}=		Set Variable	20240626_130059_jpetstore-nomon-quick
	${resultfolder0}=	Set Variable	${basefolder}${/}${resultdata0}

	${resultdata1}=		Set Variable	20240626_130756_jpetstore-nomon-quick
	${resultfolder1}=	Set Variable	${basefolder}${/}${resultdata1}

	${templatename}=	Set Variable	Issue-#250
	${templatefolder}=	Set Variable	${OUTPUT DIR}${/}${templatename}${/}template_dir

	${testresultfolder0}=	Set Variable	${OUTPUT DIR}${/}${templatename}${/}${resultdata0}
	${testresultfolder1}=	Set Variable	${OUTPUT DIR}${/}${templatename}${/}${resultdata1}

	Change Reporter INI File Settings	templatedir		${templatefolder}
	Create Directory		${templatefolder}

	Log To Console 	${\n}TAGS: ${TEST TAGS}
	Log to console 	basefolder: ${basefolder} 	console=True
	Log 	resultfolder0: ${resultfolder0} 	console=True
	Log 	resultfolder1: ${resultfolder1} 	console=True
	Log To Console	Open Reporter with resultfolder0 and create template

	Open GUI	-d 	${resultfolder0}
	Wait For Status 	PreviewLoaded

	# change the start and end times
	Click Section			Report
	# Take A Screenshot

	Make Clipboard Not None
	${StartTime}= 	Get Text Value To Right Of 	StartTime
	${StartTime}= 	Replace String 	${StartTime} 	03:00 	03:01
	Set Text Value To Right Of 	StartTime 	${StartTime}

	${EndTime}= 	Get Text Value To Right Of 	EndTime
	${EndTime}= 	Replace String 	${EndTime} 	03:03 	03:02
	Set Text Value To Right Of 	EndTime 	${EndTime}

	Select Field With Label 	Title
	Wait For Status 	PreviewLoaded
	# Take A Screenshot


	# switch to preview tab

	Click Tab 	 Preview

	Click Section			TestResultSummary
	# Wait For Status 	PreviewLoaded
	# Take A Screenshot

	Click Button	savetemplate
	Save Template File OS DIALOG	${templatename}

	Click Button 	GenerateHTML
	Wait For Status 	SavedXHTMLReport

	Close GUI

	${html}= 	Parse XML 		${resultfolder0}${/}${resultdata0}.html
	${sectionid}= 		Get Element Attribute 	${html} 	id 	.//h1[text()='2 Test Result Summary']/..
	${table}= 		Get Element 	${html} 	.//div[@id='${sectionid}']//table
	${expected}= 	Get Elements Texts 	${table} 	tr/td[1]

	Copy Files 	${resultfolder0}/*.report 	${testresultfolder0}
	Copy Files 	${resultfolder0}/*.html 	${testresultfolder0}

	Log To Console	Open Reporter with resultfolder1 and check template works

	Open GUI	-d 	${resultfolder1}	-t 	${templatefolder}${/}${templatename}.template
	Wait For Status 	PreviewLoaded

	Click Button 	GenerateHTML
	Wait For Status 	SavedXHTMLReport

	Copy Files 	${resultfolder1}/*.report 	${testresultfolder1}
	Copy Files 	${resultfolder1}/*.html 	${testresultfolder1}

	${html}= 	Parse XML 		${resultfolder1}${/}${resultdata1}.html
	${sectionid}= 		Get Element Attribute 	${html} 	id 	.//h1[text()='2 Test Result Summary']/..
	${table}= 		Get Element 	${html} 	.//div[@id='${sectionid}']//table
	FOR 	${index}    ${item}    IN ENUMERATE    @{expected}
		${row}= 	Evaluate    ${index} + 2
		${txt}= 	Get Element Text 	${table} 	tr[${row}]/td[1]
		Should Be Equal As Strings    ${item}    ${txt}
	END

	Click Tab 	 Preview

	Click Section			TestResultSummary
	# Take A Screenshot
	Wait For 	reporter_${platform}_expected_testresultsummary.png 	 timeout=30
