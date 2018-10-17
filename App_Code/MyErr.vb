Imports Microsoft.VisualBasic
Imports System.Collections.Specialized
Imports System.Linq
Imports System.Data.Linq
Imports System.IO
Imports System.Net
Imports System
Imports System.Web

Public Class MyErr


    Inherits System.Web.UI.Page


    Public Shared Sub HandleError(ByVal Ex As Exception, Optional ByVal bRedirectToErrorPage As Boolean = False, Optional ByVal bSendEmail As Boolean = True)

        On Error GoTo EH
        Dim sHTML As String = "", iErrID As Int32 = 0, sErrRedirect As String = "", sLastPage As String = ""

        ' Get Error information
        sHTML = GetHTMLError(Ex)


		
        iErrID = MyLogError(Ex.Message, Ex.Source, Ex.TargetSite.ToString, Ex.StackTrace, sHTML, bSendEmail)


        ' Redirect to Error page if needed
        If bRedirectToErrorPage Then
            sErrRedirect = MyUtils.GetAppSetting("ErrorRedirectPage")
            sLastPage = HttpContext.Current.Request.ServerVariables("SCRIPT_NAME")

            If sErrRedirect.ToString <> "" Then
                On Error Resume Next
                HttpContext.Current.Response.Redirect(sErrRedirect & "?ErrID=" & iErrID & "&LastPage=" & HttpContext.Current.Server.UrlEncode(sLastPage.ToString), True)
                Exit Sub
            End If
        End If
