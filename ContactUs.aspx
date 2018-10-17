<%@ Page Title="Contact Cooperstown Stay" Language="VB" MasterPageFile="~/MasterLeftCol.master" AutoEventWireup="false" CodeFile="ContactUs.aspx.vb" Inherits="ContactUs" MetaDescription="CooperstownStay.com is here to help you plan your trip to Cooperstown, NY and answer questions about lodging and the Cooperstown area." %>
<%@ Register TagPrefix="cc1" Namespace="GoogleReCaptcha" Assembly="GoogleReCaptcha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/contact" />
  <meta name="keywords" content="Cooperstown, Cooperstown, Cooperstown NY, Cooperstown rental homes, Cooperstown lodging, Cooperstown vacation rentals, Cooperstown accommodations, Cooperstown lodging, rentals in Cooperstown, lodging in Cooperstown, accomodations, rentals, weekly rentals, lodging, vacation rentals, Cooperstown Dreams Park, Dreams Park, Dreamspark, lodging for Cooperstown Dreams Rark families, Cooperstown Baseball World, Baseball World, Oneonta, NY, Baseball Hall of Fame, private homes, Cooperstown rentals, stay, apartments, waterfront, lakeside cottages, Otsego County Chamber of Commerce, Cooperstown Chamber, Lonetta, Lonetta Swartout">
    <style type="text/css">
        .bs-callout-danger {border-left-color: #ce4844!important;}
        .bs-callout {padding: 20px;margin: 20px 0;border: 1px solid #eee;border-left-width: 5px;border-radius: 3px;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" runat="Server">
</asp:Content>
<asp:Content ID="Content9" ContentPlaceHolderID="phTop" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" runat="Server"><!--img class="RoundImage5" src="/photos/cstay-pto-lonetta3.jpg" alt="Cooperstown Stay rental homes director Lonetta Swartout " width="150" height="222" border="0" /--></asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">
        
    <div class="canvas">
        <div class="row" id="rowNeedHelpCallout" runat="server">
            <div class="col-sm-12" style="padding:10px 20px 30px;">
            <h1 class="h2" style="color:#334377">Contact Us</h1>
                <p class="lead"><strong>We live in Cooperstown, NY.</strong>  We know our rentals and will help you find the best lodging match for your specific needs.</p>
        
                <p><strong>Need Help?</strong> &nbsp;Call <a href="tel:6075476260">607-547-6260</a> or complete the form below.</p>
                <!--results-->
            </div>
        </div>
        <asp:Label ID="lblResults" runat="server" Text="" CssClass="bs-callout bs-callout-danger" style="display:block;" visible="false"></asp:Label>


    <asp:Panel ID="pnlContactForm" runat="server">
    
        <div class="well" id="divProperty" runat="server">
            <h1 class="h2" style="color:#334377">Send Us An Email</h1>
            <div class="row">
                <div class="form-group col-sm-12">
                    <label for="property">RENTAL PROPERTY</label>
                    <input type="text" class="form-control" id="rpoi" name="rpoi" size="100" maxlength="200" value="<%= Request("p") %>" />
                    <span class="help-block">Interested in <strong>more than one</strong> rental property? List them separated by a comma.</span>
                </div>
            </div>
        </div>

    
        <h3>Contact Information</h3>
        <div class="well">
    
            <div class="row">
                <div class="form-group col-sm-6">
                    <label for="name_first_last"><span class="req">*</span> NAME</label>
                    <input type="text" class="form-control" id="name_first_last" name="name_first_last" maxlength="40" placeholder="First and Last Name" value="<%= Request("name_first_last") %>"/>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-sm-6">
                    <label for="email"><span class="req">*</span> E-MAIL</label>
                    <input type="text" class="form-control" id="email" name="email" maxlength="100" placeholder="Email Address" value="<%= Request("email") %>"/>
                </div>
                <div class="form-group col-sm-4">
                    <label for="phone"><span class="req">*</span> PHONE</label>
                    <input type="text" class="form-control" id="phone" name="phone" maxlength="20" placeholder="555-555-5555" value="<%= Request("phone") %>"/>
                </div>
            
            </div>
        </div><!--/well-->

        <h3>Lodging Needs</h3>
        <div class="well">
    
                <div class="row">
                    <div class="form-group col-sm-4">
                        <label for="arrival_date"><span class="req">*</span> TOURNAMENT WEEK</label>
                        <!--input type="text" class="form-control" id="arrival_date" name="arrival_date" maxlength="10" placeholder="MM/DD/YY"/-->
                        <asp:DropDownList ID="ddlSearchTournamentWeek" runat="server" cssclass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group col-sm-4">
                        <label for="tournament"><span class="req">*</span> TOURNAMENT </label>
                        <select class="form-control" id="tournament" name="tournament" runat="server">
                          <option></option>
                          <option>NOT SURE</option>
                          <option>Dreams Park</option>
                          <option>Other</option>
                        </select>
                    </div>
                    <div class="form-group col-sm-4">
                        <label for="how_many_in_your_party"># GUESTS </label>
                        <input type="text" class="form-control" id="how_many_in_your_party" name="how_many_in_your_party" maxlength="30" placeholder="Ex: 3 Adults, 2 Kids" value="<%= Request("how_many_in_your_party") %>"/>
                    </div>
                </div>
        </div>

        <h3>Specific Questions</h3>
        <div class="well">
            <div class="row">
                <div class="form-group col-sm-12">
                    <textarea class="form-control" id="special_requests" name="special_requests" cols="42" rows="8" wrap="virtual" maxlength="500"><%= Request("special_requests") %></textarea>
                </div>
            </div>
        </div>


        <div class="form-group">
            <cc1:GoogleReCaptcha ID="ctrlGoogleReCaptcha" runat="server" PublicKey="6LcKjEIUAAAAACHp6-8SpdqLeOn4JBqrSkE2ANLk" PrivateKey="6LcKjEIUAAAAAN9Ejs1glFacLJ2f1oDKg0i2Dchy" />
        </div>
            
        <asp:Button ID="btnSendContactInfo" runat="server" Text="Submit" cssclass="btn btn-primary" />
    <!--/panel-->
    </asp:Panel>

    </div><!--/canvas-->
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" runat="Server">
</asp:Content>
