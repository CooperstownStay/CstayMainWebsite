<%@ Page Title="Login" MetaDescription="Enter user name and password to edit site content" Language="VB" MasterPageFile="~/MasterMinimal.master" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="phTop" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" Runat="Server">
  <table border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td>
        <asp:Label ID="lblEditModeWarning" Visible="false" ForeColor="Red" Font-Size="X-Large" Font-Bold="true" Font-Names="Arial" runat="server" Text="<div align='center'>CURRENTLY  IN  EDIT  MODE</div>"></asp:Label>
      </td>

    </tr>
    <tr>
            <td height="500px" width="600px" align="left" valign="top" style="padding: 50px;">
              <br />
              <br />
              Login to Enter Edit Mode<br />
              <br />
              User Name:
                  <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox><br />
              <br />
              Password :
                  <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox><br />
              <br />
              <asp:Button ID="btnLogin" runat="server" Text="Login" />&nbsp;&nbsp;&nbsp;
                  <asp:Button ID="btnLogout" runat="server" Text="Logout" />&nbsp;&nbsp;&nbsp;
                  <br />
              <asp:Label ID="lblLoginMessage" runat="server" ForeColor="Red" Text="Invalid User Name or Password" Visible="false"></asp:Label><br />

            </td>
          </tr>
  </table>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" Runat="Server">
</asp:Content>

