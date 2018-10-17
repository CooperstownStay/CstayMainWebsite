<%@ Page Title="Cooperstown Stay Reviews" MetaDescription="Book your Cooperstown lodging reservations through CooperstownStay.com for a customer service experience that is out of the park. Don't just take our word... check out what our customers had to say about Cooperstown Stay." Language="VB" MasterPageFile="~/MasterLeftCol.master" AutoEventWireup="false" CodeFile="Testimonials.aspx.vb" Inherits="Testimonials" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <title>Reviews and Testimonials | Cooperstown Stay</title>
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/reviews" />
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />

  <style type="text/css">
  
  .callout-white, .callout-light, .callout-medium, .callout-dark 
  {
       margin: 0px 30px 0px 0px;
       color: #082140;
  }
  
  /* update this one in MasterLeftCol.css */
  .callout, .callout-white, .callout-light, .callout-medium, .callout-dark, .callout-bright {
    padding: 50px;
  }
  
  .callout-white .testimonial p, .callout-light .testimonial p, .callout-medium .testimonial p, .callout-dark .testimonial p {font-size: 23px;}
  .testimonial p.author {font-size: 13px;}
  
  .callout-white {background-color: #fff;} .callout-white p {color: #666;}
  .callout-light {background-color: #f2f2f2;}  .callout-light p {color: #444;}
  .callout-medium {background-color: #334377;} .callout-medium p {color: #fff;}
  .callout-dark {background-color: #082140;} .callout-dark p {color: #fff;}
  
  .testimonial i.fa-quote-left {font-size: 40px;padding: 0 8px 0 0;}
  .callout-white>.testimonial i{color: #eee;}
  .callout-light>.testimonial i{color: #ddd;}
  .callout-medium>.testimonial i{color: #7183C1;}
  .callout-dark>.testimonial i{color: #c0c0c0;}
  
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" runat="Server"></asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">

<div class="row">
    
    <div class="callout-white">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> [...] It was a pleasure dealing with Lonetta who was very accomodating when we had to switch weeks unexpectedly and she helped us find comparable house to what we originally had and in the same price range (even though it was Hall of Fame induction week, she did not attempt to price gouge). Very stand up company."</p>
        <p class="author">James W.</p>
        </div>
    </div>
    
    <div class="callout-light">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> Thanks! Your website is so easy to use! You showed and cross-referenced all the details we needed to choose our lodging. Very 'unconfusing'. You're the best!"</p>
        <p class="author">a California Team Mom</p>
        </div>
    </div>
    
    <div class="callout-white">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> Thank you for your help and patience as you guided me into selecting the perfect home during our Cooperstown Stay"</p>
        <p class="author">Baseball Mom</p>
        </div>
    </div>
    
    <div class="callout-light">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> Cooperstown Stay's website is the easiest to navigate.  It has all of the info I need.  By far, it is the best - it is terrific!"</p>
        <p class="author">Debbie, from Virginia</p>
        </div>
    </div>
    
    <div class="callout-white">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> Your customer service and advice are greatly appreciated. It's such a nice change to speak with someone over the phone who is kind, considerate and pleasant!"</p>
        <p class="author">Pam S.</p>
        </div>
    </div>
    
    <div class="callout-light">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> You have been a blessing for our team, I just want to thank you for all your help."</p>
        <p class="author">Alina I.</p>
        </div>
    </div>
    
    <div class="callout-white">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> I'm so glad I found you – your informative website and your helpful attitude are both refreshing in a very impersonal world. Thank you!"</p>
        <p class="author">Suzie, Team Mom</p>
        </div>
    </div>
    
    <div class="callout-light">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> Thank you so much for your help and wonderful service."</p>
        <p class="author">Keyport, New York</p>
        </div>
    </div>
    
    <div class="callout-white">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> Thanks for getting back to me so quickly, Lonetta. You do a wonderful job running Cooperstownstay.com, and the website is super consumer-friendly.!"</p>
        <p class="author">Henry, California</p>
        </div>
    </div>
    
    <div class="callout-light">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> Thank you, Lonetta, for helping me simplify the lodging search!"</p>
        <p class="author">Miami, FL</p>
        </div>
    </div>
    
    <div class="callout-white">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> Cooperstown Stay was extremely patient and helpful, even when I kept changing my mind! Thank you."</p>
        <p class="author">Coach's wife, NJ</p>
        </div>
    </div>
    
    <div class="callout-light">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> I really appreciate your help. You are a great source of knowledge for those of us who have never visited your town! Thank you!"</p>
        <p class="author">Tami A.</p>
        </div>
    </div>

</div><!--/row-->
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" runat="Server"></asp:Content>
