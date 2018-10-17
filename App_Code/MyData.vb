Imports Microsoft.VisualBasic
Imports System.Configuration.ConfigurationManager
Imports System.Linq
Imports System.Data.Linq
Imports System.IO
Imports System.Net
Imports System
Imports System.Web
Imports System.Collections.Generic

Public Class MyData

  Inherits System.Web.UI.Page

  Private Shared mHouseRentalContext As HouseRentalDataContext = Nothing
  Public Shared ReadOnly Property HouseRentalContext() As HouseRentalDataContext
    Get
      ' BJR Put try to here to stop getting Open Data Reader errors 
      Try

        If mHouseRentalContext Is Nothing Then
          mHouseRentalContext = GetHouseRentalContext()
        End If
        Return mHouseRentalContext
      Catch ex As Exception
        Dim s As String = ""
      End Try
    End Get
  End Property

  Private Shared mHouseRentalContextTracking As HouseRentalDataContext = Nothing
  Public Shared ReadOnly Property HouseRentalContextTracking() As HouseRentalDataContext
    Get
      ' BJR Put try to here to stop getting Open Data Reader errors 
      Try

        If mHouseRentalContextTracking Is Nothing Then
          mHouseRentalContextTracking = GetHouseRentalContext(True)
        End If
        Return mHouseRentalContextTracking
      Catch ex As Exception
        Dim s As String = ""
      End Try
    End Get
  End Property
  Public Shared Function GetHouseRentalContext(Optional ByVal bEnableObjectTracking As Boolean = False, Optional ByVal sConnectionString As String = "HouseRentalConnectionString") As HouseRentalDataContext
    GetHouseRentalContext = Nothing
    Dim oLocalContext As New HouseRentalDataContext()
    Try

      oLocalContext.ObjectTrackingEnabled = bEnableObjectTracking
      GetHouseRentalContext = oLocalContext
    Catch ex As Exception
      oLocalContext.Dispose()
      oLocalContext = Nothing
      Throw New Exception("Error in GetHouseRentalContext", ex)
    End Try

  End Function

    Public Shared Function DisposeHouseRentalContext(ByRef MyDataContext As HouseRentalDataContext, Optional ByVal bSubmitChanges As Boolean = False) As Boolean
        DisposeHouseRentalContext = False
        Try
            If bSubmitChanges Then MyDataContext.SubmitChanges()
            MyDataContext.Connection.Close()
            MyDataContext.Dispose()
            MyDataContext = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
            DisposeHouseRentalContext = True
        Catch ex As Exception

        End Try
  End Function
  Protected Overrides Sub Finalize()
    If mHouseRentalContext IsNot Nothing Then DisposeHouseRentalContext(mHouseRentalContext)
    If mHouseRentalContextTracking IsNot Nothing Then DisposeHouseRentalContext(mHouseRentalContextTracking)
    MyBase.Finalize()
  End Sub



  Public Shared Function ErrorLogGetDup(ByVal TargeSite As String, ByVal Message As String) As WebErrorLog

    ErrorLogGetDup = Nothing
    Dim oDB As HouseRentalDataContext = GetHouseRentalContext()
    Try
      Return (From x In oDB.WebErrorLogs Where x.cErrorMessage = Message And x.cErrorTargetSite = TargeSite Select x).FirstOrDefault
    Catch ex As Exception
      MyErr.LogError(ex, False)
    End Try
    DisposeHouseRentalContext(oDB)
  End Function


  Public Shared Function GetCodeData(sKey As String, Optional ByRef oHouse As HouseRentalDataContext = Nothing, Optional bUseApplicationAsStore As Boolean = False) As String

    GetCodeData = ""
    Try

      If bUseApplicationAsStore Then
        GetCodeData = MyUtils.CNullS(HttpContext.Current.Application.Item(sKey.ToString), "nonsense")
        If GetCodeData <> "nonsense" Then
          Exit Function
        End If
      End If
      GetCodeData = ""
      Dim bDestroyHouse As Boolean = False
      If oHouse Is Nothing Then
        oHouse = GetHouseRentalContext()
        bDestroyHouse = True
      End If
      Dim oCode = (From x In oHouse.CodeDatas Where x.CodeKey = sKey).FirstOrDefault
      If oCode IsNot Nothing Then
        GetCodeData = MyUtils.CNullS(oCode.CodeValue)
        If GetCodeData = "" Then GetCodeData = MyUtils.CNullS(oCode.CodeValueLarge)
      End If
      If bDestroyHouse Then DisposeHouseRentalContext(oHouse)
      If bUseApplicationAsStore And GetCodeData <> "" Then HttpContext.Current.Application.Item(sKey.ToString) = GetCodeData.ToString

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function


  Public Shared Function GetAvailabilityChart(ByRef oProps As List(Of vwPropertiesWithGroup), ByVal sStartName As String, ByVal iStartCount As Integer, ByRef iNewCount As Integer, bJustIncrementCounter As Boolean, oPropAvailabilities As List(Of vwPropertyAvailability)) As String
    GetAvailabilityChart = ""
    Try

      Dim sAvail As String = ""
      Dim bAfterSeason As Boolean = MyUtils.AfterSeason
      Dim sBookingYear As String = Year(CDate(GetCodeData("BookingYearStart")))
      If bAfterSeason Then
        sBookingYear = CDate(MyUtils.GetAppSetting("SeasonStartDate")).Year + 1
      End If

      
      sAvail &= "<div class=""key row"">" & vbCrLf
      sAvail &= "<div class=""col-xs-5 avail""><a id=""Availability""> </a>Availability In " & sBookingYear & " Season</br><span style='color:red;'>Chart Always Current</span> </div>" & vbCrLf
      sAvail &= "<div class=""col-xs-7"">" &
                "<div class=""pull-right""><div class=""PropOpen"">Available</div><div class=""PropHold"">On Hold</div><div class=""PropReserved"">Not Available</div></div>"
      If bAfterSeason Then
        sAvail &= "</div><!--/col7-->" & vbCrLf &
                "<div class=""col-xs-12 book-not-avail"">" & sBookingYear & " Reservations Begin " & CDate(MyUtils.GetAppSetting("SeasonStartDate")).ToString("MMMM d, yyyy") & "<div>Self-Book Online at Midnight OR by Phone at 9:00 am EST</div></div>"
      Else
        sAvail &= "<div class=""book-instruction"">Click <i class=""fa fa-hotel"" aria-hidden=""True""></i> to BOOK</div><!--/inst-->" &
                "</div><!--/col7-->" & vbCrLf
      End If
      
      sAvail &= "</div>" & vbCrLf

      ' If Aprtments or Rooms& Suites, multiple avail charts need 
      Dim oProp As vwPropertiesWithGroup, sPropIDs As String = "", iCount As Integer = 0, iLastProperty_ID As Integer = 0
      For iCount = iStartCount To oProps.Count - 1
        oProp = oProps(iCount)
        If oProp.Property_ID <> iLastProperty_ID Then
          iLastProperty_ID = oProp.Property_ID
          If sStartName <> oProp.PropertyGroupName Then Exit For

          sPropIDs &= oProp.Property_ID & ","
          sAvail &= "<div Class=""cal row"">" & vbCrLf
          If MyUtils.CNullI(oProp.GroupID) > 0 Then
            sAvail &= "<h5>" & oProp.PropertyName & "</h5>" & vbCrLf
            iNewCount = iCount
          End If
          If bAfterSeason Then
            sAvail &= CreateAvailabilityChartAfterSeason() & "</div><!--/cal-->"
          Else
            sAvail &= CreateAvailabilityChart(oProp.Property_ID, oPropAvailabilities) & "</div><!--/cal-->"
          End If
        End If

      Next

      sPropIDs = sPropIDs.Substring(0, sPropIDs.Length - 1)


      If Not bJustIncrementCounter Then GetAvailabilityChart = sAvail
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function

  Private Shared Function CreateAvailabilityChart(iPropertyID As Integer, oPropAvailabilities As List(Of vwPropertyAvailability)) As String
    CreateAvailabilityChart = ""
    Dim sOut As String = "", sHead As String = "", sBody As String = "", sClass As String = "", siClass As String = ""
    Dim dStartDate As DateTime = Nothing, dEndDate As DateTime = Nothing
    Dim sHREF As String = "", sCloseHREF As String = "", sPropStatus As String = "", sWeekParam As String
    Dim oAES As New MyAES, sPass As String = AppSettings("EncryptPassword")

    Try
      Dim oThisPropAvails As List(Of vwPropertyAvailability) = (From x In oPropAvailabilities Where x.Property_ID = iPropertyID Order By x.StartDate).ToList()

      For Each oThisPropAvail In oThisPropAvails

        dStartDate = Convert.ToDateTime(oThisPropAvail.StartDate)
        dEndDate = Convert.ToDateTime(oThisPropAvail.EndDate)

        sHREF = ""
        sCloseHREF = ""
        If oThisPropAvail.Booked Then
          If oThisPropAvail.Status = "Hold" Then
            sClass = "PropHold"
            siClass = "fa fa-pause"
            sPropStatus = "On Hold"
          Else
            sClass = "PropReserved"
            siClass = "fa fa-minus"
            sPropStatus = "Not Available"
          End If
        Else
          sClass = "PropOpen"
          siClass = "fa fa-hotel"
          sPropStatus = "Book Rental"
          sWeekParam = Web.HttpUtility.UrlEncode(oAES.AES_Encrypt(dStartDate.ToShortDateString, sPass) & ":" & oAES.AES_Encrypt(dEndDate.ToShortDateString, sPass))
          sHREF = "<a href=""" & MyUtils.GetAppSetting("ReservationWebsite") & "/Reserve.aspx?PropID=" & oThisPropAvail.Property_ID & "&amp;Week=" & sWeekParam & """ rel=""nofollow"">"
          sCloseHREF = "</a>"
        End If

        sHead &= "<th class=""" & sClass & """>" & dStartDate.Month & "/" & dStartDate.Day & "<br/>to<br/>" & dEndDate.Month & "/" & dEndDate.Day & "</th>" & vbCrLf
        sBody &= "<td class=""" & sClass & """>" & sHREF & "<i class=""" & siClass & """ aria-hidden=""True"" title=""" & sPropStatus & """></i>" & sCloseHREF & "</td>" & vbCrLf

      Next

      sOut = "<table class=""table table-bordered""><thead><tr>" & vbCrLf & sHead & vbCrLf
      sOut &= "</tr></thead><tbody><tr>" & vbCrLf & sBody & vbCrLf
      sOut &= "</tr></tbody></table>" & vbCrLf
      CreateAvailabilityChart = sOut

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try
  End Function
  Private Shared Function CreateAvailabilityChartAfterSeason() As String
    CreateAvailabilityChartAfterSeason = ""
    Dim sOut As String = "", sHead As String = "", sBody As String = ""
    Dim dSeasonStartDate As Date = CDate(MyUtils.GetAppSetting("SeasonStartDate"))
    Dim dStartDate As DateTime = CDate("5/1/" & dSeasonStartDate.Year + 1), dEndDate As DateTime = CDate("10/1/" & dSeasonStartDate.Year + 1)

    Try

      Dim oWeeks As List(Of [Event]) = (From x In HouseRentalContext.Events Where x.StartDate > dStartDate And x.EndDate < dEndDate Order By x.StartDate).ToList
      For Each oWeek In oWeeks
        dStartDate = Convert.ToDateTime(oWeek.StartDate)
        dEndDate = Convert.ToDateTime(oWeek.EndDate)
        sHead &= "<th class=""PropOpen"">" & dStartDate.Month & "/" & dStartDate.Day & "<br/>to<br/>" & dEndDate.Month & "/" & dEndDate.Day & "</th>" & vbCrLf
        sBody &= "<td class=""PropOpen""><i class=""fa fa-check"" aria-hidden=""True"" title=""Available""></i></td>" & vbCrLf
      Next

      sOut = "<table class=""table table-bordered""><thead><tr>" & vbCrLf & sHead & vbCrLf
      sOut &= "</tr></thead><tbody><tr>" & vbCrLf & sBody & vbCrLf
      sOut &= "</tr></tbody></table>" & vbCrLf
      CreateAvailabilityChartAfterSeason = sOut

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try
  End Function


  Public Shared Function CreateMapButton(sPropID As String, sGroupID As String, sHostName As String, sMapType As String) As String

    CreateMapButton = ""
    Try

      Dim sOut As String = ""
      Dim sHostHeader As String = "www", sArea As String = "", sGoogle As String = ""
      Dim sHostTLD As String = MyUtils.ParseString(sHostName, ".", 2)
      Dim sVillageProps As String = MyUtils.GetAppSetting("VillageMapProperties"), sPage As String = "area-map"

      If sVillageProps.Contains(":" & sPropID & ":") Then sPage = "village-map"

      sArea = "<a class=""MapButton PlainText"" href=""/" & sPage & "?Props=" & sPropID & ":" & sGroupID & """ target=""_blank"" title=""View on Area Map"">Area Map</a>" & vbCrLf
      sGoogle = "<a class=""MapButton PlainText"" href=""/rental-map?Place=CDP&IDs=" & sPropID & """  target=""_blank"" title=""View on Google Map"">Google Map</a>" & vbCrLf

      If sMapType = "Google" Then
        CreateMapButton = sGoogle
      ElseIf sMapType = "Area" Then
        CreateMapButton = sArea
      Else
        CreateMapButton &= sArea & sGoogle
      End If
    Catch ex As Exception

    End Try


  End Function


    Public Shared Function GetMapUrl(sPropID As String, sGroupID As String, sHostName As String, sMapType As String) As String

        GetMapUrl = ""
        Try

            Dim sOut As String = ""
            Dim sHostHeader As String = "www", sArea As String = "", sGoogle As String = ""
            Dim sHostTLD As String = MyUtils.ParseString(sHostName, ".", 2)
      Dim sVillageProps As String = MyUtils.GetAppSetting("VillageMapProperties"), sPage As String = "area-map"

      If sVillageProps.Contains(":" & sPropID & ":") Then sPage = "village-map"
            If sHostName.ToLower.Contains("test") Then sHostHeader = "test"
            If sHostTLD.Trim = "" Then sHostTLD = "com"

      sArea = "/" & sPage & "?Props=" & sPropID & ":" & sGroupID
      sGoogle = "/rental-map?Place=CDP&IDs=" & sPropID

      If sMapType = "Google" Then
                GetMapUrl = sGoogle
            ElseIf sMapType = "Area" Then
                GetMapUrl = sArea
            Else
                GetMapUrl = sArea
            End If
        Catch ex As Exception

        End Try

    End Function


   Public Shared Function GetWebItemByKey(ByVal sKey As String, Optional ByRef oHouse As HouseRentalDataContext = Nothing) As WebItem

    GetWebItemByKey = GetWebItem(sKey, 0, oHouse)

  End Function

  Public Shared Function GetWebItemByID(ByVal iWebItemID As Integer, Optional ByRef oHouse As HouseRentalDataContext = Nothing) As WebItem

    GetWebItemByID = GetWebItem("", iWebItemID, oHouse)

  End Function

  Public Shared Function GetWebItem(ByVal sKey As String, ByVal iWebItemID As Integer, Optional ByRef oHouse As HouseRentalDataContext = Nothing) As WebItem

    GetWebItem = Nothing
    Dim bCloseConn As Boolean = (oHouse Is Nothing)
    If bCloseConn Then oHouse = GetHouseRentalContext()

    Try
      Dim oWebItem As WebItem = Nothing
      If iWebItemID > 0 Then
        oWebItem = (From x In oHouse.WebItems Where x.ID = iWebItemID).FirstOrDefault
      ElseIf sKey <> "" Then
        oWebItem = (From x In oHouse.WebItems Where x.ItemKey = sKey).FirstOrDefault
      End If

      If oWebItem IsNot Nothing AndAlso oWebItem.ID > 0 Then
        If MyUtils.InEditMode Or CBool(oWebItem.Show) Then GetWebItem = oWebItem
      End If

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try
    If bCloseConn Then DisposeHouseRentalContext(oHouse)

  End Function
  Public Shared Function GetWebItemForDisplay(ByRef oDisplayLiteral As System.Web.UI.WebControls.Literal, ByVal sKey As String, Optional ByRef oHouse As HouseRentalDataContext = Nothing, Optional ByVal iTextWidth As Integer = 0, Optional ByVal bDontUseSession As Boolean = False, Optional sRoundCornerClass As String = "") As String

    GetWebItemForDisplay = ""

    Dim bCloseConn As Boolean = (oHouse Is Nothing)
    If bCloseConn Then oHouse = GetHouseRentalContext()

    Try
      Dim oWebItem As WebItem = GetWebItemByKey(sKey, oHouse)
      If oWebItem IsNot Nothing AndAlso oWebItem.ID > 0 Then
        oDisplayLiteral.Visible = MyUtils.InEditMode Or CBool(oWebItem.Show)
        If MyUtils.InEditMode Or CBool(oWebItem.Show) Then
          If oWebItem.Type = "HTML" Then
            GetWebItemForDisplay = oWebItem.Value
          ElseIf oWebItem.Type = "Image" Then
            GetWebItemForDisplay = "<img src=""" & MyUtils.GetAppSetting("PhotosDir") & oWebItem.Media & """ "
            GetWebItemForDisplay &= " alt=""" & If(oWebItem.Title = "", oWebItem.ItemKey, oWebItem.Title) & """ "
            If MyUtils.CNullI(oWebItem.Height) > 0 Then GetWebItemForDisplay &= " height=""" & oWebItem.Height & """ "
            If MyUtils.CNullI(oWebItem.Width) > 0 Then GetWebItemForDisplay &= " width=""" & oWebItem.Width & """ "
            GetWebItemForDisplay &= " />"
            If MyUtils.CNullS(oWebItem.ClickURL) <> "" Then
              GetWebItemForDisplay = "<a href=""" & oWebItem.ClickURL & """ target=""_blank"" >" & GetWebItemForDisplay & "</a>"
            End If
 
          End If
        End If

        If MyUtils.InEditMode Then
          Dim sURL As String = "", iHeight As Integer = MyUtils.CNullI(oWebItem.Height), iWidth As Integer = MyUtils.CNullI(oWebItem.Width), iEditWidth As Integer = 0
          If iTextWidth > 0 Then iWidth = iTextWidth
          If iHeight = 0 Then iHeight = 500
          If iWidth = 0 Then iWidth = 400
          iEditWidth = iWidth + 75
          If GetWebItemForDisplay = "" Then
            If oWebItem.Type = "HTML" Then
              GetWebItemForDisplay = "<br><br>Click Here to Add Text<br><br>"
            Else
              GetWebItemForDisplay = "<br><br>Click Here to Add Image<br><br>"
            End If
          End If
          sURL = MyUtils.GetEditWebsiteLink & "&WebItemID=" & oWebItem.ID & "&Width=" & iWidth & "&Height=" & iHeight
          If Not CBool(oWebItem.Show) Then
            GetWebItemForDisplay = "<div style=""cursor:pointer;"" title=""THIS ITEM NOT SET TO SHOW ON WEBSITE"" onclick=""EditContent('" & sURL & "'," & iEditWidth & "," & iHeight + 270 & ");"">" & GetWebItemForDisplay & "</div>" & vbCrLf
          Else
            GetWebItemForDisplay = "<div style=""cursor:pointer;"" title=""Click to edit text"" onclick=""EditContent('" & sURL & "'," & iEditWidth & "," & iHeight + 270 & ");"">" & GetWebItemForDisplay & "</div>" & vbCrLf
          End If

        End If
      End If

      If sRoundCornerClass <> "" Then
        GetWebItemForDisplay = "<div class=""" & sRoundCornerClass & """ >" & GetWebItemForDisplay & "</div>"
      End If

      If oDisplayLiteral.Visible Then oDisplayLiteral.Text = GetWebItemForDisplay
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try
    If bCloseConn Then DisposeHouseRentalContext(oHouse)


  End Function

  Public Shared Function GetPropertyInfoByName(ByVal sPropertyName As String, ByRef sPropertyID As String, ByRef sGroupID As String, ByRef bIsActive As Boolean, ByRef sCategoryID As String) As Boolean
    Dim sCanonicalName As String = ""
    Return GetPropertyInfoByName(sPropertyName, sPropertyID, sGroupID, bIsActive, sCategoryID, sCanonicalName)
  End Function
  Public Shared Function GetPropertyInfoByName(ByVal sPropertyName As String, ByRef sPropertyID As String, ByRef sGroupID As String, ByRef bIsActive As Boolean, ByRef sCategoryID As String, ByRef sCanonicalName As String) As Boolean

    GetPropertyInfoByName = False
    Dim oDB As HouseRentalDataContext = MyData.GetHouseRentalContext

    Try

      Dim oProp As vwPropertiesWithGroup = Nothing, iGroupID As Integer = MyUtils.CNullI(sGroupID), iPropID As Integer = MyUtils.CNullI(sPropertyID)
      If sPropertyName <> "" Then
        ' If make change here, need to change SetPropertyName
        oProp = (From x In oDB.vwPropertiesWithGroups Where x.PropertyName.ToLower.Replace("'", "").Replace("-", "").Replace("#", "Number").Replace(".", "").Replace("&", "and") = sPropertyName And x.Status = "Active").FirstOrDefault
        ' If oProp Is Nothing Then MyErr.LogError("Could not get info for " & sPropertyName, "GetPropertyInfoByName")
      ElseIf iGroupID > 0 Then
        oProp = (From x In oDB.vwPropertiesWithGroups Where x.GroupID = iGroupID And x.Status = "Active").FirstOrDefault
      ElseIf iPropID > 0 Then
        oProp = (From x In oDB.vwPropertiesWithGroups Where x.Property_ID = iPropID).FirstOrDefault
      End If
      If oProp IsNot Nothing Then
        sPropertyID = oProp.Property_ID.ToString
        sGroupID = oProp.GroupID.ToString
        bIsActive = (oProp.Status = "Active")
        sCategoryID = oProp.Category_ID
        sCanonicalName = oProp.PropertyName
        If IsNumeric(sGroupID) Then
          iGroupID = CInt(sGroupID)
          oProp = (From x In oDB.vwPropertiesWithGroups Where x.GroupID = iGroupID And x.Status = "Active" Order By x.SequenceNumber).FirstOrDefault
          If oProp IsNot Nothing Then
            sCanonicalName = oProp.PropertyName
          End If
        End If
      End If

      GetPropertyInfoByName = True
    Catch ex As Exception
      Dim s As String = ex.Message
      '      MyErr.HandleError(ex)
    End Try
    MyData.DisposeHouseRentalContext(oDB)

  End Function


  Public Shared Function PropertyDiscountsExist() As Boolean

    Dim sCheck As String = "False"
    Try
      sCheck = MyUtils.CNullS(HttpContext.Current.Session("DiscountPropertiesExist"))

      If sCheck <> "" Then
      Else

        Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext

        Dim oActPropWithDiscount = (From x In oHouse.vwPropertiesWithGroups Where x.Status = "Active" And x.DiscountedRate > 0).FirstOrDefault
        If oActPropWithDiscount Is Nothing Then
          sCheck = "False"
        Else
          sCheck = "True"
        End If
        HttpContext.Current.Session("DiscountPropertiesExist") = sCheck
        MyData.DisposeHouseRentalContext(oHouse)
      End If
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

    If sCheck = "" Then sCheck = "False"

    Return CBool(sCheck)

  End Function

  Public Shared Function RetrievePropertyName(ByVal sPropertyName As String) As String


    RetrievePropertyName = sPropertyName.Replace("-", "").Replace("Number", "#").Replace("and", "&")
  End Function

  'Public Shared Function SetPropertyName(ByVal sPropertyName As String, iPropertyCategory As Integer, Optional iSecondCategory As Integer = 0) As String

  '  SetPropertyName = ""
  '  Dim sCategory As String = "", sHomeType As String = "", sDreamsPark As String = "", sCity As String = "Cooperstown"
  '  Dim RandomClass As New Random()
  '  Dim iRandomNumber As Integer = 0, iRandomNumber2 As Integer = 0
  '  '    iRandomNumber = RandomClass.Next(1, 4)
  '  iRandomNumber2 = RandomClass.Next(1, 3)

  '  iRandomNumber = 2
  '  Select Case iRandomNumber
  '    Case 1
  '      sHomeType = "-Home"
  '    Case 2
  '      sHomeType = "-House"
  '    Case 3
  '      sHomeType = "-Lodging"
  '  End Select

  '  'If iRandomNumber2 = 2 Then sDreamsPark = "-Dreams-Park"
  '  If iPropertyCategory = 10 And iSecondCategory > 0 Then
  '    sCity = "Oneonta"
  '    iPropertyCategory = iSecondCategory
  '  End If

  '  Select Case iPropertyCategory
  '    Case 1  ' Apartment
  '      sHomeType = "-Apartment"
  '      '        If iRandomNumber2 = 1 Then sHomeType = "-Apartment"
  '    Case 3, 13 ' Lakefront
  '      sCategory = "-Lake"
  '      If iRandomNumber2 = 1 Then sCategory = "-Lakefront"
  '    Case 4 ' Riverfront
  '      sCategory = "-Waterfront"
  '      '        If iRandomNumber2 = 1 Then sCategory = "-Riverfront"
  '    Case 5 ' Rooms and suites
  '      If iRandomNumber2 = 1 Then sHomeType = "-Suite"
  '    Case 6, 7, 8, 9, 11 ' Homes
  '    Case 10 ' Oneonta
  '      sCity = "Oneonta"
  '      sDreamsPark = ""
  '    Case Else
  '      SetPropertyName = "Rental-Lodging"
  '  End Select

  '  ' BJR - changed to not have so much variation in URLs for same content

  '  If SetPropertyName = "" Then SetPropertyName = sCity & sCategory & "-Rental" & sHomeType
  '  '    If SetPropertyName = "" Then SetPropertyName = sCity & sDreamsPark & sCategory & "-Rental" & sHomeType
  '  ' If SetPropertyName = "" Then SetPropertyName = sCategory & "/" & sCity & sDreamsPark & "-Rental" & sHomeType
  '  ' If make change here, need to change GetPropertyInfoByName
  '  SetPropertyName = SetPropertyName & "/" & sPropertyName.Replace("-", "").Replace(" ", "-").Replace("'", "").Replace("#", "Number").Replace(".", "").Replace("&", "and")

  'End Function



  '' 4/18/18 - SAM - removed random and category specific folder naming
  'Public Shared Function SetPropertyName(ByVal sPropertyName As String, iPropertyCategory As Integer, Optional iSecondCategory As Integer = 0) As String

  '  SetPropertyName = "lodging-rentals/" & sPropertyName.Replace("-", "").Replace(" ", "-").Replace("'", "").Replace("#", "Number").Replace(".", "").Replace("&", "and")

  'End Function



  ' 4/18/18 - SAM - removed random and category specific folder naming
  Public Shared Function SetPropertyName(ByVal sPropertyName As String, iPropertyCategory As Integer, Optional iSecondCategory As Integer = 0) As String

    SetPropertyName = ""

    Select Case iPropertyCategory
      Case 1  ' Apartment
        SetPropertyName = "apartment-rentals"
      Case 3, 13 ' Lakefront
        SetPropertyName = "house-rentals-on-lake"
      Case 4 ' Riverfront
        SetPropertyName = "house-rentals-on-lake"
      Case 5 ' Rooms and suites
        SetPropertyName = "rooms-suites"
      Case 6, 7, 8, 9, 11 ' Homes
        SetPropertyName = "house-rentals"
      Case 10 ' Oneonta
        SetPropertyName = "oneonta-ny-lodging"
      Case 15 ' Group
        SetPropertyName = "group-lodging"
      Case Else
        SetPropertyName = "lodging-rentals"
    End Select

    ' BJR - changed to not have so much variation in URLs for same content

    If SetPropertyName = "" Then SetPropertyName = "rentals"
    '    If SetPropertyName = "" Then SetPropertyName = sCity & sDreamsPark & sCategory & "-Rental" & sHomeType
    ' If SetPropertyName = "" Then SetPropertyName = sCategory & "/" & sCity & sDreamsPark & "-Rental" & sHomeType
    ' If make change here, need to change GetPropertyInfoByName
    SetPropertyName = SetPropertyName & "/" & sPropertyName.Replace("-", "").Replace(" ", "-").Replace("'", "").Replace("#", "Number").Replace(".", "").Replace("&", "and")

  End Function



  Public Shared Sub SetPageRoutes(ByVal oRoute As System.Web.Routing.RouteCollection)

    'oRoute.MapPageRoute("PropertyName1", "Rental-Lodging/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName2", "Oneonta-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName3", "Oneonta-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName4", "Oneonta-Rental-Lodging/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName5", "Cooperstown-Rental-Suite/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName6", "Cooperstown-Rental-Apartment/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName7", "Cooperstown-Dreams-Park-Rental-Suite/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName8", "Cooperstown-Dreams-Park-Rental-Apartment/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName9", "Cooperstown-Waterfront-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName10", "Cooperstown-Lakefront-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName11", "Cooperstown-Lake-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName12", "Cooperstown-Riverfront-Rental-Home/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName13", "Cooperstown-Dreams-Park-Waterfront-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName14", "Cooperstown-Dreams-Park-Lakefront-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName15", "Cooperstown-Dreams-Park-Lake-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName16", "Cooperstown-Dreams-Park-Riverfront-Rental-Home/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName17", "Cooperstown-Waterfront-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName18", "Cooperstown-Lakefront-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName19", "Cooperstown-Lake-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName20", "Cooperstown-Riverfront-Rental-House/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName21", "Cooperstown-Dreams-Park-Waterfront-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName22", "Cooperstown-Dreams-Park-Lakefront-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName23", "Cooperstown-Dreams-Park-Lake-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName24", "Cooperstown-Dreams-Park-Riverfront-Rental-House/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName25", "Cooperstown-Waterfront-Rental-Lodging/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName26", "Cooperstown-Lakefront-Rental-Lodging/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName27", "Cooperstown-Lake-Rental-Lodging/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName28", "Cooperstown-Riverfront-Rental-Lodging/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName29", "Cooperstown-Dreams-Park-Waterfront-Rental-Lodging/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName30", "Cooperstown-Dreams-Park-Lakefront-Rental-Lodging/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName31", "Cooperstown-Dreams-Park-Lake-Rental-Lodging/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName32", "Cooperstown-Dreams-Park-Riverfront-Rental-Lodging/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName33", "Cooperstown-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName34", "Cooperstown-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName35", "Cooperstown-Rental-Lodging/{PropertyName}", "~/Details.aspx")

    'oRoute.MapPageRoute("PropertyName36", "Cooperstown-Dreams-Park-Rental-Home/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName37", "Cooperstown-Dreams-Park-Rental-House/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName38", "Cooperstown-Dreams-Park-Rental-Lodging/{PropertyName}", "~/Details.aspx")




    oRoute.MapPageRoute("PropertyName39", "apartment-rentals/{PropertyName}", "~/Details.aspx")
    oRoute.MapPageRoute("PropertyName40", "house-rentals-on-lake/{PropertyName}", "~/Details.aspx")
    'oRoute.MapPageRoute("PropertyName41", "house-rentals-on-river/{PropertyName}", "~/Details.aspx")
    oRoute.MapPageRoute("PropertyName42", "rooms-suites/{PropertyName}", "~/Details.aspx")
    oRoute.MapPageRoute("PropertyName43", "house-rentals/{PropertyName}", "~/Details.aspx")
    oRoute.MapPageRoute("PropertyName44", "oneonta-ny-lodging/{PropertyName}", "~/Details.aspx")
    oRoute.MapPageRoute("PropertyName45", "group-lodging/{PropertyName}", "~/Details.aspx")
    oRoute.MapPageRoute("PropertyName46", "lodging-rentals/{PropertyName}", "~/Details.aspx")



    ' house-rentals
    ' room-suite
    ' apartment-rentals
    ' oneonta-ny-lodging
    ' house-rentals-on-lake


    ' could do a generic folder like:
    ' /lodging
    ' /lodging-rentals (i like this one the best. doesn't conflict with house-rentals, has two great terms, makes sense, and generic enough for all categories)
    ' /lodging-house-rentals
    ' /house-rentals (but they're not all houses)

    ' doing something general/static makes most sense since they could change the 
    ' primary category of a rental and that would cause a broken link if we dynamically determine the parent folder based on the primary category.

    ' you might want to consider making the generic folder resolve to a search page and the search results page instead of /search-lodging

  End Sub


End Class
