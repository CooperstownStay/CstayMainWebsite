
Partial Class WebError
    Inherits System.Web.UI.Page

  Protected Sub btnSend_Click(sender As Object, e As System.EventArgs) Handles btnSend.Click

    Dim iErrID As Integer = MyUtils.CNullI(lblErrID.Text.ToString)
    If iErrID > 0 And txtFeedback.Text.ToString.Trim <> "" Then


      Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext(True)
      Try
        Dim oErr = (From x In oHouse.WebErrorLogs Where x.idError = iErrID).FirstOrDefault
        oErr.cErrorUserInput = txtFeedback.Text
        oHouse.SubmitChanges()
        lblThankYou.Text = "Thank you for taking the time to give us your input!"
        pnlFeedback.Visible = False

      Catch ex As Exception

      End Try
      MyData.DisposeHouseRentalContext(oHouse)

    End If
  End Sub

  Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

    If Not IsPostBack Then

      Try

        Dim iErrID As Integer = MyUtils.CNullI(Request("ErrID"))
        If iErrID > 0 Then
          pnlFeedback.Visible = True
          lblErrID.Text = MyUtils.CNullS(Request("ErrID"))
        End If

        If Not Request.Url.AbsoluteUri.ToLower.Contains("www") Then
          If iErrID > 0 Then
            Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext
            Try

              Dim oErr = (From x In oHouse.WebErrorLogs Where x.idError = iErrID).FirstOrDefault
              If oErr IsNot Nothing Then
                lblErrorHTML.Text = oErr.cErrorHTML
                lblErrorHTML.Visible = True
              End If
              oErr = Nothing
            Catch ex As Exception

            End Try
            MyData.DisposeHouseRentalContext(oHouse)

          End If
        End If
      Catch ex As Exception

      End Try
    End If

  End Sub
End Class
