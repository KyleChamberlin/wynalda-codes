#include "wynaldaFunc.au3"

if $CmdLine[0] <> "" then
	$wynaldaFile = $CmdLine[1]
else
	$wynaldaFile = FileOpenDialog("Wynalda Code File","\\kciapp1\data\job lists\","All (*.*)|CSV or TXT (*.csv;*.txt)")
EndIf

$jobnumber = promptForValue("Please enter the Job Number:", "123456", "\\kcimail2\inkjet", "Job Number already exists, please try again", "jobNumberExistsIn", 0)

$outfilepath = "\\kcimail2\inkjet\" & StringRight($jobnumber,5) & ".1UP"

$spoilfilepath = "\\kcimail2\inkjet\" & StringRight($jobnumber,5) & "SP.1UP"

$totalCodes = _FileCountLines( $wynaldafile )

$toPrint = promptForValue("How many of the " & $totalcodes & " would you like to put in the file?", $totalcodes - 2500, $totalcodes - 2500, "Invalid entry, please try again.")
$toPrint = int($toPrint)

$toSpoil = promptForValue("How many of the " & ($totalcodes - $toPrint) & " would you like to put in the file?", 2500, ($totalcodes - $toPrint), "Invalid entry, please try again.")
$toSpoil = int($toSpoil)

$breakcount = promptForValue("How often should breaks appear in the file?", "8000", "", "Invalid entry, please try again.")
$breakcount = int($breakcount)

writeCodesToInkjetFile($wynaldaFile, $outfilepath, 1, $toPrint, $breakcount)
writeCodesToInkjetFile($wynaldaFile, $spoilfilepath, $toPrint + 1, $toSpoil, $breakcount)

FileMove($wynaldafile,"\\kciapp1\DATA\LISTS\Wynalda\USED_CODES\" & $jobnumber & "_" & getFileNameWithExtension($wynaldaFile))

$qc = QCReport("\\kciapp1\DATA\LISTS\Wynalda\USED_CODES\", $jobnumber, getFileNameWithExtension($wynaldaFile), $totalCodes, getFileNameWithExtension($outfilepath), $toPrint, getFileNameWithExtension($spoilfilepath), $toSpoil, $breakcount)

Run("notepad.exe " & $qc)