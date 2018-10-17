
Partial Class ContactUs
  Inherits System.Web.UI.Page

  Dim sProperty As String

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    sProperty = MyUtils.CNullS(Request("p"))

    If Not IsPostBack Then
      Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext

      InitializeTournamentWeeks(oHouse)

      Session("CurrentPage4GoogleAnalytics") = "/MainSite/ContactUs.aspx"

      divProperty.Visible = (sProperty <> "")
      If divProperty.Visible Then rowNeedHelpCallout.Visible = False
    Else
      lblResults.Visible = True

    End If

  End Sub

  Protected Sub btnSendContactInfo_Click(sender As Object, e As System.EventArgs) Handles btnSendContactInfo.Click

    Dim sMsg As String = "", bSent As Boolean = False

    Try

      If MyUtils.CNullS(Request("name_first_last")) = "" Or _
        MyUtils.CNullS(Request("phone")) = "" Or _
        MyUtils.CNullS(Request("email")) = "" Or _
        MyUtils.CNullS(tournament.Value) = "" Or _
        MyUtils.CNullS(ddlSearchTournamentWeek.SelectedValue) = "" Then
        ' only require tournament week and location when user is inquiring about a specific property
        lblResults.Text = "Name, Phone, Email, Tournament Week and Location are required for us to know how to assist you.  Please re-enter and try again." '<div style=""background-color: yellow;color: red;padding: 10px;font-size:15px;font-weight:bold;""></div>
        Exit Sub
      End If

      ' 1/7/17 - SAM - Added reCAPTCHA
      If Not ctrlGoogleReCaptcha.Validate() Then
        lblResults.Text = "<div style=""background-color: yellow;color: red;padding: 10px;font-size:15px;font-weight:bold;"">Incorrect reCAPTCHA Code. Please try again.  If the problem persists, please call us at 607-547-6260.</div>"
        Exit Sub
      End If

      sMsg += "<BR/><BR/><table cellpadding=""3"" border=""0"">"
      sMsg += "<tr><td nowrap>Name:</td><td>" & MyUtils.CNullS(Request("name_first_last")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>Address 1:</td><td>" & MyUtils.CNullS(Request("address_1")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>Address 2:</td><td>" & MyUtils.CNullS(Request("address_2")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>City:</td><td>" & MyUtils.CNullS(Request("city")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>State:</td><td>" & MyUtils.CNullS(Request("state")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>Zip:</td><td>" & MyUtils.CNullS(Request("zip")) & "</td></tr>" & vbCrLf
      sMsg += "<tr><td nowrap>Phone #:</td><td>" & FormatPhoneNumber(MyUtils.CNullS(Request("phone"))) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>Work Phone:</td><td>" & MyUtils.CNullS(Request("phone_w")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>Cell Phone:</td><td>" & MyUtils.CNullS(Request("phone_c")) & "</td></tr>" & vbCrLf
      sMsg += "<tr><td nowrap>Email:</td><td><a href=""mailto:" & MyUtils.CNullS(Request("email")) & """>" & MyUtils.CNullS(Request("email")) & "</td></tr>" & vbCrLf

      If divProperty.Visible Then
        sMsg += "<tr><td nowrap>Property:</td><td>" & MyUtils.CNullS(Request("rpoi")) & "</td></tr>" & vbCrLf
      Else
        sMsg += "<tr><td nowrap>Property:</td><td>Customer didn't express interest in a specific property.</td></tr>" & vbCrLf
      End If

      sMsg += "<tr><td nowrap>Tournament:</td><td>" & MyUtils.CNullS(tournament.Value, "Not Specified") & "</td></tr>" & vbCrLf
      sMsg += "<tr><td nowrap># Guests:</td><td>" & MyUtils.CNullS(Request("how_many_in_your_party"), "Not Specified") & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap># Children:</td><td>" & MyUtils.CNullS(Request("number_of_children")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap># Adults:</td><td>" & MyUtils.CNullS(Request("number_of_adults")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>Lodging Type:</td><td>" & MyUtils.CNullS(Request("type_of_lodging")) & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>Arrival Date:</td><td>" & MyUtils.CNullS(Request("arrival_date")) & "</td></tr>" & vbCrLf
      sMsg += "<tr><td nowrap>Tournament Week:</td><td>" & MyUtils.CNullS(ddlSearchTournamentWeek.SelectedValue, "Not Specified").Replace(":", " - ") & "</td></tr>" & vbCrLf
      'sMsg += "<tr><td nowrap>Departure Date:</td><td>" & MyUtils.CNullS(Request("departure_date")) & "</td></tr>" & vbCrLf
      sMsg += "<tr><td nowrap>Special Requests:</td><td>" & MyUtils.CNullS(Request("special_requests"), "None") & "</td></tr></table><BR/><BR/>" & vbCrLf

      ' Lonetta wants the email subject to be different depending on whether the person is inquiring about a specific product or just someone who visited the contact page.
      Dim sSubject = "CooperstownStay email form"
      If divProperty.Visible Then sSubject = "Info Request for " & sProperty & " by " & MyUtils.CNullS(Request("name_first_last"))

      bSent = MyUtils.SendMail("find@cooperstownstay.com", "find@cooperstownstay.com", sSubject, sMsg, MyUtils.CNullS(Request("name_first_last")), "Cooperstown Stay", True, True, , MyUtils.CNullS(Request("email")), True)

      If MyUtils.CNullS(Request("email")) <> "" And MyUtils.CNullS(Request("name_first_last")) <> "" Then
        sMsg = "Hello,<br><br>Thank you for contacting Cooperstown Stay for your lodging needs.<br><br>I will respond to your specific request by phone and/or email.<br><br>" &
       "Lonetta<br>Cooperstown Stay<br>607-547 6260<br>www.cooperstownstay.com<br>" & sMsg
        If Not divProperty.Visible Then
          sSubject = "Lodging in Cooperstown"
        Else
          sSubject = "Info Request for " & sProperty
        End If
        MyUtils.SendMail(Request("email"), "find@cooperstownstay.com", sSubject, sMsg, "Cooperstown Stay", MyUtils.CNullS(Request("name_first_last")), True, True)
      End If
    Catch ex As Exception
      MyErr.HandleError(ex)
    End Try

    If bSent Then
      Dim sResults As String = ""

      If sProperty <> "" Then
        sResults = "<h3>Success! Your Inquiry Has Been Received.</h3>" & _
                "<p>Thank you for inquiring about the <strong>" & sProperty & "</strong> weekly rental property.  We will respond by phone and/or email.</p>" & _
                "<p>Feel free to call 607-547-6260 on Weekdays between 9:00 am - 6:00 pm (EST) or Saturday between 10:00 am - 4:00 pm (EST).</p>" & _
                "<p>Thank you for choosing CooperstownStay.com for your accommodations.</p>" & _
                "<p><i>Lonetta</i></p>" & _
               "<p><a href=""#"" runat=""server"" class=""btn btn-success"" onclick=""window.close();"">Return To Previous Page</a></p>"
      Else
        sResults = "<br><br>Thank you for contacting us.<br>We'll respond by <br>phone and/or email!<br><br><i>Lonetta<br></i><br><br><br>"
      End If
      lblResults.Text = sResults
      pnlContactForm.Visible = False
    Else
      lblResults.Text = "<b>We are unable to submit your Contact Request.</b><br/><br/>Please examine the information you provided and try submitting, again.<br><br>"
    End If
    '			End If
  End Sub


  Private Sub InitializeTournamentWeeks(oHouse As HouseRentalDataContext)

    ddlSearchTournamentWeek.AppendDataBoundItems = True
    ddlSearchTournamentWeek.Items.Add(New ListItem("", ""))
    ddlSearchTournamentWeek.Items.Add(New ListItem("NOT SURE", "NOT SURE"))

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

  Private Function FormatPhoneNumber(sPhoneNum As String) As String
    Dim sRetVal As String

    If sPhoneNum.Length = 10 Then
      sRetVal = sPhoneNum.Substring(0, 3) & "-" & sPhoneNum.Substring(3, 3) & "-" & sPhoneNum.Substring(6)
    Else
      sRetVal = sPhoneNum
    End If

    FormatPhoneNumber = sRetVal
  End Function

End Class
