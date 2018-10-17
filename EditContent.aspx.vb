
Partial Class EditContent
  Inherits System.Web.UI.Page

  Private Sub EditContent_Load(sender As Object, e As EventArgs) Handles Me.Load

    ' This is here until can change the Rental software to use a different link
    Dim sEditEmailCodeData As String = MyUtils.CNullS(Request("EditEmailCodeData"))
    If sEditEmailCodeData = "True" And Not MyUtils.InEditMode Then
      Response.Redirect(MyUtils.GetAppSetting("MainWebsite") & "/Login.aspx?EWP=d0&" & Request.QueryString.ToString, True)
    Else
      Response.Redirect("/")
    End If
  End Sub
End Class
