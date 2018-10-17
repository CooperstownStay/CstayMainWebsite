<%@ Page Title="Payment Options & Cancellation Policy" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Info.aspx.vb" Inherits="Info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/rental-info" />
  <title>Reservation Payment Options and Cancellation Policy | Cooperstown Stay</title>
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />
  <meta name="description" content="Cooperstown NY rental homes and lodging. Connecting Dreams Park families to private homes, apartments, lakefront cottages. Simplify your search. Personalized customer service.  Hassle free!">
  <style type="text/css">
    
    @media (max-width:767px) {
      .infopad {padding:30px}
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" runat="Server">
  <img class="RoundImage5" src="/photos/cstay-pto-lonetta3.jpg" alt="Cooperstown Stay rental homes director Lonetta Swartout " width="150" height="222" border="0" />
  <table width="150" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left">
        <br />
          <asp:Literal ID="litStandardAmenities" runat="server"></asp:Literal>
      </td>
    </tr>
  </table>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">
  
    <div class="infopad">
    <table border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center">
            <div class="heading">
              Payment &amp; Cancellation Policies
            </div>
        </td>
      </tr>
      <tr>
        <td >
          <div class='DividerBlueThin'></div>
        </td>
      </tr>
      <tr>
        <td align="left" valign="top"><div class="AgreementAndPolicies">
          <asp:Literal ID="litInfo_PaymentPolicy" runat="server"></asp:Literal></div>
        </td>
      </tr>
      <tr>
        <td align="left"  valign="top">
          <div class='DividerBlueThin'></div>
        </td>
      </tr>
      <tr>
        <td align="center"  valign="middle">
          <font size="2" color="white" face="Helvetica, Geneva, Arial, SunSans-Regular, sans-serif"><b><a href="/rental-agreement<%= Session("EditModeQS") %>">Click here for Cooperstown Stay Rental Agreement</a></b></font>
        </td>
      </tr>
      <tr>
        <td align="left"  valign="top">
          <div class='DividerBlueThin'></div>
        </td>
      </tr>
      <tr>
        <td align="left" valign="top">
          <div class="AgreementAndPolicies">
          <asp:Literal ID="litInfo_CancellationPolicy" runat="server"></asp:Literal></div>
        </td>
      </tr>
      <tr>
        <td align="left"  valign="top">
          <div class='DividerBlueThin'></div>
        </td>
      </tr>
      <tr height="48">
        <td align="center" width="431" valign="top" height="48">
          <img src="/images/cstay-logo-credit-cds4.jpg" alt="VISA, MasterCard, Discover" width="228" height="49" border="0">
        </td>
      </tr>
      <tr>
        <td align="center" width="431">
          <font size="2" color="black" face="Helvetica, Geneva, Arial, SunSans-Regular, sans-serif"><b>Questions?</b> Please 
          </font><font size="2" face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular"><a href="/contact">send us an email</a>.</font>
        </td>
      </tr>
    </table>
    </div>
  

</asp:Content>
