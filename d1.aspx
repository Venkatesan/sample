<%@ Page Language="VB" %>
<script Language="VB" Option="Explicit" runat="server">

	Sub Page_Load(sender as Object, e as EventArgs)
		Dim strFileName As String
		
		' Retrieve the filename to download
		strFileName = Request.QueryString("file")

		' Check for directory traversal issues.
		If InStr(1, strFileName, "\", 1) <> 0  Then strFileName = ""
		If InStr(1, strFileName, "/", 1) <> 0  Then strFileName = ""
		If InStr(1, strFileName, "..", 1) <> 0 Then strFileName = ""

		' You'll probably want to add additional safeguards as to what
		' files people can download.  Since this is our sample area,
		' everything is fair game, but please note that this file will
		' send users your "web.config" file, Access database files, and
		' lots of other goodies you may not really want to share... so
		' PLEASE BE CAREFUL!!!

		' Since we're doing this for illustration, we want users to get
		' something and not just an error if they didn't pass in a filename.
		If strFileName = "" Then strFilename = "download_sample.aspx"

		If strFileName = "" Then
			Response.Write("Error: File Not Found!")
		Else
			'Response.ContentType = "application/octet-stream"
			Response.ContentType = "application/x-download"
			Response.AddHeader("Content-Disposition", "attachment;filename=" & strFileName)

			' If we needed to edit the file at all we could read it using something
			' like the GetTextFromFile function in our view source sample:
			' http://aspnet.asp101.com/samples/source.aspx
			' Here we'll just be reading it and writing it back out so
			' Response.WriteFile is easier and faster.
			' Writes the specified file directly to an HTTP content output stream.
			Response.WriteFile(Server.MapPath(strFileName))
			Response.End
		End If
	End Sub

</script>
