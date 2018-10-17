
Partial Class Controls_TitleBar
  Inherits System.Web.UI.UserControl

  Private _title As String = "default"
  Private _subTitle As String = "default"
  Private _calloutOnly As String = ""

  Public Property Title() As String
    Get
      Return IIf(_title = "default", Page.Title, _title)
    End Get
    Set(ByVal value As String)
      _title = value
    End Set
  End Property

  Public Property SubTitle() As String
    Get
      Return IIf(_subTitle = "default", Page.MetaDescription, _subTitle)
    End Get
    Set(ByVal value As String)
      _subTitle = value
    End Set
  End Property

  Public Property CalloutOnly() As String
    Get
      Return IIf(_calloutOnly = "", "", " style=""display:none""")
    End Get
    Set(ByVal value As String)
      _calloutOnly = value
    End Set
  End Property


  Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
  End Sub


End Class
