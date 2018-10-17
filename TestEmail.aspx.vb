

Partial Class TestEmail
    Inherits System.Web.UI.Page

	Protected Sub btnAddEmail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddEmail.Click

		Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext(True)
		Try

			Dim oMail As New QueuedEmail
			oMail.AddDate = Now
			oMail.AttachmentFile = "E:\Temp\Obamacare.pdf"
			oMail.Body = "<html><body><table><tr><td>This is my test email</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in a table</td></tr></table></body></html>"
			oMail.FormatIsHTML = False
			oMail.FromAddress = "Byron.Richard@Architechsw.com"
			oMail.FromName = "Bubba Bean"
			oMail.Priority = 2
			oMail.SourceDB = "HouseRental"
			oMail.SourceServer = "TSS-LAPTOP"
			oMail.Subject = "This is Test Email at " & Now
			oMail.SubmittedBy = "Byron"
			oMail.ToAddress = "team@ArtHost.biz"
			oMail.ToName = "The Team"
			oMail.Status = "Queued"
			oHouse.QueuedEmails.InsertOnSubmit(oMail)
			oHouse.SubmitChanges()

		Catch ex As Exception

		End Try

	End Sub

  Protected Sub btnShowCache_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowCache.Click

    Dim oKeys As List(Of String) = Nothing, iCount As Integer = 0

    Dim oEnum As IDictionaryEnumerator = HttpRuntime.Cache.GetEnumerator()
    lblResult.Text = "<br><br><br><br>Runtime Cache: <br><br>"
    Do While (oEnum.MoveNext())
      lblResult.Text &= "Key: " & oEnum.Key.ToString & "<br>"
      oKeys.Add(oEnum.Key.ToString)
    Loop

    lblResult.Text &= "<br><br><br><br>Current Cache: <br><br>"
    oEnum = HttpContext.Current.Cache.GetEnumerator()
    Do While (oEnum.MoveNext())
      lblResult.Text &= "Key: " & oEnum.Key.ToString & "<br>"
      oKeys.Add(oEnum.Key.ToString)
    Loop


  End Sub

  Protected Sub btnTestDB_Click(sender As Object, e As System.EventArgs) Handles btnTestDB.Click
    Dim sConnString As String = Global.System.Configuration.ConfigurationManager.ConnectionStrings("HouseRentalConnectionString").ConnectionString

    Try
      If txtConnString.Text <> "" Then sConnString = txtConnString.Text
      Dim MyConnection = New System.Data.SqlClient.SqlConnection
      MyConnection.ConnectionString = sConnString
      MyConnection.Open()

      lblResult.Text = "Connection opened!"
    Catch ex As Exception
      lblResult.Text = "Error connecting with: " & sConnString & "<br><br>" & MyErr.GetHTMLError(ex)
    End Try

  End Sub

End Class
