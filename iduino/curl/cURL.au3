#include-once
#Region Header
#cs
	Title:   		cURL UDF Library for AutoIt3
	Filename:  		cURL.au3
	Description: 	A collection of functions for cURL - a tool for transferring data with URL syntax
	Author:   		seangriffin
	Version:  		V0.5
	Last Update: 	03/04/12
	Requirements: 	Windows 32-bit,
					AutoIt3 3.2 or higher,
					libcurl v7.24.0 or higher (libcurl.dll, libeay32.dll, libssl32.dll).
	Changelog:		---------03/04/12---------- v0.5
					Increase the maximum size of a URL to 65,536 characters.

					---------03/04/12---------- v0.4
					Added HTTP header support.

					---------30/03/12---------- v0.3
					Added a new function called "cURL_multi".

					---------13/02/12---------- v0.2
					Made $url the first parameter for cURL_easy().
					Replaced all cookie parameters with $cookie_action and $cookie_file.
					Added $output_type and $output_file parameters.

					---------11/02/12---------- v0.1
					Initial release.

#ce
#EndRegion Header
#Region Global Variables and Constants
Global Const $CURLOPTTYPE_LONG          	= 0
Global Const $CURLOPTTYPE_OBJECTPOINT   	= 10000
Global Const $CURLOPT_URL 					= 0x2712
Global Const $CURLOPT_WRITEDATA 			= 0x2711
Global Const $CURLOPT_WRITEFUNCTION 		= 0x4E2B
Global Const $CURLOPT_PROGRESSFUNCTION 		= 0x4E58
Global Const $CURLOPT_NOPROGRESS 			= 0x2B
Global Const $CURLOPT_ERRORBUFFER 			= 0x271A
Global Const $CURLOPT_TRANSFERTEXT 			= 0x35
Global Const $CURL_ERROR_SIZE 				= 0x100
Global Const $CURLOPT_SSL_VERIFYPEER 		= 0x40
Global Const $CURLOPT_COOKIEFILE 			= $CURLOPTTYPE_OBJECTPOINT +31
Global Const $CURLOPT_COOKIEJAR 			= $CURLOPTTYPE_OBJECTPOINT +82
Global Const $CURLOPT_FOLLOWLOCATION 		= $CURLOPTTYPE_LONG +52
Global Const $CURLOPT_POSTFIELDS 			= $CURLOPTTYPE_OBJECTPOINT + 15
Global Const $CURLOPT_POST 					= $CURLOPTTYPE_LONG +47
Global Const $CURLOPT_POSTFIELDSIZE 		= $CURLOPTTYPE_LONG +60
Global Const $CURLOPT_HTTPHEADER 			= $CURLOPTTYPE_OBJECTPOINT +23
Global $hDll_Libcurl
Global $pWriteFunc
Global $binary_output 						= 0
Global $curlout
#EndRegion Global Variables and Constants
#Region Core functions
; #FUNCTION# ;===============================================================================
;
; Name...........:	cURL_initialise()
; Description ...:	Initialises cURL.
; Syntax.........:	cURL_initialise()
; Parameters ....:
; Return values .:
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	Must be executed prior to any other cURL functions.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
func cURL_initialise()

	; Load and initialize curl
	$hDll_Libcurl = DllOpen("libcurl.dll")
	$pWriteFunc = DllCallbackRegister ("_WriteFunc", "uint", "ptr;uint;uint;ptr")
EndFunc

