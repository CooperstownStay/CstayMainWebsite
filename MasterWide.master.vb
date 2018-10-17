
Partial Class MasterWide
  Inherits System.Web.UI.MasterPage

  Public Property HasRightColumn As Boolean
    Get
      Return Boolean.Parse(MyUtils.CNullS(ViewState.Item("HasRightColumn"), "True"))
    End Get
    Set(value As Boolean)
      ViewState.Item("HasRightColumn") = value
    End Set
  End Property

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    'Response.Redirect("ReserveUnavailable.htm")
    'Exit Sub


    Dim sURL As String = Request.Url.AbsoluteUri.ToString, sPropCat As String = MyUtils.CNullS(Request("PropCat"))
    Dim sPropID As String = MyUtils.CNullS(Request("PropID")), sGroupID As String = MyUtils.CNullS(Request("GroupID"))
    Dim sHost As String = Request.Url.DnsSafeHost ', sData2() As String  ' commented sData2 b/c it was an unused variable
    '      Response.Write(sHost & "  :  " & sURL)
    'sData2 = Split(sHost, ".")
    '    If sData2.Count > 0 Then
    '        If sData2(0) = "www" Then
    '            sURL = sURL.Replace(sHost, "www." & sHost)
    '            Response.Redirect(sURL, True)
    '            Exit Sub
    '        End If
    '    End If

    If Not IsPostBack Then
      pnlEditMode.Visible = MyUtils.InEditMode
      If (Request.Url.AbsoluteUri.ToLower.Contains("test.") Or Request.Url.AbsoluteUri.ToLower.Contains("dev.")) Then
        lblTestMode.Text = "<div class=""testmode"">  *** Test Website ****** Test Website ****** Test Website ****** Test Website ***  <a rel=""nofollow"" href=""" & Request.Url.AbsoluteUri.Replace("http://dev.", "http://www.").Replace("http://test.", "http://www.") & """>View This Page on our Production Website</a></div>"
        lblTestMode.Visible = True
      End If


      If (sURL.Contains("Properties") And Not sURL.Contains("Search")) Or sURL.Contains("Rental-") Or sPropID <> "" Then
        If sURL.Contains("Properties") Then
          If sPropCat.Contains(",") Then
          End If
        Else
          Dim sPropName As String = MyUtils.CNullS(Page.RouteData.Values("PropertyName")).Replace("-", " ").ToLower, bIsActive As Boolean = False
          If sPropName <> "" Or sPropID <> "" Then
            MyData.GetPropertyInfoByName(sPropName, sPropID, sGroupID, bIsActive, sPropCat)
            If sPropID <> "" Then
              Session("PropID") = sPropID
            End If
          End If

        End If
      End If


    End If

  End Sub

  '
  Public Function GetGoogle_gaq_Link() As String
    GetGoogle_gaq_Link = ""
    On Error Resume Next
    If Not (MyUtils.BrowserInCStayOffice(Request, Session)) Then GetGoogle_gaq_Link = MyUtils.GetAppSetting("Google_gaqLink")
    Err.Clear()
  End Function


  Protected Sub btnLeavEditMode_Click(sender As Object, e As System.EventArgs) Handles btnLeavEditMode.Click
    Dim sReplace As String = MyUtils.CNullS(Session("EditModeQS"), "#e5@90*jN|")
    Dim sReplace2 As String = MyUtils.CNullS(Session("AndEditModeQS"), "#e5@90*jN|")
    Dim sURL As String = Request.Url.AbsoluteUri.Replace(sReplace, "").Replace(sReplace2, "").Replace("Edit-", "").Replace("edit-", "").Replace("EWP", "h")

    Session.Abandon()
    Try
      Response.Redirect(sURL, True)

    Catch ex As Exception

    End Try

  End Sub

End Class

