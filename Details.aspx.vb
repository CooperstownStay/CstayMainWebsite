Imports System.IO
Imports System.Management
Imports System.DirectoryServices

Partial Class Details
  Inherits System.Web.UI.Page

  Protected Const GO_ONLINE As String = "Go Online"

  Public Shared sDisplayWheelchairIcon As String = ""
  Public Shared sDisplayPoolIcon As String = ""
  Public Shared sDisplayPhoneIcon As String = ""
  Public Shared sDisplayInternetIcon As String = ""
  Public Shared sDisplayWifiIcon As String = ""
  Public Shared sDisplayWaterfrontIcon As String = ""
  Public Shared sDisplayWateraccessIcon As String = ""
  Public Shared sDisplayACIcon As String = ""
  Public Shared sDisplayTVIcon As String = ""
  Public Shared sDisplayPartiesIcon As String = ""
  Public Shared sDisplayGrillIcon As String = ""
  Public Shared sDisplayWasherDryerIcon As String = ""
  Public Shared sDisplayDishwasherIcon As String = ""
  Public Shared sDisplayDvdIcon As String = ""
  Public Shared sOpenGraphImages As String = ""
  Public Shared sPermaLink As String = ""

  Private _isDiscounted As Boolean = False

  Public Property IsDiscounted() As Boolean
    Get
      Return _isDiscounted
    End Get
    Set(ByVal value As Boolean)
      _isDiscounted = value
    End Set
  End Property

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    lblDeleteImagesResult.Text = ""
    If Not IsPostBack Then

      Dim sAutoEditPage As String = MyUtils.CNullS(Request("EWP"))
      If sAutoEditPage = "d0" And Not MyUtils.InEditMode Then
        Response.Redirect("Login.aspx?" & Request.QueryString.ToString)
      End If

      btnTakeOffline.Visible = MyUtils.InEditMode
      btnDeleteAllImages.Visible = MyUtils.InEditMode


      Dim sPropID As String = MyUtils.CNullS(Request("PropID")), sGroupID As String = MyUtils.CNullS(Request("GroupID")), sPropCat As String = MyUtils.CNullS(Request("PropCat"))
      Dim sPropName As String = MyUtils.CNullS(Page.RouteData.Values("PropertyName")).Replace("-", " ").ToLower, bIsActive As Boolean = False
      Dim sImageID As String = MyUtils.CNullS(Request("ImageID")), sNewSectionTitle As String = MyUtils.CNullS(Request("NewTitle")), sNewSectionTitleLocation As String = MyUtils.CNullS(Request("NewTitleLocation"))
      Dim sEditType As String = MyUtils.CNullS(Request("EditType")), sNewSeq As String = MyUtils.CNullS(Request("NewSeq")), sCanonicalName As String = ""

      If sEditType <> "" Then
        If sImageID <> "" And sEditType = "EditSectionTitle" Then
          ChangeSectionTitle(sImageID, sPropID, sGroupID, sNewSectionTitle, sNewSectionTitleLocation)
        End If
      Else

        If sPropName <> "" Or MyUtils.CNullI(sGroupID) > 0 Or MyUtils.CNullI(sPropID) > 0 Then
          If Not MyData.GetPropertyInfoByName(sPropName, sPropID, sGroupID, bIsActive, sPropCat, sCanonicalName) Then
            Try
              Response.Redirect("/", True)
              Exit Sub
            Catch ex As Exception
              Dim s As String = ex.Message
            End Try
          Else
            If Not bIsActive Then
              Try
                Response.Redirect("/", False)
                Response.StatusCode = 301
                Response.End()
                Exit Sub
              Catch ex As Exception
                Dim s As String = ex.Message
              End Try
            End If

            ' Handle when user gets to details.aspx page without a friendly url.  do a proper 301 redirect to the new friendly url
            If Request.RawUrl.StartsWith("/Details.aspx") And Not MyUtils.InEditMode Then
              Response.Status = "301 Moved Permanently"
              Response.StatusCode = 301
              Response.AddHeader("Location", MyUtils.GetAppSetting("MainWebsite") & "/" & MyData.SetPropertyName(sCanonicalName, sPropCat))
              Response.End()
            End If

            sPermaLink = MyUtils.GetAppSetting("MainWebsite") & "/" & MyData.SetPropertyName(sCanonicalName, sPropCat)
            litCanonicalPageLink.Text = "<link rel=""canonical"" href=""" & sPermaLink & """ />"

          End If
        End If
      End If

      Dim sTitle As String = "", sUniqueID As String = sGroupID, sGooglePageName As String = ""
      ViewState("PropID") = sPropID
      ViewState("PropCat") = sPropCat
      ViewState("GroupID") = sGroupID

      If sUniqueID = "" Then sUniqueID = sPropID

      If IsNumeric(sPropID) Then

        SetDetailsPage(sPropID, sGroupID, sPropCat, MyUtils.InEditMode)


      End If
      MyData.GetWebItemForDisplay(litStandardAmenities, "StandardAmenities")
      litStandardAmenitiesMobile.Text = litStandardAmenities.Text
      MyData.GetWebItemForDisplay(litDamageDepositWarning, "DamageDepositWarning")
      litDamageDepositWarningMobile.Text = litDamageDepositWarning.Text

    End If

  End Sub

  Private Sub ChangeSectionTitle(sImageID As String, sPropID As String, sGroupID As String, sNewTitle As String, sNewTitleLocation As String)
    Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext(True)
    Try
      Dim iPropID As Integer = MyUtils.CNullI(sPropID), iImageID As Integer = MyUtils.CNullI(sImageID), iGroupID As Integer = MyUtils.CNullI(sGroupID)
      Dim oImage = (From x In oHouse.PropertyImages Where ((x.Property_ID = iPropID) Or (x.PropertyGroupID = iGroupID)) And x.ID = iImageID).FirstOrDefault
      If oImage IsNot Nothing Then
        Dim oImages = (From y In oHouse.PropertyImages Where ((y.Property_ID = iPropID) Or (y.PropertyGroupID = iGroupID)) And y.ImageLocation = sNewTitleLocation And y.ImageSectionTitle = oImage.ImageSectionTitle)
        For Each oThisImg In oImages
          oThisImg.ImageSectionTitle = sNewTitle.Replace("null", "")
        Next
        oHouse.SubmitChanges()
      End If

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Sub


  Private Sub SetDetailsPage(ByVal sPropID As String, ByVal sGroupID As String, ByVal sPropCat As String, ByVal sForEdit As String)

    Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext, bHasEnlargedImages As Boolean = False
    Dim sUniqueID As String = sGroupID, sContent As String = "", sPropDescription As String = "", sReviewsCount As String = "", sReviewsRating As String = ""
    Dim sDiscountedCode As String = ""


    If sUniqueID = "" Then sUniqueID = sPropID

    Try
      If IsSearchMode("Simple") Then
        divSearchNav.Visible = True
        lnkClose.Visible = False
        lnkModfiy.Visible = True
      ElseIf IsSearchMode("Property") Then
        divSearchNav.Visible = True
        lnkClose.Visible = False
        lnkModfiy.Visible = False
      ElseIf IsSearchMode("Advanced") Then
        divSearchNav.Visible = True
        lnkBack.Visible = False
        lnkNewSearch.Visible = False
        lnkModfiy.Visible = False
      Else
        divSearchNav.Visible = False
      End If

      Dim oProps As List(Of vwPropertiesWithGroup) = Nothing

      If MyUtils.CNullI(sGroupID) = 0 Then
        If MyUtils.CNullI(sPropCat) > 0 And Not sPropCat.Contains(",") Then
          oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Property_ID = MyUtils.CNullI(sPropID) And x.Category_ID = MyUtils.CNullI(sPropCat)).ToList
        Else
          oProps = (From x In oHouse.vwPropertiesWithGroups Where x.Property_ID = MyUtils.CNullI(sPropID)).ToList
        End If
      Else
        If MyUtils.CNullI(sPropCat) > 0 And Not sPropCat.Contains(",") Then
          oProps = (From x In oHouse.vwPropertiesWithGroups Where x.GroupID = MyUtils.CNullI(sGroupID) And x.Category_ID = MyUtils.CNullI(sPropCat) Order By x.PropertyGroupName, x.SequenceNumber).ToList
        Else
          oProps = (From x In oHouse.vwPropertiesWithGroups Where x.GroupID = MyUtils.CNullI(sGroupID) Order By x.PropertyGroupName, x.SequenceNumber).ToList
        End If
        If Not MyUtils.InEditMode Then
          oProps = (From y In oProps Where y.Status = "Active" Order By y.PropertyGroupName, y.SequenceNumber).ToList
        End If
      End If
      If oProps IsNot Nothing Then

        If CBool(oProps(0).Offline) And (Not MyUtils.InEditMode) Then
          Try
            Response.Redirect("/", True)
          Catch ex As Exception
            Dim s As String = ex.Message
          End Try
          Exit Sub
        End If

        Dim sPropertySpecial As String
        'If the property is waterfront, riverfront, specify which body of water by showing the webcategorytitle. if it has a private pond or has water access, indicate as such.
        If (oProps(0).Category_ID = 3 Or MyUtils.CNullI(oProps(0).Category_ID2) = 3 Or MyUtils.CNullI(oProps(0).Category_ID3) = 3) Then
          sPropertySpecial = "    <div class=""prop-special""><span>" & oProps(0).Location & "</span></div>" & vbCrLf
        ElseIf (oProps(0).Category_ID = 4 Or MyUtils.CNullI(oProps(0).Category_ID2) = 4 Or MyUtils.CNullI(oProps(0).Category_ID3) = 4) Then
          sPropertySpecial = "    <div class=""prop-special""><span>Riverfront</div>" & vbCrLf
        ElseIf oProps(0).Category_ID.ToString = "13" Or oProps(0).Category_ID2.ToString = "13" Or oProps(0).Category_ID3.ToString = "13" Then
          If oProps(0).PrivatePond = -1 Then
            sPropertySpecial = "    <div class=""prop-special""><span>Private Pond</span></div>" & vbCrLf
          Else
            'sOut &= "<div class=""propFeatCap"">Water Access Nearby</div>" & vbCrLf
            sPropertySpecial = "    <div class=""prop-special""><span>Water Access Nearby</span></div>" & vbCrLf
          End If
        Else
          sPropertySpecial = ""
        End If

        litPropertySpecial.Text = sPropertySpecial
        litMobilePropertySpecial.Text = sPropertySpecial

        Session("DetailsPage") = "/" & MyData.SetPropertyName(oProps(0).PropertyName, oProps(0).Category_ID)

        litExteriorImages.Text = CreateDetailsLeftImages(oProps, oHouse, bHasEnlargedImages, sForEdit)
        litInteriorImages.Text = CreateDetailsRightImages(oProps, oHouse, bHasEnlargedImages, sForEdit)
        litMasterImage.Text = CreateMasterImage(oProps, oHouse, bHasEnlargedImages, sForEdit)

        litMobileMasterImage.Text = litMasterImage.Text.Replace("gallery1", "gallery2")
        'litMobilePhotoButton.Text = "<a href=""http://devs.cooperstownstay.com/PropertyPhotos/638/cstay-hse-lg-grandview1.jpg"" data-lightbox-gallery=""gallery1"" data-lightbox-hidpi=""http://devs.cooperstownstay.com/PropertyPhotos/638/cstay-hse-lg-grandview1.jpg"" title=""Grandview exterior""><i class=""fa fa-image"" aria-hidden=""true""></i></a>"
        If MyUtils.CNullS(oProps(0).MasterImageFile) <> "" Then
          litMobilePhotoButton.Text = "<a href=""/PropertyPhotos/" & oProps(0).Property_ID & "/" & oProps(0).MasterImageFileEnlarged & """ data-lightbox-gallery=""gallery1"" data-lightbox-hidpi=""/PropertyPhotos/" & oProps(0).Property_ID & "/" & oProps(0).MasterImageFileEnlarged & """ title=""" & oProps(0).MasterImageFileAlt & """><i class=""fa fa-image"" aria-hidden=""true""></i></a>"
        End If
        SetPropertyAmenitiesIcons(oProps(0))

        litReviews.Text = GetReviewsForProperty(oHouse, oProps(0).Property_ID.ToString, sGroupID, sForEdit, sReviewsRating, sReviewsCount)
        litMobileReviews.Text = litReviews.Text
        litMobileMaps.Text = "<div class=""col-xs-6 text-center""><a class=""btn btn-default btn-map"" href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Google") & "&mode=pop"" target=""_blank"">View on<br/><strong>Google Maps</strong></a></div>" &
            "<div class=""col-xs-6 text-center""><a class=""btn btn-default btn-map"" href=""https://www.google.com/maps/dir/?api=1&destination=" & HttpUtility.UrlEncode(oProps(0).Address & "," & oProps(0).City & " " & oProps(0).Zip) & """ target=""_blank""><strong>Get Directions</strong><br/> to Rental</a></div>"

        'Pinning doesn't work on mobile.  need to fix that before showing this button on mobile.  When it works, then uncomment this and delete the version above.
        'litMobileMaps.Text = "<div class=""col-xs-6 text-center""><a class=""btn btn-default btn-map"" href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Google") & """ target=""_new"">View on<br/><strong>Google Maps</strong></a></div>" &
        '    "<div class=""col-xs-6 text-center""><a class=""btn btn-default btn-map"" href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Area") & "&mode=pop"" target=""_new"">View on<br/><strong>Our Area Map</strong></a></div>" &
        '    "<div class=""col-xs-12 text-center"" style=""margin-top:10px;""><a class=""btn btn-default btn-map"" href=""https://www.google.com/maps/dir/?api=1&destination=" & HttpUtility.UrlEncode(oProps(0).Address & "," & oProps(0).City & " " & oProps(0).Zip) & """ target=""_new""><strong>Get Directions</strong><br/> to " & oProps(0).PropertyGroupName & "</a></div>"

        litReviewsRating.Text = sReviewsRating
        litReviewsCount.Text = sReviewsCount
        litMobileReviewsCount.Text = sReviewsCount

        litDetails.Text = GetContent(oHouse, oProps, sGroupID, sForEdit)
        litMobileDetails.Text = litDetails.Text


        If MyUtils.CNullI(oProps(0).GroupID) <> 43 Then
          Dim oPropAvailabilities As List(Of vwPropertyAvailability) = (From x In oHouse.vwPropertyAvailabilities Where x.Category_ID = oProps(0).Category_ID).ToList
          litAvailabilityModal.Text = MyData.GetAvailabilityChart(oProps, oProps(0).PropertyGroupName, 0, 0, False, oPropAvailabilities)
        End If

        litCategoryTitle.Text = CreateCategoryTitle(oProps, MyUtils.CNullS(Session("PropertiesPageCat")))
        litTitle.Text = CreatePageTitle(oProps, MyUtils.CNullS(Session("PropertiesPageCat")))
        litPropertyName.Text = oProps(0).PropertyGroupName
        litMobilePropertyName.Text = oProps(0).PropertyGroupName
        lnkSubmitQuestion.HRef &= Server.UrlEncode(litPropertyName.Text)
        lnkSubmitQuestion2.HRef = lnkSubmitQuestion.HRef
        lnkSubmitQuestion3.HRef = lnkSubmitQuestion.HRef

        litPropertyCategory.Text = CreatePropertyCategory(oProps, MyUtils.CNullS(Session("PropertiesPageCat")))


        Dim sBeds As String = CInt(oProps(0).Bedrooms), sBaths As String = oProps(0).Baths, sSleeps As String = CInt(oProps(0).Sleeps), sRate As String = CInt(oProps(0).SummerRate) & "/week"
        If sBaths Like "*.0" Then sBaths = CInt(sBaths)

        If (MyUtils.CNullI(oProps(0).DiscountedRate) > 0 AndAlso (IsSearchMode("Simple") OrElse IsSearchMode("Advanced"))) Then
          sRate = CInt(oProps(0).DiscountedRate) & "/week"
          IsDiscounted = True
        End If

        If (MyUtils.CNullI(oProps(0).GroupID) > 0) Then

          ' Get Rate Range
          Dim iMinBeds As Integer, iMaxBeds As Integer, iMinBaths As Integer, iMaxBaths As Integer, iMinRate As Integer, iMaxRate As Integer, iMinSleeps As Integer, iMaxSleeps As Integer
          Dim bGroupHasDiscountedProperties As Boolean
          MyUtils.GetPropertyGroupAmenityRanges(oProps, MyUtils.CNullI(oProps(0).GroupID), iMinBeds, iMaxBeds, iMinBaths, iMaxBaths, iMinRate, iMaxRate, iMinSleeps, iMaxSleeps, (IsSearchMode("Simple") OrElse IsSearchMode("Advanced")), bGroupHasDiscountedProperties)
          sBeds = iMinBeds
          sBaths = iMinBaths
          sSleeps = iMinSleeps
          sRate = iMinRate & "/week"
          If iMinBeds <> iMaxBeds Then sBeds &= "-" & iMaxBeds
          If iMinBaths <> iMaxBaths Then sBaths &= "-" & iMaxBaths
          If iMinSleeps <> iMaxSleeps Then sSleeps &= "-" & iMaxSleeps
          If iMinRate <> iMaxRate Then sRate = iMinRate & "-" & iMaxRate & "/wk"
          IsDiscounted = bGroupHasDiscountedProperties

          ' Get List of Rates for Rates Tab

          Dim sRatesGrid As String = MyUtils.GetPropertyGroupRates(oProps, MyUtils.CNullI(oProps(0).GroupID), IsDiscounted)
          litRates.Text = sRatesGrid
          litMobileRates.Text = sRatesGrid
          liRatesTab.Visible = True
          liMobileRatesTab.Visible = True
        End If

        If IsDiscounted AndAlso (IsSearchMode("Simple") OrElse IsSearchMode("Advanced")) Then
          sDiscountedCode = "<div class=""prop-discounted""><span>Discounted Rate</span></div>"
          litDiscountedCode.Text = sDiscountedCode
          litDiscountedCodeMobile.Text = sDiscountedCode
        End If


        litRate.Text = sRate
        litBA.Text = sBaths
        litBR.Text = sBeds
        litSleeps.Text = sSleeps

        litRateMobile.Text = sRate
        litMobileBA.Text = sBaths
        litMobileBR.Text = sBeds
        litMobileSleeps.Text = sSleeps

        litMobileBA.Text = IIf(Convert.ToInt32(oProps(0).Baths) = oProps(0).Baths, Convert.ToInt32(oProps(0).Baths), oProps(0).Baths.ToString())
        litMobileBR.Text = oProps(0).Bedrooms.ToString()
        litMobileSleeps.Text = oProps(0).Sleeps.ToString()

        litDistToDP.Text = Convert.ToDouble(oProps(0).Distance2CDP).ToString()
        litDistToAV.Text = Convert.ToDouble(oProps(0).Distance2ASV).ToString()
        litDistToBW.Text = Convert.ToDouble(oProps(0).Distance2BW).ToString()

        litMobileDistToDP.Text = Convert.ToDouble(oProps(0).Distance2CDP).ToString()
        litMobileDistToAV.Text = Convert.ToDouble(oProps(0).Distance2ASV).ToString()
        litMobileDistToBW.Text = Convert.ToDouble(oProps(0).Distance2BW).ToString()

        litGoogleMap.Text = "<a href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Google") & "&mode=pop"" target=""_blank"">google map</a>"
        litAreaMap.Text = "<a href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Area") & "&mode=pop"" target=""_blank"">area map</a>"
        litGoogleMapEmbed.Text = "<div class=""col-sm-4 col-xs-12""><a class=""btn btn-default btn-map"" href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Google") & "&mode=pop"" target=""_blank"">View on<br/><strong>Google Maps</strong></a></div>" &
                    "<div class=""col-sm-4 col-xs-12""><a class=""btn btn-default btn-map"" href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Area") & "&mode=pop"" target=""_blank"">View on<br/><strong>Our Area Map</strong></a></div>" &
                    "<div class=""col-sm-4 text-center""><a class=""btn btn-default btn-map"" href=""https://www.google.com/maps/dir/?api=1&destination=" & HttpUtility.UrlEncode(oProps(0).Address & "," & oProps(0).City & " " & oProps(0).Zip) & """ target=""_blank""><strong>Get Directions</strong><br/>to Rental</a></div>"
        'litGoogleMapEmbed.Text = "<iframe width=""100%"" height=""250px"" frameborder=""0"" style=""border: 0"" src=""https://www.google.com/maps/embed/v1/place?key=" & GetGoogleAPI() & "&q=Space+Needle,Seattle+WA"" allowfullscreen></iframe>"


        litMobileGoogleMap.Text = "<a href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Google") & "&mode=pop"" target=""_blank"">google map</a>"
        litMobileAreaMap.Text = "<a href=""" & MyData.GetMapUrl(oProps(0).Property_ID.ToString, oProps(0).GroupID.ToString, Request.Url.Host, "Area") & "&mode=pop"" target=""_blank"">area map</a>"


        litAddress.Text = oProps(0).Address & "<br/>" & oProps(0).City & " " & oProps(0).Zip
        litGPS.Text = FormatNumber(oProps(0).Latitude, 5) & ", " & FormatNumber(oProps(0).Longitude, 5)

        litMobileAddress.Text = litAddress.Text
        litMobileGPS.Text = litGPS.Text

        ' BJR need to know where to stick these
        pnlRedwoodInnMap.Visible = (oProps(0).Property_ID = 766 Or MyUtils.CNullI(oProps(0).GroupID) = 45)
        pnlHomeRunCabinsMap.Visible = (MyUtils.CNullI(oProps(0).GroupID) = 51)
        pnlCreeksideCottagesMap.Visible = (MyUtils.CNullI(oProps(0).GroupID) = 49)
        Dim sTitleForSocial As String

        sTitleForSocial = litTitle.Text.Replace(" | Cooperstown Stay", "").Replace("<title>", "").Replace("</title>", "")

        'Add Facebook Open Graph Meta Tags
        litOpenGraphTags.Text = "<meta property=""og:title"" content=""" & sTitleForSocial & """ />" & _
                                "<meta property=""og:site_name"" content=""CooperstownStay.com"" />" & _
                                "<meta property=""og:url"" content=""" & sPermaLink & """ />" & _
                                "<meta property=""og:description"" content=""" & Session("DetailsPropertyDescription") & """ />" & _
                                "<meta property=""og:type"" content=""place"" />" & _
                                IIf(MyUtils.CNullS(oProps(0).MasterImageFileEnlarged) <> "", "<meta property=""og:image"" content=""" & MyUtils.GetAppSetting("MainWebsite") & "/PropertyPhotos/" & oProps(0).Property_ID & "/" & oProps(0).MasterImageFileEnlarged & """ />", "") & _
                                "<meta property=""og:street-address"" content=""" & oProps(0).Address & """ />" & _
                                "<meta property=""og:locality"" content=""" & oProps(0).City & """ />" & _
                                "<meta property=""og:region"" content=""NY"" />" & _
                                "<meta property=""og:postal-code"" content=""" & oProps(0).Zip & """ />" & _
                                "<meta property=""og:country-name"" content=""USA"" />" & _
                                "<meta property=""place:location:latitude"" content=""" & oProps(0).Latitude & """ />" & _
                                "<meta property=""place:location:longitude"" content=""" & oProps(0).Longitude & """ />"

        'includes all images in the opengraph
        litOpenGraphTags.Text &= sOpenGraphImages

        litAddThis.Text = "<div class=""addthis_inline_share_toolbox"" data-url=""" & sPermaLink & """ data-title=""" & sTitleForSocial & """ data-description=""Look at this weekly rental property I found on CooperstownStay.com""></div>"
        litMobileShare.Text = litAddThis.Text

        Session("CurrentPage4GoogleAnalytics") = "/MainSite/Property/" & oProps(0).Property_ID & "/" & oProps(0).PropertyGroupName
        Session("DetailsPropertyTitle") = oProps(0).PropertyGroupName
        Session("DetailsPropertyKeywords") = MyUtils.SetPageKeywords(oProps(0).PropertyGroupName & ", " & oProps(0).WebCategoryTitle)
        sPropDescription = MyUtils.CNullS(oProps(0).GroupMasterText)
        If sPropDescription = "" Then sPropDescription = MyUtils.CNullS(oProps(0).MasterWebDescription)
        Session("DetailsPropertyDescription") = Left(MyUtils.StripAllHTML(sPropDescription, 2), 140) & "... as of " & FormatDateTime(Now, DateFormat.ShortDate)

        ToggleOfflineButton(CBool(oProps(0).Offline), True)
      End If


    Catch ex As Exception
      If ex.Message <> "Thread was being aborted." Then
        MyErr.HandleError(ex)
      End If
    End Try
    MyData.DisposeHouseRentalContext(oHouse)


  End Sub

  Private Sub ToggleOfflineButton(ByVal bOffline As Boolean, ByVal bInitialize As Boolean)

    If MyUtils.InEditMode Then
      If Not bInitialize Then
        bOffline = (btnTakeOffline.Text = GO_ONLINE)
        Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext(True)
        Try
          Dim iGroupID As Integer = MyUtils.CNullI(ViewState("GroupID")), iPropID As Integer = MyUtils.CNullI(ViewState("PropID"))
          If iGroupID > 0 Then
            oHouse.ExecuteCommand("update properties set offline=" & CInt(Not bOffline) & " where property_id in (select property_id from propertiesgroups where groupid=" & iGroupID & ")")
          Else
            Dim oProp = (From x In oHouse.Properties Where x.Property_ID = iPropID).FirstOrDefault
            If oProp IsNot Nothing Then
              oProp.Offline = CInt(Not bOffline)
            End If
            oHouse.SubmitChanges()
          End If


          bOffline = Not bOffline
        Catch ex As Exception
          MyErr.HandleError(ex)
        End Try
        MyData.DisposeHouseRentalContext(oHouse)
      End If
      btnTakeOffline.Text = "Go Offline"
      If bOffline Then btnTakeOffline.Text = GO_ONLINE
    End If

  End Sub

  Private Function GetContent(ByRef oHouse As HouseRentalDataContext, ByVal oProps As List(Of vwPropertiesWithGroup), ByVal sGroupID As String, ByVal sForEdit As String) As String
    GetContent = ""

    Dim sContent As String = "", dDiscRate As Double = 0, sTemp As String = ""

    Try

      If MyUtils.CNullI(sGroupID) > 0 Then
        Dim oGroup = (From x In oHouse.PropertyGroups Where x.GroupID = CInt(sGroupID)).FirstOrDefault
        If oGroup IsNot Nothing Then
          sContent = oGroup.DetailsText
        End If
      Else
        sContent = oProps(0).WebDetailsDescription
      End If
      'If MyUtils.CNullD(oProps(0).DiscountedRate) > 0 Then
      '  If oProps(0).Category_ID = 1 And MyUtils.CNullI(sGroupID) > 0 Then
      '    Dim oAProps = (From x In oHouse.vwPropertiesWithGroups Where x.GroupID = MyUtils.CNullI(sGroupID) And x.DiscountedRate > 0 Order By x.SequenceNumber).ToList
      '    If oAProps IsNot Nothing AndAlso oAProps.Count > 0 Then
      '      sTemp &= "<div class='DiscountNotice DiscountNoticeApartments'><u>Discount Rates</u><br><br>"
      '      For Each oAProp In oAProps
      '        sTemp &= oAProp.PropertyName & " - " & FormatCurrency(MyUtils.CNullD(oAProp.DiscountedRate), 0) & " + tax<br>"
      '      Next
      '      sContent = sTemp & "</div>" & sContent
      '    End If
      '  Else
      '    sContent = "<div class='DiscountNotice'>Discount Rate - " & FormatCurrency(MyUtils.CNullD(oProps(0).DiscountedRate), 0) & " + tax</div>" & sContent
      '  End If
      'End If

      If sForEdit = "True" Then
        If sContent = "" Then sContent = "<div style=""text-align:center; ""><br /><br /><br />Click HERE to add a Detailed Description&nbsp;<br /><br /><br /><br /><br /><br /></div>"
        Dim sURL As String = MyUtils.GetEditWebsiteLink & "&PropID=" & oProps(0).Property_ID & "&Type=DetailsDescription&GroupID=" & MyUtils.CNullI(sGroupID) & "&Height=600&Width=475" & MyUtils.GetCachedPageQS
        sContent = "<div title=""Click to edit text"" style=""cursor:pointer;"" height=""200px"" onclick=""EditContent('" & sURL & "',600,800);"">" & sContent & "</div>" & vbCrLf
      End If

      Dim oPropWheel = (From y In oProps Where y.WheelchairAccess = -1).ToList()
      If oPropWheel.Any() Then ' IsNot Nothing Then
        sContent &= "<div style=""text-align:center;""><br /><img src=""/images/cstay-logo-handicp2.gif"" alt=""Wheelchair Accessible"" /><br /><br /></div>"
      End If

      sContent &= "<!-- " & oPropWheel.Count() & "-->"


      GetContent = sContent
    Catch ex As Exception

    End Try

  End Function



  Private Function CreateCategoryTitle(ByRef oProps As List(Of vwPropertiesWithGroup), sPropertiesPageCat As String) As String



    CreateCategoryTitle = ""
    Try
      Dim sOut As String = "", sCategoryTitle As String = sPropertiesPageCat

      If sCategoryTitle = "" Then
        sCategoryTitle = oProps(0).WebCategoryTitle
        If oProps(0).Category Like "*front*" Then
          sCategoryTitle = oProps(0).Category
        End If
      End If

      sOut = "Cooperstown Stay " & sCategoryTitle

      CreateCategoryTitle = sOut
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function


  Private Function CreatePageTitle(ByRef oProps As List(Of vwPropertiesWithGroup), sPropertiesPageCat As String) As String



    CreatePageTitle = ""
    Try
      Dim sOut As String = "", sCategoryTitle As String = sPropertiesPageCat
      Dim sPropertyName As String

      If sCategoryTitle = "" Then
        sCategoryTitle = oProps(0).WebCategoryTitle
      End If

      sPropertyName = MyUtils.GetPropertyName(oProps(0).PropertyName, oProps(0).GroupName)

      If oProps(0).Category Like "*front*" Then
        sCategoryTitle = oProps(0).Category
        If sCategoryTitle Like "*River*" Then
          sOut = sPropertyName & " - Rental on River near Cooperstown, NY"
        Else
          sOut = sPropertyName & " - Rental on Lake near Cooperstown, NY"
        End If
      ElseIf sCategoryTitle Like "*Homes*" Then
        sOut = sPropertyName & " - House Rental near Cooperstown, NY"
      ElseIf sCategoryTitle Like "*Group*" Then
        sOut = sPropertyName & " - Group Lodging near Cooperstown, NY"
      ElseIf sCategoryTitle Like "*Apartments*" Then
        sOut = sPropertyName & " - Apartment Rental near Cooperstown, NY"
      ElseIf sCategoryTitle Like "*Rooms*" Then
        sOut = sPropertyName & " - Room Rental near Cooperstown, NY"
      ElseIf sCategoryTitle Like "*Oneonta*" Then
        sOut = sPropertyName & " - Rental in Oneonta, NY near All Star Village"
      Else
        sOut = sPropertyName & " - " & sCategoryTitle & " Rental near Cooperstown, NY"
      End If

      CreatePageTitle = "<title>" & sOut & " | Cooperstown Stay</title>"

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function


  Private Function CreatePropertyCategory(ByRef oProps As List(Of vwPropertiesWithGroup), sPropertiesPageCat As String) As String


    CreatePropertyCategory = ""
    Try
      Dim sOut As String = ""

      If oProps(0).Category_ID.ToString = "13" Or oProps(0).Category_ID2.ToString = "13" Or oProps(0).Category_ID3.ToString = "13" Then
        If oProps(0).PrivatePond = -1 Then
          sOut &= "<div class=""SmallWhiteItalics"" style=""margin:3px;"">Private Pond</div>" & vbCrLf
        Else
          sOut &= "<div class=""SmallWhiteItalics"" style=""margin:3px;"">Water Access Nearby</div>" & vbCrLf
        End If
      End If


      CreatePropertyCategory = sOut
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function

  Public Function CreateDetailsLeftImages(ByRef oProps As List(Of vwPropertiesWithGroup), ByRef oHouse As HouseRentalDataContext, ByRef bHasEnlargedImages As Boolean, ByVal sForEdit As String) As String
    CreateDetailsLeftImages = ""

    Dim sOut As String = "", iPropID As Integer = MyUtils.CNullI(oProps(0).Property_ID), iGroupID As Integer = MyUtils.CNullI(oProps(0).GroupID)
    Dim sExteriorImages As String = "", sOtherImages As String = "", sTestimonial As String = "", sGroupID As String = "", sAlt As String = "", sDefaultAlt As String = ""

    Try
      sAlt = MyUtils.CreatePropertyImageAltTitleText(oProps(0).MasterImageFileAlt, oProps(0).PropertyGroupName, oHouse)
      sDefaultAlt = "&ImageDefaultAlt=" & Server.UrlEncode(MyUtils.CreatePropertyImageAltTitleText("", oProps(0).PropertyGroupName, oHouse))

      sExteriorImages = GetImagesForProperty(oHouse, oProps(0), iPropID, "Exterior", "Left", False, "150", sForEdit)
      sOut = sExteriorImages
      sOut &= GetImagesForProperty(oHouse, oProps(0), iPropID, "Other", "Left", True, "150", sForEdit)

      If sForEdit = "True" Then
        Dim sAddImageURL As String = ""
        If sExteriorImages = "" Then
          sAddImageURL = MyUtils.GetEditWebsiteLink & "&Add=True&NewSection=True&PropID=" & iPropID & "&Type=Details&GroupID=" & iGroupID & "&ImageType=Exterior&ImageLocation=Left" & MyUtils.GetCachedPageQS & sDefaultAlt

          sOut &= "<tr>" & vbCrLf
          sOut &= "  <td>" & vbCrLf
          sOut &= "<div style=""text-align:center;""><a  class=""LinkSmallBlue"" target=""_blank"" href=""" & sAddImageURL & """>Click To Add<br/>Exterior Images </a><br><br></div>" & vbCrLf
          sOut &= "  </td>" & vbCrLf
          sOut &= "</tr>" & vbCrLf

        End If
        sAddImageURL = MyUtils.GetEditWebsiteLink & "&Add=True&NewSection=True&PropID=" & iPropID & "&Type=Details&GroupID=" & iGroupID & "&ImageType=Other&ImageLocation=Left" & MyUtils.GetCachedPageQS & sDefaultAlt

        sOut &= "<tr>" & vbCrLf
        sOut &= "  <td>" & vbCrLf
        sOut &= "<div style=""text-align:center;""><a  class=""LinkSmallBlue"" target=""_blank"" href=""" & sAddImageURL & """>Click To Add<br/>New Image Section</a><br><br></div>" & vbCrLf
        sOut &= "  </td>" & vbCrLf
        sOut &= "</tr>" & vbCrLf

      End If

      If iGroupID = 0 Then
        sTestimonial = MyUtils.CNullS(oProps(0).WebTestimonialLeft)
      Else
        sTestimonial = MyUtils.CNullS(oProps(0).TestimonialLeft)
      End If

      If sForEdit = "True" Then
        If iGroupID > 0 Then sGroupID = iGroupID
        If sTestimonial = "" Then sTestimonial = "<div style=""text-align:center;""><br /><br /><br />Click HERE to add<br>Testimonials&nbsp;<br /><br /><br /><br /><br /><br /></div>"
        Dim sURL As String = MyUtils.GetEditWebsiteLink & "&PropID=" & oProps(0).Property_ID & "&Type=TestimonialLeft&GroupID=" & iGroupID & "&Height=600&Width=475" & MyUtils.GetCachedPageQS
        sTestimonial = "<div title=""Click to edit text"" style=""cursor:pointer;"" height=""200px"" onclick=""EditContent('" & sURL & "',600,800);"">" & sTestimonial & "</div>" & vbCrLf
      End If
      If sTestimonial <> "" Then sTestimonial = "<tr><td>" & sTestimonial & "</td></tr>" & vbCrLf
      sOut &= sTestimonial

      CreateDetailsLeftImages = sOut
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function


  Public Function CreateDetailsRightImages(ByRef oProps As List(Of vwPropertiesWithGroup), ByRef oHouse As HouseRentalDataContext, ByVal bHasEnlargedImages As Boolean, ByVal sForEdit As String) As String
    CreateDetailsRightImages = ""

    Dim sOut As String = "", iPropID As Integer = oProps(0).Property_ID, iGroupID As Integer = MyUtils.CNullI(oProps(0).GroupID), sType As String = ""
    Dim sAlt As String = "", sImgWidth As String = "", sImgHeight As String = "", iCurrPropID As Integer = 0, sTitle As String = "", sImage As String = ""
    Dim sInteriorImages As String = "", sOtherImages As String = "", sDefaultAlt As String = "", sTestimonial As String = "", sGroupID As String = ""

    Try

      sAlt = MyUtils.CreatePropertyImageAltTitleText(oProps(0).MasterImageFileAlt, oProps(0).PropertyGroupName, oHouse)
      sDefaultAlt = "&ImageDefaultAlt=" & Server.UrlEncode(MyUtils.CreatePropertyImageAltTitleText("", oProps(0).PropertyGroupName, oHouse))
      sImgWidth = MyUtils.CNullS(oProps(0).MasterImageFileWidth)
      sImgHeight = MyUtils.CNullS(oProps(0).MasterImageFileheight)
      If sAlt = "" Then sAlt = oProps(0).PropertyGroupName
      If sImgWidth = "" Then sImgWidth = "150"

      If iGroupID = 0 Then
        sInteriorImages = GetImagesForProperty(oHouse, oProps(0), oProps(0).Property_ID, "Interior", "Right", False, "150", sForEdit)
        sOut &= sInteriorImages
        sOut &= GetImagesForProperty(oHouse, oProps(0), oProps(0).Property_ID, "Other", "Right", True, "150", sForEdit)
      Else
        For Each oProp As vwPropertiesWithGroup In oProps
          If oProp.Property_ID <> iCurrPropID Then
            iCurrPropID = oProp.Property_ID
            sOut &= GetImagesForProperty(oHouse, oProp, oProp.Property_ID, "Interior", "Right", True, "150", sForEdit)
          End If
        Next
        sOut &= GetImagesForProperty(oHouse, oProps(0), 0, "Other", "Right", True, "150", sForEdit)
      End If

      If sForEdit = "True" Then
        Dim sAddImageURL As String = ""
        If sInteriorImages = "" Then
          sAddImageURL = MyUtils.GetEditWebsiteLink & "&Add=True&NewSection=True&PropID=" & iPropID & "&Type=Details&GroupID=" & iGroupID & "&ImageType=Interior&ImageLocation=Right" & MyUtils.GetCachedPageQS & sDefaultAlt

          sOut &= "<tr>" & vbCrLf
          sOut &= "  <td>" & vbCrLf
          sOut &= "<div style=""text-align:center;""><a  class=""LinkSmallBlue"" target=""_blank"" href=""" & sAddImageURL & """>Click To Add<br/>Interior Images </a><br><br></div>" & vbCrLf
          sOut &= "  </td>" & vbCrLf
          sOut &= "</tr>" & vbCrLf

        End If
        sAddImageURL = MyUtils.GetEditWebsiteLink & "&Add=True&NewSection=True&PropID=" & iPropID & "&Type=Details&GroupID=" & iGroupID & "&ImageType=Other&ImageLocation=Right" & MyUtils.GetCachedPageQS & sDefaultAlt

        sOut &= "<tr>" & vbCrLf
        sOut &= "  <td>" & vbCrLf
        sOut &= "<div style=""text-align:center;""><a  class=""LinkSmallBlue"" target=""_blank"" href=""" & sAddImageURL & """>Click To Add<br/>New Image Section</a><br><br></div>" & vbCrLf
        sOut &= "  </td>" & vbCrLf
        sOut &= "</tr>" & vbCrLf

      End If


      If iGroupID = 0 Then
        sTestimonial = MyUtils.CNullS(oProps(0).WebTestimonialRight)
      Else
        sTestimonial = MyUtils.CNullS(oProps(0).TestimonialRight)
      End If

      If sForEdit = "True" Then
        If iGroupID > 0 Then sGroupID = iGroupID
        If sTestimonial = "" Then sTestimonial = "<div style=""text-align:center;""><br /><br /><br />Click HERE to add<br>Testimonials&nbsp;<br /><br /><br /><br /><br /><br /></div>"
        Dim sURL As String = MyUtils.GetEditWebsiteLink & "&PropID=" & oProps(0).Property_ID & "&Type=TestimonialRight&GroupID=" & iGroupID & "&Height=600&Width=475" & MyUtils.GetCachedPageQS
        sTestimonial = "<div title=""Click to edit text"" style=""cursor:pointer;"" height=""200px"" onclick=""EditContent('" & sURL & "',600,700);"">" & sTestimonial & "</div>" & vbCrLf
      End If
      If sTestimonial <> "" Then sTestimonial = "<tr><td>" & sTestimonial & "</td></tr>" & vbCrLf
      sOut &= sTestimonial


      CreateDetailsRightImages = sOut

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function




  Public Function CreateMasterImage(ByRef oProps As List(Of vwPropertiesWithGroup), ByRef oHouse As HouseRentalDataContext, ByVal bHasEnlargedImages As Boolean, ByVal sForEdit As String) As String
    CreateMasterImage = ""

    Dim sOut As String = "", iPropID As Integer = oProps(0).Property_ID, iGroupID As Integer = MyUtils.CNullI(oProps(0).GroupID), sType As String = ""
    Dim sAlt As String = "", sImgWidth As String = "", sImgHeight As String = "", iCurrPropID As Integer = 0, sTitle As String = "", sImage As String = ""
    Dim sInteriorImages As String = "", sOtherImages As String = "", sDefaultAlt As String = "", sTestimonial As String = "", sGroupID As String = ""
    Dim sLinkText As String = ""


    Try

      sAlt = MyUtils.CreatePropertyImageAltTitleText(oProps(0).MasterImageFileAlt, oProps(0).PropertyGroupName, oHouse)
      sDefaultAlt = "&ImageDefaultAlt=" & Server.UrlEncode(MyUtils.CreatePropertyImageAltTitleText("", oProps(0).PropertyGroupName, oHouse))
      sImgWidth = MyUtils.CNullS(oProps(0).MasterImageFileWidth)
      sImgHeight = MyUtils.CNullS(oProps(0).MasterImageFileheight)
      If sAlt = "" Then sAlt = oProps(0).PropertyGroupName
      If sImgWidth = "" Then sImgWidth = "150"


      ' Determine the image we are going to show.  
      If MyUtils.CNullS(oProps(0).MasterImageFileEnlarged) = "" Then
        sImage = "<img src=""/PropertyPhotos/noimage.jpg"" alt=""No Photo Available""/>"
      Else
        sImage = "<img src=""/PropertyPhotos/" & oProps(0).Property_ID & "/" & oProps(0).MasterImageFileEnlarged & """ alt=""" & sAlt & """ title=""" & sAlt & """/>"
      End If

      sImage = "<div class=""col-xs-12 property-photo"">" & sImage & "<img src=""/images/view-more-photos.png"" class=""view-more-photos"" alt=""VIEW MORE PHOTOS""/></div>"


      ' Link below image.  It will either be to edit or to view gallery

      If sForEdit = "True" Then
        Dim sURL As String = MyUtils.GetEditWebsiteLink & "&PropID=" & iPropID & "&Type=Details&ImageType=Master&GroupID=" & iGroupID & "&ImageID=" & oProps(0).MasterImageID & MyUtils.GetCachedPageQS & sDefaultAlt
        sOut &= "<a target=""_blank"" href=""" & sURL & """>" & sImage.Replace("/>", " title=""Click to EDIT Master Image""/>") & "</a>" & vbCrLf
      Else
        If MyUtils.CNullS(oProps(0).MasterImageFileEnlarged) <> "" Then
          sOut &= "<div class=""gallery-item""><a href=""/PropertyPhotos/" & oProps(0).Property_ID & "/" & oProps(0).MasterImageFileEnlarged & """ data-lightbox-gallery=""gallery1"" data-lightbox-hidpi=""/PropertyPhotos/" & oProps(0).Property_ID & "/" & oProps(0).MasterImageFileEnlarged & """ title=""" & sAlt & """ class=""gallery1FirstImage"">" & sImage & "</a></div>" & vbCrLf

          ' Check to see if there are more photos besides the Master Image.  If so, add them to the gallery.
          Dim oImages As List(Of PropertyImage)
          If iGroupID = 0 Then
            oImages = (From x In oHouse.PropertyImages Where x.Property_ID = iPropID And x.ImageFileEnlarged IsNot Nothing Order By x.ImageType Descending, x.ImageSequence).ToList
          Else
            ' For property groups, images of tyep "Other" belong to all properties and are saved with just the group ID, so use groupid to get images 
            oImages = (From x In oHouse.PropertyImages Where x.PropertyGroupID = iGroupID And x.ImageFileEnlarged IsNot Nothing Order By x.ImageType, x.ImageSectionTitle, x.ImageSequence).ToList
          End If
          If oImages IsNot Nothing Then
            For Each oImage As PropertyImage In oImages
              If oImage.ImageFileEnlarged <> oProps(0).MasterImageFileEnlarged Then
                Dim sImgTitle = oImage.ImageAlt
                If oImage.ImageSectionTitle.Trim <> "" And oImage.ImageSectionTitle.Trim <> "No Title" Then sImgTitle = oImage.ImageSectionTitle & " - " & sImgTitle
                sOut &= "<a href=""/PropertyPhotos/" & oImage.Property_ID & "/" & oImage.ImageFileEnlarged & """ data-lightbox-gallery=""gallery1"" data-lightbox-hidpi=""/PropertyPhotos/" & oImage.Property_ID & "/" & oImage.ImageFileEnlarged & """ title=""" & sImgTitle & """></a>" & vbCrLf
              End If
            Next

          End If
        Else
          sOut &= sImage & vbCrLf
        End If

      End If



      'sOut &= "</div><!--/DetimG-->"


      CreateMasterImage = sOut

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function



  Private Function GetImagesForProperty(ByRef oHouse As HouseRentalDataContext, oProp As vwPropertiesWithGroup, iPropID As Integer, ByVal sType As String, ByVal sLocation As String, ByVal bUseSectionTitle As Boolean, ByVal sDefaultWidth As String, ByVal sForEdit As String) As String

    GetImagesForProperty = ""
    Try

      Dim iGroupID As Integer = MyUtils.CNullI(oProp.GroupID)
      Dim sAlt As String = "", sImgWidth As String = "", sImgHeight As String = "", sOut As String = "", sURL As String = "", bFirstImage As Boolean = True, sDefaultAlt As String = ""
      Dim oImages As List(Of PropertyImage), oSections As List(Of PropertyImage), sSections As List(Of String), sCurrSectionTitle As String = "", bAddSectionEdit As Boolean = False, iMaxImageSeq As Integer = 0, sTitle As String = ""
      Dim sAddImageURL As String = MyUtils.GetEditWebsiteLink & "&Add=True&PropID=" & iPropID & "&Type=Details&GroupID=" & iGroupID & "&ImageType=" & sType & "&ImageLocation=" & sLocation & MyUtils.GetCachedPageQS

      ' BJR kindof a workaround to being able to number the sections.  Assumes the sections will be created in the order wanted
      If iGroupID = 0 Then
        oSections = (From x In oHouse.PropertyImages Where x.Property_ID = iPropID And x.ImageType = sType And x.ImageLocation = sLocation Order By x.ImageSectionSequence, x.ID).ToList
        '        oSections = (From x In oHouse.PropertyImages Where x.Property_ID = iPropID And x.ImageType = sType And x.ImageLocation = sLocation Select IIf(x.ImageSectionTitle Is Nothing, "", x.ImageSectionTitle) Distinct).ToArray
      Else
        If iPropID = 0 Then
          oSections = (From x In oHouse.PropertyImages Where x.PropertyGroupID = iGroupID And x.ImageType = sType And x.ImageLocation = sLocation Order By x.ImageSectionSequence, x.ID).ToList
        Else
          oSections = (From x In oHouse.PropertyImages Where x.PropertyGroupID = iGroupID And x.Property_ID = iPropID And x.ImageType = sType And x.ImageLocation = sLocation Order By x.ImageSectionSequence, x.ID).ToList
        End If
      End If
      If oSections IsNot Nothing And oSections.Count > 0 Then

        sSections = (From x In oSections Select x.ImageSectionTitle Distinct).ToList
        For Each sSection As String In sSections

          Dim oThisSection As String = sSection
          If iGroupID = 0 Then
            oImages = (From x In oHouse.PropertyImages Where x.Property_ID = iPropID And x.ImageType = sType And x.ImageLocation = sLocation And x.ImageSectionTitle = oThisSection Order By x.ImageSequence).ToList
          Else
            If iPropID = 0 Then
              oImages = (From x In oHouse.PropertyImages Where x.PropertyGroupID = iGroupID And x.ImageType = sType And x.ImageLocation = sLocation And x.ImageSectionTitle = oThisSection Order By x.ImageSequence).ToList
            Else
              oImages = (From x In oHouse.PropertyImages Where x.PropertyGroupID = iGroupID And x.Property_ID = iPropID And x.ImageType = sType And x.ImageLocation = sLocation And x.ImageSectionTitle = oThisSection Order By x.ImageSequence).ToList
            End If
          End If
          sCurrSectionTitle = oThisSection

          bFirstImage = True
          If sCurrSectionTitle = "No Title" And sForEdit <> "True" Then sCurrSectionTitle = ""

          If oImages IsNot Nothing AndAlso oImages.Count > 0 Then

            sDefaultAlt = "&ImageDefaultAlt=" & Server.UrlEncode(MyUtils.CreatePropertyImageAltTitleText("", oProp.PropertyGroupName, oHouse))

            For Each oImage As PropertyImage In oImages

              If oImage.ImageFile <> "" Then

                If oImage.ImageSequence > iMaxImageSeq Then iMaxImageSeq = oImage.ImageSequence
                sAlt = MyUtils.CreatePropertyImageAltTitleText(oImage.ImageAlt, oProp.PropertyGroupName, oHouse)

                If sCurrSectionTitle <> "" And bFirstImage Then
                  '                  If bUseSectionTitle And sCurrSectionTitle <> oImage.ImageSectionTitle Then
                  '                  bFirstImage = True
                  sCurrSectionTitle = oImage.ImageSectionTitle
                  If sCurrSectionTitle = "No Title" And sForEdit <> "True" Then sCurrSectionTitle = ""
                  sOut &= "<h3 Class=""ImageSectionTitle"">"
                  If sForEdit = "True" Then
                    sOut &= "<a  Class=""LinkLargeWhite"" title=""Click To change section title"" href=""#"" onclick=""ChangeSectionTitle(" & iPropID & "," & iGroupID & "," & oImage.ID & ",'" & oImage.ImageLocation & "')"">" & sCurrSectionTitle & "</a>"
                  Else
                    sOut &= sCurrSectionTitle
                  End If
                  sOut &= "</h3>" & vbCrLf

                  If sForEdit = "True" Then

                    sOut &= "<div style=""text-align:center;""><a class=""LinkSmallBlue"" target=""_blank"" href=""" & sAddImageURL & "&ImageSection=" & Server.HtmlEncode(sCurrSectionTitle) & sDefaultAlt & "_MAX_SEQ_"">Click To Add Image<br>for Section Below</a><br><br></div>" & vbCrLf

                  End If
                Else

                  If sForEdit = "True" And sCurrSectionTitle = "" And bFirstImage Then
                    sOut &= "<div style=""text-align:center;""><a  class=""LinkSmallBlue"" target=""_blank"" href=""" & sAddImageURL & sDefaultAlt & "_MAX_SEQ_"">Click To Add<br>" & oImage.ImageType & " Image<br>For Section Below</a><br><br></div>" & vbCrLf
                  End If
                End If
                'If Not bFirstImage Then
                '  sOut &= "  <td>" & vbCrLf
                '  sOut &= "    <div class=""DividerBlueThin""></div>" & vbCrLf
                '  sOut &= "  </td>" & vbCrLf
                '  sOut &= "</tr>" & vbCrLf
                'End If

                bFirstImage = False


                sImgWidth = MyUtils.CNullS(oImage.ImageWidth)
                sImgHeight = MyUtils.CNullS(oImage.ImageHeight)
                If sImgWidth = "" Then sImgWidth = sDefaultWidth
                If sImgHeight <> "" Then sImgHeight = " height=""" & sImgHeight & """ "
                If sImgWidth <> "" Then sImgWidth = " width=""" & sImgWidth & """ "


                sOut &= "<li>"
                If sForEdit = "True" Then
                  sTitle = "Click to edit image"
                  sURL = MyUtils.GetEditWebsiteLink & "&PropID=" & iPropID & "&Type=Details&GroupID=" & iGroupID & "&ImageID=" & oImage.ID & "&ImageSequence=" & oImage.ImageSequence & "&ImageType=" & sType & "&ImageLocation=" & sLocation & "&ImageSection=" & Server.UrlEncode(oImage.ImageSectionTitle) & MyUtils.GetCachedPageQS & sDefaultAlt
                  sOut &= "<a target=""_blank"" href=""" & sURL & """>" & vbCrLf
                  sAlt = sTitle
                  sOut &= "<img src=""/PropertyPhotos/" & oImage.Property_ID & "/" & oImage.ImageFile & """ title=""" & sTitle & """ alt=""" & sAlt & """  " & sImgWidth & " " & sImgHeight & "/></a>" & vbCrLf
                Else

                  Dim sZoomImage As String = ""
                  If MyUtils.CNullS(oImage.ImageFileEnlarged) <> "" And sForEdit <> "True" Then
                    Dim sPrettyImageName As String = sAlt

                    If oImage.ImageAlt <> "" Then sPrettyImageName = oImage.ImageAlt
                    sZoomImage = "<span class=""effect8""><img src=""/PropertyPhotos/" & oImage.Property_ID & "/" & oImage.ImageFileEnlarged & """ alt=""" & sPrettyImageName & """ title=""" & sPrettyImageName & """/><div class=""caption"">" & sPrettyImageName & "</div></span>"
                    sOpenGraphImages &= "<meta property=""og:image"" content=""" & MyUtils.GetAppSetting("MainWebsite") & "/PropertyPhotos/" & oImage.Property_ID & "/" & oImage.ImageFileEnlarged & """ />"
                  Else
                    sTitle = oProp.PropertyGroupName & " "
                    If oImage.ImageType = "Other" Then
                      sTitle &= MyUtils.CNullS(oImage.ImageSectionTitle)
                    Else
                      sTitle &= oImage.ImageType
                    End If
                    '                    sOut &= MyUtils.GetEnlargedImageSetup(oImage, sTitle, sAlt)
                  End If

                  sOut &= "<img src=""/PropertyPhotos/" & oImage.Property_ID & "/" & oImage.ImageFile & """ title=""" & sTitle & """ alt=""" & sAlt & """ " & sImgWidth & " " & sImgHeight & ">" & vbCrLf
                  sOut &= sZoomImage
                End If
                sOut &= "</li>" & vbCrLf

                ' 2/7/17 - SAM - removed the following <TR> b/c don't see a need for it.  but, you might have a dangling </tr> somewhere.
                'sOut &= "<tr><!--WHERE-END?-->" & vbCrLf
              End If

            Next

            'If sForEdit = "True" And sCurrSectionTitle = "" Then
            '  sOut &= "<tr>" & vbCrLf
            '  sOut &= "  <td>" & vbCrLf
            '  sOut &= "<a target=""_blank"" href=""" & sAddImageURL & "_MAX_SEQ_"">Click To Add Image</a><br><br>" & vbCrLf
            '  sOut &= "  </td>" & vbCrLf
            '  sOut &= "</tr>" & vbCrLf

            'End If

            If iMaxImageSeq >= 0 Then sOut = sOut.Replace("_MAX_SEQ_", "&ImageSequence=" & iMaxImageSeq + 1)

          End If
        Next
      End If

      GetImagesForProperty = sOut

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function

  Private Sub SetPropertyAmenitiesIcons(ByRef oProp As vwPropertiesWithGroup)

        sDisplayWheelchairIcon = ""
        sDisplayPoolIcon = ""
        sDisplayPhoneIcon = ""
        sDisplayInternetIcon = ""
        sDisplayWifiIcon = ""
        sDisplayWaterfrontIcon = ""
        sDisplayWateraccessIcon = ""

        sDisplayACIcon = ""
        sDisplayTVIcon = ""
        sDisplayPartiesIcon = ""
        sDisplayGrillIcon = ""
        sDisplayWasherDryerIcon = ""

    Try
            If Not oProp.Wireless Then sDisplayWifiIcon = "style='display: none;'"
            If Not oProp.Broadband Then sDisplayInternetIcon = "style='display: none;'"
            If Not oProp.Telephone Then sDisplayPhoneIcon = "style='display: none;'"
            If Not oProp.Pool Then sDisplayPoolIcon = "style='display: none;'"
            If Not oProp.TeamParties Then sDisplayPartiesIcon = "style='display: none;'"
            If Not oProp.Grill Then sDisplayGrillIcon = "style='display: none;'"
            If Not (oProp.CableTV Or oProp.DishSatellite) Then sDisplayTVIcon = "style='display: none;'"
            If Not oProp.DVD Then sDisplayDvdIcon = "style='display: none;'"
            If Not oProp.Dishwasher Then sDisplayDishwasherIcon = "style='display: none;'"
            If Not oProp.WasherDryer Then sDisplayWasherDryerIcon = "style='display: none;'"
            If Not (oProp.WindowAC Or oProp.CentralAC) Then sDisplayPoolIcon = "style='display: none;'"
            If Not oProp.WheelchairAccess Then sDisplayWheelchairIcon = "style='display: none;'"
            If Not (oProp.Category_ID = 3 Or MyUtils.CNullI(oProp.Category_ID2) = 3 Or MyUtils.CNullI(oProp.Category_ID3) = 3) And
                Not (oProp.Category_ID = 4 Or MyUtils.CNullI(oProp.Category_ID2) = 4 Or MyUtils.CNullI(oProp.Category_ID3) = 4) Then sDisplayWaterfrontIcon = "style='display: none;'"
            If (sDisplayWaterfrontIcon = "") Or Not (oProp.Category_ID = 13 Or MyUtils.CNullI(oProp.Category_ID2) = 13 Or MyUtils.CNullI(oProp.Category_ID3) = 13) Then sDisplayWateraccessIcon = "style='display: none;'"

    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try
  End Sub

  Private Function GetReviewsForProperty(ByRef oHouse As HouseRentalDataContext, sPropID As String, sGroupID As String, sForEdit As String, ByRef sReviewsRating As String, ByRef sReviewsCount As String) As String
    GetReviewsForProperty = ""

    ' For now, if editing, don't show
    If sForEdit = "True" Then Exit Function
    Try

      Dim sRating As String = "", sPropReviews As String = "", bFirstProp As Boolean = True
      'Dim sClose As String = "<div class=""ReviewsCloseButton""><a class=""MapButton PlainText"" href=""#"" onClick=""CloseReviews()"" title=""Close Guest Reviews"">Close Reviews</a></div>" & vbCrLf
      Dim oGSurvs As List(Of vwGuestSurveyAll) = Nothing
      Dim dRatingSum As Double = 0

      If sGroupID = "" Then
        oGSurvs = (From x In oHouse.vwGuestSurveyAlls Where x.Property_ID = MyUtils.CNullI(sPropID) And x.ShowOnline = -1 And x.PermissionToUse = "True" Order By x.PropertyName, x.ArriveDate Descending).ToList
      Else
        oGSurvs = (From x In oHouse.vwGuestSurveyAlls Where x.GroupID = MyUtils.CNullI(sGroupID) And x.ShowOnline = -1 And x.PermissionToUse = "True" Order By x.SequenceNumber, x.ArriveDate Descending).ToList
      End If
      Dim sOut As String = "<div id=""GuestReviews"" name=""GuestReviews"" class=""ReviewsMain""  >" & vbCrLf, sName As String = "", sData() As String = Nothing, sCurrProp As String = ""

      'sOut &= sClose & vbCrLf

      If oGSurvs IsNot Nothing AndAlso oGSurvs.Count > 0 Then
        For Each oGSurv In oGSurvs

          ' If property group, list name of each property
          If oGSurv.PropertyName <> sCurrProp Then
            sCurrProp = oGSurv.PropertyName
            'If sGroupID = "" Then
            '  sCurrProp = ""
            'End If
            If Not bFirstProp Then
              sPropReviews &= "</div>" & vbCrLf
            End If
            bFirstProp = False
            sPropReviews &= "<div class='ReviewsProperty'><div class='ReviewsPropertyTitle'>" & sCurrProp & "</div>" & vbCrLf
          End If

          sName = ""
          sData = Split(MyUtils.CNullS(oGSurv.Name).Trim, " ")
          If sData.Length = 1 AndAlso oGSurv.Name.Trim <> "" Then
            sName = sData(0)
          ElseIf sData.Length = 2 Then
            sName = sData(0) & " " & sData(1).Substring(0, 1)
            '            sName = sData(0).Substring(0, 1) & " " & sData(1)
          End If
          If sName = "" Then
            sName = "Guest"
          End If
          If MyUtils.CNullS(oGSurv.GuestState).Trim <> "" Then sName &= " from " & oGSurv.GuestState
          sPropReviews &= "<div class='ReviewsContent'><img class=""ReviewsImage"" src=""/images/StarRate" & oGSurv.LikeProperty & ".gif"" alt=""" & oGSurv.LikeProperty & " Stars!"" title=""" & oGSurv.LikeProperty & " Stars! - " & oGSurv.Booking_ID & """ /><div class=""ReviewsHeader"">" & sName & " - " & FormatDateTime(oGSurv.ArriveDate, DateFormat.ShortDate) & "</div>" & vbCrLf
          sPropReviews &= "<div class='ReviewsBody'>" & IIf(oGSurv.TextToShowOnline.Trim() = "", "", "<p>" & oGSurv.TextToShowOnline & "</p>") & "</div><div class='ReviewsRecommend'>Would you recommend to a friend? " & IIf(MyUtils.CNullI(oGSurv.ReferFriend, 1) = 0, "No", "Yes") & "</div></div>" & vbCrLf
          dRatingSum += oGSurv.LikeProperty
        Next
        sPropReviews &= "</div>" & vbCrLf

        If oGSurvs.Count > 0 Then dRatingSum = Int(10 * dRatingSum / oGSurvs.Count) / 10.0

        sReviewsRating = "<div><ul class='starBoxDet'>" & "<li><span class='fa fa-star'></span></li><li><span class='fa fa-star'></span></li>"
        If (dRatingSum > 2.5) Then
          sReviewsRating += "<li><span class='fa fa-star'></span></li>" & vbCrLf
          If (dRatingSum > 3.5) Then
            sReviewsRating += "<li><span class='fa fa-star'></span></li>" & vbCrLf
            If (dRatingSum > 4.5) Then
              sReviewsRating += "<li><span class='fa fa-star'></span></li>" & vbCrLf
            Else
              sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
            End If
          Else
            sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
            sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
          End If
        Else
          sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
          sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
          sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
        End If
        sReviewsRating += "</ul></div>"
        sReviewsCount = "(" & oGSurvs.Count & " reviews)"
      Else
        sOut &= "<div class='ReviewsContent'><br>Sorry, there are no reviews for this property yet.<br><br></div>" & vbCrLf

        sReviewsRating = "<ul class='starBoxDet'>" & vbCrLf
        sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
        sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
        sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
        sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
        sReviewsRating += "<li class='laststar'><span class='fa fa-star'></span></li>" & vbCrLf
        sReviewsRating += "</ul>"
        sReviewsCount = "(0 reviews)"


      End If
      sOut &= sPropReviews & "</div>" & vbCrLf

      GetReviewsForProperty = sOut
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

  End Function

  Protected Sub btnTakeOffline_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTakeOffline.Click
    ToggleOfflineButton(False, False)

  End Sub

  Protected Sub btnDeleteAllImages_Click(sender As Object, e As System.EventArgs) Handles btnDeleteAllImages.Click
    Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext(True)
    Dim iGroupID As Integer = MyUtils.CNullI(ViewState("GroupID")), sThisImage As String = ""
    Dim iPropID As Integer = MyUtils.CNullI(ViewState("PropID"))
    Dim iPropCat As Integer = MyUtils.CNullI(ViewState("PropCat")), oProps As List(Of [Property]) = Nothing

    Try

      Dim sPath As String = "", sDeletedPath As String = "", sImageFile As String = "", sDeletedImageFile As String = ""

      sPath = Server.MapPath("/PropertyPhotos/" & iPropID.ToString & "/")
      If Directory.Exists(sPath) Then

        sDeletedPath = sPath & "Deleted\"
        If Not Directory.Exists(sDeletedPath) Then Directory.CreateDirectory(sDeletedPath)

        Dim oImages = (From x In oHouse.PropertyImages Where x.Property_ID = iPropID Or x.PropertyGroupID = iGroupID).ToList
        If oImages IsNot Nothing AndAlso oImages.Count > 0 Then
          For Each oImage In oImages
            sThisImage = sPath & MyUtils.CNullS(oImage.ImageFile)
            If File.Exists(sThisImage) Then
              sDeletedImageFile = sDeletedPath & MyUtils.CNullS(oImage.ImageFile)
              Try
                File.Move(sThisImage, sDeletedImageFile)
              Catch ex As Exception
                MyErr.LogError(ex)
              End Try

            End If
            sThisImage = sPath & MyUtils.CNullS(oImage.ImageFileEnlarged)
            If File.Exists(sThisImage) Then
              sDeletedImageFile = sDeletedPath & MyUtils.CNullS(oImage.ImageFileEnlarged)
              Try
                File.Move(sThisImage, sDeletedImageFile)
              Catch ex As Exception
                MyErr.LogError(ex)
              End Try

            End If
            oHouse.PropertyImages.DeleteOnSubmit(oImage)
            oHouse.SubmitChanges()
          Next
        End If
      End If

      lblDeleteImagesResult.Text = "<br><br>Images Deleted!<br><br>"

    Catch ex As Exception
      MyErr.HandleError(ex)
      lblDeleteImagesResult.Text = "<br><br>There was an Error<br>While deleting the images.<br><br>"
    End Try
    MyData.DisposeHouseRentalContext(oHouse)

    SetDetailsPage(iPropID, iGroupID, iPropCat, MyUtils.InEditMode)


  End Sub

  Public Function GetDiscounted() As String
    If IsDiscounted AndAlso (IsSearchMode("Simple") OrElse IsSearchMode("Advanced")) Then
      GetDiscounted = "discounted"
    Else
      GetDiscounted = ""
    End If
  End Function

  Private Function IsSearchMode(ByVal sMode As String) As Boolean
    If sMode <> "Advanced" Then
    IsSearchMode = (MyUtils.CNullS(Session("SearchMode")) = sMode AndAlso MyUtils.CNullS(Request("Search")) = sMode)
    Else
      IsSearchMode = (Not Request.UrlReferrer Is Nothing) AndAlso (MyUtils.CNullS(Request.UrlReferrer.Host).ToLower.Contains(".cstayreserve.com"))
    End If

  End Function

End Class
