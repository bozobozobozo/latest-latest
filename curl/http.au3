$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("GET", "http://beamtic.com/", False)

$oHTTP.Send()
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status

If $oStatusCode == 200 then
 $file = FileOpen("Received.html", 2) ; The value of 2 overwrites the file if it already exists
 FileWrite($file, $oReceived)
 FileClose($file)
EndIf