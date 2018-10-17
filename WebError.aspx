<%@ Page Title="" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="WebError.aspx.vb" Inherits="WebError" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" Runat="Server">
  <table width="375px" cellpadding="0" cellspacing="0" border="0" class="SearchPage">
    <tr align="center">
      <td>
        <br />
        <h3>
          <strong>We're Sorry, an Error Has Ocurred</strong></h3>
      </td>
    </tr>
    <tr valign="top" align="center">
      <td>
        Our support team has been notified of the error,
        <br />
        and should be looking into it shortly.
        <br />
      </td>
    </tr>
    <tr valign="top" align="center">
      <td>
        <asp:Panel ID="pnlFeedback" runat="server">
          <table cellpadding="0" cellspacing="0" border="0">
            <tr>
              <td style="text-align: center">
                <br />
                If you would like to send a message to our support team,
                <br />
                or can provide information that will help us fix this error,
                <br />
                please enter it below and click "Send Feedback"<br />
                <br />
                <asp:TextBox ID="txtFeedback" runat="server" Width="375px" TextMode="MultiLine" Rows="10"></asp:TextBox>
                <br />
                <br />
                <asp:Button CssClass="Button" ID="btnSend" runat="server" Text="Send Feedback"></asp:Button>
                <br />
                <br />
              </td>
            </tr>
          </table>
        </asp:Panel>
      </td>
    </tr>
    <tr valign="top" align="center">
      <td>
        <asp:Label ID="lblThankYou" runat="server" Font-Bold="True">Thank you for your patience and understanding.</asp:Label><br />
        <br />
        &nbsp;
        <asp:Label ID="lblErrID" runat="server" Visible="False"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblErrorHTML" runat="server" Visible="False"></asp:Label>
      </td>
    </tr>
  </table>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="RightSideContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="BottomScripts" Runat="Server">
</asp:Content>

