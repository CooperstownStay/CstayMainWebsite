<%@ Page Title="Cooperstown Stay Rental Agreement" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="Agreement.aspx.vb" Inherits="Agreement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/rental-agreement" />
  <title>Cooperstown rental homes and lodging - Reservation Info</title>
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />
  <meta name="description" content="Cooperstown Stay Rental Agreement">
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
    <table border="0" cellspacing="0" cellpadding="0">
      <tr >
        <td align="center" valign="middle" >
          <div class="heading ">
          Cooperstown Stay Rental Agreement</div>
        </td>
      </tr>
      <tr>
        <td align="left"  valign="top">
          &nbsp;
        </td>
      </tr>
      <tr>
        <td align="left"  valign="top">
          <div class='DividerBlueThin'></div>
        </td>
      </tr>
      <tr>
        <td align="center"  valign="middle">
          <font size="2" color="white" face="Helvetica, Geneva, Arial, SunSans-Regular, sans-serif"><b><a href="/rental-info<%= Session("EditModeQS") %>">Click Here for Payment Options</a></b></font>
        </td>
      </tr>
      <tr>
        <td align="left"  valign="top">
          <div class='DividerBlueThin'></div>
        </td>
      </tr>
      <tr>
        <td align="left">
          <div class="AgreementAndPolicies">
          <asp:Literal ID="litInfo_RentalAgreement" runat="server"></asp:Literal></div>
        </td>
      </tr>
    </table>
    </div>

</asp:Content>
