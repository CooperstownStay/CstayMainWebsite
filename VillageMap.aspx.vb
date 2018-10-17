
Partial Class VillageMap
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    If IsPostBack Then
      litRedirectToAreaMap.Text = ""
    Else

      Dim sInProps As String = MyUtils.CNullS(Request("Props")), bRedirectToAreaMap As Boolean = False
      Dim sVillageProps As String = MyUtils.GetAppSetting("VillageMapProperties")
        If sInProps <> "" Then
          Dim sData() As String = sInProps.Split("|"), sProps() As String = Nothing, iIndex As Integer = 0, sData2() As String = Nothing
          For iIndex = 0 To sData.Count - 1
            sData2 = sData(iIndex).Split(":")
            If sData2.Count > 1 Then
              If sVillageProps.Contains(sData2(0)) Then

                If MyUtils.CNullS(sData2(1)) = "" Then
                  MyUtils.AddItemToArray(sProps, "PropID=" & sData2(0))
                Else
                  MyUtils.AddItemToArray(sProps, "GroupID=" & MyUtils.CNullS(sData2(1)))
                End If

              Else
                bRedirectToAreaMap = True
              litRedirectToAreaMap.Text = " <script type=""text/javascript"">" & vbCrLf &
                  "var sNewLoc = window.location.href.replace('village', 'area') + '&RedirectFromVillageMap=True'" & vbCrLf &
                  "alert('Not all the properties you chose are in the Village of Cooperstown\nso we will display your selections on our Cooperstown Area Map.')  " & vbCrLf &
                "window.location.href = sNewLoc" & vbCrLf & "</script>"
              Exit Sub
              End If
            End If
          Next
          hidPropertiesToMark.Value = MyUtils.ArrayToJSON(sProps, "Props")

        End If

      End If


  End Sub
End Class
