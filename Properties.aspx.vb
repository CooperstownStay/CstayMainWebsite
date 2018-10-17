
Partial Class Properties
  Inherits System.Web.UI.Page


  Enum PropertyMode As Integer ' Note: These are NOT intended to match what's in the database.
    ONE_TWO_BR = 0
    THREE_BR
    FOUR_BR
    FIVE_BR
    SIX_BR
    WATERFRONT
    APARTMENT
    ROOM_SUITE
    GROUP
    ONEONTA
  End Enum

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    If Not IsPostBack Then

      Dim sPropCat As String = MyUtils.CNullS(Request("PropCat"))
      Dim sDoSearch As String = MyUtils.CNullS(Request("Search"))

      If sPropCat.Trim = "" And sDoSearch = "" Then
        Response.Redirect("/", True)
        Response.End()
        Exit Sub
      End If

      Dim oProps As List(Of vwPropertiesWithGroup) = Nothing
      Dim oPropsUnfiltered As List(Of vwPropertiesWithGroup) = Nothing
      Dim sFirstCat As String = ""

      lblMasterListTitle.Text = ""
      lblMasterTitle.Text = ""
      lblMasterList.Text = ""
      lblMasterBody.Text = ""

      pnlSearchButtons.Visible = False
      If sDoSearch = "True" Then
        Session("SearchWeek") = MyUtils.CNullS(Request("Week"))
        Session("SearchLodgingType") = MyUtils.CNullS(Request("Lodging"))
        Session("SearchTerm") = MyUtils.CNullS(Request("Term"))
        Session("SearchBedrooms") = MyUtils.CNullS(Request("Beds"))
        Session("SearchBaths") = MyUtils.CNullS(Request("Baths"))
        Session("SearchLocation") = MyUtils.CNullS(Request("Location"))
        Session("SearchMode") = IIf(MyUtils.CNullS(Request("Term")) <> "", "Property", "Simple")

        oProps = GetProperties(sPropCat, oPropsUnfiltered)
        ' Since not using text search at top, only show if search term (from left side) isn't specified
        pnlSearchButtons.Visible = Session("SearchTerm") = ""
        If oProps IsNot Nothing AndAlso oProps.Count > 0 Then
          ' BJR for now, have Water Access as a separate type.  Keep this in case Lonetta changes her mind :)
          '' If search terms include Lodging Type of Waterfront, split results into Waterfront first and Water Access second.  Waterfront includes water or river, Wateraccess includes having pond 
          'If Session("SearchLodgingType") = "3,4,13" Then
          '  Dim iTotalPropsCount = oProps.Count
          '  Dim oPropsWaterAccess As List(Of vwPropertiesWithGroup) = (From x In oProps Where x.Category_ID = 13 Or x.Category_ID2 = 13 Or x.Category_ID3 = 13).ToList
          '  oProps = (From x In oProps Where x.Category_ID <> 13 And x.Category_ID2 <> 13 And x.Category_ID3 <> 13).ToList
          '  SetPropertiesPage(oProps, sPropCat, False, False, sFirstCat, True, oPropsUnfiltered, iTotalPropsCount)
          '  If oPropsWaterAccess IsNot Nothing AndAlso oPropsWaterAccess.Count > 0 Then
          '    lblMasterBody.Text &= "<div class='search-props-additional' style='margin-top:50px; margin-bottom:50px;'>Properties With Water Access</div>"
          '    SetPropertiesPage(oPropsWaterAccess, sPropCat, True, False, sFirstCat, True, oPropsWaterAccess)
          '  End If
          '        Else
          SetPropertiesPage(oProps, sPropCat, False, False, sFirstCat, True, oPropsUnfiltered)
          '          End If
        Else
          lblMasterTitle.Text = "<div class='text-center'><br>There were no results for your search.<br><br>Please try another search term.</div><br><br>"
        End If
        ucTitleBar.Title = ""
        ucTitleBar.SubTitle = ""
        ucTitleBar.CalloutOnly = "true"
      Else
        Session("SearchMode") = ""
        If sPropCat <> "" Then
          ' Group Lodging is only ever a second cat but needs to be treated like it's a first so it displays in one list w/o grouping into the first/third cats
          If sPropCat = "15" Then
            oProps = GetProperties(sPropCat, True, False)
            ' Reorder to list by name, then by id so that can get corerct image
            oProps = (From y In oProps Order By y.PropertyGroupName, y.Property_ID).ToList
            If oProps IsNot Nothing Then SetPropertiesPage(oProps, sPropCat, False, False, sFirstCat)
          Else

            oProps = GetProperties(sPropCat, False, False)
            If oProps IsNot Nothing Then
              SetPropertiesPage(oProps, sPropCat, False, False, sFirstCat)
              If Not (sPropCat.Contains("3") Or sPropCat.Contains("4")) Then
                oProps = GetProperties(sPropCat, True, False)
                If oProps IsNot Nothing Then
                  SetPropertiesPage(oProps, sPropCat, True, False, sFirstCat)
                  oProps = GetProperties(sPropCat, False, True)
                  If oProps IsNot Nothing Then
                    SetPropertiesPage(oProps, sPropCat, False, True, sFirstCat)
                  End If
                End If
              End If
            End If
          End If
        End If

      End If

      Page.Title = GetPageTitle(Session("PropertiesPageTitle")) ' "Cooperstown Rental Lodging - " & Session("PropertiesPageTitle")
      ucTitleBar.Title = GetH1(Session("PropertiesPageTitle"))
      ucTitleBar.SubTitle = GetMetaDescription(Session("PropertiesPageTitle"))

      MyData.GetWebItemForDisplay(litStandardAmenities, "StandardAmenities")

    Else
    End If

  End Sub

  Public Function GetGoogleAdwordsConversionKey() As String
    GetGoogleAdwordsConversionKey = ""
    Try

      GetGoogleAdwordsConversionKey = MyUtils.CNullS(ViewState("GoogleAdwordsKey"))

    Catch ex As Exception
      Dim s As String = ex.Message
    End Try

  End Function

  Private Function GetProperties(ByRef sPropCat As String, bSecondCategory As Boolean, bThirdCategory As Boolean) As List(Of vwPropertiesWithGroup)
    GetProperties = Nothing
    Dim sPropID() As String = Split(sPropCat, ",")
    Dim bMultiCategory As Boolean = (UBound(sPropID) > 0), oProps As List(Of vwPropertiesWithGroup) = Nothing


    If UBound(sPropID) >= 0 Then
      Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext(True)

      Try

        ' BJR do this in case old url that only had two waterfront proerpties
        If bMultiCategory Then ReDim Preserve sPropID(3)
        If Not (bSecondCategory Or bThirdCategory) Then
          If MyUtils.InEditMode Then
            If Not bMultiCategory Then
              oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Category_ID = sPropID(0) And x.Status = "Active" Order By x.WebDisplaySequence, x.PropertyGroupName, x.SequenceNumber).ToList
            Else
              ' Only waterfront is mutil cat, add in those with water access as second cat
              oProps = (From x In oHouse.vwPropertiesWithGroups Where (x.Category_ID = sPropID(0) Or x.Category_ID = sPropID(1) Or x.Category_ID = sPropID(2)) And x.Status = "Active" Order By x.WebDisplaySequence, x.Category_ID, x.PropertyGroupName, x.SequenceNumber).ToList
            End If
          Else
            If Not bMultiCategory Then
              oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Category_ID = sPropID(0) And x.Status = "Active" And x.Offline = 0 Order By x.WebDisplaySequence, x.PropertyGroupName, x.SequenceNumber).ToList
            Else
              ' Only waterfront is mutil cat, add in those with water access as second cat
              oProps = (From x In oHouse.vwPropertiesWithGroups Where (x.Category_ID = sPropID(0) Or x.Category_ID = sPropID(1) Or x.Category_ID = sPropID(2)) And x.Status = "Active" And x.Offline = 0 Order By x.WebDisplaySequence, x.Category_ID, x.PropertyGroupName, x.SequenceNumber).ToList
            End If
          End If
        Else
          If bSecondCategory Then
            If MyUtils.InEditMode Then
              oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Category_ID2 = sPropID(0) And x.Status = "Active" Order By x.WebDisplaySequence, x.Category_ID, x.PropertyGroupName, x.SequenceNumber).ToList
            Else
              oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Category_ID2 = sPropID(0) And x.Status = "Active" And x.Offline = 0 Order By x.WebDisplaySequence, x.Category_ID, x.PropertyGroupName, x.SequenceNumber).ToList
            End If
          Else
            If MyUtils.InEditMode Then
              oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Category_ID3 = sPropID(0) And x.Status = "Active" Order By x.WebDisplaySequence, x.Category_ID, x.PropertyGroupName, x.SequenceNumber).ToList
            Else
              oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Category_ID3 = sPropID(0) And x.Status = "Active" And x.Offline = 0 Order By x.WebDisplaySequence, x.Category_ID, x.PropertyGroupName, x.SequenceNumber).ToList
            End If
          End If
        End If

        GetProperties = oProps

      Catch ex As Exception
        MyErr.HandleError(ex)
      End Try
    End If
  End Function


  Private Function GetProperties(ByRef sPropCat As String, ByRef oPropsUnfiltered As List(Of vwPropertiesWithGroup)) As List(Of vwPropertiesWithGroup)
    GetProperties = Nothing
    Dim oProps As List(Of vwPropertiesWithGroup) = Nothing
    Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext(True)

    Try

      oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Status = "Active" And x.Offline = 0 Order By x.WebDisplaySequence, x.Category_ID, x.PropertyGroupName, x.SequenceNumber).ToList


      If oProps IsNot Nothing AndAlso Session("SearchTerm") <> "" Then
        Dim sSearchTerm As String = Session("SearchTerm").ToString.ToLower
        oProps = (From x In oProps Where (x.PropertyName.ToLower().Contains(sSearchTerm) Or x.Address.ToLower().Contains(sSearchTerm) Or x.City.ToLower().Contains(sSearchTerm) Or x.Zip.ToLower().Contains(sSearchTerm))).ToList
      End If

      If oProps IsNot Nothing AndAlso Session("SearchLodgingType") <> "" Then
        If Not Session("SearchLodgingType").ToString.Contains(",") Then
          oProps = (From x In oProps Where x.Category_ID = Session("SearchLodgingType")).ToList
        Else
          Dim sData() As String = Split(Session("SearchLodgingType"), ",")

          ' BJR Keep in case Lonetta wants Water Access bundled with WAterfront again           
          'If UBound(sData) = 2 Then
          '          oProps = (From x In oProps Where x.Category_ID = sData(0) Or x.Category_ID = sData(1) Or x.Category_ID = sData(2)).ToList
          If UBound(sData) = 1 Then
            oProps = (From x In oProps Where x.Category_ID = sData(0) Or x.Category_ID = sData(1)).ToList
          Else
            oProps = (From x In oProps Where x.Category_ID = sData(0) Or x.Category_ID = sData(1) Or x.Category_ID = sData(2) Or x.Category_ID = sData(3) Or x.Category_ID = sData(4)).ToList
            End If
          End If
        End If

      ' Save copy of oProps so for property groups can find Porperty ID of first one in group to use with  master file image later
      oPropsUnfiltered = oProps

      If oProps IsNot Nothing AndAlso Session("SearchBedrooms") <> "" Then
        'oProps = (From x In oProps Where x.Bedrooms >= MyUtils.CNullI(Session("SearchBedrooms"))).ToList
        oProps = (From x In oProps Where MyUtils.CNullS(Session("SearchBedrooms")).Split(",").Contains(x.Bedrooms.ToString())).ToList
      End If

      If oProps IsNot Nothing AndAlso Session("SearchBaths") <> "1" Then
        oProps = (From x In oProps Where x.Bedrooms >= MyUtils.CNullI(Session("SearchBaths"))).ToList
      End If


      ' only include properties that are available during the specified week.  We do this after all the other filters so we only look at the properties in oProps that match the other criteria.
      ' If after season ignore availability
      If Not MyUtils.AfterSeason Then

        If oProps IsNot Nothing AndAlso Session("SearchWeek") <> "" Then
          Dim sSearchWeek As String()
          Dim sSearchWeekFrom As Date
          Dim sSearchWeekTo As Date

          sSearchWeek = Session("SearchWeek").ToString().Split(":")
          sSearchWeekFrom = Date.Parse(sSearchWeek(0))
          sSearchWeekTo = Date.Parse(sSearchWeek(1))

          'get a list of property IDs for all properties available during the selected week
          Dim oPropsAvailable() As Integer = Nothing
          oPropsAvailable = (From x In oHouse.vwPropertyAvailabilities Where x.Booked = "0" And x.StartDate = sSearchWeekFrom And x.EndDate = sSearchWeekTo Select x.Property_ID).ToArray

          'filter properties to only include those available
          If (oPropsAvailable IsNot Nothing) Then
            oProps = (From x In oProps Where (oPropsAvailable.Contains(x.Property_ID))).ToList
          Else
            oProps = Nothing
          End If
        End If
      End If

      Select Case Session("SearchLocation")
        Case "CDP", ""
          oProps = (From x In oProps Order By x.Distance2CDP).ToList()
        Case "BW"
          oProps = (From x In oProps Order By x.Distance2BW).ToList()
        Case "ASV"
          oProps = (From x In oProps Order By x.Distance2ASV).ToList()
      End Select

      If oProps IsNot Nothing AndAlso oProps.Count > 0 Then
        sPropCat = oProps(0).Category_ID
      End If
      GetProperties = oProps

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

    MyData.DisposeHouseRentalContext(oHouse)
  End Function

  Private Function GetPropertyAvailabilityForProperties(oProps As List(Of vwPropertiesWithGroup), oHouse As HouseRentalDataContext, iMaxSearchProps As Integer) As List(Of vwPropertyAvailability)
    Try

      Dim oAllPropAvails As List(Of vwPropertyAvailability) = (From x In oHouse.vwPropertyAvailabilities).ToList()
      Dim oPropAvail As vwPropertyAvailability
      Dim oPropAvails As New List(Of vwPropertyAvailability)
      Dim oThisPropAvails As New List(Of vwPropertyAvailability)
      Dim iCount As Integer = 0
      Dim sPropsAdded As String = ":"

      For Each oProp In oProps
        If Not sPropsAdded.Contains(":" & oProp.Property_ID & ":") Then
          oThisPropAvails = (From x In oAllPropAvails Where x.Property_ID = oProp.Property_ID).ToList()
          For Each oPropAvail In oThisPropAvails
            oPropAvails.Add(oPropAvail)
          Next
          sPropsAdded &= oProp.Property_ID & ":"
        End If
        If iCount > iMaxSearchProps Then Exit For
      Next

      Return oPropAvails
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function

  Private Function GetPropertyAvailabilityForCategories(sPropCats() As String, oHouse As HouseRentalDataContext, Optional bSecondCategory As Boolean = False, Optional bThirdCategory As Boolean = False) As List(Of vwPropertyAvailability)
    Try
      ' 2/27/18 SAM - added check for 2nd and 3rd categories when only one category is passed in but need to check if prop has that category in any of its non-primary categories
      Return (From x In oHouse.vwPropertyAvailabilities Where sPropCats.Contains(x.Category_ID) Or (bSecondCategory = True And sPropCats.Contains(x.Category_ID2)) Or (bThirdCategory = True And sPropCats.Contains(x.Category_ID3))).ToList()

      'commented out the following because the above statement covers every situation below, including checking CatID2 and CatID3 when there are more than one categories to be checked. Also doesn't limit us to only 3 categories.
      'If sPropCats.Length = 1 Then
      '  ' 2/27/18 SAM - added check for 2nd and 3rd categories when only one category is passed in but need to check if prop has that category in any of its non-primary categories
      '  Return (From x In oHouse.vwPropertyAvailabilities Where x.Category_ID = sPropCats(0) Or (bSecondCategory = True And x.Category_ID2 = sPropCats(0)) Or (bThirdCategory = True And x.Category_ID3 = sPropCats(0))).ToList()
      'ElseIf sPropCats.Length = 2 Then
      '  Return (From x In oHouse.vwPropertyAvailabilities Where x.Category_ID = sPropCats(0) Or x.Category_ID = sPropCats(1)).ToList()
      'ElseIf sPropCats.Length = 3 Then
      '  Return (From x In oHouse.vwPropertyAvailabilities Where x.Category_ID = sPropCats(0) Or x.Category_ID = sPropCats(1) Or x.Category_ID = sPropCats(2)).ToList()
      'End If
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function

  Private Sub SetPropertiesPage(ByRef oProps As List(Of vwPropertiesWithGroup), ByRef sPropCat As String, bSecondCategory As Boolean, bThirdCategory As Boolean, ByRef sFirstCat As String, Optional bFromSearch As Boolean = False, Optional oPropsUnfiltered As List(Of vwPropertiesWithGroup) = Nothing, Optional iTotalPropsCount As Integer = 0)

    Dim sPropCats() As String = Split(sPropCat, ",")
    Dim bMultiCategory As Boolean = False, iMaxProps As Integer = oProps.Count - 1, iMaxSearchProps As Integer = MyUtils.CNullI(MyUtils.GetAppSetting("MaxSearchResults"))
    Dim sList As String = "", sBody As String = "", sTitle As String = "", sCategory As String = "", bSecondCatHeaderCreated As Boolean = False
    Dim sGoogleKey As String = "", sGooglePageName As String = "", sForEdit As String = MyUtils.InEditMode, bPropertyDiscounted As Boolean = False
    Dim sShowingCount As String = ""

    Session("PropertiesPageCat") = ""
    If bFromSearch Then
      If oProps.Count > iMaxSearchProps Then
        iMaxProps = iMaxSearchProps
        sShowingCount = "Showing first <strong>" & iMaxSearchProps & "</strong> of <strong>" & oProps.Count & "</strong>"
      Else
        If iTotalPropsCount = 0 Then iTotalPropsCount = oProps.Count
        sShowingCount = "We have <strong>" & iTotalPropsCount & "</strong>"
      End If
    End If
    If UBound(sPropCats) >= 0 Then
      Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext(True)
      Try

        ' Get master listing of properties

        Dim iCount As Integer = 0, iNewCount As Integer = 0, sWebCategorieTitles() As String = Nothing, sThisCat As String = ""
        Dim oProp As vwPropertiesWithGroup, sCat As String = "", iCount2 As Integer = 0, sPropertyName As String = ""
        Dim sCategories() As String = Nothing
        Dim oCats = (From y In oProps Select y.Category_ID Distinct).ToArray
        Dim oPropAvailabilities As List(Of vwPropertyAvailability)

        sTitle = ""
        sCategory = ""

        ' Special handling for Group Lodging .  
        If sPropCat = "15" Then
          'Force the Title and Category.  
          sTitle = "Group Lodging"
          sCategory = "Group Lodging"
          ' Group Lodging is only ever a second cat but needs to be treated like it's a first so it displays in one list w/o grouping into the first/third cats
          bMultiCategory = False
          ' However, for availability charts need to specify SecondCat
          oPropAvailabilities = GetPropertyAvailabilityForCategories(sPropCats, oHouse, True, bThirdCategory)
        Else
          bMultiCategory = (oCats.Count > 1) Or bSecondCategory Or bThirdCategory
          If bFromSearch Then
            oPropAvailabilities = GetPropertyAvailabilityForProperties(oProps, oHouse, iMaxSearchProps)
          Else
            oPropAvailabilities = GetPropertyAvailabilityForCategories(sPropCats, oHouse, bSecondCategory, bThirdCategory)  ' 2/27/18 SAM - Passed in 2nd and 3rd categories b/c some props didn't render a calendar
          End If
        End If



        For iCount = 0 To iMaxProps
          oProp = oProps(iCount)
          If sTitle = "" Then sTitle = oProp.WebCategoryTitle
          If sCategory = "" Then sCategory = oProp.Category.Replace("Homes", "")
          If Not (bSecondCategory Or bThirdCategory) Then sFirstCat = sCategory
          If (oProp.WebCategoryTitle <> sThisCat) Then
            sThisCat = oProp.WebCategoryTitle


            If bMultiCategory Then
                If bSecondCategory Or bThirdCategory Then
                  If bSecondCategory And Not bSecondCatHeaderCreated Then
                    If sFirstCat.Contains("Oneonta") Then
                      sList &= "<div class=""PropertyCategoryTitle"">Also Close to " & sFirstCat & "</div>"
                    Else
                      sList &= "<div class=""PropertyCategoryTitle""><br><u>Other " & sFirstCat & "</u></div>"
                    End If
                    bSecondCatHeaderCreated = True
                  End If
                  sList &= "<div class=""PropertyCategoryTitle"">" & oProp.Category & "</div>"
                Else
                  sList &= "<div class=""PropertyCategoryTitle"">" & oProp.Category & "</div>"
                End If
                sBody &= "<CATEGORY" & oProp.Category & ">" & vbCrLf
                MyUtils.AddItemToArray(sWebCategorieTitles, sThisCat)
                MyUtils.AddItemToArray(sCategories, oProp.Category)
              End If
            End If

            If sGoogleKey = "" Then sGoogleKey = oProp.GoogleAdwordsTrackingKey
          If sGooglePageName = "" Then sGooglePageName = "/MainSite/Category/" & oProp.Category_ID & "/" & oProp.Category
          sPropertyName = oProp.PropertyName
          If oProp.GroupID > 0 Then sPropertyName = oProp.GroupName

          sList &= "<div class=""PropertyListCell"">"
          sList &= "<a  class=""LinkMasterList"" href=""#Prop" & oProp.Property_ID & """ >" & sPropertyName & "</a>"
          'If MyUtils.CNullD(oProp.DiscountedRate) > 0 Then
          '  sList &= "<span class='DiscountNotice'>&nbsp;*</span>"
          '  bPropertyDiscounted = True
          'End If

          sList &= "</div>" & vbCrLf
          If Not CreatemasterPropertyEntry(oProps, oProp, sBody, iCount, iNewCount, sForEdit, sPropCat, oHouse, oPropAvailabilities, bFromSearch, oPropsUnfiltered) Then Exit For
          iCount = iNewCount
        Next

        If Not (bSecondCategory Or bThirdCategory) Then
          If (sTitle.ToLower Like "*front*" Or sTitle.ToLower Like "*water*" Or sTitle.ToLower Like "*lakes*") Then
            sTitle = "Waterfront"
            sCategory = "Waterfront"
            Session("PropertiesPageCat") = sCategory
          End If
        End If


        If sCategories IsNot Nothing And Not bFromSearch Then
          Dim sCatHeader As String = "", sCatTitle As String = ""
          If bSecondCategory Then
            If sFirstCat.Contains("Oneonta") Then
              sCatHeader = "<div class=""PropertyCategoryTitle""><br>Also Close to " & sFirstCat & "</div><hr/>" & vbCrLf
            End If
          End If

          If sFirstCat.Contains("Water") Or sFirstCat.Contains("River") Or sFirstCat.Contains("Lakes") Then
            For iCount = 0 To UBound(sCategories)
              sThisCat = sCategories(iCount)
              sCatTitle = "<a id=""" & sThisCat & """ name=""" & sThisCat & """><div class=""PropertyCategoryTitle"">" & sWebCategorieTitles(iCount) & " Properties</div></a>"
              If sWebCategorieTitles(iCount).ToLower.Contains("access") Then sCatTitle &= "<div >These have a <b>private pond</b><br />or <b>access</b> to a lake.</div>"

              sCat = "<div >" & sCatTitle
              For iCount2 = 0 To UBound(sCategories)
                If sThisCat <> sCategories(iCount2) Then
                  sCat &= "<a class=""LinkMedBlue"" href=""#" & sCategories(iCount2) & """>Click to see " & sCategories(iCount2) & " Properties</a></b></font><br>"
                End If
              Next
              sCat &= "</div><hr/>" & vbCrLf
              sBody = sBody.Replace("<CATEGORY" & sThisCat & ">", sCatHeader & sCat)
              sCatHeader = ""
            Next
          End If
        End If

        If Not (bSecondCategory Or bThirdCategory) Then
          If bFromSearch Then


            lblMasterListTitle.Text = "<div class='PropertyCategoryTitle'>Search Results<br>MASTER LIST...</div>"

            If Session("SearchTerm").ToString() <> "" Then
              lblMasterTitle.Text = "<h2>Search Results for '" & Session("SearchTerm").ToString() & "'</h2>"
            Else

              lblMasterTitle.Text = "<h2>Search Results</h2>"

              Dim sSearchWeek As String()
              Dim sSearchWeekFrom As String
              Dim sSearchWeekTo As String

              sSearchWeek = Session("SearchWeek").ToString().Split(":")
              sSearchWeekFrom = Convert.ToDateTime(sSearchWeek(0)).ToString("dddd MMM d")
              sSearchWeekTo = Convert.ToDateTime(sSearchWeek(1)).ToString("dddd MMM d")
              lblMasterTitle.Text &= "<p>" & sShowingCount & " Weekly Rentals Available <strong>" & sSearchWeekFrom & " - " & sSearchWeekTo & "</strong></p>"


              '            lblMasterTitle.Text = "Search Results for '" & MyUtils.CNullS(Request("Search")) & "'"
              If oProps.Count > iMaxSearchProps Then
                lblMasterTitle.Text &= "<br><div style='font-size:10px; margin:5px;'>(Only first " & MyUtils.CNullI(MyUtils.GetAppSetting("MaxSearchResults")) & " results shown)</div>"
              End If

              lblMasterTitle.Text &= GetFriendlySearchCriteria()
            End If

          Else
            lblMasterListTitle.Text = "<div class='PropertyCategoryTitle'>" & sCategory & "<br>MASTER LIST...</div>"
            lblMasterTitle.Text = "Cooperstown Stay " & sTitle
          End If
          ViewState("GoogleAdwordsKey") = sGoogleKey
          Session("CurrentPage4GoogleAnalytics") = sGooglePageName
          Session("PropertiesPageTitle") = sCategory
        End If

        '        If bPropertyDiscounted Then sList &= "<tr><td align=""left"" class='PropertyListCell'><span class='DiscountNotice DiscountNoticeMed'>* Discounted</span></td></tr>"

        ' If doing search, don't show Master List or 
        If bFromSearch Then
          lblMasterListTitle.Text = ""
          lblMasterList.Text = ""
        Else
          lblMasterList.Text &= sList
        End If
        lblMasterBody.Text &= sBody

      Catch ex As Exception
        MyErr.HandleError(ex)
      End Try
      MyData.DisposeHouseRentalContext(oHouse)
    End If

  End Sub

  Private Function GetFriendlySearchCriteria() As String

    Dim sCriteriaInEnglish As String = ""
    Dim sSearchLocation As String = ""
    Dim sSearchLodgingType As String = ""

    Select Case Session("SearchLocation")
      Case "CDP"
        sSearchLocation = "Cooperstown Dreams Park"
      Case "ASV"
        sSearchLocation = "All Star Village"
      Case "BBW"
        sSearchLocation = "Baseball World"
    End Select


    Select Case Session("SearchLodgingType")
      Case "6,7,8,9,11"
        sSearchLodgingType = "Private Homes"
      Case "3,4,13"
        sSearchLodgingType = "Waterfront Rentals"
      Case "1"
        sSearchLodgingType = "Apartments"
      Case "5"
        sSearchLodgingType = "Rooms/Suites"
      Case "15"
        sSearchLodgingType = "Group Lodging Rentals"
      Case "10"
        sSearchLodgingType = "Oneonta Rentals"
    End Select

    sCriteriaInEnglish &= IIf(sSearchLocation <> "", "<li>Sorted by Distance to <strong>" & sSearchLocation & "</strong></li>", "")
    sCriteriaInEnglish &= IIf(Session("SearchBedrooms") <> "", "<li><strong>" & Session("SearchBedrooms").ToString().Replace(",", " or ") & "</strong> Bedroom(s)</li>", "")
    sCriteriaInEnglish &= IIf(sSearchLodgingType <> "", "<li><strong>" & sSearchLodgingType & "</strong> only</li>", "")

    If (sCriteriaInEnglish <> "") Then
      GetFriendlySearchCriteria = "<ul>" & sCriteriaInEnglish & "</ul>"
    Else
      GetFriendlySearchCriteria = ""
    End If

  End Function

  Private Function CreatemasterPropertyEntry(ByRef oProps As List(Of vwPropertiesWithGroup), ByVal oProp As vwPropertiesWithGroup, ByRef sBody As String, ByVal iStartCount As Integer, ByRef iNewCount As Integer, ByVal sForEdit As String, ByVal sPropCat As String, ByRef oHouse As HouseRentalDataContext, oPropAvailabilities As List(Of vwPropertyAvailability), bFromSearch As Boolean, oPropsUnfiltered As List(Of vwPropertiesWithGroup)) As Boolean

    CreatemasterPropertyEntry = False
    Try

      Dim sOut As String = "", sAvail As String = "", iCount As Integer = 0, sStartName As String = oProp.PropertyGroupName, sContent As String = "", sImage As String = "", sPropertySpecial As String = ""
      Dim sAlt As String = MyUtils.CreatePropertyImageAltTitleText(oProp.MasterImageFileAlt, oProp.PropertyGroupName, oHouse), sImgWidth As String = MyUtils.CNullS(oProp.MasterImageFileWidth), sImgHeight As String = MyUtils.CNullS(oProp.MasterImageFileheight)
      Dim sLinkTitle As String = oProp.PropertyGroupName & " Details", sDefaultAlt As String = "", sDiscounted As String = "", sDiscountedCode As String = "", bDiscounted As Boolean = False

      If sImgWidth = "" Then sImgWidth = "150"
      sDefaultAlt = "&ImageDefaultAlt=" & Server.UrlEncode(MyUtils.CreatePropertyImageAltTitleText("", oProp.PropertyGroupName, oHouse))

      sContent = oProp.MasterWebDescription
      If MyUtils.CNullI(oProp.GroupID) > 0 Then
        sContent = oProp.GroupMasterText
      End If


      'If the property is waterfront, riverfront, specify which body of water by showing the webcategorytitle. if it has a private pond or has water access, indicate as such.
      If (oProp.Category_ID = 3 Or MyUtils.CNullI(oProp.Category_ID2) = 3 Or MyUtils.CNullI(oProp.Category_ID3) = 3) Then
        sPropertySpecial = "    <div class=""prop-special""><span>" & oProp.Location & "</span></div>" & vbCrLf
      ElseIf (oProp.Category_ID = 4 Or MyUtils.CNullI(oProp.Category_ID2) = 4 Or MyUtils.CNullI(oProp.Category_ID3) = 4) Then
        sPropertySpecial = "    <div class=""prop-special""><span>Riverfront</div>" & vbCrLf
      ElseIf oProp.Category_ID.ToString = "13" Or oProp.Category_ID2.ToString = "13" Or oProp.Category_ID3.ToString = "13" Then
        If oProp.PrivatePond = -1 Then
          sPropertySpecial = "    <div class=""prop-special""><span>Private Pond</span></div>" & vbCrLf
        Else
          'sOut &= "<div class=""propFeatCap"">Water Access Nearby</div>" & vbCrLf
          sPropertySpecial = "    <div class=""prop-special""><span>Water Access Nearby</span></div>" & vbCrLf
        End If
      Else
        sPropertySpecial = ""
      End If



      sOut &= "<a name=""Prop" & oProp.Property_ID & """ id=""Prop" & oProp.Property_ID & """></a>" &
                            "<div class=""propertyBox hidden-xs hidden-sm"">" & vbCrLf &
                            "<h3>" & oProp.PropertyGroupName & "</h3>" & vbCrLf &
                            "<div class=""propertyImg"">" & vbCrLf
      sOut &= sPropertySpecial
      sOut &= "    <div class=""clearfix"">" &
                            "        <div class=""col-xs-12 property-photo"">" & vbCrLf


      Dim sMasterImageFileEnlarged As String



      If MyUtils.CNullS(oProp.MasterImageFile) <> "" Then
        sMasterImageFileEnlarged = oProp.Property_ID & "/" & oProp.MasterImageFileEnlarged
      Else
        sMasterImageFileEnlarged = "noimage.jpg"
      End If

      If bFromSearch Then
        Dim oMasterProp = (From x In oPropsUnfiltered Where x.GroupID = oProp.GroupID Order By x.SequenceNumber Ascending).FirstOrDefault()
        If oMasterProp IsNot Nothing Then
          If MyUtils.CNullS(oMasterProp.MasterImageFileEnlarged) <> "" Then
            sMasterImageFileEnlarged = oMasterProp.Property_ID & "/" & oMasterProp.MasterImageFileEnlarged
          Else
            sMasterImageFileEnlarged = "noimage.jpg"
          End If
        End If
      End If


      'PROPERTY IMAGE
      If sForEdit = "True" Then
        Dim sURL As String = MyUtils.GetEditWebsiteLink & "&PropID=" & oProp.Property_ID & "&Type=Master&ImageType=Master&PropCat=" & sPropCat & "&GroupID=" & MyUtils.CNullI(oProp.GroupID) & "&ImageID=" & oProp.MasterImageID & MyUtils.GetCachedPageQS & sDefaultAlt
        sOut &= "<a target=""_blank"" href=""" & sURL & """>" & vbCrLf
        sAlt = "Click to Edit Image"
      Else
        sOut &= "              <a href=""/" & MyData.SetPropertyName(oProp.PropertyName, oProp.Category_ID) & """ title=""" & oProp.PropertyGroupName & " Details"" >" & vbCrLf
      End If

      Dim sPropImage As String = "<img src=""/PropertyPhotos/" & sMasterImageFileEnlarged & """ alt=""" & sAlt & " ""/>"


      'TODO - replace the "click here" text to be a grayscale image of home indicating no picture available
      If sForEdit = "True" Then
        'sOut &= "                <br /><br /><br />Click HERE to Edit<br> a Master Image<br /><br /><br /></a>" & vbCrLf
        sOut &= "                " & sPropImage.Replace("/>", " title=""Click to EDIT Master Image""/>") & "</a>" & vbCrLf
      Else
        sOut &= "                " & sPropImage & "</a>" & vbCrLf  ' width=""" & sImgWidth & """ height=""" & sImgHeight & """ border=""0""
      End If

      Dim sBeds As String = CInt(oProp.Bedrooms), sBaths As String = oProp.Baths, sSleeps As String = CInt(oProp.Sleeps), sRate As String = CInt(oProp.SummerRate) & "/week"
      If sBaths Like "*.0" Then sBaths = CInt(sBaths)
      If MyUtils.CNullI(oProp.DiscountedRate) > 0 AndAlso MyUtils.CNullS(Session("SearchMode")) = "Simple" Then
        sRate = CInt(oProp.DiscountedRate) & "/week"
        bDiscounted = True
      End If



      If (MyUtils.CNullI(oProp.GroupID) > 0) Then

        Dim iMinBeds As Integer, iMaxBeds As Integer, iMinBaths As Integer, iMaxBaths As Integer, iMinRate As Integer, iMaxRate As Integer, iMinSleeps As Integer, iMaxSleeps As Integer

        MyUtils.GetPropertyGroupAmenityRanges(oProps, MyUtils.CNullI(oProp.GroupID), iMinBeds, iMaxBeds, iMinBaths, iMaxBaths, iMinRate, iMaxRate, iMinSleeps, iMaxSleeps, MyUtils.CNullS(Session("SearchMode")) = "Simple", bDiscounted)
        
        sBeds = iMinBeds
        sBaths = iMinBaths
        sSleeps = iMinSleeps
        sRate = iMinRate & "/week"
        If iMinBeds <> iMaxBeds Then sBeds &= "-" & iMaxBeds
        If iMinBaths <> iMaxBaths Then sBaths &= "-" & iMaxBaths
        If iMinSleeps <> iMaxSleeps Then sSleeps &= "-" & iMaxSleeps
        If iMinRate <> iMaxRate Then sRate = iMinRate & "-" & iMaxRate & "/wk"
      End If

      If bDiscounted Then
        sDiscounted = "discounted"
        sDiscountedCode = "<div class=""prop-discounted""><span>Discounted Rate</span></div>"
      End If

      sOut &= "        </div></a>" & vbCrLf &
                            "        <div class=""col-xs-7"">" & vbCrLf &
                            "            <div class=""property-price " & sDiscounted & """>$" & sRate & "</div>" & vbCrLf &
                            "        </div>" & vbCrLf &
                            "        <div class=""col-xs-5"">" & vbCrLf


      If sForEdit Then
        sOut &= "<a class=""btn property-detail-btn"" href=""/Details.aspx?PropID=" & oProp.Property_ID & "&GroupID=" & MyUtils.CNullI(oProp.GroupID) & Session("AndEditModeQS") & "&PropCat=" & sPropCat & """ title=""" & sLinkTitle & """ class=""active"">VIEW RENTAL</a>" & vbCrLf
      Else
        sOut &= "<a class=""btn property-detail-btn"" href=""/" & MyData.SetPropertyName(oProp.PropertyName, oProp.Category_ID) & IIf(MyUtils.CNullS(Session("SearchMode") <> ""), "?Search=" & Session("SearchMode"), "") & """>View Rental</a>" & vbCrLf
      End If



      sOut &= "        </div>" & SDiscountedCode & vbCrLf &
                            "    </div><!--/row-->" & vbCrLf

      sOut &= "</div><!--/propertyImg-->" & vbCrLf

      sOut &= "<div class=""rightbox"">" & vbCrLf
      sOut &= "<div class=""clearfix"">" & vbCrLf
      sOut &= "<div class=""counder"">" & vbCrLf
      sOut &= "<ul>" & vbCrLf
      sOut &= " <li>BR <span>" & sBeds & "</span></li>" & vbCrLf
      sOut &= " <li>BA <span>" & sBaths & "</span></li>" & vbCrLf
      sOut &= " <li>Sleeps <span>" & sSleeps & "</span></li>" & vbCrLf
      sOut &= "</ul>" & vbCrLf
      sOut &= "</div><!--/counder-->" & vbCrLf
      sOut &= "</div><!--/clearfix-->" & vbCrLf

      sOut &= "<div class=""distancepark"">" & vbCrLf
      sOut &= "<h2>miles to tournament</h2>" & vbCrLf

      sOut &= "<div class=""prop-dist""><span>" & Convert.ToDouble(oProp.Distance2CDP).ToString() & "</span> mi to <strong>Dreams Park</strong></div>" & vbCrLf
      sOut &= "<div class=""prop-dist""><span>" & Convert.ToDouble(oProp.Distance2BW).ToString() & "</span> mi to <strong>Baseball World</strong></div>" & vbCrLf
      sOut &= "<div class=""prop-dist""><span>" & Convert.ToDouble(oProp.Distance2ASV).ToString() & "</span> mi to <strong>All Star Village</strong></div>" & vbCrLf

      sOut &= "</div><!--/distancepark-->" & vbCrLf

      Dim sFeatures As String = ""

      If oProp.WheelchairAccess = -1 Then
        'Dim oPropWheel = (From y In oProps Where y.WheelchairAccess = -1).ToList()
        'If oPropWheel.Any() Then ' IsNot Nothing Then
        sFeatures &= "<img src=""/images/cstay-logo-handicp2.gif"" alt=""Wheelchair Accessible"" />"
      End If

      If sFeatures <> "" Then
        sOut &= "<div class=""prop-features"">" & sFeatures & "</div><!--/features-->"
      End If

      sOut &= "</div><!--/rightbox-->" & vbCrLf

      sOut &= "&nbsp;" ' this is a hack.  needed to fix the descriptionText from doing weird things.
      sOut &= "<div class=""descriptionText clearfix"">" & vbCrLf
      If sForEdit = "True" Then
        If sContent = "" Then sContent = "<br /><br /><br />Click HERE to add a Master Description<br /><br /><br />"
        Dim sURL As String = MyUtils.GetEditWebsiteLink & "&PropID=" & oProp.Property_ID & "&Type=MasterDescription&PropCat=" & sPropCat & "&GroupID=" & MyUtils.CNullI(oProp.GroupID) & "&Height=500&Width=300" & MyUtils.GetCachedPageQS
        '				sOut &= "<a target=""_blank"" href=""" & sURL & """><div>" & sContent & "</div></a>" & vbCrLf
        sOut &= "<div height=""200px"" style=""cursor:pointer;"" title=""Click to edit text"" onclick=""EditContent('" & sURL & "',450,800);"">" & sContent & "</div>" & vbCrLf
        sLinkTitle = "Click to Edit Details"

      Else
        sOut &= sContent & vbCrLf
      End If
      'sOut &= "<div class=""showHide""><a data-toggle=""collapse"" data-target=""#moreless" & oProp.Property_ID & """>show more / show less</a></div><!--/showHide-->" & vbCrLf
      'sOut &= "<div id=""moreless" & oProp.Property_ID & """ class=""collapse"">" & vbCrLf
      'sOut &= "<p>" & Mid(sContent, 100, sContent.Length) & "</p>" & vbCrLf
      'sOut &= "</div><!--/moreless-->" & vbCrLf
      sOut &= "</div><!--/descriptionText-->" & vbCrLf

      sOut &= "<div class=""gridbox clearfix""><AVAILABILITY></div><!--/gridbox-->" & vbCrLf
      ' sOut &= "<div class=""gridbox clearfix""><table><AVAILABILITY></table></div><!--/gridbox-->" & vbCrLf
      sOut &= "<div class=""questionbox clearfix"">" & vbCrLf
      sOut &= "<h2>For Help: <a class=""btn btn-xs btn-info"" href=""tel:6075476260"">Call 607-547-6260</a> or <a class=""btn btn-xs btn-info"" target=""_blank"" href=""/ContactUs.aspx?p=" & Server.UrlEncode(oProp.PropertyGroupName) & """>Email Us</a></h2>" & vbCrLf
      'sOut &= "<h2>Questions?  Looking for Something in Particular?</h2>" & vbCrLf
      'sOut &= "<p>For assistance, call <a href=""tel:6075476260"">607-547-6260</a> or <a href=""/ContactUs.aspx?p=" & Server.UrlEncode(oProp.PropertyGroupName) & """>send us an email</a></p>" & vbCrLf
      'sOut &= "<p><span style='color:red;'>Availability Charts are Always Up-To-Date</span></p>" & vbCrLf
      sOut &= "</div><!--/questionbox-->" & vbCrLf
      sOut &= "</div><!--/propertyBox-->" & vbCrLf


      '// MOBILE VERSION BELOW ----------------------------------------------------------------------------------------------------------------

      Dim sMobileVer As String = ""

      sMobileVer &= "<!--MobileVer-->" & vbCrLf &
                            "<div class=""propertyBox visible-xs visible-sm"">" & vbCrLf &
                            "<h3>" & oProp.PropertyGroupName & "</h3>" & vbCrLf &
                            sPropertySpecial &
                            "    <div class=""clearfix""><a href=""/" & MyData.SetPropertyName(oProp.PropertyName, oProp.Category_ID) & """ title=""" & oProp.PropertyGroupName & " Details"" >" & vbCrLf &
                            "        <div class=""col-xs-12 property-photo"">" & vbCrLf &
                            "            <img src=""/PropertyPhotos/" & sMasterImageFileEnlarged & """ alt=""" & sAlt & """ title=""" & sAlt & " ""/></a>" & vbCrLf &
                            "        </div></a>" & vbCrLf &
                            "        <div class=""col-xs-7"">" & vbCrLf &
                            "            <div class=""property-price " & sDiscounted & """>$" & sRate & "</div>" & vbCrLf &
                            "        </div>" & vbCrLf &
                            "        <div class=""col-xs-5"">" & vbCrLf &
                            "            <a class=""btn property-detail-btn"" href=""/" & MyData.SetPropertyName(oProp.PropertyName, oProp.Category_ID) & IIf(MyUtils.CNullS(Session("SearchMode") <> ""), "?Search=" & Session("SearchMode"), "") & """>View Rental</a>" & vbCrLf &
                            "        </div>" & sDiscountedCode & vbCrLf &
                            "    </div><!--/row-->" & vbCrLf &
                            "    <div class=""row clearfix"">" & vbCrLf &
                            "        <div class=""col-xs-7 prop-meta"">" & vbCrLf &
                            "            <span class=""prop-br"">" & sBeds & "br</span>" & vbCrLf &
                            "            <span class=""prop-ba"">" & sBaths & "ba</span>" & vbCrLf &
                            "            <span class=""prop-sleeps"">Sleeps " & sSleeps & "</span>" & vbCrLf &
                            "            <div class=""prop-dist""><span>" & Convert.ToDouble(oProp.Distance2CDP).ToString() & "</span> mi to <strong>Dreams Park</strong></div>" & vbCrLf &
                            "            <div class=""prop-dist""><span>" & Convert.ToDouble(oProp.Distance2BW).ToString() & "</span> mi to <strong>Baseball World</strong></div>" & vbCrLf &
                            "            <div class=""prop-dist""><span>" & Convert.ToDouble(oProp.Distance2ASV).ToString() & "</span> mi to <strong>All Star Village</strong></div>" & vbCrLf


      'If oProp.Category_ID.ToString = "13" Or oProp.Category_ID2.ToString = "13" Or oProp.Category_ID3.ToString = "13" Then
      '  If oProp.PrivatePond = -1 Then
      '    sMobileVer &= "<div class=""propFeatCap"">Private Pond</div>" & vbCrLf
      '  Else
      '    sMobileVer &= "<div class=""propFeatCap"">Water Access Nearby</div>" & vbCrLf
      '  End If
      'End If

      If oProp.WheelchairAccess = -1 Then
        'Dim oPropWheel = (From y In oProps Where y.WheelchairAccess = -1).ToList()
        'If oPropWheel.Any() Then ' IsNot Nothing Then
        sMobileVer &= "<img src=""/images/cstay-logo-handicp2.gif"" alt=""Wheelchair Accessible"" />"
      End If


      Dim blnShowMoreInfoButton As Boolean = False  'if you want the More Info button, set this to True.  Otherwise, set it to False

      If blnShowMoreInfoButton Then

        sMobileVer &= "        </div>" & vbCrLf &
                              "        <div class=""col-xs-4"">" & vbCrLf &
                              "    <button type=""button"" href=""#"" class=""btn btn-more-info"" data-toggle=""collapse"" data-target=""#more-info-" & oProp.Property_ID & """>More Info</button>" & vbCrLf &
                              "        </div>" & vbCrLf &
                              "    </div>" & vbCrLf

        sMobileVer &= "    <div id=""more-info-" & oProp.Property_ID & """ class=""row clearfix collapse"">" & vbCrLf &
                              "        <div class=""col-xs-12"">" & vbCrLf &
                              "            <!--- more info -->" & vbCrLf &
                              "            <ul class=""nav nav-tabs"">" & vbCrLf &
                              "              <li class=""active""><a data-toggle=""tab"" href=""#prop-" & oProp.Property_ID & "-avail""><i class=""fa fa-calendar"" aria-hidden=""true""></i></a></li>" & vbCrLf &
                              "              <li><a data-toggle=""tab"" href=""#prop-" & oProp.Property_ID & "-info""><i class=""fa fa-info-circle"" aria-hidden=""true""></i></a></li>" & vbCrLf &
                              "            </ul>" & vbCrLf &
                              "            <div class=""tab-content"">" & vbCrLf &
                              "              <div id=""prop-" & oProp.Property_ID & "-avail"" class=""tab-pane fade in active""><AVAILABILITY></div><!--/prop-avail-->" & vbCrLf &
                              "              <div id=""prop-" & oProp.Property_ID & "-info"" class=""tab-pane fade"">" & vbCrLf &
                              "                    <div class=""descriptionText clearfix"">" & vbCrLf &
                              oProp.MasterWebDescription & vbCrLf &
                              "                    </div><!--/descriptionText-->" & vbCrLf &
                              "              </div><!--/tab-pane-->" & vbCrLf &
                              "            </div>" & vbCrLf &
                              "            <!-- /more info -->" & vbCrLf &
                              "        </div>" & vbCrLf &
                              "    </div>" & vbCrLf
      Else

        'sMobileVer &= "        </div><!--/col-->" & vbCrLf &
        '                      "        <div class=""col-xs-5 click4more"">" & vbCrLf &
        '                      "          <a href=""#"" class=""btn btn-info"">More Info, Photos,<br/>Guest Reviews</a>" & vbCrLf &
        '                      "        </div>" & vbCrLf &
        '              "    </div><!--/row-->" & vbCrLf

        sMobileVer &= "        </div><!--/col-->" & vbCrLf &
                      "        <div class=""col-xs-4 click4more"">" & vbCrLf &
                      "<strong>For Help</strong><br/><a class=""btn btn-xs btn-info"" href=""tel:6075476260"">Call 607-547-6260</a> or <a class=""btn btn-xs btn-info"" target=""_blank"" href=""/ContactUs.aspx?p=" & Server.UrlEncode(oProp.PropertyGroupName) & """>Email Us</a>" & vbCrLf &
                      "        </div>" & vbCrLf &
                      "    </div><!--/row-->" & vbCrLf

        sMobileVer &= "    <div id=""more-info-" & oProp.Property_ID & """ class=""row clearfix"">" & vbCrLf &
                              "        <div class=""col-xs-12"">" & vbCrLf &
                              "           <div id=""prop-" & oProp.Property_ID & "-info"">" & vbCrLf &
                              "             <div class=""descriptionText clearfix"">" & vbCrLf & oProp.MasterWebDescription & vbCrLf & "                    </div><!--/descriptionText-->" & vbCrLf &
                              "           </div><!--/prop-info-->" & vbCrLf &
                              "           <div id=""prop-" & oProp.Property_ID & "-avail""><AVAILABILITY></div><!--/prop-avail-->" & vbCrLf &
                              "        </div><!--/col-xs-12-->" & vbCrLf &
                              "    </div><!--/more-info-->" & vbCrLf

      End If




      sMobileVer &= "</div><!--/propertyBox-->"

      sMobileVer &= "<div class=""questionbox clearfix visible-xs visible-sm"">" & vbCrLf &
                    "<h2>For Help: <a class=""btn btn-xs btn-info"" href=""tel:6075476260"">Call 607-547-6260</a> or <a class=""btn btn-xs btn-info"" target=""_blank"" href=""/ContactUs.aspx?p=" & Server.UrlEncode(oProp.PropertyGroupName) & """>Email Us</a></h2>" & vbCrLf &
                    "</div><!--/questionbox-->" & vbCrLf


      '// END MOBILE VERSION BELOW ----------------------------------------------------------------------------------------------------------------

      sOut &= sMobileVer
      '//////////////// old below, new above

      If oProp.Property_ID = 1006 Then
        Dim s As String = ""
      End If

      iNewCount = iStartCount

      If oProp.Property_ID = 1006 Then
        Dim s As String = ""
      End If

      sAvail = ""
      If MyUtils.CNullI(oProp.GroupID) <> 43 Then
        sAvail = MyData.GetAvailabilityChart(oProps, sStartName, iStartCount, iNewCount, False, oPropAvailabilities)
      Else
        sAvail = MyData.GetAvailabilityChart(oProps, sStartName, iStartCount, iNewCount, True, oPropAvailabilities)
      End If

      sBody &= sOut.Replace("<AVAILABILITY>", sAvail)

      CreatemasterPropertyEntry = True

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function



  Public Function GetPageTitle(ByVal sPropCat As String) As String
    GetPageTitle = ""
    Try

      Select Case GetPropertyMode(sPropCat)
        Case PropertyMode.ONE_TWO_BR
          GetPageTitle = "Cooperstown House Rentals - 1 to 2 Bedroom Homes | CooperstownStay.com"
        Case PropertyMode.THREE_BR
          GetPageTitle = "Cooperstown House Rentals - 3 Bedroom Homes | CooperstownStay.com"
        Case PropertyMode.FOUR_BR
          GetPageTitle = "Cooperstown House Rentals - 4 Bedroom Homes | CooperstownStay.com"
        Case PropertyMode.FIVE_BR
          GetPageTitle = "Cooperstown House Rentals - 5 Bedroom Homes | CooperstownStay.com"
        Case PropertyMode.SIX_BR
          GetPageTitle = "Cooperstown House Rentals - 6+ Bedroom Homes | CooperstownStay.com"
        Case PropertyMode.APARTMENT
          GetPageTitle = "Apartments for Rent in Cooperstown NY - Weekly Rentals | CooperstownStay.com"
        Case PropertyMode.WATERFRONT
          GetPageTitle = "Cooperstown Rentals Lakefront and Waterfront | CooperstownStay.com"
        Case PropertyMode.ROOM_SUITE
          GetPageTitle = "Cooperstown Lodging Rooms and Suites | CooperstownStay.com"
        Case PropertyMode.ONEONTA
          GetPageTitle = "House Rentals in Oneonta near Cooperstown All Star Village | CooperstownStay.com"
        Case PropertyMode.GROUP
          GetPageTitle = "Group Lodging in Cooperstown, NY - Team Accommodations | CooperstownStay.com"
        Case Else
          GetPageTitle = "Cooperstown Rentals - Homes, Apartments, Cabins, Hotels & Suites | CooperstownStay.com"
      End Select

    Catch ex As Exception
      Dim s As String = ex.Message
    End Try

  End Function


  Public Function GetMetaDescription(ByVal sPropCat As String) As String
    GetMetaDescription = ""
    Try

      Select Case GetPropertyMode(sPropCat)
        Case PropertyMode.ONE_TWO_BR
          GetMetaDescription = "Search 1-2 bedroom house rentals in Cooperstown, NY near the Dreams Park. Find Cooperstown lodging such as private home rentals and cabin rentals that will accommodate your family for the week. Book online or call for personal assistance."
        Case PropertyMode.THREE_BR
          GetMetaDescription = "We have 3 bedroom home rentals in Cooperstown for your family. Find lodging near Cooperstown Dreams Park.  Call to speak with a local Cooperstown resident to assist with your decision.  Or, book online!"
        Case PropertyMode.FOUR_BR
          GetMetaDescription = "Play Ball! CooperstownStay.com has 4 bedroom weekly home rentals available for your big trip to Cooperstown, NY. You can choose to stay in a house close to Cooperstown Dreams Park or in nearby Oneonta, NY."
        Case PropertyMode.FIVE_BR
          GetMetaDescription = "Need a large 5 bedroom house rental in Cooperstown for your large family? Whatever your accommodation needs are, we've got large homes for rent near the Dreams Park. Search our site or call for friendly, local assistance."
        Case PropertyMode.SIX_BR
          GetMetaDescription = "Large family? We've got 6+ bedroom lodging available in Cooperstown to accomodate your needs. Our house rentals are available on a weekly basis for families playing at the Dreams Park. Visit CooperstownStay.com or call 607-547-6260 for personal assistance."
        Case PropertyMode.APARTMENT
          GetMetaDescription = "Looking for economical weekly rentals in Cooperstown, NY? We have apartment rentals available for families coming to Cooperstown to play a tournament at the Dreams Park. Visit CooperstownStay.com or call 607-547-6260 for personal assistance."
        Case PropertyMode.WATERFRONT
          GetMetaDescription = "Find weekly house rentals on the lake in Cooperstown, NY. We've got beautiful waterfront homes for rent - on the river, on a lake or with a private pond. Find lakefront house rentals at CooperstownStay.com. Search online or call 607-547-6260 for personal assistance."
        Case PropertyMode.ROOM_SUITE
          GetMetaDescription = "Looking for Hotel Rooms in Cooperstown, NY? We have rooms and suites available for rent in Cooperstown, NY for your trip to Cooperstown Dreams Park. Visit CooperstownStay.com or call 607-547-6260."
        Case PropertyMode.ONEONTA
          GetMetaDescription = "Looking for Lodging in Oneonta, NY? We've got all types of weekly rentals available including house rentals, rental apartments, cabins, rooms and suites."
        Case PropertyMode.GROUP
          GetMetaDescription = "Trying to keep your baseball team together when you go to Cooperstown? Check out our group lodging available close to Cooperstown Dreams Park. Let one of our friendly, local staff members help you find what you need. Call 607-547-6260.  Or, book online, anytime!"
        Case Else
          GetMetaDescription = "Cooperstown NY house rentals, lodging and accommodations. Connecting Dreams Park families to private homes, apartments, lakefront cottages. Simplify your search. Personalized customer service.  Hassle free!"
      End Select

    Catch ex As Exception
      Dim s As String = ex.Message
    End Try

  End Function


  Public Function GetH1(ByVal sPropCat As String) As String
    GetH1 = ""
    Try

      Select Case GetPropertyMode(sPropCat)
        Case PropertyMode.ONE_TWO_BR
          GetH1 = "1-2 Bedroom House Rentals in Cooperstown, NY"
        Case PropertyMode.THREE_BR
          GetH1 = "3 Bedroom House Rentals in Cooperstown, NY"
        Case PropertyMode.FOUR_BR
          GetH1 = "4 Bedroom House Rentals in Cooperstown, NY"
        Case PropertyMode.FIVE_BR
          GetH1 = "5 Bedroom House Rentals in Cooperstown, NY"
        Case PropertyMode.SIX_BR
          GetH1 = "6+ Bedroom House Rentals in Cooperstown, NY"
        Case PropertyMode.APARTMENT
          GetH1 = "Rental Apartments in Cooperstown NY"
        Case PropertyMode.WATERFRONT
          GetH1 = "Cooperstown NY House Rentals on Lake, River or Water Access"
        Case PropertyMode.ROOM_SUITE
          GetH1 = "Cooperstown Rooms, Inns and Suites"
        Case PropertyMode.ONEONTA
          GetH1 = "Oneonta, NY Lodging and Weekly House Rentals"
        Case PropertyMode.GROUP
          GetH1 = "Group Lodging in Cooperstown, NY - Team Accommodations"
        Case Else
          GetH1 = "Cooperstown rental lodging - " & sPropCat
      End Select

    Catch ex As Exception
      Dim s As String = ex.Message
    End Try

  End Function


  Public Function GetPropertyMode(ByVal sCategoryTag As String) As PropertyMode

    GetPropertyMode = PropertyMode.THREE_BR

    Try

      Select Case Trim(MyUtils.CNullS(sCategoryTag))
        Case "1- 2 Bedroom"
          GetPropertyMode = PropertyMode.ONE_TWO_BR
        Case "3 Bedroom"
          GetPropertyMode = PropertyMode.THREE_BR
        Case "4 Bedroom"
          GetPropertyMode = PropertyMode.FOUR_BR
        Case "5 Bedroom"
          GetPropertyMode = PropertyMode.FIVE_BR
        Case "6+ Bedroom"
          GetPropertyMode = PropertyMode.SIX_BR
        Case "Apartments"
          GetPropertyMode = PropertyMode.APARTMENT
        Case "Waterfront"
          GetPropertyMode = PropertyMode.WATERFRONT
        Case "Rooms/Suites"
          GetPropertyMode = PropertyMode.ROOM_SUITE
        Case "Oneonta"
          GetPropertyMode = PropertyMode.ONEONTA
        Case Else
          GetPropertyMode = PropertyMode.GROUP
      End Select

    Catch ex As Exception
      Dim s As String = ex.Message
    End Try

  End Function


End Class
