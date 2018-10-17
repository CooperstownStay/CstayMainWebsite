<%@ Control Language="VB" AutoEventWireup="false" CodeFile="TitleBar.ascx.vb" Inherits="Controls_TitleBar" %>
<%@ Register TagName="Callout" TagPrefix="uc" Src="~/Controls/Callout.ascx" %>
    <div class="container">
        <div class="row">
            <div class="titlebox"<%=CalloutOnly%>>
                <h1 class="h2"><%=Title%></h1>
                <p class="lead"><%=SubTitle%></p>
            </div>
<uc:Callout ID="ucCallout" runat="server" />
        </div>
    </div>