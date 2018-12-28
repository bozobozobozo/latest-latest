; The data to be sent
$sPD = 'name=Jacob&bench=150'


; Creating the object
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
;$oHTTP.Open("POST", "http://beamtic.com/Examples/http-post.php", False)
$oHTTP.Open("GET", "http://192.168.1.120/arduino/step^^", False)
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")

; Performing the Request
$oHTTP.Send($sPD)

; Download the body response if any, and get the server status response code.
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status

If $oStatusCode <> 200 then
 MsgBox(4096, "Response code", $oStatusCode)
EndIf

; Saves the body response regardless of the Response code
 $file = FileOpen("Received.html", 2) ; The value of 2 overwrites the file if it already exists
 FileWrite($file, $oReceived)
 FileClose($file)