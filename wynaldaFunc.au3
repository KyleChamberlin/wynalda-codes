#include "string.au3"
#include "Array.au3"
#include "File.au3"

Func getFileNameWithExtension($file)
	dim $drive, $dir, $filename, $ext
	_PathSplit($file,$drive, $dir, $filename, $ext)
	Return $filename & $ext
EndFunc

Func isValidValue($value, $limit)
	if ( $limit = "" ) Then
		$limit = 99999999999
	EndIf
	if ( $value < 0 OR $value > $limit ) then
		return False
	EndIf
	return true
EndFunc

Func writeCodesToInkjetFile($inputFile, $inkjetFile, $firstCode, $lastCode, $breakPoint)
	local $codes = FileReadToArray($inputFile)
	dim $fileArray[ ($lastCode * 2) + 1 ]
	For $counter = 0 to $lastCode - $firstCode Step 1
		ConsoleWrite( ($counter + $firstCode) & @CRLF)
		$fileArray[ 2 * $counter ] = $codes[ $counter + $firstCode - 1 ]
		if (mod( $counter + 1, $breakpoint ) = 0 AND $counter <> 0) then
			$fileArray[ (2 * $counter + 1) ] = "********"
		Else
			$fileArray[ (2 * $counter + 1) ] = ""
		EndIf
	next
	_FileWriteFromArray($inkjetFile,$fileArray)
EndFunc

Func jobNumberExistsIn($JobNumber, $Folder)
	$path = $Folder & "\" & StringRight($JobNumber,5) & ".1up"
	Return FileExists( $path )
EndFunc

Func promptForValue( $prompt, $default, $max, $reprompt, $validationFunction = "isValidValue", $validationValue = 1)
	Do
		$value = InputBox("Wynalda Codes", $prompt, $default)
		if (@error = 1) then
			Exit
		EndIf
		$prompt = $reprompt
		$isValid = Call($validationFunction, $value, $max)
	Until $isValid = $validationValue

	return $value
EndFunc

Func QCReport($path, $jobnumber, $originalFile, $totalCodes, $inkjetFile, $inkjetCodes, $spoilageFile, $spoilageCodes, $breakPoint)
	$reportpath = $path & "\"& $jobnumber & "_QC.txt"
	$report = FileOpen($reportpath, 10)
	FileWriteLine($report,$jobnumber & " - Wynalda Codes Inkjet File Info")
	FileWriteLine($report,"Original Code File: " & $originalFile)
	FileWriteLine($report,"Original Number of Codes: "& $totalCodes)
	FileWriteLine($report,"")
	FileWriteLine($report,"Two line files with breaks every " & $breakcount & " codes:")
	FileWriteLine($report,"")
	FileWriteLine($report,"Inkjet File: " & $inkjetFile)
	FileWriteLine($report,"Contains: " & $inkjetCodes& " codes")
	FileWriteLine($report,"")
	FileWriteLine($report,"Spoilage File: " & $spoilageFile)
	FileWriteLine($report,"Contains: "& $spoilageCodes & " Spoilage codes")
	FileWriteLine($report,"")
	FileClose($report)

	return $reportpath
EndFunc

