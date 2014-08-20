#Region Includes
#include <micro/micro.au3>
#include <../wynaldaFunc.au3>
#EndRegion

#Region Testing Local Variables
$filePath = @TempDir & "\myfile.txt"
$inputFile = "data\testData.txt"
$inkjetFile = @TempDir & "\testInkjetFile.1UP"
$firstCode = 1
$lastCode = 100
$breakPoint = 10
#EndRegion

#Region Test Suite
$testSuite = newTestSuite("Wynalda 1UP Code File Generation Program - Test Suite")

$testSuite.addTest(fileNameExtractedFromFullPathIncludesExtensionAndExcludesPath())
$testSuite.addTest(isValidValueTest())
$testSuite.addTest(inkjetFileHasLastCodeMinusFirstCodePlusOneTimesTwoLines())
$testSuite.addTest(inkjetFileContainsSameCodesAsSourceFile())
$testSuite.addTest(evenNumberedLinesThatAreNotBreaksAreBlank())
$testSuite.addTest(evenNumberedLinesThatAreBreaksAreStars())
$testSuite.addTest(whenJobNumberDoesNotExistReturnFalse())
$testSuite.addTest(whenJobNumberExistsReturnTrue())
$testSuite.finish()
#EndRegion

#Region Setup and Teard Down
Func setUp()
	FileOpen($filePath, 8)
    createEmptyInkjetFileForJob("12345")
	writeCodesToInkjetFile($inputFile, $inkjetFile, $firstCode, $lastCode, $breakPoint)
EndFunc   ;==>setUp

Func tearDown()
	FileDelete($filePath)
	FileDelete($inkjetFile)
	FileDelete(@TempDir & "\12345.1up")
EndFunc   ;==>tearDown
#EndRegion

#Region Tests
Func isValidValueTest()
    $test = newTest("isValidValue() preforms as expected")
	$test.assertTrue("provided value zero", isValidValue(0, 100))
	$test.assertTrue("provided value exactly highest possible", isValidValue(100, 100))
	$test.assertTrue("provided value valid value", isValidValue(50, 100))
	$test.assertFalse("provided value negative", isValidValue(-5, 100))
	$test.assertFalse("provided value too big", isValidValue(200, 100))
    Return $test
EndFunc

Func whenJobNumberDoesNotExistReturnFalse()
	setUp()

	$test = newTest("When Job Number Does Not Exist JobNumberExistsIn() Returns False")
	$test.assertFalse("5 digit job number", jobNumberExistsIn("12346", @TempDir))
	$test.assertFalse("6 digit job number", jobNumberExistsIn("123456", @TempDir))

	tearDown()

	Return $test
EndFunc   ;==>whenJobNumberDoesNotExistReturnFalse

Func whenJobNumberExistsReturnTrue()
	setUp()

	$test = newTest("When Job Number Does Exist JobNumberExistsIn() Returns True")
	$test.assertTrue("5 digit job number", jobNumberExistsIn("12345", @TempDir))
	$test.assertTrue("6 digit job number", jobNumberExistsIn("012345", @TempDir))

	tearDown()

	Return $test
EndFunc   ;==>whenJobNumberExistsReturnTrue

Func inkjetFileContainsSameCodesAsSourceFile()
	setUp()

	$test = newTest("Inkjet File Contains Same Codes As Source File")
	$test.assertEquals("First Codes Match", FileReadLine($inputFile, 1), FileReadLine($inkjetFile, 1))
    $test.assertEquals("Second Codes Match", FileReadLine($inputFile, 2), FileReadLine($inkjetFile, 3))
    $test.assertEquals("Third Codes Match", FileReadLine($inputFile, 3), FileReadLine($inkjetFile, 5))
    $test.assertEquals("100th Codes Match", FileReadLine($inputFile, 100), FileReadLine($inkjetFile, 199))

	tearDown()

	Return $test
EndFunc   ;==>inkjetFileContainsSameCodesAsSourceFile

Func inkjetFileHasLastCodeMinusFirstCodePlusOneTimesTwoLines()
	setUp()

	$test = newTest("Inkjet File Has ($lastCode - $firstCode + 1) * 2 lines")
	$test.assertEquals("(100 - 1 + 1) * 2 = 200", ($lastCode - $firstCode + 1) * 2, _FileCountLines($inkjetFile))

	tearDown()

	Return $test
EndFunc   ;==>inkjetFileContainsSameCodesAsSourceFile

Func evenNumberedLinesThatAreNotBreaksAreBlank()
    setUp()

    $test = newTest("Even Numbered Lines That Are Not Breaks Are Blank")
    $test.assertEquals("Second Line is Blank", "", FileReadLine($inkjetFile, 2))
    $test.assertEquals("fourth Line is Blank", "", FileReadLine($inkjetFile, 4))
    $test.assertNotEquals("$breakPoint * 2 Line is not Blank", "", FileReadLine($inkjetFile, $breakPoint * 2))

    tearDown()

    Return $test
EndFunc

Func evenNumberedLinesThatAreBreaksAreStars()
    setUp()

    $test = newTest("Even Numbered Lines That Are Not Breaks Are Blank")
	$test.assertEquals("line $breakPoint * 2 is *'s", "********", FileReadLine($inkjetFile, $breakPoint * 2))
	$test.assertEquals("line $breakPoint * 4 is *'s", "********", FileReadLine($inkjetFile, $breakPoint * 4))

    tearDown()

    Return $test
EndFunc

Func fileNameExtractedFromFullPathIncludesExtensionAndExcludesPath()
	$test = newTest("File Name Extracted From Full Path Includes Extension and Excludes Path")
	$test.assertEquals("simple file", getFileNameWithExtension($filePath), "myfile.txt")
	Return $test
EndFunc
#EndRegion

#Region Helper Functions
Func createEmptyInkjetFileForJob($string)
    _FileCreate(@TempDir & "\" & $string & ".1up")
EndFunc
#EndRegion