; #FUNCTION# ;===============================================================================
;
; Name...........:	cURL_easy()
; Description ...:	Executes a cURL easy-session on a URL and returns the downloaded data.
; Syntax.........:	cURL_easy($url, $cookie_file = "", $cookie_action = 0, $output_type = 0, $output_file = "", $postfields = "", $ssl_verifypeer = 0, $noprogress = 1, $followlocation = 0, $http_headers = "")
; Parameters ....:	$url			- the URL you are requesting.
;					$cookie_file	- Optional: The name of a cookie file to include with the request.
;										"" = do not include a cookie
;					$cookie_action	- Optional: The actions to perform with $cookie.
;										0 = do nothing
;										1 = read the cookie
;										2 = write to the cookie
;										4 = delete the cookie, if it exists, before writing
;					$output_type	- Optional: the type of output for the HTTP response.
;										0 = output as text
;										1 = output as binary
;					$output_file	- Optional: the name of a file to output to.
;					$postfields		- the full data to post in an HTTP POST operation.
;										"" = do not post data
;					$ssl_verifypeer	- Optional: determines whether the authenticity of the peer's certificate is verified.
;										1 = verify
;										0 = do not verify
;					$noprogress		- Optional: output the cURL progress meter?
;										1 = no progress meter
;										0 = progress meter
;					$followlocation	- Optional: follow any Location: header the server sends as part of an HTTP header?
;										0 = don't follow the location header
;										1 = follow the location header
;					$http_headers	- Optional: a comma-separated list of HTTP headers
;										"" = do not send any headers
; Return values .: 	On Success			- Returns the HTTP response data.
;                 	On Failure			- Returns nothing.
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	A prerequisite is that cURL_initialise() has been executed.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
func cURL_easy($url, $cookie_file = "", $cookie_action = 0, $output_type = 0, $output_file = "", $postfields = "", $ssl_verifypeer = 0, $noprogress = 1, $followlocation = 0, $http_headers = "")

	; curl_easy_init

	$hCurlHandle = DllCall($hDll_LibCurl, "ptr:cdecl", "curl_easy_init")
	$hCurlHandle = $hCurlHandle[0]

	; curl_easy_setopt

	$binary_output = $output_type

	if $cookie_action > 0 Then

		$cookie_struct = DllStructCreate("char[256]")
		DllStructSetData($cookie_struct, 1, $cookie_file)

		if $cookie_action = 4 or $cookie_action = 6 or $cookie_action = 7 Then

			FileDelete($cookie_file)
		EndIf

		; if read cookie action
		if $cookie_action = 1 or $cookie_action = 3 or $cookie_action = 7 Then

			DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_COOKIEFILE, "ptr", DllStructGetPtr($cookie_struct))
		EndIf

		; if write cookie action
		if $cookie_action = 2 or $cookie_action = 3 or $cookie_action = 6 Then

			DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_COOKIEJAR, "ptr", DllStructGetPtr($cookie_struct))
		EndIf
	EndIf

	if StringLen($postfields) > 0 Then

		$postfields_struct = DllStructCreate("char[256]")
		DllStructSetData($postfields_struct, 1, $postfields)
		DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_POSTFIELDS, "ptr", DllStructGetPtr($postfields_struct))
	EndIf

	$url_struct = DllStructCreate("char[65536]")
	DllStructSetData($url_struct, 1, $url)
	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_URL, "ptr", DllStructGetPtr($url_struct))

	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_NOPROGRESS, "int", $noprogress)
	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_WRITEFUNCTION, "ptr", DllCallbackGetPtr($pWriteFunc))

	$CURL_ERROR = DllStructCreate("char[" & $CURL_ERROR_SIZE + 1 & "]")
	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_ERRORBUFFER, "ptr", DllStructGetPtr($CURL_ERROR))

	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_SSL_VERIFYPEER, "int", $ssl_verifypeer)
	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_FOLLOWLOCATION, "int", $followlocation)

	if StringLen($http_headers) > 0 Then

		$curl_slist_struct = DllStructCreate("ptr")
		$http_header_arr = StringSplit($http_headers, ";", 2)

		for $http_header in $http_header_arr

			$curl_slist_struct = cURL_slist_append($curl_slist_struct, $http_header)
		Next

		DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_HTTPHEADER, "ptr", $curl_slist_struct)
	EndIf

;	if $request_type = 1 Then

;		DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_POST, "int", 1)
;	EndIf

	; curl_easy_perform

	; initialise $curlout to be either binary or string output
	if $binary_output = 0 Then

		$curlout = ""
	Else

		$curlout = Binary('')
	EndIf


	$nPerform = DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_perform", "ptr", $hCurlHandle)
	$nPerform = $nPerform[0]
	If $nPerform <> 0 Then
		; libcurl reported an error
		ConsoleWrite("! " & DllStructGetData($CURL_ERROR, 1) & @CRLF)
	EndIf

	; Cleanup
	DllCall($hDll_LibCurl, "none:cdecl", "curl_easy_cleanup", "ptr", $hCurlHandle)

	; If file output is required
	if StringLen($output_file) > 0 Then

		$output_file_handle = FileOpen($output_file,2+16)
		FileWrite($output_file_handle, $curlout)
		FileClose($output_file_handle)
	EndIf

	return $curlout

