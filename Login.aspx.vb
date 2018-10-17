Imports System.IO
Imports System.Net

Partial Class Login
  Inherits System.Web.UI.Page
  Dim sOrdinals(12) As String


  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    lblEditModeWarning.Visible = MyUtils.InEditMode
    If Not IsPostBack Then

      Session.Abandon()
      ViewState("RedirectAfterLogin") = "/"
      If (MyUtils.CNullS(Request("EWP") <> "")) Then
        Dim sEditEmailCodeData As String = MyUtils.CNullS(Request("EditEmailCodeData"))
        If sEditEmailCodeData = "True" Then
          ViewState("RedirectAfterLogin") = MyUtils.GetEditWebsiteLink & "&EditEmailCodeData=True"
        Else
          ViewState("RedirectAfterLogin") = "Details.aspx?PropID=" & MyUtils.CNullS(Request("PropID")) & "&GroupID=" & MyUtils.CNullS(Request("GroupID"))
        End If
      End If
    End If


  End Sub

  Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click

    If (txtUserName.Text.ToLower.Trim = "lonetta" And txtPassword.Text = "freed0m") Or
    (txtUserName.Text.ToLower.Trim = "bruce" And txtPassword.Text = "brucer") Then
      MyUtils.SetEditMode(False)
      Session("EditUser") = txtUserName.Text.ToLower
      Session.Timeout = 3600
      Response.Redirect(ViewState("RedirectAfterLogin"), True)
      Exit Sub
    Else
      lblLoginMessage.Visible = True
    End If


  End Sub


  Protected Sub btnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogout.Click
    MyUtils.SetEditMode(True)
    Session.Abandon()
    '    Response.Redirect("http://" & Request.Url.Host.ToLower.Replace("edit-", "") & "/Default.aspx")
    Response.Redirect("/")
  End Sub

End Class
