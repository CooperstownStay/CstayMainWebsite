Imports Microsoft.VisualBasic
Imports System.Configuration.ConfigurationManager
Imports System.IO
Imports System.Net
Imports System.Linq
Imports System.Data.Linq
Imports System.Text.RegularExpressions
Imports System
Imports System.Web

Public Class MyUtils

  Inherits System.Web.UI.Page
  Public Shared Function CreatePropertyImageAltTitleText(sDefaultAltText As String, sPropertyName As String, Optional ByRef oMyHouse As HouseRentalDataContext = Nothing) As String

    CreatePropertyImageAltTitleText = ""
    Try
            Dim sOut As String = ""
      If sDefaultAltText = "" Then
        sDefaultAltText = sPropertyName
      End If
      sOut = sDefaultAltText
      CreatePropertyImageAltTitleText = sOut
    Catch ex As Exception

    End Try

  End Function

  Public Shared Function GetAppSetting(ByVal sKey As String, Optional ByVal sDefault As String = "") As String
    GetAppSetting = CNullS(AppSettings(sKey))
    If GetAppSetting = "" Then GetAppSetting = sDefault
  End Function


  Public Shared Function CNull(ByVal oInp As Object) As Object
    CNull = DBNull.Value
    If Not IsDBNull(oInp) Then
      If Not (oInp Is Nothing) Then CNull = oInp
    End If
  End Function

  Public Shared Function CNullS(ByVal oInp As Object, Optional ByVal sDefault As String = "") As String
    CNullS = sDefault
    If Not IsDBNull(oInp) Then
      If Not (oInp Is Nothing) Then CNullS = CStr(oInp)
    End If
  End Function

  Public Shared Function CNullI(ByVal oInp As Object, Optional ByVal iDefault As Integer = 0) As Integer
    CNullI = iDefault
    If Not IsDBNull(oInp) Then
      If Not (oInp Is Nothing) Then
        If IsNumeric(oInp) Then CNullI = CInt(oInp)
      End If
    End If
  End Function

  Public Shared Function CNullD(ByVal oInp As Object, Optional ByVal dDefault As Double = 0) As Double
    CNullD = dDefault
    If Not IsDBNull(oInp) Then
      If Not (oInp Is Nothing) Then
        If IsNumeric(oInp) Then CNullD = CDbl(oInp)
      End If
    End If
  End Function

  Public Shared Function FixSQLParam(ByVal oInput As Object, Optional ByVal sDefaultValue As String = "") As String
    FixSQLParam = ""

    If IsDBNull(oInput) Then
      If sDefaultValue.ToString <> "" Then
        FixSQLParam = sDefaultValue
      Else
        FixSQLParam = "Null"
      End If

    Else
      FixSQLParam = CStr(oInput)
      If Not IsNumeric(oInput) Then
        FixSQLParam = "'" & FixSQLParam & "'"
      End If
    End If


  End Function


  Public Shared Function SendMail( _
   ByVal sTo As String, _
   ByVal sFrom As String, _
   ByVal sSubject As String, _
   ByVal sBody As String, _
   Optional ByVal sFromName As String = "", _
   Optional ByVal sToName As String = "", _
   Optional ByVal BodyFormatIsHTML As Boolean = False, _
   Optional ByVal bFromErrorHandler As Boolean = False, _
   Optional ByVal sAttachment As String = "", _
   Optional ByVal sReplyTo As String = "", _
   Optional ByVal bForceSendNow As Boolean = False) As Boolean  ' 9/24/18 - SAM - Added bForceSendNow.  This was the quickest, easiest way to resolve issue contact form reply-to email always showing as find@cooperstownstay.com.

    SendMail = False

    Try

      Dim sStatus As String = "", bQueueEmail As Boolean = False

      If CStr(GetAppSetting("QueueEmail")) = "True" AndAlso bForceSendNow = False Then
        bQueueEmail = True
        SendMail = True
        sStatus = "Unsent-Queued"
        Dim oDB As HouseRentalDataContext = MyData.GetHouseRentalContext(True)
        Try
          Dim oMail As New QueuedEmail

          oMail.FromAddress = sFrom
          oMail.FromName = sFromName
          oMail.ToAddress = sTo
          oMail.ToName = sToName
          oMail.Body = sBody
          oMail.Subject = sSubject
          oMail.Status = sStatus
          oMail.FormatIsHTML = BodyFormatIsHTML
          oMail.AddDate = Now
          oDB.QueuedEmails.InsertOnSubmit(oMail)
          oDB.SubmitChanges()

        Catch ex As Exception
          If Not bFromErrorHandler Then MyErr.LogError(ex, False)
        End Try
        MyData.DisposeHouseRentalContext(oDB)
      Else
        Dim oMsg As New System.Net.Mail.MailMessage(sFrom, sTo, sSubject, sBody)
        If sAttachment <> "" Then
          Dim oAtttach As New System.Net.Mail.Attachment(sAttachment)
          oMsg.Attachments.Add(oAtttach)
        End If
        oMsg.ReplyTo = New System.Net.Mail.MailAddress(IIf(sReplyTo = "", sFrom, sReplyTo))
        Dim sSMTPServer As String = GetAppSetting("SMTPServer")
        Dim sUser As String = "", sPass As String = "", iPort As Integer = 0
        sUser = GetAppSetting("SMTPServerUser")
        sPass = GetAppSetting("SMTPServerPassword")
        iPort = CNullI(GetAppSetting("SMTPServerPort"))

        Dim oEmail As New System.Net.Mail.SmtpClient(sSMTPServer)

        If sUser <> "" Then
          Dim SMTPUserInfo As New NetworkCredential(sUser, sPass)
          oEmail.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network
          oEmail.UseDefaultCredentials = False
          oEmail.Credentials = SMTPUserInfo
        End If
        If iPort > 0 Then
          oEmail.Port = iPort
          oEmail.EnableSsl = True
        End If

        oMsg.IsBodyHtml = BodyFormatIsHTML
        Try
          oEmail.Send(oMsg)
          SendMail = True
          sStatus = "Sent"
        Catch ex As Exception

          Dim sInfo As String = "Server: " & sSMTPServer & " User: " & sUser & " Pass: " & sPass
          sStatus = "Unsent-Error While Sending"
          sInfo = ex.Message
          If Not (ex.InnerException Is Nothing) Then sInfo &= " : " & ex.InnerException.Message
          '				If Not (ex.InnerException.InnerException Is Nothing) Then sInfo &= " : " & ex.InnerException.InnerException.Message
          If Not bFromErrorHandler Then MyErr.LogError(sInfo, "SendEmail", , False)
        End Try
        oMsg = Nothing
        oEmail = Nothing

      End If

    Catch ex As Exception
      If Not bFromErrorHandler Then MyErr.LogError(ex, False)
    End Try

  End Function
  Public Shared Sub AddItemToArray(ByRef sArray() As String, ByRef sNewItem As String)

    If sNewItem IsNot Nothing Then
      If sArray Is Nothing Then
        ReDim Preserve sArray(0)
      Else
        ReDim Preserve sArray(UBound(sArray) + 1)
      End If
      sArray(UBound(sArray)) = sNewItem
    End If

  End Sub
  Public Shared Function ParseString(ByVal sIn As String, ByVal sDelim As String, ByVal iPosition As Integer, Optional ByRef sSplitData() As String = Nothing, Optional ByVal bStartFromFront As Boolean = True) As String
    ParseString = ""
    Try
      sSplitData = Split(sIn, sDelim)
      If Not bStartFromFront Then
        iPosition = UBound(sSplitData) - iPosition
      End If
      If sSplitData.GetUpperBound(0) >= 0 AndAlso sSplitData.GetUpperBound(0) >= iPosition Then
        ParseString = sSplitData(iPosition)
      End If
    Catch ex As Exception
    End Try

  End Function


  Public Shared Function AdvanceArray(ByRef sInArray() As String, sSearchString As String, ByRef iCurrPosition As Integer) As Boolean
    AdvanceArray = False
    Try

      Dim iIndex As Integer = 0
      For iIndex = iCurrPosition To sInArray.Count - 1
        If sInArray(iIndex).Contains(sSearchString) Then
          iCurrPosition = iIndex
          Exit For
        End If
      Next
      If iCurrPosition < sInArray.Count - 1 Then AdvanceArray = True
    Catch ex As Exception

    End Try

  End Function


  Public Shared Function ArrayToJSON(sInArray() As String, sArrayName As String) As String

    ArrayToJSON = ""
    Try
      If sInArray IsNot Nothing Then

        Dim iIndex As Integer = 0, sOut As String = ""
        For iIndex = 0 To sInArray.Count - 1
          sOut &= """" & sInArray(iIndex) & ""","
        Next

        If sOut.Count > 0 Then
          sOut = "{""" & sArrayName & """: [ " & sOut.TrimEnd(",") & " ]}"
        End If
        ArrayToJSON = sOut
      End If
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function
  Public Shared Function ArrayToJSON(sInArray(,) As String, sArrayName As String, sArrayProperties() As String) As String

    ArrayToJSON = ""
    Try

      If sInArray IsNot Nothing Then

        Dim iIndex As Integer = 0, iIndex2 As Integer = 0, sOut As String = "", s As System.Array
        For iIndex = 0 To sInArray.Length - 1
          sOut &= "{ "
          For iIndex2 = 0 To sArrayProperties.Length - 1
            sOut &= """" & sArrayProperties(iIndex2) & """ : """ & sInArray(iIndex, iIndex2) & ""","
          Next
          sOut = sOut.TrimEnd(",") & " } " & vbCrLf
        Next

        If sOut.Length > 0 Then
          sOut = "{""" & sArrayName & """: [ " & sOut.TrimEnd(",") & " ]}"
        End If
        ArrayToJSON = sOut

      End If

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function


  Public Shared Function StripAllHTML(ByVal strHTML As String, Optional iNumberSentencesToReturn As Integer = 0) As String
    'Strips the HTML tags from strHTML

    StripAllHTML = ""
    Dim objRegExp As New Regex("</?\w+((\s+\w+(\s*=\s*(?:"".*?""|'.*?'|[^'"">\s]+))?)+\s*|\s*)/?>", RegexOptions.IgnoreCase), strOutput As String = ""

    Try

      'Replace all HTML tag matches with the empty string
      strHTML = MyUtils.CNullS(strHTML)
      strOutput = objRegExp.Replace(strHTML, "")

      strOutput = strOutput.Replace(vbCrLf, " ").Replace(vbTab, " ").Replace("  ", " ").Replace("  ", " ").Replace("  ", " ").Replace("  ", " ").Replace("  ", " ").Replace("<", "").Replace(">", "")
      If iNumberSentencesToReturn > 0 Then
        Dim sData() As String = Nothing
        sData = Split(strOutput, ".")
        If sData.Count < iNumberSentencesToReturn Then iNumberSentencesToReturn = sData.Count
        ReDim Preserve sData(iNumberSentencesToReturn - 1)
        strOutput = Join(sData, ".") & "."
      End If
      StripAllHTML = strOutput    'Return the value of strOutput

    Catch ex As Exception

    End Try


    objRegExp = Nothing
  End Function


  Public Shared Function StripHTMLTag(ByVal sIn As String, ByVal sTag As String) As String

    StripHTMLTag = ""
    Dim sData1() As String = Nothing, sData2() As String = Nothing, iCount1 As Integer = 0, iCount2 As Integer = 0, sTmp As String = ""
    Dim sTagStart As String = "", sTagEnd As String = "", sThis As String = ""

    Try

      sTag = sTag.Replace("<", "").Replace(">", "")
      sTagStart = "<" & sTag
      sTagEnd = "</" & sTag & ">"

      sIn = sIn.Replace("< ", "<").Replace("</ ", "</").Replace(" >", ">")
      sIn = sIn.Replace(sTagStart & ">", "")
      sData1 = Split(sIn, sTagStart)
      For iCount1 = 0 To UBound(sData1)
        sThis = ""
        For iCount2 = 0 To sData1(iCount1).Length - 1
          If sData1(iCount1).Substring(iCount2, 1) = ">" Then
            sThis &= sData1(iCount1).Substring(iCount2 + 1, sData1(iCount1).Length - iCount2 - 1)
            Exit For
          End If
        Next
        ' Whoops no closing bracket, just keep original 
        If sThis = "" Then
          sTmp &= sData1(iCount1)
        Else
          sTmp &= sThis
        End If
      Next
      If sTmp = "" Then sTmp = sIn
      sTmp = sTmp.Replace(sTagEnd, "")
    Catch ex As Exception
      Dim sDontcare As String = ""
    End Try
    StripHTMLTag = sTmp

  End Function


  Public Shared Function StripHTMLTags(ByVal sIn As String, ByVal sTags() As String) As String
    StripHTMLTags = ""
    Dim iCount As Integer = 0, sThisTag As String = "", sOut As String = ""

    Try

      sOut = sIn
      For iCount = 0 To UBound(sTags)
        sOut = StripHTMLTag(sOut, sTags(iCount))
      Next

    Catch ex As Exception
      Dim sDontcare As String = ""
    End Try
    StripHTMLTags = sOut

  End Function




  Public Shared Function StripHTMLTags(ByVal sIn As String, ByVal sTags As String) As String
    StripHTMLTags = ""

    Dim sSplitTags() As String = Nothing

    Try

      sSplitTags = Split(sTags, ",")
      If UBound(sSplitTags) >= 0 Then
        StripHTMLTags = StripHTMLTags(sIn, sSplitTags)
      End If

    Catch ex As Exception
      Dim sDontcare As String = ""
    End Try

  End Function
  Public Shared Sub SetEditMode(ByVal bSwitchOff As Boolean)

    If bSwitchOff Then
      HttpContext.Current.Session("EditMode") = ""
      HttpContext.Current.Session("EditModeQS") = ""
      HttpContext.Current.Session("AndEditModeQS") = ""
    Else
      HttpContext.Current.Session("EditMode") = "True"
      HttpContext.Current.Session("EditModeQS") = "?EditMode=True"
      HttpContext.Current.Session("AndEditModeQS") = "&EditMode=True"
      HttpContext.Current.Session.Timeout = 600
    End If

  End Sub

  Public Shared Function InEditMode() As Boolean

    If CNullS(HttpContext.Current.Session("EditMode")) = "True" Then Return True
    ' This call only needed on edit website 
    'Return CBool(ProcessEditSessionToken(False))
  End Function

  Public Shared Function ProcessEditSessionToken(bEncode As Boolean) As String

    Dim oAES As New MyAES
    Dim sSessionToken As String, sPass As String = GetAppSetting("EncryptPassword")
    If bEncode Then
      sSessionToken = "|" & Now.ToShortDateString
      sSessionToken = HttpContext.Current.Server.UrlEncode(oAES.AES_Encrypt(sSessionToken, sPass))
      Return sSessionToken
    Else
      sSessionToken = CNullS(HttpContext.Current.Request("Token"))
      If sSessionToken <> "" Then
        Dim sDecode As String = oAES.AES_Decrypt(sSessionToken, sPass)
        Dim sData() As String = Split(sDecode, "|")
        If UBound(sData) > 0 AndAlso IsDate(sData(1)) Then
          HttpContext.Current.Session("EditMode") = "True"
          Return "True"
        End If
      End If
    End If
    Return "False"

  End Function

  Public Shared Function GetEditWebsiteLink() As String

    Return MyUtils.GetAppSetting("EditWebsiteLink") & "?Token=" & ProcessEditSessionToken(True)

  End Function


  Public Shared Function GetCachedPageQS(Optional ByVal sPage As String = "", Optional ByVal bEncode As Boolean = True) As String
    GetCachedPageQS = ""
    Dim sOut As String = ""
    Try
      If sPage = "" Then sPage = HttpContext.Current.Request.RawUrl
      sOut = ClearURL(sPage)
      If bEncode Then sOut = "&CachedPage=" & HttpContext.Current.Server.UrlEncode(sOut)
    Catch ex As Exception

    End Try
    GetCachedPageQS = sOut

  End Function

 
  Public Shared Function ClearURL(sInURL As String, Optional bRemovePropCat As Boolean = False) As String

    ClearURL = sInURL
    Try
      If CNullS(HttpContext.Current.Session("AndEditModeQS")) <> "" Then ClearURL = ClearURL.Replace(CNullS(HttpContext.Current.Session("AndEditModeQS")), "")
      If CNullS(HttpContext.Current.Session("EditModeQS")) <> "" Then ClearURL = ClearURL.Replace(CNullS(HttpContext.Current.Session("EditModeQS")), "")

      Dim sNew As String = ""
      If ClearURL.Contains("Upd") Then
        Dim sData() As String = Split(ClearURL, "&"), iCount As Integer
        If sData.Length > 1 Then
          sNew = sData(0)
          For iCount = 1 To sData.Length - 1
            If Not (sData(iCount).Contains("Upd")) Then
              sNew &= "&" & sData(iCount)
            End If

          Next
        End If
        ClearURL = sNew
      End If

      If bRemovePropCat Then
        If ClearURL.Contains("PropCat") Then
          Dim sData() As String = Split(ClearURL, "&"), iCount As Integer
          If sData.Length >= 1 Then
            sNew = sData(0)
            For iCount = 1 To sData.Length - 1
              If Not (sData(iCount).Contains("PropCat")) Then
                sNew &= "&" & sData(iCount)
              End If
            Next
          End If
        End If
        ClearURL = sNew
      End If

    Catch ex As Exception

    End Try


  End Function

  Public Shared Function SetPageKeywords(ByVal sKeywordsIn As String) As String

    If sKeywordsIn <> "" Then sKeywordsIn &= ", "
    SetPageKeywords = sKeywordsIn & GetAppSetting("CommonPageKeywords")

  End Function

  Public Shared Function GetEnlargedImageSetup(ByRef oImage As PropertyImage, ByRef sTitle As String, ByVal sDefaultTitle As String) As String

    GetEnlargedImageSetup = ""
    Try
      sTitle = oImage.ImageAlt.Trim
      If sTitle = "" Then sTitle = sDefaultTitle

      If CNullS(oImage.ImageFileEnlarged) <> "" Then
        sTitle = "Click to View Larger Image"
        GetEnlargedImageSetup = "<a href=""/photos/" & oImage.ImageFileEnlarged & """ class=""top_up"" topoptions=""height=" & oImage.ImageFileEnlargedHeight & ", width=" & oImage.ImageFileEnlargedWidth & """ > "
      End If

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try
  End Function


  Public Shared Function SetGoogleAdwordsConversionCode(ByRef oPage As System.Web.UI.Page, ByVal sID As String, ByVal sLabel As String, Optional ByVal sValue As String = "0") As String

    SetGoogleAdwordsConversionCode = ""
    Dim sHTTP As String = "http"
    If oPage.Request.IsSecureConnection Then sHTTP = "https"

      SetGoogleAdwordsConversionCode = "    <script language=""JavaScript"" type=""text/javascript"">" & vbCrLf & _
       "/* <![CDATA[ */" & vbCrLf & _
      "var google_conversion_id = " & sID & vbCrLf & _
      "var google_conversion_language = ""en_US"";" & vbCrLf & _
      "var google_conversion_format = ""3"";" & vbCrLf & _
      "var google_conversion_color = ""EEEEBB"";" & vbCrLf & _
      "var google_conversion_label = """ & sLabel & """;" & vbCrLf & _
      "var google_conversion_value = " & sValue & vbCrLf & _
      "/* ]]> */" & vbCrLf & _
      "    </script>" & vbCrLf & _
      "<script language=""JavaScript"" src=""" & sHTTP & "://www.googleadservices.com/pagead/conversion.js"">" & vbCrLf & _
      "</script>" & vbCrLf & _
      "<noscript>" & vbCrLf & _
      "<img height=""1"" width=""1"" border=""0"" src=""" & sHTTP & "://www.googleadservices.com/pagead/conversion/" & sID & "/?label=" & sLabel & "&amp;guid=ON&amp;script=0"" />" & vbCrLf & _
      "</noscript>" & vbCrLf



  End Function
  Public Shared Function SetGoogleAnalyticsLinker() As String
    SetGoogleAnalyticsLinker = ""
    Try
      SetGoogleAnalyticsLinker = " onclick=""_gaq.push(['_link',this.href]); return false;"" "
    Catch ex As Exception
    End Try
  End Function

  Public Shared Function SetGoogleAnalyticsCode(sPageview As String) As String

    SetGoogleAnalyticsCode = ""
    Try

      If sPageview <> "" Then sPageview = ",'" & sPageview.Replace("'", "") & "'"

      SetGoogleAnalyticsCode = "<script type=""text/javascript"">" & vbCrLf &
        "var _gaq = _gaq || [];" & vbCrLf &
        "_gaq.push(['_setAccount', 'UA-7665160-1']);" & vbCrLf &
        "_gaq.push(['_setDomainName', 'cooperstownstay.com']);" & vbCrLf &
        "_gaq.push(['_setAllowLinker', true]);" & vbCrLf &
        "_gaq.push(['_trackPageview'" & sPageview & "]);" & vbCrLf &
        "(function () {" & vbCrLf &
         " var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;" & vbCrLf &
         " ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';" & vbCrLf &
         " var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);" & vbCrLf &
        "})();" & vbCrLf &
          "</script>"
    Catch ex As Exception

    End Try
  End Function


  Public Shared Function BrowserInCStayOffice(ByRef oRequest As HttpRequest, ByRef oSession As HttpSessionState) As Boolean

    If CNullS(oSession("LonettaOffice")) = "" Then

      Try
        Dim oIP As IPHostEntry = Nothing, sOfficeHostName As String = "CooperstownStay.DynDNS.Org"
        oIP = Dns.GetHostEntry(sOfficeHostName)
        If oRequest.UserHostAddress = oIP.AddressList(0).ToString Then
          oSession("LonettaOffice") = "True"
        Else
          oSession("LonettaOffice") = "False"
        End If
      Catch ex As Exception

      End Try
    End If
    BrowserInCStayOffice = oSession("LonettaOffice") = "True"

  End Function

  Public Shared Function AfterSeason() As Boolean

    ' BJR NOTE: This function Main and Reservation website

    AfterSeason = False
    Try
      Dim dNow As DateTime = CDate(GetAppSetting("DateForTesting", DateTime.Now.ToShortDateString))
      Dim dSeasonEnd As DateTime = CDate(GetAppSetting("SeasonEndDate"))
      Dim dSeasonStart As DateTime = CDate(GetAppSetting("SeasonStartDate"))

      If dNow >= CDate(dSeasonEnd) And dNow < dSeasonStart Then
        AfterSeason = True
      End If
    Catch ex As Exception
      Dim s As String = ex.Message.ToString
    End Try

  End Function


  Public Shared Function GetPropertyGroupAmenityRanges(oProps As List(Of vwPropertiesWithGroup), iGroupID As Integer, ByRef iMinBeds As Integer, ByRef iMaxBeds As Integer, ByRef iMinBaths As Integer, ByRef iMaxBaths As Integer, ByRef iMinRate As Integer, ByRef iMaxRate As Integer, ByRef iMinSleeps As Integer, ByRef iMaxSleeps As Integer, ByVal bDiscountedRatesVisible As Boolean, ByRef bGroupHasDiscountedProperties As Boolean) As Boolean

    iMinBeds = 0
    iMaxBeds = 0
    iMinBaths = 0
    iMaxBaths = 0
    iMinRate = 0
    iMaxRate = 0
    iMinSleeps = 0
    iMaxSleeps = 0

    If iGroupID > 0 Then
      Dim oThisGroupProps As List(Of vwPropertiesWithGroup) = (From x In oProps Where x.GroupID = iGroupID).ToList
      If oThisGroupProps.Count >= 1 Then
        Dim oPropsSort As List(Of vwPropertiesWithGroup) = (From x In oThisGroupProps Order By x.Bedrooms).ToList()
        iMinBeds = oPropsSort(0).Bedrooms
        oPropsSort = (From x In oThisGroupProps Order By x.Bedrooms Descending).ToList()
        iMaxBeds = oPropsSort(0).Bedrooms

        oPropsSort = (From x In oThisGroupProps Order By x.Baths).ToList()
        iMinBaths = oPropsSort(0).Baths
        oPropsSort = (From x In oThisGroupProps Order By x.Baths Descending).ToList()
        iMaxBaths = oPropsSort(0).Baths

        oPropsSort = (From x In oThisGroupProps Order By x.Sleeps).ToList()
        iMinSleeps = oPropsSort(0).Sleeps
        oPropsSort = (From x In oThisGroupProps Order By x.Sleeps Descending).ToList()
        iMaxSleeps = oPropsSort(0).Sleeps

        oPropsSort = (From x In oThisGroupProps Order By x.SummerRate).ToList()
        iMinRate = oPropsSort(0).SummerRate
        oPropsSort = (From x In oThisGroupProps Order By x.SummerRate Descending).ToList()
        iMaxRate = oPropsSort(0).SummerRate


        bGroupHasDiscountedProperties = False

        If bDiscountedRatesVisible Then

          Dim iNewMaxRate As Integer
          iNewMaxRate = iMaxRate

          'get the new max rate considering discounted rates
          oPropsSort = (From x In oThisGroupProps Where x.SummerRate = iNewMaxRate Order By x.DiscountedRate).ToList()
          ' if there exists a property whose summer rate equals the max rate without a discounted rate, then the max rate stays the same
          ' however, if the (0) property has a discounted rate > 0, then that means all properties with a summer rate = max rate have a discounted rate.  
          ' therefore, get the most expensive discounted rate among the properties whose summer rate = max rate
          If oPropsSort(0).DiscountedRate > 0 Then
            bGroupHasDiscountedProperties = True
            iNewMaxRate = oPropsSort(oPropsSort.Count - 1).DiscountedRate

            'now, we need to make sure there doesn't exist a property whose summer rate > the most expensive discounted rate among properties whose summer rate = non-discounted max rate
            oPropsSort = (From x In oThisGroupProps Where x.SummerRate > iNewMaxRate And x.DiscountedRate = 0 Order By x.SummerRate Descending).ToList()
            If oPropsSort.Count > 0 Then iNewMaxRate = oPropsSort(0).SummerRate

            'Last thing to consider... look for a property whose discounted rate is > the new max rate.
            oPropsSort = (From x In oThisGroupProps Where x.DiscountedRate > iNewMaxRate Order By x.DiscountedRate Descending).ToList()
            If oPropsSort.Count > 0 Then iNewMaxRate = oPropsSort(0).DiscountedRate

            iMaxRate = iNewMaxRate
          End If


          'get the new min rate considering discounted rates
          oPropsSort = (From x In oThisGroupProps Where x.DiscountedRate > 0 Order By x.DiscountedRate).ToList()
          If oPropsSort.Count > 0 Then
            bGroupHasDiscountedProperties = True
            If MyUtils.CNullI(oPropsSort(0).DiscountedRate) < iMinRate Then iMinRate = oPropsSort(0).DiscountedRate

          End If

        End If

      End If
    End If
    Return (iMinBeds <> iMaxBeds Or iMinBaths <> iMaxBaths Or iMinRate <> iMaxRate Or iMinSleeps <> iMaxSleeps)
  End Function

  Public Shared Function GetPropertyGroupRatesAsDiv(oProps As List(Of vwPropertiesWithGroup), iGroupID As Integer, bDiscountedRatesVisible As Boolean) As String
    Dim sRates As String = ""
    Try

      If iGroupID > 0 Then
        Dim oThisGroupProps As List(Of vwPropertiesWithGroup) = (From x In oProps Where x.GroupID = iGroupID).ToList
        If oThisGroupProps.Count >= 1 Then
          Dim oPropsSort As List(Of vwPropertiesWithGroup) = (From x In oThisGroupProps Order By x.PropertyName).ToList()

          Dim i As Int16 = 0
          Dim sPropRate As String = ""

          sRates = "<div class=""row"">" & _
                   "<div class=""col-xs-2"">Rate</div>" & _
                   "<div class=""col-xs-1"">BD</div>" & _
                   "<div class=""col-xs-1"">BA</div>" & _
                   "<div class=""col-xs-1"">Sleeps</div>" & _
                   "<div class=""col-xs-7"">Property</div>" & _
                   "</div>"

          sPropRate = ""
          For i = 0 To oPropsSort.Count - 1


            If bDiscountedRatesVisible AndAlso CNullD(oPropsSort(i).DiscountedRate) > 0.0 Then
              sPropRate = "<div class=""col-xs-2 discounted"">" & CNullD(oPropsSort(i).DiscountedRate).ToString() & "</div>"
              'sPropRate = "<div class=""col-xs-2 summer-rate-discounted"">" & oPropsSort(i).SummerRate & "</div><div class=""col-xs-2 discounted-rate"">" & IIf(oPropsSort(i).DiscountedRate > 0, oPropsSort(i).DiscountedRate, "") & "</div>"
            Else
              sPropRate = "<div class=""col-xs-2"">" & CNullD(oPropsSort(i).SummerRate).ToString() & "</div>"
            End If
            sPropRate &= "<div class=""col-xs-1"">" & oPropsSort(i).Bedrooms.ToString() & "</div>" & _
                "<div class=""col-xs-1"">" & oPropsSort(i).Baths.ToString() & "</div>" & _
                "<div class=""col-xs-1"">" & oPropsSort(i).Sleeps.ToString() & "</div>"

            sPropRate &= "<div class=""col-xs-7 prop-name"">" & oPropsSort(i).PropertyName & "</div>"

            sRates &= "<div class=""row"">" & sPropRate & "</div>"
          Next

        End If
      End If

    Catch ex As Exception

      Return ""
    End Try
    Return sRates
  End Function


  Public Shared Function GetPropertyGroupRates(oProps As List(Of vwPropertiesWithGroup), iGroupID As Integer, bDiscountedRatesVisible As Boolean) As String
    Dim sRates As String = ""
    Try

      If iGroupID > 0 Then
        Dim oThisGroupProps As List(Of vwPropertiesWithGroup) = (From x In oProps Where x.GroupID = iGroupID).ToList
        If oThisGroupProps.Count >= 1 Then
          Dim oPropsSort As List(Of vwPropertiesWithGroup) = (From x In oThisGroupProps Order By x.PropertyName).ToList()

          Dim i As Int16 = 0
          Dim sPropRate As String = ""

          sRates = ""

          sPropRate = ""
          For i = 0 To oPropsSort.Count - 1

            sPropRate = "<td class=""text-center""><a href=""#"" class=""btn-rates-avail text-center"" data-toggle=""modal"" data-target="".avail-cal""><i class=""fa fa-calendar"" aria-hidden=""true""></i></a></td>"

            If bDiscountedRatesVisible AndAlso CNullD(oPropsSort(i).DiscountedRate) > 0.0 Then
              sPropRate &= "<td class=""text-right rate-discounted"">" & FormatCurrency(CNullD(oPropsSort(i).DiscountedRate), 0) & "<sup>*</sup></td>"
              'sPropRate = "<div class=""col-xs-2 summer-rate-discounted"">" & oPropsSort(i).SummerRate & "</div><div class=""col-xs-2 discounted-rate"">" & IIf(oPropsSort(i).DiscountedRate > 0, oPropsSort(i).DiscountedRate, "") & "</div>"
            Else
              sPropRate &= "<td class=""text-right"">" & FormatCurrency(CNullD(oPropsSort(i).SummerRate), 0) & "</td>"
            End If
            sPropRate &= "<td class=""text-center"">" & oPropsSort(i).Bedrooms.ToString() & "</td>" & _
                "<td class=""text-center"">" & oPropsSort(i).Baths.ToString() & "</td>" & _
                "<td class=""text-center"">" & oPropsSort(i).Sleeps.ToString() & "</td>"

            sPropRate &= "<td>" & oPropsSort(i).PropertyName & "</td>"

            sRates &= "<tr>" & sPropRate & "</tr>"
          Next

        End If
      End If

      sRates = IIf(bDiscountedRatesVisible, "<div class=""rate-discounted"">* Discounted Rate</div>", "") & _
               "<table class=""table table-striped"">" & _
               "<thead class=""thead-dark"">" & _
                 "<th scope=""col"" class=""text-center"">Avail</th>" & _
                 "<th scope=""col"" class=""text-right"">Rate</th>" & _
                 "<th scope=""col"" class=""text-center"">BD</th>" & _
                 "<th scope=""col"" class=""text-center"">BA</th>" & _
                 "<th scope=""col"" class=""text-center"">Sleeps</th>" & _
                 "<th scope=""col"">Property</th>" & _
               "</thead>" & _
               sRates & _
               "</table>"
    Catch ex As Exception

      Return ""
    End Try
    Return sRates
  End Function

  Public Shared Sub CheckWebsiteOffline()
    Try

      Dim sWebsiteOffline = GetAppSetting("WebsiteOffline")
      Dim sByPass = CNullS(HttpContext.Current.Request.QueryString("BWO"))
      If sByPass <> "" Then
        HttpContext.Current.Session("WBP") = sByPass
      End If
      If (sWebsiteOffline = "True" And HttpContext.Current.Session("WBP") = "") Then
        HttpContext.Current.Response.Redirect(GetAppSetting("WebsiteOfflinePage"), True)
      End If
    Catch ex As Exception
      Dim s As String = ex.Message.ToString
    End Try
  End Sub

  Public Shared Function GetPropertyName(ByVal sPropertyName As String, ByVal sGroupName As String) As String
    If sGroupName = "" Then
      GetPropertyName = sPropertyName
    Else
      GetPropertyName = sGroupName
    End If
  End Function

  Protected Overrides Sub Finalize()

    MyBase.Finalize()
  End Sub
End Class
