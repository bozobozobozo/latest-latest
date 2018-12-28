#include <libcURL.au3>

_Demo1()

Func _Demo1()
    Local $sURL = "http://www.google.com/search?q=http+headers"
    Local $hcurl = _curl_easy_init()

    If ($hcurl) Then
        ; set referer
        Local $ptNewList = _curl_slist_append(0, "Referer: http://www.google.com")

        ; add a custom accept
        $ptNewList = _curl_slist_append($ptNewList, "Accept: foo")

        Local $tCURLSTRUCT_URL = DllStructCreate("char[" & StringLen($sURL) + 1 & "]")
        DllStructSetData($tCURLSTRUCT_URL, 1, $sURL)
        _curl_easy_setopt($hcurl, $CURLOPT_URL, DllStructGetPtr($tCURLSTRUCT_URL))

        _curl_easy_setopt($hcurl, $CURLOPT_VERBOSE, 1)
        _curl_easy_perform($hcurl)

        ; redo request with our custom headers:
        _curl_easy_setopt($hcurl, $CURLOPT_HTTPHEADER, $ptNewList)
        _curl_easy_perform($hcurl)

        _curl_slist_free_all($ptNewList)

        _curl_easy_cleanup($hcurl)
    EndIf
EndFunc   ;==>_Demo1