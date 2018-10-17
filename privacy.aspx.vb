
Partial Class Privacy
    Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    Session("CurrentPage4GoogleAnalytics") = "/MainSite/Privacy.aspx"
	
    If Not IsPostBack Then

			Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext
			Try

				MyData.GetWebItemForDisplay(litPrivacyPolicy, "Info_PrivacyPolicy", oHouse)

			Catch ex As Exception
				MyErr.HandleError(ex)
			End Try
			MyData.DisposeHouseRentalContext(oHouse)


    End If
  End Sub
End Class
