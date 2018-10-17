<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/Master.master" CodeFile="Properties.aspx.vb" MaintainScrollPositionOnPostback="true" Inherits="Properties" %>
<%@ Register TagName="TitleBar" TagPrefix="uc" Src="~/Controls/TitleBar.ascx" %>

<asp:Content ID="ContentTop" ContentPlaceHolderID="phTop" runat="server">
<uc:TitleBar ID="ucTitleBar" runat="server"  />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <!-- title set in codebehind-->
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />
  <meta name="description" content="<%= GetMetaDescription(Session("PropertiesPageTitle")) %>"/>
    <script type="text/javascript" language="javascript">
      function DoScroll() {
        ScrollMeTo(window.document.location)
      }
    </script>


  <style type="text/css">
    
    .btn-more-info
    {
        background: #aeb9dd;
        color: #fff;
        display: inline-block;
        font-size: 14px;
        font-weight: bold;
        padding: 6px 10px;
        text-decoration: none;
        margin-top:70px;
    }
    
    .property-photo img 
    {
        width:100%;
    }
    
    .property-photo {
        height:100%; /*height: 250px;*/
        max-height: 450px;
        overflow-y: hidden;
    }
    
    .property-detail-btn {
        background: #ffd22c;
        color: #333!important;
        text-decoration: none;
        display: inline-block;
        padding: 8px 15px;
        margin: -47px 10px 0px 0px;
        text-transform: uppercase;
        float: right;
        font-weight: bold;
    }
    a.btn.property-detail-btn:hover {
        background-color: #ECB700;
    }
    .property-price {
        margin-top: -50px;
        display: block;
        padding: 10px 20px;
        color: #fff;
        font-size: 19px;
    }
    
    .property-photo:after {
        content: "";
        display: block;
        height: 60%;
        width: 100%;
        position: absolute;
        left: 0;
        bottom: 0;
        right: 0;
        background-image: -webkit-linear-gradient(top, transparent 0%, rgba(0,0,0,0.7) 100%);
        background-image: -o-linear-gradient(top, transparent 0%, rgba(0,0,0,0.7) 100%);
        background-image: -webkit-gradient(linear, left top, left bottom, from(transparent), to(rgba(0,0,0,0.7)));
        background-image: -moz-linear-gradient(top, transparent 0%, rgba(0,0,0,0.7) 100%);
        background-image: linear-gradient(to bottom, transparent 0%, rgba(0,0,0,0.7) 100%);
        background-repeat: repeat-x;
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00000000', endColorstr='#B3000000', GradientType=0);
    }
    
    .prop-br, .prop-ba, .prop-sleeps {
        font-size: 15px;
        font-weight: bold;
        display: inline-block;
        padding: 0px 10px 10px 0px;
    }
    .prop-dist {
        font-size: 12px;
        padding-top: 3px;
    }
    
    
    .prop-meta {padding: 15px 15px 15px 30px;}
    
    .prop-dist span {
        display: inline-block;
        width: 40px;
        text-align: center;
        background-color: #fff;
        margin-right: 3px;
        font-weight:bold;
    }

    .PropHold {background-color:#669966;}
        
    .propertyBox h3 
    {
        padding: 15px 10px;
        text-align: center;
        display: block;
        background: #334377;
        color: #fff;
        font-size: 1.5em;
        margin: 10px 0px 0px;
    }
    
    .tab-pane {
        background-color: #fff;
        margin-top: 0px;
        padding: 20px 0px 0px;
    }
    
    
    @media (max-width: 767px){
        .row {margin-right: 0px;margin-left: 0px;}
    
        .prop-meta {padding: 15px;}
    }
    
    .click4more {
        display: inline-block;
        margin-top: 30px;
        text-align: center;
    }
    .click4more a.btn.btn-xs.btn-info {
        margin: 3px 0px;
    }
    
    /* prop-special for waterfront */
    
    .propertyBox .prop-special {
        display: block;
        background-color: #F2D46F;
        padding: 3px 3px;
        text-align: center;
        font-weight: bold;
    }
    
    .rightbox .details {text-align: right;margin-right: 30px;} /* removed other buttons - photos,reviews - so pushed this to the right */
    
    /**** Styles for amenities expand/collapse ***/
    
    
        .extra button:after {
            font-family:'FontAwesome';
            content:"\f068";
            float: right;
            color: #000;
        }
        .extra button.collapsed:after {
            content:"\f067";
        }
        
        .extra button {display:block;}
        
        .extra button.btn.btn-link {
            display: block!important;
            width: 100%;
            text-align: left;
            background-color: #f2f2f2;
            font-weight: bold;
            color: #000;
            margin: 10px 0px;
        }
        .extra button.btn.btn-link:hover {background-color:#e2e2e2;text-decoration:none;}
        
        .btn-link:focus, .btn-link:active, .btn-link:hover {outline: none!important;text-decoration:none;}
    
        #amenities {padding:10px;}
        
    /*** end: amenities */
    
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftSideContent" runat="Server">
<!--LeftSideContent-->
<div class="extra">
<button type="button" class="btn btn-link btn-sm collapsed" data-toggle="collapse" data-target="#amenities">Standard Amenities</button>
<div id="amenities" class="collapse"><div class="StandardAmenities" ><asp:Literal ID="litStandardAmenities" runat="server"></asp:Literal></div></div>
</div>
<!--/LeftSideContent-->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainBodyContent" runat="Server">
<!--MainBodyContent-->
<!--div style="margin-left:3px;"-->
  <div class="listingPage">
<h2><asp:Literal ID="lblMasterTitle" Text="Apartments" runat="server"></asp:Literal></h2>

    <asp:Panel ID="pnlSearchButtons"  runat="server" Visible="true">
    <div class="row">
      <div class="form-group col-xs-offset-1 col-xs-4 col-sm-offset-2 col-sm-4">
        <input type="button" value="Modify Search" class="form-control btn btn-success"  id="btnModifySearch" onclick="SearchReturn('True')" />
      </div>
      <div class="form-group col-xs-offset-1 col-xs-4  col-sm-4">
        <input type="button" value="New Search" class="form-control" id="btnNewSearch" onclick="SearchReturn('')" />
      </div>
    </div>
      </asp:Panel>
    <!--lblMasterBody--><asp:Literal ID="lblMasterBody" runat="server" Text="Master Body"></asp:Literal><!--/lblMasterBody-->
<!--div-->
</div><!--/listingPage-->
<!--/MainBodyContent-->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="RightSideContent" Runat="Server">
<!--RightSideContent-->
  <div class="mobileHide"><b><a id="MasterList"></a>
          <asp:Literal ID="lblMasterListTitle" runat="server" Text=""></asp:Literal>
          </b></div>
  <div class="mobileHide"><asp:Literal ID="lblMasterList" runat="server" Text=""></asp:Literal></div>
<!--/RightSideContent-->
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" Runat="Server">

    <script type="text/javascript">
      function SearchReturn(sNewSearch) {
        var sURL = "/?ModifySearch=" + sNewSearch;
        window.location = sURL
      }
    </script>

  <%=MyUtils.SetGoogleAdwordsConversionCode(Page, "1036267566", GetGoogleAdwordsConversionKey())%>
</asp:Content>


