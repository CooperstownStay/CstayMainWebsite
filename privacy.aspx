<%@ Page Title="Privacy Policy" Language="VB" MasterPageFile="~/MasterLeftCol.master" AutoEventWireup="false" CodeFile="Privacy.aspx.vb" Inherits="Privacy" MetaDescription="Cooperstown Stay values your privacy and sensitive information."%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/privacy" />
  <title>Privacy Policy | Cooperstown Stay</title>
<style type="text/css">
ol {
    margin: 10px 50px 30px;
    line-height: 20px;
}
ul {
    margin: 10px 50px 30px;
    line-height: 20px;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" runat="Server">
  <img class="RoundImage5" src="/photos/cstay-pto-lonetta3.jpg" alt="Cooperstown Stay rental homes director Lonetta Swartout " width="150" height="222" border="0" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">


<div class="canvas">
<div class="row">
    <div class="col-xs-12 ">
    
          <h2>Privacy of Personal Information</h2>
          
          
          <asp:Literal ID="litPrivacyPolicy" runat="server"></asp:Literal>

          
          <p>
          This privacy policy discloses the privacy practices for both CooperstownStay.com and CstayReserve.com (Websites). 
          </p>
          <p>
          This privacy policy applies solely to information collected by Websites. It will notify you of the following:
          </p>

          <ol>
          <li>What personally identifiable information is collected from you through Websites, how it is used and with whom it may be shared.</li>
          <li>What choices are available to you regarding the use of your data.</li>
          <li>The security procedures in place to protect the misuse of your information.</li>
          <li>How you can correct any inaccuracies in the information.</li>
          </ol>

          <h2>Information Collection, Use, and Sharing</h2>

          <p>
          We are the sole owners of the information collected on this site. We only have access to/collect information that you voluntarily give us via email or other direct contact from you. We will not sell or rent this information to anyone.
          </p>
          <p>
          We will use your information to respond to you, regarding the reason you contacted us. We will not share your information with any third party outside of our organization, other than as necessary to fulfill your request.
          </p>
          <p>
          Unless you ask us not to, we may contact you via email in the future to tell you about specials, new products or services, or changes to this privacy policy.
          </p>

          <h2>Your Access to and Control Over Information</h2>
          <p>
          You may opt out of any future contacts from us at any time. You can do the following at any time by contacting us via the email address or phone number given on Websites:
          </p>
          <ol>
          <li>See what data we have about you, if any.</li>
          <li>Change/correct any data we have about you.</li>
          <li>Have us delete any data we have about you.</li>
          <li>Express any concern you have about our use of your data.</li>
          </ol>

          <h2>Security</h2>
          <p>
          We take precautions to protect your information. When you submit sensitive information via Websites, your information is protected both online and offline.
          </p>
          <p>
          Wherever we collect sensitive information (such as credit card data), that information is encrypted and transmitted to us in a secure way. You can verify this by looking for a closed lock icon at the bottom of your web browser, or looking for "https" at the beginning of the address of the web page.
          </p>
          <p>
          While we use encryption to protect sensitive information transmitted online, we also protect your information offline. Only employees who need the information to perform a specific job (for example, billing or customer service) are granted access to personally identifiable information. The computers/servers in which we store personally identifiable information are kept in a secure environment.
          </p>

          <h2>Updates</h2>
          <p>
          Our Privacy Policy may change from time to time and all updates will be posted on this page.
          </p>
          <p>
          If you feel that we are not abiding by this privacy policy, you should <a href="/contact">contact us immediately</a>.
          </p>

          <h2>Orders</h2>

          <p>
          We request information from you on our order form. To buy from us, you must provide contact information (like name and address) and financial information (like credit card number, expiration date). This information is used for billing purposes and to fill your orders. If we have trouble processing an order, we'll use this information to contact you.
          </p>

          <h2>Cookies</h2>
          <p>
          We use "cookies" on Websites. A cookie is a piece of data stored on a site visitor's hard drive to help us improve the user experience. Usage of a cookie is in no way linked to any personally identifiable information.
          </p>

          <h2>Sharing</h2>
          <p>
          We do <u>not</u> share any of your information with anyone <em>except</em> contact information to your rental property Host so they can communicate with you regarding your reservation.
          </p>

          <h2>Links</h2>
          <p>
          Websites contain links to other sites. Please be aware that we are not responsible for the content or privacy practices of such other sites. We encourage our users to be aware when they leave our site and to read the privacy statements of any other site that collects personally identifiable information.
          </p>



    </div>
</div>
</div><!--/canvas-->

  
</asp:Content>