EndFunc

; #FUNCTION# ;===============================================================================
;
; Name...........:	cURL_cleanup()
; Description ...:	Cleans up cURL.
; Syntax.........:	cURL_cleanup()
; Parameters ....:
; Return values .:
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	A prerequisite is that cURL_initialise() has been executed.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
func cURL_cleanup()

	DllCallbackFree ($pWriteFunc)
EndFunc

; #FUNCTION# ;===============================================================================
;
; Name...........:	_WriteFunc()
; Description ...:	This Callback function recieves the data downloaded with cURL.
; Syntax.........:	_WriteFunc ($ptr,$nSize,$nMemb,$pStream)
; Parameters ....:	$ptr		- TBD.
;					$nSize		- TBD.
;					$nMemb		- TBD.
;					$pStream	- TBD.
; Return values .: 	$nSize * $nMemb.
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
;
; ;==========================================================================================
Func _WriteFunc($ptr,$nSize,$nMemb,$pStream)

	Local $vData = DllStructCreate ("byte[" & $nSize*$nMemb & "]",$ptr)

	if $binary_output = 1 Then

		$curlout = $curlout & DllStructGetData($vData,1)
	Else

		$curlout = $curlout & BinaryToString(DllStructGetData($vData,1))
	EndIf

	Return $nSize*$nMemb
EndFunc

; #FUNCTION# ;===============================================================================
;
; Name...........:	cURL_slist_append()
; Description ...:	TBD.
; Syntax.........:	cURL_slist_append($slist, $append)
; Parameters ....:	$slist		- TBD.
;					$append		- TBD.
; Return values .: 	$aResult[0].
; Author ........:	ProgAndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
;
; ;==========================================================================================
Func cURL_slist_append($slist, $append)

	Local $aResult = DllCall($hDll_Libcurl, "ptr:cdecl", "curl_slist_append", 'ptr', $slist, 'str', $append)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc


