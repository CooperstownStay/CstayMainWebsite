<%@ Page Title="Cooperstown, NY Area Map" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Maps.aspx.vb" Inherits="Maps" MetaDescription="Map of Cooperstown, NY and surrounding area.  Find the best rental accommodations near your baseball tournament." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/cooperstown-ny-map" />
  <title>Map of Cooperstown, NY and Surrounding Area | Cooperstown Stay</title>
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />
  
<style type="text/css">

    /*  these styles are for the right column text that comes from the database */
    .map-help {
        margin-top: 30px;
    }
    .map-help ul {
        padding-left: 18px;
        padding-right: 15px;
    }
    .map-help li {
        margin-top: 15px;
    }


    @media (max-width: 420px){
        .map-help {padding:10px;}
    }
    @media (max-width: 767px){
        .row {margin-right: 0px;margin-left: 0px;}
    }

    /* These styles are for the content */

    .areamap .heading {
        font-size: 1.4em;
        text-align: center;
    }

    @media screen and (max-width: 767px){
        .areamap .heading {
            display: inline-block;
            margin: 20px 0px 10px;
            width: 100%;
            padding: 20px;
        }
    }

    /*  */


    .areamap a i.fa {
        color: #334377;
        display: inline-block;
        margin: 10px 15px 10px 5px;
        border: solid 1px rgba(100,100,100,.2);
        padding: 10px;
        border-radius: 4px;
        background-color: rgba(200,200,200,.1);
        float: left;
    }

    a.btn-primary {
        color: #fff!important;
    }

    .areamap a.btn span {
        display: block;
        /*white-space: normal;*/
        font-size: 14px;
        /* float: left; */
        /* width: 150px; */
        margin: 10px 0px;
        text-align: left;
        font-weight: bold;
    }

    .areamap a.map-pdf span 
    {
        margin: 15px 0px;
    }

    .areamap a:hover i.fa {
        color: #ddd;
        background-color: #334377;
    }

    .areamap a.btn:hover span {
        color: red;
    }

    .areamap a.btn:hover span {
        color: #334377;
    }

    .areamap a.btn {display:block;}
    .areamap {display:block;}


</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightSideContent" Runat="Server">
        
        <div class="acrobat-dld"><a href="http://get.adobe.com/reader/"><img src="/images/getacrobat.gif" alt width="88" height="31" border="0"><br />Get Acrobat Reader</a></div>
        
        <asp:Literal ID="litMaps_Directions" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" Runat="Server">

<div class="row">
    <div class="col-xs-12 haspad areamap clearfix">
        <div class="well ">
            <p class="lead">Click on maps to enlarge.</p>
            <p>There are <strong>two types</strong> of maps:</p>
            <ol>
                <li><strong>PDF file</strong> you can download to your phone or computer that you can print or access any time.</li>
                <li><strong>Interactive page</strong> with links to lodging (only available on devices with a large screen)</li>
            </ol>
        </div><!--/well-->
    </div>
</div>
<div class="row">
    <div class="col-sm-6 haspad areamap clearfix">
        <h2 class="heading">Cooperstown Area Map</h2>
        <div class="col-xs-6 col-sm-12 haspad-sides">
            <a href="/area-map" target="_blank" title="PDF Cooperstown Area Map"><img src="/images/cstay-accomm-map-medsm.jpg" alt="Map of Cooperstown Area" class="responsive"></a>
        </div>
        <div class="col-xs-6 col-sm-12">
            <a class="btn map-links" href="/area-map" target="_blank" title="Cooperstown Area Map with Links to Rentals"><i class="fa fa-map" aria-hidden="true"></i><span>Map w/ Links<br />to Lodging</span></a>
            <a class="btn map-pdf" href="/images/cstay-accomm-map.pdf" target="_blank" title="Cooperstown Area Map as PDF"><i class="fa fa-download" aria-hidden="true"></i><span>Download PDF</span></a>
        </div>
        
    </div>
    <div class="col-sm-6 haspad areamap clearfix">
        <h2 class="heading">Cooperstown Village Map</h2>
        <div class="col-xs-6 col-sm-12 haspad-sides">
            <a href="/village-map" target="_blank" title="PDF Cooperstown Village Map"><img src="/images/cstay-village-map-medsm.jpg" alt="Map of Cooperstown Village" class="responsive"></a>
        </div>
        <div class="col-xs-6 col-sm-12">
            <a class="btn map-links" href="/village-map" target="_blank" title="Cooperstown Village Map with Links to Rentals"><i class="fa fa-map" aria-hidden="true"></i><span>Map w/ Links<br />to Lodging</span></a>
            <a class="btn map-pdf" href="/images/cstay-coop-village-map.pdf" target="_blank" title="Cooperstown Village Map as PDF"><i class="fa fa-download" aria-hidden="true"></i><span>Download PDF</span></a>
        </div>
        
    </div>
</div>

<div class="row">
    <div class="col-sm-12 haspad areamap clearfix">
        <h2 class="heading">New York State Map</h2>
        <div class="col-xs-12 haspad-sides">
            <img src="/images/coopstay-nymap.gif" alt="Cooperstown, NY rentals location" lowsrc="/images/coopstay-nymapls.gif" class="responsive">
        </div>
        
    </div>
</div>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" Runat="Server">
  <%=MyUtils.SetGoogleAdwordsConversionCode(Page, "1036267566", "uWWhCILZggEQruCQ7gM")%>
</asp:Content>

