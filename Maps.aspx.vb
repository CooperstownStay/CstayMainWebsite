
Partial Class Maps
    Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Session("CurrentPage4GoogleAnalytics") = "/MainSite/Maps.aspx"

    If Not IsPostBack Then


      MyData.GetWebItemForDisplay(litMaps_Directions, "Maps_Directions")

    End If



  End Sub
End Class
