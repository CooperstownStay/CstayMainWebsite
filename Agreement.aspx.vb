
Partial Class Agreement
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    Session("CurrentPage4GoogleAnalytics") = "/MainSite/Agreement.aspx"
    If Not IsPostBack Then

      Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext
      Try

        MyData.GetWebItemForDisplay(litInfo_RentalAgreement, "Info_RentalAgreement", oHouse)
        MyData.GetWebItemForDisplay(litStandardAmenities, "StandardAmenities", oHouse)

      Catch ex As Exception
        MyErr.HandleError(ex)
      End Try

      MyData.DisposeHouseRentalContext(oHouse)

    End If
  End Sub
End Class
