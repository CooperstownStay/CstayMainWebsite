
Partial Class Photos
    Inherits System.Web.UI.Page

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

		If Not IsPostBack Then


      MyData.GetWebItemForDisplay(litPhotos_Description, "Photos_Description")

		End If

	End Sub
End Class
