Imports System.Configuration.ConfigurationManager
Imports System.Linq
Imports System.Data.Linq

Partial Class GoogleMap
  Inherits System.Web.UI.Page

  Private _locationTitle As String
  Private _locationInfo As String
  Private _locationName As String
  Private _locationLat As String
  Private _locationLng As String
  Private _locationAddress As String

  Public Property LocationTitle() As String
    Get
      Return _locationTitle
    End Get
    Set(ByVal value As String)
      _locationTitle = value
    End Set
  End Property

  Public Property LocationInfo() As String
    Get
      Return _locationInfo
    End Get
    Set(ByVal value As String)
      _locationInfo = value.Replace("""", "\""")
    End Set
  End Property

  Public Property LocationName() As String
    Get
      Return _locationName
    End Get
    Set(ByVal value As String)
      _locationName = value
    End Set
  End Property

  Public Property LocationLat() As String
    Get
      Return _locationLat
    End Get
    Set(ByVal value As String)
      _locationLat = value
    End Set
  End Property

  Public Property LocationLng() As String
    Get
      Return _locationLng
    End Get
    Set(ByVal value As String)
      _locationLng = value
    End Set
  End Property

  Public Property LocationAddress() As String
    Get
      Return _LocationAddress
    End Get
    Set(ByVal value As String)
      _LocationAddress = value
    End Set
  End Property


  Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load



    If IsPostBack Then
    Else


      Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext()
      Try

        Dim sGMapScript As String = "", sIDs As String, sCenter As String, sParkTitle As String = "", sLoc As String = "", bMultiTourn As Boolean = False
        Dim dParkLat As Double = 0, dParkLong As Double = 0, sTitle As String = "", sWhere As String = "", sMsg As String = "", oRand As New System.Random
        Dim dLatUsed(50) As Double, dLongUsed(50) As Double, iIndex As Integer, iCount As Integer, dCurrLat As Double, dCurrLong As Double, sData() As String = Nothing
        Dim oMark As Artem.Google.UI.Marker = Nothing, oIcon As New Artem.Google.UI.MarkerImage
        Dim dMinLat As Double = 10000, dMaxLat As Double = -1000, dMinLong As Double = 1000, dMaxLong As Double = -1000
        Dim dLatSum As Double = 0, dLongSum As Double = 0, iLatLongCount As Integer = 0, sParkInfo As String = "", iLatDiff As Double = 0, iLongDiff As Double = 0
        Dim iLatScale As Integer = 0, iLongScale As Integer = 0, sAutoZoomScript As String = "", sIDsa() As String = Nothing, sThisID As String = ""


        sIDs = MyUtils.CNullS(Request("IDs"))
        If sIDs.ToString <> "" Then
          sData = Split(sIDs, "|")
          sIDs = ","
          For Each sID In sData
            sThisID = MyUtils.ParseString(sID, ":", 0)
            sIDs &= sThisID & ","
            MyUtils.AddItemToArray(sIDsa, sThisID)
          Next
        End If


        iCount = 0


        sCenter = MyUtils.CNullS(Request("Place"))

        If dParkLat > 0 Then

          dLatSum += dParkLat
          dLongSum += dParkLong
          iLatLongCount += 1

          dMinLat = dParkLat
          dMinLong = dParkLong
          dMaxLat = dParkLat
          dMaxLong = dParkLong
        End If

        Dim iLastID As Integer = 0
        Dim oProps = (From x In oHouse.vwPropertiesWithGroups Where sIDsa.Contains(x.Property_ID))
        For Each oProp In oProps

          If iLastID <> oProp.Property_ID Then
            iLastID = oProp.Property_ID

            If oProp.Latitude <> 0 And oProp.Longitude <> 0 Then
              dCurrLat = oProp.Latitude
              dCurrLong = oProp.Longitude
              dLatSum += dCurrLat
              dLongSum += dCurrLong
              iLatLongCount += 1

              If dCurrLat < dMinLat Then dMinLat = dCurrLat
              If dCurrLong < dMinLong Then dMinLong = dCurrLong
              If dCurrLat > dMaxLat Then dMaxLat = dCurrLat
              If dCurrLong > dMaxLong Then dMaxLong = dCurrLong

              For iIndex = 0 To iCount
                If Math.Abs(dLatUsed(iIndex) - dCurrLat) < 0.0001 And Math.Abs(dLongUsed(iIndex) - dCurrLong) < 0.001 Then
                  dCurrLat = dCurrLat + (oRand.NextDouble() - 0.5) * 0.001
                  dCurrLong = dCurrLong + (oRand.NextDouble() - 0.5) * 0.001
                  Exit For
                End If
              Next
              dLatUsed(iCount) = dCurrLat
              dLongUsed(iCount) = dCurrLong
              iCount += 1

              sTitle = "<span class=""GoogleMapInfo""><b><a href=""http://" & MyUtils.GetAppSetting("MainWebsite") & "/Details.aspx?PropID=" & oProp.Property_ID & "&GroupID=" & oProp.GroupID & """ target=""_blank"">" & oProp.PropertyName.ToString & "</a></b> <br><div class='FloatLeft'>"
              sTitle += oProp.Address.ToString & "<BR/>"
              sTitle += oProp.Bedrooms.ToString & " Bd, "
              sTitle += oProp.Baths.ToString.Replace(".0", "") & " Ba, "
              sTitle += FormatCurrency(oProp.SummerRate, 0) & "/wk<BR/>"

              sTitle += oProp.Distance2Coop.ToString & " Mi to Cooperstown<BR/>"
              Select Case sCenter
                Case "CDP", ""
                  sTitle += oProp.Distance2CDP & " Mi to Dreams Park<BR/>"
                Case "ASV", ""
                  sTitle += oProp.Distance2ASV & " Mi to " & sLoc.ToString & "<BR/>"
                Case "BW", ""
                  sTitle += oProp.Distance2BW & " Mi to " & sLoc.ToString & "<BR/>"
              End Select

              sTitle += "</div><div class='FloatRight'><img width='70px' src='" & MyUtils.GetAppSetting("MainWebsite") & "/PropertyPhotos/" & oProp.Property_ID & "/" & oProp.MasterImageFile & "' border='0' alt='" & oProp.PropertyGroupName & " /></div></span>"

              LocationInfo = sTitle
              LocationTitle = oProp.PropertyName & " - Click for details!"
              LocationName = oProp.PropertyName
              LocationLat = oProp.Latitude.ToString()
              LocationLng = oProp.Longitude.ToString()
              'LocationAddress = HttpUtility.UrlEncode(oProp.Address & "," & oProp.City & " " & oProp.Zip)
              LocationAddress = (oProp.Address & "," & oProp.City & " " & oProp.Zip).Replace(" ", "+") ' changed from using HttpUtility.UrlEncode because it was causing problems on some properties when the comma was converted to "%2c"

              Title = "Map of " & oProp.PropertyName & " in " & oProp.City.Replace("  NY", ", NY")
              litTitle.Text = "<title>" & oProp.PropertyName & " Rental Property - Map and Directions | Cooperstown Stay</title>"
              MetaDescription = oProp.PropertyName & " is located at " & oProp.Address & ", " & oProp.City.Replace("  NY", ", NY") & " " & oProp.Zip & ". View the rental property on the map, get directions to/from local attractions in Cooperstown, NY"
              litCanonical.Text = "<link rel=""canonical"" href=""" & MyUtils.GetAppSetting("MainWebsite") & "/rental-map?Place=" & MyUtils.CNullS(Request.Item("Place")) & "IDs=" & MyUtils.CNullS(Request.Item("IDs")) & """ />"


              'for more map parameters SEE: https://developers.google.com/maps/documentation/urls/guide
              ' link to directions by Property Address
              litDirFromAnywhere.Text = "<div class=""text-center""><a href=""https://www.google.com/maps/dir/?api=1&destination=" & LocationAddress & """ class=""btn btn-sm btn-primary hidden-print"" style=""white-space:normal"">Get Directions to <strong>" & oProp.PropertyName & "</strong> from Anywhere</a></div>"

              ' link to directions by Property LAT/LNG.  
              ' I decided not to use Lat/Lng because I noticed the lat/lng directions for some properties resulted in directions for the wrong address.
              ' For Example: Deer Meadow Farm Studio
              ' by address - https://www.google.com/maps/dir/?api=1&destination=169+Van+Yahres+Road%2cCooperstown+NY+13326
              ' by lat/lng - https://www.google.com/maps/dir/?api=1&destination=42.74089,-74.87732  (notice the resolved address in the destination field on Google Maps)
              'litDirFromAnywhere.Text = "<a href=""https://www.google.com/maps/dir/?api=1&destination=" & oProp.Latitude & "," & oProp.Longitude & """ class=""btn btn-sm btn-primary hidden-print"">Get Directions to <strong>" & oProp.PropertyName & "</strong> from Anywhere</a>"
              
            Else
              sMsg += "<a href=""/Details.aspx?PropID=" & oProp.Property_ID & """ target=""_blank"">" & oProp.PropertyName & "</a><BR/>"
            End If
          End If

        Next

        If sMsg.ToString <> "" Then
          sMsg = "<h5>Map information not available for the following properties</h5>" & sMsg
        End If


      Catch ex As Exception
        MyErr.HandleError(ex)
      End Try

    End If




  End Sub


  Public Function CreateMapMarker(sParkLoc As String, dParkLat As Decimal, dParkLong As Decimal, sParkTitle As String, sParkInfo As String, Optional sIconUrl As String = "/images/MapPegGreen.png") As Artem.Google.UI.Marker
    Dim oMark As Artem.Google.UI.Marker
    Dim oIcon As New Artem.Google.UI.MarkerImage

    oMark = New Artem.Google.UI.Marker
    oMark.Position.Latitude = dParkLat
    oMark.Position.Longitude = dParkLong
    oMark.Title = sParkTitle
    oMark.Info = sParkInfo
    oIcon.Url = sIconUrl
    oMark.Icon = oIcon

    CreateMapMarker = oMark
  End Function

  Public Function GetBackButton() As String
    If Request("mode") = "pop" Then
      GetBackButton = "<a href=""#"" class=""btn btn-default hidden-print"" onclick=""window.close()""><i class=""fa fa-times"" aria-hidden=""True"" title=""X""></i> Close</a>"
    Else
      GetBackButton = "<a href=""#"" class=""btn btn-default hidden-print"" onclick=""history.back()""><i class=""fa fa-arrow-left"" aria-hidden=""True"" title=""<--""></i> Go Back</a>"
    End If

  End Function

End Class
