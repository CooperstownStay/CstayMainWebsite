
Partial Class AreaMap
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    If IsPostBack Then
    Else

      Session("AreaMapReturnPage") = MyUtils.CNullS(Request("ReturnPage"))
      Dim sInProps As String = MyUtils.CNullS(Request("Props"))
      If sInProps <> "" Then
        Dim sData() As String = sInProps.Split("|"), sProps() As String = Nothing, iIndex As Integer = 0, sData2() As String = Nothing
        If sData.Count = 1 Then
          sData2 = sData(0).Split(":")
          Dim sVillageProps As String = MyUtils.GetAppSetting("VillageMapProperties")
          If sVillageProps.Contains(":" & sData2(0) & ":") Then
            Try
              Response.Redirect(Request.RawUrl.Replace("area", "village"), True)
            Catch ex As Exception
            End Try
            Exit Sub
          End If
        End If
        For iIndex = 0 To sData.Count - 1
          sData2 = sData(iIndex).Split(":")
          If sData2.Count > 1 Then
            If MyUtils.CNullS(sData2(1)) = "" Then
              MyUtils.AddItemToArray(sProps, "PropID=" & sData2(0))
            Else
              MyUtils.AddItemToArray(sProps, "GroupID=" & MyUtils.CNullS(sData2(1)))
            End If
          End If
        Next
        hidPropertiesToMark.Value = MyUtils.ArrayToJSON(sProps, "Props")

      End If

    End If



  End Sub

  


End Class