; #FUNCTION# ;===============================================================================
;
; Name...........:	cURL_multi()
; Description ...:	Executes a cURL multi-session on a URL and returns the downloaded data.
; Syntax.........:	cURL_multi($url, $cookie_file = "", $cookie_action = 0, $output_type = 0, $output_file = "", $postfields = "", $ssl_verifypeer = 0, $noprogress = 1, $followlocation = 0, $http_headers = "")
; Parameters ....:	$url			- the URL you are requesting.
;					$cookie_file	- Optional: The name of a cookie file to include with the request.
;										"" = do not include a cookie
;					$cookie_action	- Optional: The actions to perform with $cookie.
;										0 = do nothing
;										1 = read the cookie
;										2 = write to the cookie
;										4 = delete the cookie, if it exists, before writing
;					$output_type	- Optional: the type of output for the HTTP response.
;										0 = output as text
;										1 = output as binary
;					$output_file	- Optional: the name of a file to output to.
;					$postfields		- the full data to post in an HTTP POST operation.
;										"" = do not post data
;					$ssl_verifypeer	- Optional: determines whether the authenticity of the peer's certificate is verified.
;										1 = verify
;										0 = do not verify
;					$noprogress		- Optional: output the cURL progress meter?
;										1 = no progress meter
;										0 = progress meter
;					$followlocation	- Optional: follow any Location: header the server sends as part of an HTTP header?
;										0 = don't follow the location header
;										1 = follow the location header
;					$http_headers	- Optional: a comma-separated list of HTTP headers
;										"" = do not send any headers
; Return values .: 	On Success			- Returns the HTTP response data.
;                 	On Failure			- Returns nothing.
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	A prerequisite is that cURL_initialise() has been executed.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
func cURL_multi($url, $cookie_file = "", $cookie_action = 0, $output_type = 0, $output_file = "", $postfields = "", $ssl_verifypeer = 0, $noprogress = 1, $followlocation = 0, $http_headers = "")

	;curl_multi_init

	$hCurlMultiHandle = DllCall($hDll_LibCurl, "ptr:cdecl", "curl_multi_init")
	$hCurlMultiHandle = $hCurlMultiHandle[0]

	; curl_easy_init

	$hCurlEasyHandle = DllCall($hDll_LibCurl, "ptr:cdecl", "curl_easy_init")
	$hCurlEasyHandle = $hCurlEasyHandle[0]

	; curl_easy_setopt

	$binary_output = $output_type

	if $cookie_action > 0 Then

		$cookie_struct = DllStructCreate("char[256]")
		DllStructSetData($cookie_struct, 1, $cookie_file)

		if $cookie_action = 4 or $cookie_action = 6 or $cookie_action = 7 Then

			FileDelete($cookie_file)
		EndIf

		; if read cookie action
		if $cookie_action = 1 or $cookie_action = 3 or $cookie_action = 7 Then

			DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_COOKIEFILE, "ptr", DllStructGetPtr($cookie_struct))
		EndIf

		; if write cookie action
		if $cookie_action = 2 or $cookie_action = 3 or $cookie_action = 6 Then

			DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_COOKIEJAR, "ptr", DllStructGetPtr($cookie_struct))
		EndIf
	EndIf

	if StringLen($postfields) > 0 Then

		$postfields_struct = DllStructCreate("char[256]")
		DllStructSetData($postfields_struct, 1, $postfields)
		DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_POSTFIELDS, "ptr", DllStructGetPtr($postfields_struct))
	EndIf

	$url_struct = DllStructCreate("char[65536]")
	DllStructSetData($url_struct, 1, $url)
	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_URL, "ptr", DllStructGetPtr($url_struct))

	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_NOPROGRESS, "int", $noprogress)
	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_WRITEFUNCTION, "ptr", DllCallbackGetPtr($pWriteFunc))

	$CURL_ERROR = DllStructCreate("char[" & $CURL_ERROR_SIZE + 1 & "]")
	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_ERRORBUFFER, "ptr", DllStructGetPtr($CURL_ERROR))

	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_SSL_VERIFYPEER, "int", $ssl_verifypeer)
	DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlEasyHandle, "uint", $CURLOPT_FOLLOWLOCATION, "int", $followlocation)

	if StringLen($http_headers) > 0 Then

		$curl_slist_struct = DllStructCreate("ptr")
		$http_header_arr = StringSplit($http_headers, ";", 2)

		for $http_header in $http_header_arr

			$curl_slist_struct = cURL_slist_append($curl_slist_struct, $http_header)
		Next

		DllCall($hDll_LibCurl, "uint:cdecl", "curl_easy_setopt", "ptr", $hCurlHandle, "uint", $CURLOPT_HTTPHEADER, "ptr", $curl_slist_struct)
	EndIf

	; curl_easy_perform

	; initialise $curlout to be either binary or string output
	if $binary_output = 0 Then

		$curlout = ""
	Else

		$curlout = Binary('')
	EndIf

	$running_handles_struct = DllStructCreate("uint")

	$hCurlMultiCode = DllCall($hDll_LibCurl, "uint:cdecl", "curl_multi_add_handle", "ptr", $hCurlMultiHandle, "ptr", $hCurlEasyHandle)
	$hCurlMultiCode = $hCurlMultiCode[0]

	Do

		$nPerform = DllCall($hDll_LibCurl, "uint:cdecl", "curl_multi_perform", "ptr", $hCurlMultiHandle, "ptr", DllStructGetPtr($running_handles_struct))
		$running_handles = DllStructGetData($running_handles_struct, 1)

		Sleep(250)
	until $running_handles < 1

	$nPerform = $nPerform[0]

	If $nPerform <> 0 Then
		; libcurl reported an error
		ConsoleWrite("! " & DllStructGetData($CURL_ERROR, 1) & @CRLF)
	EndIf

	; Cleanup
	$hCurlMultiCode = DllCall($hDll_LibCurl, "uint:cdecl", "curl_multi_remove_handle", "ptr", $hCurlMultiHandle, "ptr", $hCurlEasyHandle)
	$hCurlMultiCode = $hCurlMultiCode[0]
	DllCall($hDll_LibCurl, "none:cdecl", "curl_easy_cleanup", "ptr", $hCurlEasyHandle)
	$hCurlMultiCode = DllCall($hDll_LibCurl, "uint:cdecl", "curl_multi_cleanup", "ptr", $hCurlMultiHandle)

	; If file output is required
	if StringLen($output_file) > 0 Then

		$output_file_handle = FileOpen($output_file,2+16)
		FileWrite($output_file_handle, $curlout)
		FileClose($output_file_handle)
	EndIf

	return $curlout

EndFunc
