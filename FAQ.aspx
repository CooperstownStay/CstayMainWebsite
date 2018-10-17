<%@ Page Title="Frequently Asked Questions" Language="VB" MasterPageFile="~/MasterLeftCol.master" AutoEventWireup="false" CodeFile="FAQ.aspx.vb" Inherits="FAQ" MetaDescription="F.A.Q.s about Cooperstown Stay rental service and the Cooperstown area." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <title>Frequently Asked Questions | Cooperstown Stay</title>
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/faq" />
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />
  <meta name="description" content="Frequently asked questions about weekly lodging accommodations in Cooperstown, NY for a youth baseball tournament.">
  <style>
      
    /*****************
    *** FAQ Styles
    *** ref: https://codepen.io/moso/pen/vKGxMx
    ****************/
    .list-group.help-group {
      margin-bottom: 20px;
      padding-left: 0;
      margin: 0;
      .faq-list {
        display: block;
        top: auto;
        margin: 0 0 32px;
        border-radius: 2px;    
        border: 1px solid #ddd;
        box-shadow: 0 1px 5px rgba(85, 85, 85, 0.15);
        .list-group-item {
          position: relative;
          display: block;
          margin: 0;
          padding: 13px 16px;
          background-color: #fff;
          border: 0;
          border-bottom: 1px solid #ddd;
          border-top-left-radius: 2px;
          border-top-right-radius: 2px;
          color: #616161;
          transition: background-color .2s;
          i.mdi {
            margin-right: 5px;
            font-size: 18px;
            position: relative;
            top: 2px;
          }
          &:hover {
            background-color: #f6f6f6;
          }
          &.active {
            background-color: #f6f6f6;
            font-weight: 700;
            color: rgba(0,0,0,.87);        
          }
          &:last-of-type {
            border-bottom-left-radius: 2px;
            border-bottom-right-radius: 2px;
            border-bottom: 0;
          }
        }
      }
    }

    .tab-content.panels-faq {
      padding: 0;
      border: 0;
    }

    .panel.panel-help {
      box-shadow: 0 1px 5px rgba(85, 85, 85, 0.15);
      padding-bottom: 0;
      border-radius: 2px;
      overflow: hidden;
      background-color: #fff;
      margin: 0 0 16px;
      a[href^="#"],
      a[href^="#"]:hover,
      a[href^="#"]:focus {
        outline: none;
        cursor: pointer;
        text-decoration: none;
      }
      .panel-heading {
        background-color: #f6f6f6;
        padding: 0 16px;
        line-height: 48px;
        border-top-right-radius: 2px;
        border-top-left-radius: 2px;
        color: rgba(0,0,0,.87);
        h2 {      
          margin: 0;
          padding: 14px 0 14px;
          font-size: 18px;
          font-weight: 400;
          line-height: 20px;
          letter-spacing: 0;
          text-transform: none;
        }
      }
      .panel-body {
        background-color: #fff;
        border-top: 1px solid #ddd;
        border-radius: 2px;
        border-top-right-radius: 0;
        border-top-left-radius: 0;
        margin-top: 0;
        p {
          margin: 0 0 16px;
          &:last-of-type {
            margin: 0;
          }
        }
      }
    }
    
    
    /**** Scott Custom ****/
    .faq>.col-md-8, .faq>.col-md-12 {padding: 15px;}
    .faq>.col-md-4 {padding: 15px;}
    .row.faq {margin-right: 30px;padding-top:50px;}
    
    .panel>a {display: block;background-color: #f2f2f2;text-decoration:none;}
    .panel>a:hover {background-color: #dfdfdf;}
    .panel>a:focus {background-color: #dfdfdf;}
    
    /**** filter styles ****/
    
    ul#filter { 
      float: left; 
      font-size: 16px; 
      list-style: none; 
      margin-left: 0; 
      width: 100%;
    }
    ul#filter li { 
      border-right: 1px solid #dedede;
      float: left;
      line-height: 16px;
      margin-right: 10px;
      padding-right: 10px;
    }

    ul#filter li:last-child { border-right: none; margin-right: 0; padding-right: 0; }
    ul#filter a { color: #999; text-decoration: none; }

    ul#filter li.current a, ul#filter a:hover { text-decoration: underline; }
    ul#filter li.current a { color: #333; font-weight: bold; }


    ul#portfolio { 
      float: left; 
      list-style: none; 
      margin-left: 0; 
      width: 672px;
    }
    ul#portfolio li { 
      border: 1px solid #dedede; 
      float: left; 
      margin: 0 10px 10px 0; 
      padding: 5px;
      width: 202px;
    }

    ul#portfolio a { display: block; width: 100%; }
    ul#portfolio a:hover { text-decoration: none; }
    ul#portfolio img { border: 1px solid #dedede; display: block; padding-bottom: 5px; }



    <!--[if lt IE 7]>
    ul#portfolio li { margin-right: 5px; }
    <![endif]-->

    
    /*** END:FAQ Styles ***/
    
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">
        <asp:Literal ID="litFAQ" runat="server"></asp:Literal>