EH:
        Err.Clear()
    End Sub
    'Public shared Function LogWebError(ByVal sMessage As String, Optional ByVal sSource As String = "", Optional ByVal bSendEmail As Boolean = True, Optional ByVal sTargetSite As String = "", Optional ByVal sErrorHTML As String = "", Optional ByVal iNumber As Integer = 0, Optional ByVal sStackTrace As String = "", Optional ByVal sUserInput As String = "") As Integer
    '  LogWebError = MyLogError(sMessage, sSource, sTargetSite, sStackTrace, sErrorHTML, bSendEmail)
    'End Function

    'Public shared Function LogWebErrorAndReturn(ByVal sMessage As String, Optional ByVal sSource As String = "", Optional ByVal bSendEmail As Boolean = True, Optional ByVal sTargetSite As String = "", Optional ByVal sErrorHTML As String = "", Optional ByVal iNumber As Integer = 0, Optional ByVal sStackTrace As String = "", Optional ByVal sUserInput As String = "") As Integer
    '  LogWebErrorAndReturn = MyLogError(sMessage, sSource, sTargetSite, sStackTrace, sErrorHTML, bSendEmail)
    'End Function

    Public Shared Function LogError(ByVal sMessage As String, ByVal sSource As String, Optional ByVal sReturnMessage As String = "", Optional ByVal bSendEmail As Boolean = True) As String
        MyLogError(sMessage, sSource, "", "", , bSendEmail)
        LogError = sReturnMessage
    End Function

    Public Shared Function LogError(ByRef ex As System.Exception, Optional ByVal bSendEmail As Boolean = True) As String
        MyLogError(ex.Message, ex.Source, IIf(IsNothing(ex.TargetSite), "", ex.TargetSite.ToString), IIf(IsNothing(ex.StackTrace), "", ex.StackTrace.ToString), GetHTMLError(ex), bSendEmail)
        LogError = ex.Message
    End Function


    Public Shared Function LogError(ByVal ex As System.Exception, ByVal sReturnMessage As String, Optional ByVal bSendEmail As Boolean = True) As String
        MyLogError(ex.Message, ex.Source, IIf(IsNothing(ex.TargetSite), "", ex.TargetSite.ToString), IIf(IsNothing(ex.StackTrace), "", ex.StackTrace.ToString), GetHTMLError(ex), bSendEmail)
        LogError = sReturnMessage.ToString

    End Function


    Public Shared Function MyLogError(ByVal sMessage As String, ByVal sSource As String, ByVal sTargetSite As String, ByVal sStackTrace As String, Optional ByVal sErrorHTML As String = "", Optional ByVal bSendEmail As Boolean = True) As Integer

        Dim oError As New WebErrorLog, iErrID As Int32 = 0, sHTML As String = "", bLogError As Boolean = True
        Dim sErrEmail As String = "", sAdminErrEmail As String = "", sEmailSubject As String = "", sLastPage As String = ""

        If sErrorHTML.ToString = "" Then
            Dim Heading As String
            Heading = "<TABLE BORDER=""0"" WIDTH=""100%"" CELLPADDING=""1"" CELLSPACING=""0""><TR><TD bgcolor=""black"" COLSPAN=""2""><FONT face=""Arial"" color=""white""><B> <!--HEADER--></B></FONT></TD></TR></TABLE>"
            sErrorHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Message: " & sMessage)
            sErrorHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Source: " & sSource)
            sErrorHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "QueryString Collection")
            sErrorHTML += CollectionToHtmlTable(HttpContext.Current.Request.QueryString)
            '// Form Collection
            sErrorHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Form Collection")
            sErrorHTML += CollectionToHtmlTable(HttpContext.Current.Request.Form)
            ''// View State
            'sErrorHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Cookies Collection")
            'sErrorHTML += CollectionToHtmlTable(oViewState)
            '// Cookies Collection
            sErrorHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Cookies Collection")
            sErrorHTML += CollectionToHtmlTable(HttpContext.Current.Request.Cookies)
            '// Session Variables
            sErrorHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Session Variables")
            sErrorHTML += CollectionToHtmlTable(HttpContext.Current.Session)
            '// Server Variables
            sErrorHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Server Variables")
            sErrorHTML += CollectionToHtmlTable(HttpContext.Current.Request.ServerVariables)

        End If


        If MyUtils.GetAppSetting("SaveOnlyUniqueErrors") = "True" Then
            Dim oErrLog As WebErrorLog = MyData.ErrorLogGetDup(sTargetSite, sMessage)
            If Not oErrLog Is Nothing Then bLogError = False
        End If

        If bLogError Then
      Dim oDB As HouseRentalDataContext = MyData.GetHouseRentalContext(True)
      Try
                ' Save in DB
                If sErrorHTML.ToString = "" Then sErrorHTML = sMessage
                oError.cErrorMessage = sMessage.ToString
                oError.cErrorTargetSite = sTargetSite.ToString
                oError.cErrorSource = sSource.ToString
                oError.cErrorHTML = sErrorHTML.ToString
                oError.cErrorStackTrace = sStackTrace.ToString
                oError.dtErrorDate = Now
                oDB.WebErrorLogs.InsertOnSubmit(oError)
                oDB.SubmitChanges()
                oError = Nothing

            Catch ex As Exception
                Dim sDum As String = ex.Message
            End Try

            MyData.DisposeHouseRentalContext(oDB)

            If bSendEmail Then
        ' Email it
        sErrEmail = MyUtils.GetAppSetting("ErrorEmailAddress")
        sEmailSubject = "Error from " & HttpContext.Current.Request.Url.Host

                If CStr(sErrEmail) <> "" Then
                    MyUtils.SendMail(sErrEmail, sErrEmail, sEmailSubject, sErrorHTML, sErrEmail, sErrEmail, True, True)
                End If
            End If

        End If

    End Function


    Public Shared Function GetIISInfo() As String

        Dim Heading As String
        Dim MyHTML As String
        Heading = "<TABLE BORDER=""0"" WIDTH=""100%"" CELLPADDING=""1"" CELLSPACING=""0""><TR><TD bgcolor=""black"" COLSPAN=""2""><FONT face=""Arial"" color=""white""><B> <!--HEADER--></B></FONT></TD></TR></TABLE>"
        MyHTML = "<FONT face=""Arial"" size=""4"" color=""red"">IIS Information</FONT><BR><BR>"
        '// QueryString Collection
        MyHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "QueryString Collection")
        MyHTML += CollectionToHtmlTable(HttpContext.Current.Request.QueryString)
        '// Form Collection
        MyHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Form Collection")
        MyHTML += CollectionToHtmlTable(HttpContext.Current.Request.Form)
        ''// View State
        'MyHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Cookies Collection")
        'MyHTML += CollectionToHtmlTable(oViewState)
        '// Cookies Collection
        MyHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Cookies Collection")
        MyHTML += CollectionToHtmlTable(HttpContext.Current.Request.Cookies)
        '// Session Variables
        MyHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Session Variables")
        MyHTML += CollectionToHtmlTable(HttpContext.Current.Session)
        '// Server Variables
        MyHTML += "<BR><BR>" + Heading.Replace("<!--HEADER-->", "Server Variables")
        MyHTML += CollectionToHtmlTable(HttpContext.Current.Request.ServerVariables)
        GetIISInfo = MyHTML
    End Function


    Public Shared Function GetHTMLError(ByVal Ex As Exception) As String
        'Returns HTML an formatted error message.
        Dim Heading As String
        Dim MyHTML As String
        Dim Error_Info As New NameValueCollection
        Heading = "<TABLE BORDER=""0"" WIDTH=""100%"" CELLPADDING=""1"" CELLSPACING=""0""><TR><TD bgcolor=""black"" COLSPAN=""2""><FONT face=""Arial"" color=""white""><B> <!--HEADER--></B></FONT></TD></TR></TABLE>"
        MyHTML = "<FONT face=""Arial"" size=""4"" color=""red"">Error - " & Ex.Message & "</FONT><BR><BR>"
        Error_Info.Add("Message", CleanHTML(Ex.Message))
        Error_Info.Add("Source", CleanHTML(Ex.Source))
        Error_Info.Add("TargetSite", CleanHTML(Ex.TargetSite.ToString()))
    Error_Info.Add("StackTrace", CleanHTML(Replace(Ex.StackTrace, " at ", "<BR>")))
    If Ex.InnerException IsNot Nothing Then
      Error_Info.Add("<b>Inner Exception</b>", CleanHTML(Ex.InnerException.Message))
      Error_Info.Add("Message", CleanHTML(Ex.InnerException.Message))
      Error_Info.Add("Source", CleanHTML(Ex.InnerException.Source))
      Error_Info.Add("TargetSite", CleanHTML(Ex.InnerException.TargetSite.ToString()))
      Error_Info.Add("StackTrace", CleanHTML(Replace(Ex.InnerException.StackTrace, " at ", "<BR>")))

    End If

    MyHTML += Heading.Replace("<!--HEADER-->", "Error Information")
        MyHTML += CollectionToHtmlTable(Error_Info)
        MyHTML += GetIISInfo()
        Return MyHTML
    End Function
    Public Shared Function CollectionToHtmlTable(ByVal Collection As NameValueCollection) As String
        Dim TDName As String, TDValue As String
        Dim MyHTML As String
        Dim i As Integer
        TDName = "<TD width=""170"" ><FONT face=""Arial"" size=""2""><!--NAME--></FONT></TD>"
        TDValue = "<TD ><FONT face=""Arial"" size=""2""><!--VALUE--></FONT></TD>"
        MyHTML = "<TABLE width=""100%"">" & _
        " <TR bgcolor=""#C0C0C0"">" & _
        TDName.Replace("<!--NAME-->", " <B>Name</B>") & TDValue.Replace("<!--VALUE-->", " <B>Value</B>") & "</TR>"
        'No Body? -> N/A
        If (Collection.Count <= 0) Then
            Collection = New NameValueCollection
            Collection.Add("N/A", "")
        Else
            Try

                'Table Body0
                If Collection IsNot Nothing Then
                    For i = 0 To Collection.Count - 1
                        If Collection.Keys(i).ToString <> "__VIEWSTATE" Then
                            MyHTML += "<TR valign=""top"" bgcolor=""#EEEEEE"">" & _
                            TDName.Replace("<!--NAME-->", Collection.Keys(i)) & " " & _
                            TDValue.Replace("<!--VALUE-->", Collection(i)) & "</TR> "
                        End If
                    Next i

                End If
            Catch ex As Exception

            End Try
        End If
        'Table Footer
        Return MyHTML & "</TABLE>"
    End Function
    Public Shared Function CollectionToHtmlTable(ByVal Collection As HttpCookieCollection) As String
        'Converts HttpCookieCollection to NameValueCollection
        Dim NVC As New NameValueCollection
        Dim i As Integer
        Dim Value As String
        CollectionToHtmlTable = ""
        Try
            If Collection.Count > 0 Then
                For i = 0 To Collection.Count - 1
          NVC.Add(Collection.Keys(i), Collection(i).Value)
                Next i
            End If
            Value = CollectionToHtmlTable(NVC)
            Return Value
        Catch MyError As Exception
            MyError.ToString()
        End Try
    End Function
    Public Shared Function CollectionToHtmlTable(ByVal Collection As System.Web.SessionState.HttpSessionState) As String
        'Converts HttpSessionState to NameValueCollection
    On Error Resume Next
        Dim NVC As New NameValueCollection
        Dim i As Integer
        Dim Value As String
        If Collection.Count > 0 Then
            For i = 0 To Collection.Count - 1
        NVC.Add(Collection.Keys(i), Collection.Item(i).ToString)
        Err.Clear()
            Next i
        End If
        Value = CollectionToHtmlTable(NVC)
        Return Value
  End Function
    'Private Function CollectionToHtmlTable(ByRef oViewState As System.Web.UI.StateBag) As String
    '  'Converts HttpSessionState to NameValueCollection
    '  Dim NVC As New NameValueCollection
    '  Dim i As Integer
    '  Dim Value As String

    '  '    Select Case sNamedCollection
    '  '      Case "ViewState"
    '  If Not oViewState Is Nothing Then
    '    For Each sKey As String In ViewState.Keys
    '      NVC.Add(sKey, ViewState.Item(sKey).ToString)
    '    Next
    '  End If
    '  '    End Select
    '  Value = CollectionToHtmlTable(NVC)
    '  Return Value
    'End Function

    Public Shared Function CleanHTML(ByVal HTML As String) As String
        If HTML.Length <> 0 Then
            HTML.Replace("<", "<").Replace("\r\n", "<BR>").Replace("&", "&").Replace(" ", " ")
        Else
            HTML = ""
        End If
        Return HTML
    End Function

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class

