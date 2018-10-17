
Partial Class Info
    Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    Session("CurrentPage4GoogleAnalytics") = "/MainSite/Info.aspx"
    If Not IsPostBack Then


      Dim oHouse As HouseRentalDataContext = MyData.GetHouseRentalContext
      Try

        MyData.GetWebItemForDisplay(litInfo_CancellationPolicy, "Info_CancellationPolicy", oHouse)
        MyData.GetWebItemForDisplay(litInfo_PaymentPolicy, "Info_PaymentPolicy", oHouse)

        MyData.GetWebItemForDisplay(litStandardAmenities, "StandardAmenities", oHouse)

      Catch ex As Exception
        MyErr.HandleError(ex)
      End Try

      MyData.DisposeHouseRentalContext(oHouse)

    End If
  End Sub
End Class
