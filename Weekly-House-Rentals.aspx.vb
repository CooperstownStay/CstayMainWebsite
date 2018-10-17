
Partial Class HouseRentals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        ViewState.Item("HasRightColumn") = False
    End Sub

    Protected Sub Page_PreLoad(sender As Object, e As System.EventArgs) Handles Me.PreLoad

        ViewState.Item("HasRightColumn") = False
    End Sub
End Class
