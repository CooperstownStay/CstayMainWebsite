Partial Class _Default
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    Session("CurrentPage4GoogleAnalytics") = "/MainSite/Default.aspx"
    If Not IsPostBack Then

      If MyUtils.CNullS(Request("SetEditMode")) = "True" Then MyUtils.SetEditMode(False)
      If MyUtils.CNullS(Request("ExitEditMode")) = "True" Then MyUtils.SetEditMode(True)


      Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext
      Try
                
                MyData.GetWebItemForDisplay(litDefault_Welcome, "Default_Welcome", oHouse)
                MyData.GetWebItemForDisplay(litDefault_AboutLonetta, "Default_AboutLonetta", oHouse)
                MyData.GetWebItemForDisplay(litDefault_AboutLonetta2, "Default_AboutLonetta", oHouse)
                MyData.GetWebItemForDisplay(litDefault_Bottom, "Default_Bottom", oHouse)
                MyData.GetWebItemForDisplay(litDefault_OpeningDay, "Default_OpeningDay", oHouse)
                MyData.GetWebItemForDisplay(litDefault_SpecialMessage, "Default_SpecialMessage", oHouse)
                MyData.GetWebItemForDisplay(litDefault_LeftColumn, "Default_LeftColumn", oHouse)
                MyData.GetWebItemForDisplay(litDefault_Testimonial, "Default_Testimonial", oHouse)
                MyData.GetWebItemForDisplay(litDefault_TestimonialSource, "Default_TestimonialSource", oHouse)

        pnlSpecialMessage.Visible = (litDefault_SpecialMessage.Visible And litDefault_SpecialMessage.Text <> "") Or MyUtils.InEditMode

        pnlSeasonStart.Visible = litDefault_SpecialMessage.Visible
        rowDiscountedRates.Visible = False

        If Not MyUtils.InEditMode Then
          Dim dSeasonEndDate As DateTime = CDate(MyUtils.GetAppSetting("SeasonEndDate"))
          Dim dSeasonStartDate As DateTime = CDate(MyUtils.GetAppSetting("SeasonStartDate"))
          Dim dNow As DateTime = Now
          If IsDate(dSeasonEndDate) Then
            If dNow > CDate(dSeasonEndDate).AddDays(-60) And dNow <= CDate(dSeasonStartDate) Then
              pnlSeasonStart.Visible = True
            Else
              pnlSeasonStart.Visible = False
            End If

            'set visibility of discounted rates to visible when discounts exists and today's date is 5 months before new season date and not after 30 days before new season.
            rowDiscountedRates.Visible = MyData.PropertyDiscountsExist 'AndAlso (dNow > CDate(dSeasonEndDate).AddDays(-150) AndAlso dNow < CDate(dSeasonEndDate).AddDays(-30))
          End If
        End If

    InitializeTournamentWeeks(oHouse)
    If MyUtils.CNullS(Request("ModifySearch")) = "True" Then
      ReLoadSearchBox()
    End If

      Catch ex As Exception
      MyErr.HandleError(ex)
    End Try
      MyData.DisposeHouseRentalContext(oHouse)

    End If

  End Sub

  Private Sub InitializeTournamentWeeks(oHouse As HouseRentalDataContext)

    ddlSearchTournamentWeek.AppendDataBoundItems = True
    'ddlSearchTournamentWeek.Items.Add(New ListItem("Tournament Week", ""))

    If MyUtils.AfterSeason Then
      Dim dStart As DateTime = CDate("5/1/" & Now.Year + 1)
      Dim dEnd As DateTime = CDate("9/10/" & Now.Year + 1)
      Dim oTournWeeksAll As List(Of vwBookingWeeksAll) = (From x In oHouse.vwBookingWeeksAlls Where x.StartDate > dStart And x.EndDate < dEnd Order By x.StartDate).ToList()
      ddlSearchTournamentWeek.DataSource = oTournWeeksAll
    Else
      Dim oTournWeeks As List(Of vwBookingWeek) = (From x In oHouse.vwBookingWeeks Order By x.StartDate).ToList()
      ddlSearchTournamentWeek.DataSource = oTournWeeks
    End If
    ddlSearchTournamentWeek.DataTextField = "Week"
    ddlSearchTournamentWeek.DataValueField = "Dates"
    ddlSearchTournamentWeek.DataBind()

  End Sub
  Private Sub ReLoadSearchBox()

    ddlSearchTournamentWeek.SelectedValue = MyUtils.CNullS(Session("SearchWeek"))
    ddlSearchLodgingType.SelectedValue = MyUtils.CNullS(Session("SearchLodgingType"))
    ddlTournamentLocation.SelectedValue = MyUtils.CNullS(Session("SearchLocation"))

    If Not String.IsNullOrEmpty(Session("SearchBedrooms")) Then
      Dim sBR() As String = Session("SearchBedrooms").ToString().Split(",")

      For Each sValue In sBR
        cblSearchBedrooms.Items.FindByValue(sValue).Selected = True
      Next

    End If


  End Sub
End Class
