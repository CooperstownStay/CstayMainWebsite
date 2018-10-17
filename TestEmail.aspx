<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestEmail.aspx.vb" Inherits="TestEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <form id="form1" runat="server">
    <br />
    <br />
    <div>
      <asp:Button ID="btnAddEmail" runat="server" Text="Add Email" />
    </div>
    <br />
    <br />
    <div>
      <asp:Button ID="btnShowCache" runat="server" Text="show Cache" />
    </div>
    <div>   <br /><br />
      <asp:TextBox  runat="server" Width="700px" ID="txtConnString"></asp:TextBox>      <br />
      <asp:Button ID="btnTestDB" runat="server" Text="Test DB Access" />
    </div>
    <asp:Label runat="server" ID="lblResult" Text="Label"></asp:Label><br />
    <br />
    <br />
    Email: <asp:TextBox ID="txtMktEmail" runat="server" TextMode="MultiLine" Width="800" Height="300"></asp:TextBox><br />
    <br />
    Addr:<asp:TextBox ID="txtMktAddr" Width="308px" runat="server"></asp:TextBox>
    <br />
    Type:<asp:TextBox ID="txtMktType" runat="server"></asp:TextBox><br />
    Key:<asp:TextBox ID="txtMktKey" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="btnSendMktEmails" runat="server" Text="Send Mkt Emails" />
    </form>
</body>
</html>