<!-- FAQ - ref:https://codepen.io/moso/pen/vKGxMx  -->
<div class="row faq">

<!-- FILTER ref: https://code.tutsplus.com/tutorials/creating-a-filterable-portfolio-with-jquery--net-2907 -->
    <div class="col-xs-12 col-sm-12 visible-sm visible-xs">
        <ul id="filter">
          <li class="current"><a href="#">ALL</a></li>
          <li><a href="#">Cooperstown</a></li>
          <li><a href="#">Rentals</a></li>
          <li><a href="#">Reservation</a></li>
          <li><a href="#">Cooperstown Stay</a></li>
          <li><a href="#">Cooperstown Dreams Park</a></li>
        </ul>
    </div>
<!-- /Filter -->

  <div class="col-md-8 col-sm-12 col-xs-12">
    <div class="tab-content panels-faq">
    
    <!--
      <div class="tab-pane cooperstown">
    -->
        <div id="faqlist" class="panel-group">


              <!--question-->
              <div class="panel panel-default panel-help rentals cooperstown-dreams-park">
                <a href="#FAQ-1" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Can I walk to Cooperstown Dreams Park?</h5>
                  </div>
                </a>
                <div id="FAQ-1" class="collapse">
                  <div class="panel-body">
                    <p>Sorry, but there is no pedestrian traffic allowed to walk into the Dreams Park.  This is a safety issue because there are no sidewalks.  Cooperstown Dreams Park is in a country setting.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay">
                <a href="#FAQ-2" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>How do I place a HOLD on a Rental Property?</h5>
                  </div>
                </a>
                <div id="FAQ-2" class="collapse">
                  <div class="panel-body">
                    <p>Call us at 607-547-6260 and we will be happy to HOLD any two&nbsp;(2)&nbsp;rental properties for two&nbsp;(2)&nbsp;days, while you are finalizing your plans. No payment needed. We will just request your phone number and email.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation">
                <a href="#FAQ-3" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Is Central Air Conditioning needed in Cooperstown, NY?</h5>
                  </div>
                </a>
                <div id="FAQ-3" class="collapse">
                  <div class="panel-body">
                    <p>Window A/C units work quite sufficiently in our area.  Please note average temps below.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals cooperstown reservation">
                <a href="#FAQ-4" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>What is the average summer temperature in Cooperstown?</h5>
                  </div>
                </a>
                <div id="FAQ-4" class="collapse">
                  <div class="panel-body">
                    <p>Average temps, but Mother Nature can change her mind:</p>
                    <ul>
                        <li>June:  76 high, 50.5 low</li>
                        <li>July:  79.8 high, 54.7 low</li>
                        <li>August:  78.2 high, 54 low</li>
                    </ul>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals cooperstown reservation">
                <a href="#FAQ-5" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>What is the weather like?</h5>
                  </div>
                </a>
                <div id="FAQ-5" class="collapse">
                  <div class="panel-body">
                    <p>It gets cool at night – be sure to pack some long sleeves.  Yes, rains can come and go.  Bring some rain gear.  They sell umbrellas and ponchos at the tournament complexes. </p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown-stay">
                <a href="#FAQ-6" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Where are the tournament games played?</h5>
                  </div>
                </a>
                <div id="FAQ-6" class="collapse">
                  <div class="panel-body">
                    <p>There are three&nbsp;(3)&nbsp;youth baseball tournament locations:</p>
                    <p><strong>Cooperstown Dreams Park</strong><br />
                    Located 5 miles south of Main Street, Cooperstown.</p>
                    <p><strong>All Star Village</strong><br />
                    Located in Oneonta – half hour south of Cooperstown</p>
                    <p><strong>Baseball World</strong><br />
                    Located in Oneonta – half hour south of Cooperstown</p>
                    
                    
                    <p><a href="/parks-map">Click here for Map</a> </p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay">
                <a href="#FAQ-7" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Do I need to bring sheets and towels?</h5>
                  </div>
                </a>
                <div id="FAQ-7" class="collapse">
                  <div class="panel-body">
                    <p>All of Cooperstown Stay rentals provide bed linens and towels.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay">
                <a href="#FAQ-8" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Do we pay extra for cleaning?</h5>
                  </div>
                </a>
                <div id="FAQ-8" class="collapse">
                  <div class="panel-body">
                    <p>NO, cleaning fees are included with all Cooperstown Stay weekly rental rates.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation">
                <a href="#FAQ-36" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Can I ship items to my rental choice ahead of my stay?</h5>
                  </div>
                </a>
                <div id="FAQ-36" class="collapse">
                  <div class="panel-body">
                    <p>If your team is playing at the Cooperstown Dreams Park, the Dreams Park folks have a department set up to accept shipments.  Please call them directly at 607-547-4061.  There will be other guests staying at your rental before you and we cannot be responsible for any parcels shipped to your rental address.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-9" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Is the well water safe to drink?</h5>
                  </div>
                </a>
                <div id="FAQ-9" class="collapse">
                  <div class="panel-body">
                    <p>YES, every well has been tested and is safe to drink. Brewery Ommegang came to Cooperstown because of the excellent water quality in our area.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay cooperstown-dreams-park">
                <a href="#FAQ-10" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Can we have a team party?</h5>
                  </div>
                </a>
                <div id="FAQ-10" class="collapse">
                  <div class="panel-body">
                    <p>If any given rental can support the number of people for a team party, it will be listed in the description.  Otherwise so sorry, team parties or large gatherings are not permitted.  This is because the homes all have a private septic system and well and the infrastructure cannot support large groups week after week. We want you to have a comfortable and safe stay, so we protect the systems for you.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay">
                <a href="#FAQ-11" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5><em>Where</em> can we have a team party?</h5>
                  </div>
                </a>
                <div id="FAQ-11" class="collapse">
                  <div class="panel-body">
                    <p>Barnyard Swing, Glimmerglass State Park, Gilbert Lake State Park and many local restaurants.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay">
                <a href="#FAQ-12" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>If we have more people than beds, can we bring an air mattress?</h5>
                  </div>
                </a>
                <div id="FAQ-12" class="collapse">
                  <div class="panel-body">
                    <p>Because of local Health Department regulations, each home has been granted a permit to offer rentals based a MAXIMUM Stated Capacity. This does not include your players who stay at the tournament complex.  But YES, it does include coaches who will rotate between the tournament complex and your lodging. Sorry, no extras.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay">
                <a href="#FAQ-13" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>When is check-in?  And check-out?</h5>
                  </div>
                </a>
                <div id="FAQ-13" class="collapse">
                  <div class="panel-body">
                    <p>Cooperstown Stay is your rental agent.  Each property is privately owned and the owner is your host.    Each host will send their Welcome Notes out to you with Check-in and Check-out details.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay">
                <a href="#FAQ-14" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Are rates negotiable?</h5>
                  </div>
                </a>
                <div id="FAQ-14" class="collapse">
                  <div class="panel-body">
                    <p>Any discounts would not be offered until May – a few weeks before our summer rental season begins.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-15" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Can we swim in the lakes?</h5>
                  </div>
                </a>
                <div id="FAQ-15" class="collapse">
                  <div class="panel-body">
                    <p>Yes, you sure can!</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-16" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>How warm is the lake water?</h5>
                  </div>
                </a>
                <div id="FAQ-16" class="collapse">
                  <div class="panel-body">
                    <p>It is very weather dependent.  Average: high 60s to low 70s.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown-dreams-park">
                <a href="#FAQ-17" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Is the Dreams Park near the Baseball Hall of Fame?</h5>
                  </div>
                </a>
                <div id="FAQ-17" class="collapse">
                  <div class="panel-body">
                    <p>The Dreams Park is 5 miles south of the Baseball Hall of Fame which is on Main Street in the village of Cooperstown. The Dreams Park is out in the country, less than a 10 minute drive.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown">
                <a href="#FAQ-18" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Are there grocery stores and other services nearby? </h5>
                  </div>
                </a>
                <div id="FAQ-18" class="collapse">
                  <div class="panel-body">
                    <p>There are two supermarkets very close to Cooperstown Dreams Park – both open 24/7 in the summer. There are six in Oneonta near All Star Village.  There is a super Wal-Mart in Oneonta.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-19" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Are there restaurants nearby?</h5>
                  </div>
                </a>
                <div id="FAQ-19" class="collapse">
                  <div class="panel-body">
                    <p>We only have 1850 people, and one traffic light, but we have 40 restaurants in the immediate area – from diners and coffee shops to fine dining by the lake.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-20" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>How big is Cooperstown?</h5>
                  </div>
                </a>
                <div id="FAQ-20" class="collapse">
                  <div class="panel-body">
                    <p>Cooperstown is a small village of only 1850 people.  We have just one – that’s right – just one traffic light. Our whole town is only 8 blocks wide.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals cooperstown">
                <a href="#FAQ-21" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Is Cooperstown, NY a safe area?</h5>
                  </div>
                </a>
                <div id="FAQ-21" class="collapse">
                  <div class="panel-body">
                    <p>Golly, they don’t even measure the crime rate here. Locals would be inclined to help you, not hurt you.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals cooperstown">
                <a href="#FAQ-22" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Is there wildlife?</h5>
                  </div>
                </a>
                <div id="FAQ-22" class="collapse">
                  <div class="panel-body">
                    <p>Here in the foothills, you will see white tail deer, squirrels, rabbits, chipmunks, raccoons, woodchucks, wild turkeys, Canada Geese, ducks and more. You may see all kinds of birds – including Bald Eagles.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals cooperstown">
                <a href="#FAQ-23" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Are there insects?</h5>
                  </div>
                </a>
                <div id="FAQ-23" class="collapse">
                  <div class="panel-body">
                    <p>Yes. Many are nocturnal and are drawn to lights at nights.  Just make sure to keep doors closed.  You may consider them a nuisance, but they are not harmful.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help rentals cooperstown">
                <a href="#FAQ-24" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Are there spiders?</h5>
                  </div>
                </a>
                <div id="FAQ-24" class="collapse">
                  <div class="panel-body">
                    <p>Yes, the spiders come in search of those insects. So, if a light is left on all night outside, the insects will fly toward the light, the spiders will go in search of an insect dinner, and voila cobwebs are formed overnight. Cycle of life – a little science lesson here. The poisonous spiders native to warmer climates don’t like our cold winter climate.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-25" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Is it true that the roads are dark there?</h5>
                  </div>
                </a>
                <div id="FAQ-25" class="collapse">
                  <div class="panel-body">
                    <p>There are street lights in our towns and villages, but not on the roads in between.  But our headlights work pretty well at night!  If there were street lights everywhere, we wouldn’t be able to see the beauty of the stars at night!</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-26" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Are there Alligators or poisonous snakes in the water?</h5>
                  </div>
                </a>
                <div id="FAQ-26" class="collapse">
                  <div class="panel-body">
                    <p>No.  Our lakes are safe for swimming.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-28" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Is there an airport shuttle?</h5>
                  </div>
                </a>
                <div id="FAQ-28" class="collapse">
                  <div class="panel-body">
                    <p>Sorry, no regular scheduled shuttles.  Some private taxis will provide a ride.  The closest airport is 1 ½ hours away.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-29" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Which airport should I use?</h5>
                  </div>
                </a>
                <div id="FAQ-29" class="collapse">
                  <div class="panel-body">
                    <p>Albany NY and Syracuse NY airports are most commonly used.</p>
                    <p>FYI, here are distances to Cooperstown, NY from various Northeast cities:</p>
                    <ul>
                        <li>Albany – 73 miles</li>
                        <li>Syracuse – 85 miles</li>
                        <li>New York City – (Geo Washington Bridge) – 200 miles</li>
                        <li>Boston – 244 miles</li>
                        <li>Niagara Falls – 256 miles</li>
                        <li>Philadelphia – 268 miles</li>
                        <li>Washington D.C. – 395 miles</li>
                        <li>Chicago – 760 miles</li>
                    </ul>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-30" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Do I need a car?</h5>
                  </div>
                </a>
                <div id="FAQ-30" class="collapse">
                  <div class="panel-body">
                    <p>Yes, you will need a car.</p>
                  </div>
                </div>
              </div><!--/question-->

              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-35" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Where is the nearest Supercharger or Tesla charging station for electric cars?</h5>
                  </div>
                </a>
                <div id="FAQ-35" class="collapse">
                  <div class="panel-body">
                    <p>In Cooperstown - a Tesla charging station is located at The Inn at Cooperstown at 16 Chestnut Street.</p>

                    <p>In Oneonta – a Tesla and a J1772 hookup (for all other electric cars) are located at the Hampton Inn at 225 River Street.</p>
                  </div>
                </div>
              </div><!--/question-->
              
              <!--question-->
              <div class="panel panel-default panel-help rentals reservation cooperstown-stay">
                <a href="#FAQ-31" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Can I make multiple payments?  Do you accept checks?</h5>
                  </div>
                </a>
                <div id="FAQ-31" class="collapse">
                  <div class="panel-body">
                    <p>YES, half is requested when you make the reservation and second half is due months later. Yes, we accept checks.</p>
                    <p>For complete payment details <a href="/rental-info">click here</a>.</p>
                  </div>
                </div>
              </div><!--/question-->
              
              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-32" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>What is there to do in the area?</h5>
                  </div>
                </a>
                <div id="FAQ-32" class="collapse">
                  <div class="panel-body">
                    <p>In addition to the National Baseball Hall of Fame, you can visit the Farmer’s Museum, the Fenimore Fine Art Museum or the Glimmerglass Opera.  The folks who live here spend a lot of time on the lakes and rivers. Paddle sports, including kayaking, canoeing and paddling on Stand-up Paddleboards have all become very popular.  </p>
                    <p>For a complete listing of 	WHAT TO DO IN THE AREA , visit <a href="https://www.cooperstownchamber.org" rel="nofollow" target="_blank">www.cooperstownchamber.org</a> or <a href="http://www.thisiscooperstown.com" rel="nofollow" target="_blank">www.thisiscooperstown.com</a></p>
                  </div>
                </div>
              </div><!--/question-->
              
              <!--question-->
              <div class="panel panel-default panel-help cooperstown">
                <a href="#FAQ-33" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Is there a gym or workout center?</h5>
                  </div>
                </a>
                <div id="FAQ-33" class="collapse">
                  <div class="panel-body">
                    <p>Yes, check out the <a href="http://www.clarksportscenter.com" rel="nofollow" target="_blank">Clark Sports Center</a> in Cooperstown, and there are multiple options in Oneonta.</p>
                  </div>
                </div>
              </div><!--/question-->
              
              <!--question-->
              <div class="panel panel-default panel-help cooperstown rentals cooperstown-dreams-park">
                <a href="#FAQ-34" data-toggle="collapse" data-parent="#faqlist">
                  <div class="panel-heading">
                    <h5>Where is the closest hospital?</h5>
                  </div>
                </a>
                <div id="FAQ-34" class="collapse">
                  <div class="panel-body">
                    <p>Bassett Healthcare is in the village of Cooperstown and Fox Hospital is in Oneonta.</p>
                  </div>
                </div>
              </div><!--/question-->



         </div>
    <!--
      </div>
    -->
    </div><!--/faqlist-->
  </div><!--/col-->
  <div class="col-md-4 hidden-sm hidden-xs">
    <ul id="filter">
      <li class="current"><a href="#">ALL</a></li>
      <li><a href="#">Cooperstown</a></li>
      <li><a href="#">Rentals</a></li>
      <li><a href="#">Reservation</a></li>
      <li><a href="#">Cooperstown Stay</a></li>
      <li><a href="#">Cooperstown Dreams Park</a></li>
    </ul>
  </div>
</div>
<!-- /FAQ -->



</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" runat="Server">
<script type="text/javascript" language="javascript">

    $(document).ready(function () {

        //FAQ behavior
        $('ul#filter a').click(function () {
            $(this).css('outline', 'none');
            $('ul#filter .current').removeClass('current');
            $(this).parent().addClass('current');

            var filterVal = $(this).text().toLowerCase().replace(' ', '-').replace(' ', '-').replace(' ', '-');

            if (filterVal == 'all') {
                $('#faqlist>div.hidden').fadeIn('slow').removeClass('hidden');
            } else {
                $('#faqlist>div').each(function () {
                    if (!$(this).hasClass(filterVal)) {
                        $(this).fadeOut('normal').addClass('hidden');
                    } else {
                        $(this).fadeIn('slow').removeClass('hidden');
                    }
                });
            }

            return false;
        });
    });

</script>
</asp:Content>
