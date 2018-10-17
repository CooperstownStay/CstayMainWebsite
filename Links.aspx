<%@ Page Title="Things To Do in Cooperstown, NY" Language="VB" MasterPageFile="~/MasterLeftCol.master" AutoEventWireup="false" CodeFile="Links.aspx.vb" Inherits="Links" MetaDescription="Looking for things to do while you stay in Cooperstown, NY? Here is a list of things to do when you're not at the baseball field or touring one of our museums." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <title>Things to Do in Cooperstown, New York | Cooperstown Stay</title>
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/things-to-do" />
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />

    <style type="text/css">
      
        .link-btn {
            display: inline-block!important;
            width: 80px!important;
            margin: 0px 0px 5px 20px;
            padding: 5px;
        }
        .link-info {padding:5px 20px;}
      
        .area-link h4 {
            font-weight: bold;
        }

        .area-link .link-excerpt {
            color: #777;
        }
        .area-link .link-addr 
        { 
            white-space:nowrap;
        }

        .area-link a.link-phone {
            font-size: 20px;
            color: chocolate;
            white-space:nowrap;
        }
        
        hr.link-sep {
            border: none;
            /* margin: 20px; */
            padding: 3px;
            background-color: #eee;
            display: block;
            clear: both!important;
        }


      
        ul#filter { 
          float: left; 
          font-size: 16px; 
          list-style: none; 
          margin-left: 0; 
          width: 100%;
        }
        ul#filter li { 
          /*border-right: 1px solid #dedede;*/
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
            padding-left: 0px;
          /*width: 672px;*/
        }
        ul#portfolio li { 
          /*border: 1px solid #dedede;*/
          float: left; 
          /*margin: 0 10px 10px 0; */
          padding: 5px;
          /*width: 202px;*/
        }

        ul#portfolio a { display: block; width: 100%; }
        ul#portfolio a:hover { text-decoration: none; }
        ul#portfolio img { /*border: 1px solid #dedede;*/ display: block; padding-bottom: 5px; }

        .photo-credit {font-size: 10px;color:#555;}

        .responsive {width:100%;}
        .row.haspad-sides {
            /* padding: 15px; */
            margin-right: 15px;
            margin-left: 0px;
        }
        .photo-caption {
            text-align: center;
        }
        

      @media screen and (max-width: 767px)
      {
        .heading {display: block!important;}
      }
      
        <!--[if lt IE 7]>
        ul#portfolio li { margin-right: 5px; }
        <![endif]-->
    
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">


    <div class="row haspad-sides" style="padding-top:30px;">


        <div id="filter" class="btn-group" role="group" aria-label="...">
          <button type="button" class="btn btn-default">All</button>
          <button type="button" class="btn btn-default">Attractions</button>
          <button type="button" class="btn btn-default">Restaurants</button>
          <button type="button" class="btn btn-default">Beverage Trail</button>
          <!--button type="button" class="btn btn-default">Shopping</button-->
        </div>

        <ul id="portfolio">


          <!-------------------------------------->
          <!------------ ATTRACTIONS ------------->
          <!-------------------------------------->
          <li class="col-xs-12 attractions"><div class="heading">Attractions in Cooperstown, NY</div></li>
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/cooperstown-canoe-kayak-rental.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Canoe & Kayak Rentals and Sales</h4>
                <p class="link-excerpt">
                Rent canoes, kayaks or Stand-Up paddleboards! Check out our 2 locations: Brookwood Point (Cooperstown) on Otsego Lake and Portlandville on the Susquehanna River. Rentals offered for half day, full day or by the week. Launch on the Susquehanna River right behind our Portlandville shop or directly on Otsego Lake at our Cooperstown location. Delivery available to your waterfront home in the area. Bait & tackle available too!
                </p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  2828 NYS Route 28<br />
                  Portlandville, NY 13834<br />
                </div>
                <a class="link-phone" href="tel:6072867349">607-286-7349</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.CanoeandKayakRentals.com" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//2828+NYS-28,+Portlandville,+NY+13834" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/babierge.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Baby Equipment Rentals</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr"></div>
                <a class="link-phone" href="tel:6074318441">607-431-8441</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://www.babierge.com/jackbetsy807" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/barnyard-swing-mini-golf.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Barnyard Swing Miniature Golf</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  4604 State Hwy. 28<br />
                  Milford, NY 13807<br />
                </div>
                <a class="link-phone" href="tel:6075478330">607-547-8330</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://barnyardswing.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//4604+NY-28,+Milford,+NY+13807" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/cooperstown-art-association.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Cooperstown Art Association</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  22 Main Street<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:6075479777">607-547-9777</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.cooperstownart.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//22+Main+St,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/cooperstown-escape-room.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Cooperstown Escape Room</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  73 Main Street<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:6075444617">607-544-4617</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.cooperstownescaperooms.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//73+Main+St,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/cooperstown-summer-music-festival.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Cooperstown Summer Music Festival</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr"></div>
                <a class="link-phone" href="tel:8776667421">877-666-7421</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.cooperstownmusicfest.org/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><!--a href="TBD" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a-->
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/erie-canal-cruises.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Erie Canal Cruises</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  800 Mohawk Street<br />
                  Herkimer, NY 13350<br />
                </div>
                <a class="link-phone" href="tel:3157170350">315-717-0350</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://eriecanalcruises.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//800+Mohawk+St,+Herkimer,+NY+13350" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/fenimore-art-museum.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Fenimore Art Museum</h4>
                <p class="link-excerpt">
                
                </p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  5798 State Highway 80<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:8885471450">888-547-1450</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://www.fenimoreartmuseum.org/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//5798+NY-80,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/fly-creek-cider-mill.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Fly Creek Cider Mill and Orchard</h4>
                <p class="link-excerpt">
                
                </p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  288 Goose Street<br />
                  Fly Creek, NY 13337<br />
                </div>
                <a class="link-phone" href="tel:8005056455">800-505-6455</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://www.flycreekcidermill.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//288+Goose+St,+Fly+Creek,+NY+13337" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/herkimer-diamond-mines.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Herkimer Diamond Mines, Inc.</h4>
                <p class="link-excerpt">
                
                </p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  4626 State Route 28<br />
                  Herkimer, NY 13350<br />
                </div>
                <a class="link-phone" href="tel:3157170175">315-717-0175</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.herkimerdiamond.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//Prospector's+Pavilion,+4626+NY-28,+Herkimer,+NY+13350" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/howe-caverns.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Howe Caverns</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  255 Discovery Drive<br />
                  Howes Cave, NY 12092<br />
                </div>
                <a class="link-phone" href="tel:5182968900">518-296-8900</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://howecaverns.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//255+Discovery+Dr,+Howes+Cave,+NY+12092" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/hyde-hall.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Hyde Hall</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  267 Glimmerglass State Park Road<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:6075475098">607-547-5098</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://hydehall.org/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//267+Glimmerglass+State+Park,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/mr-shakes-mini-golf.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Mr. Shake's Mini Golf</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  663 State Route 28<br />
                  Richfield Springs, NY 13439<br />
                </div>
                <a class="link-phone" href="tel:3157177427">315-717-7427</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://www.facebook.com/Mr.Shakesicecream/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//663+NY-28,+Richfield+Springs,+NY+13439" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/baseball-hall-of-fame.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>National Baseball Hall of Fame and Museum</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  25 Main Street<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:8884255633">888-425-5633</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://baseballhall.org/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//25+Main+St,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/farmers-museum.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>The Farmers' Museum</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  5775 State Highway 80 (Lake Road)<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:6075471450">607-547-1450</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.farmersmuseum.org/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//5775+NY-80,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/glimmerglass-festival.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>The Glimmerglass Festival</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  7300 State Highway 80<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:6075470700">607-547-0700</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://glimmerglass.org/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//7300+NY-80,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/grand-slam-paintball.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Grand Slam Paintball</h4>
                <p class="link-excerpt">
                
                </p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  131 Burke Hill Road<br />
                  Milford, NY 13807<br />
                </div>
                <a class="link-phone" href="tel:6076432732">607-643-2732</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://www.grandslampaintball.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//Grand+Slam+Paintball,+131+Burke+Hill+Rd,+Milford,+NY+13807" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          
          
          <!-- Area Link -------->
          <li class="col-xs-12 attractions"><hr class="link-sep" />

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/whistle-stop-gift-shop.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Whistle Stop Gift Shop</h4>
                <p class="link-excerpt">
                
                </p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  4542 State Highway 28<br />
                  Cooperstown, NY<br />
                </div>
                <a class="link-phone" href="tel:6075474912">607-547-4912</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://www.facebook.com/whistlestopatcooperstown/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//4542+NY-28,+Milford,+NY+13807" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
          </li><!-------- /END Area Link -->
          

          
          <!-------------------------------------->
          <!--------- BEVERAGE TRAIL ------------->
          <!-------------------------------------->
          <li class="col-xs-12 beverage-trail"><div class="heading">The Beverage Trail</div></li>

          <!-- Area Link -------->
          <li class="col-xs-12 beverage-trail">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/bear-pond-winery.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Bear Pond Winery</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  2515 State Highway 28<br />
                  Oneonta, NY 13820<br />
                </div>
                <a class="link-phone" href="tel:6076430294">607-643-0294</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://www.bearpondwines.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//2515+NY-28,+Oneonta,+NY+13820" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
         
          </li><!-------- /END Area Link -->


          <!-- Area Link -------->
          <li class="col-xs-12 beverage-trail">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/brewery-ommegang.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Brewery Ommegang</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  656 County Highway 33<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:6075441800">607-544-1800</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.ommegang.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//656+Co+Hwy+33,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
         
          </li><!-------- /END Area Link -->


          <!-- Area Link -------->
          <li class="col-xs-12 beverage-trail">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/butternuts-beer-ale.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Butternuts Beer & Ale</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  4021 State Highway 51<br />
                  Garrattsville, NY 13342<br />
                </div>
                <a class="link-phone" href="tel:6072635070">607-263-5070</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://butternutsbeerandale.com" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//4021+NY-51,+Garrattsville,+NY+13342" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
         
          </li><!-------- /END Area Link -->


          <!-- Area Link -------->
          <li class="col-xs-12 beverage-trail">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/cooperstown-brewing-company.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Cooperstown Brewing Company</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  110 River Street<br />
                  Milford, NY 13807<br />
                </div>
                <a class="link-phone" href="tel:6072869330">607-286-9330</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.cooperstownbrewing.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//110+River+St,+Milford,+NY+13807" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
         
          </li><!-------- /END Area Link -->


          <!-- Area Link -------->
          <li class="col-xs-12 beverage-trail">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/cooperstown-distillery.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Cooperstown Distillery</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  11 Railroad Avenue<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:6072824246">607-282-4246</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://cooperstowndistillery.com" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//11+Railroad+Ave,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
         
          </li><!-------- /END Area Link -->


          <!-- Area Link -------->
          <li class="col-xs-12 beverage-trail">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/pail-shop-vineyards.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Pail Shop Vineyards</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  126 Goose Street<br />
                  Fly Creek, NY 13337<br />
                </div>
                <a class="link-phone" href="tel:6072824027">607-282-4027</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="https://www.pailshopvineyards.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//126+Goose+St,+Fly+Creek,+NY+13337" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
         
          </li><!-------- /END Area Link -->


          <!-- Area Link -------->
          <li class="col-xs-12 beverage-trail">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/red-shed-brewery.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Red Shed Brewery</h4>
                <p class="link-excerpt"></p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  709 County Highway 33<br />
                  Cooperstown, NY 13326<br />
                </div>
                <a class="link-phone" href="tel:6072824380">607-282-4380</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://www.redshedbrewing.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//709+Co+Hwy+33,+Cooperstown,+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
         
          </li><!-------- /END Area Link -->


          <!-- Area Link -------->
          <li class="col-xs-12 beverage-trail">

            <div class="col-xs-12 col-sm-4">
              <img src="/photos/area-links/rustic-ridge-winery.jpg" alt="" class="responsive"/>
            </div>
          
            <div class="col-xs-12 col-sm-8 area-link link-info">
              <div class="col-xs-12">
                <h4>Rustic Ridge Winery</h4>
                <p class="link-excerpt">
                Burlington's Oldest Winery. Feel free to bring a picnic lunch, grab a bottle of wine, and enjoy our relaxed, rural, rustic country atmosphere and views overlooking our farmland and vineyard.
                </p>
                <hr />
              </div>
              <div class="col-xs-7 col-sm-6">
                <div class="link-addr">
                  2805 State Highway 80<br />
                  Burlington Flats, NY 13315<br />
                </div>
                <a class="link-phone" href="tel:6079650626">607-965-0626</a>
              </div>
              <div class="col-xs-5 col-sm-6">
                <a href="http://rusticridgewinery.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir//2805+NY-80,+Burlington+Flats,+NY+13315" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a>
              </div>
            </div>
         
          </li><!-------- /END Area Link -->
          
          
          
          
          <!-------------------------------------->
          <!----------- Restaurants -------------->
          <!-------------------------------------->
          <li class="col-xs-12 restaurants"><div class="heading">Restaurants in Cooperstown, NY</div></li>
          
          <!-- Area Link -------->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Alex's Bistro</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">149 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075474070"">607-547-4070</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://chef-alex-webster.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/149+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Bear Pond Winery</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">2515 State Highway 28<br/>Oneonta, NY 13820<br /></div><a class="link-phone" href="tel:6076430294"">607-643-0294</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.bearpondwines.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/2515+State+Highway+28%2COneonta%2C+NY+13820" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Blue Mingo Grill</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">6098 State Highway 80<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075477496"">607-547-7496</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.bluemingogrill.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/6098+State+Highway+80%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Bocca Osteria</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">5438 State Highway 28<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6072824031"">607-282-4031</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.boccaosteria.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/5438+State+Highway+28%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Brewery Ommegang</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">656 County Highway 33<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075441800"">607-544-1800</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.ommegang.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/656+County+Highway+33%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Brooks' House of Bar-B-Q</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">5560 State Highway 7<br/>Cooperstown, NY 13820<br /></div><a class="link-phone" href="tel:6074321782"">607-432-1782</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://brooksbbq.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/5560+State+Highway+7%2CCooperstown%2C+NY+13820" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>China Wok</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">7 Commons Drive<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075475888"">607-547-5888</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/7+Commons+Drive%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Cooley's Stone House Tavern</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">49 Pioneer Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075441311"">607-544-1311</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/49+Pioneer+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Cooperstown Back Alley Grille</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">8 Hoffman Lane<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6073224048"">607-322-4048</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.cooperstownbackalleygrille.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/8+Hoffman+Lane%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Cooperstown Diner</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">136 1/2 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075479201"">607-547-9201</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.cooperstowndiner.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/136+1%2F2+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Council Rock Brewery</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">4861 NY-28<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6076433016"">607-643-3016</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://councilrockbrewery.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/4861+NY-28%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Danny's Market</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">92 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075474053"">607-547-4053</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/92+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Depot Deli</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">43 Pioneer Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075477130"">607-547-7130</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/43+Pioneer+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Dobler's Brewery and Tavern</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">1917 NY-205<br/>Mount Vision, NY 13810<br /></div><a class="link-phone" href="tel:6074336600"">607-433-6600</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.facebook.com/doblerbrewingcompany/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/1917+NY-205%2CMount+Vision%2C+NY+13810" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Doubleday Cafe</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">93 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075475468"">607-547-5468</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.facebook.com/DoubledayCafe" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/93+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Fenimore Café</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">5798 New York 80<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:8885471450"">888-547-1450</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/5798+New+York+80%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Fly Creek General Store</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">6212 NY-28<br/>Fly Creek, NY 13337<br /></div><a class="link-phone" href="tel:6075477274"">607-547-7274</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/6212+NY-28%2CFly+Creek%2C+NY+13337" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>HardBall Café</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">99 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075471273"">607-547-1273</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/99+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Hawkeye Bar & Grill</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">60 Lake Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075442524"">607-544-2524</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.otesaga.com/dining/the-hawkeye-bar-grill.aspx" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/60+Lake+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Jackie's Restaurant</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">3688 NY-28<br/>Milford, NY 13807<br /></div><a class="link-phone" href="tel:6072867843"">607-286-7843</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.jackiesrestaurantmilfordny.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/3688+NY-28%2CMilford%2C+NY+13807" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Jerry's Place</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">6635 NY-28<br/>Hartwick, NY 13348<br /></div><a class="link-phone" href="tel:6075471037"">607-547-1037</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.jerrysplaceny.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/6635+NY-28%2CHartwick%2C+NY+13348" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Jive Cafe</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">12 Commons Drive<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075474471"">607-547-4471</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/12+Commons+Drive%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Maskot's Pizza and Grill</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">4551 NY-28<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075472200"">607-547-2200</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://maskotsofcooperstown.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/4551+NY-28%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>McDonald's of Cooperstown</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">60 Commons Drive<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075471110"">607-547-1110</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.mcdonalds.com/us/en-us.html" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/60+Commons+Drive%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Mel's at 22</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">22 Chestnut Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6074357062"">607-435-7062</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://melsat22.net/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/22+Chestnut+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Mt. Fuji</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">134 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075441088"">607-544-1088</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://mtfujicooperstown.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/134+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>New York Pizzeria</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">75 Chestnut Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075472930"">607-547-2930</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.nypizza.biz/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/75+Chestnut+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Nicoletta's Italian Cafe</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">96 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075477499"">607-547-7499</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.nicolettasitaliancafe.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/96+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Origins Cafe</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">558 Beaver Meadow Rd<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6074372862"">607-437-2862</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.celebrateorigins.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/558+Beaver+Meadow+Rd%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Pioneer Patio Restaurant</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">46 Pioneer St # 2<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075441076"">607-544-1076</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/46+Pioneer+St+#+2%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Pizza Hut</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">23 Commons Drive<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075471000"">607-547-1000</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/23+Commons+Drive%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Pop's Place</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">4347 NY-28<br/>Milford, NY 13807<br /></div><a class="link-phone" href="tel:6072867219"">607-286-7219</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/4347+NY-28%2CMilford%2C+NY+13807" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Redneck BBQ</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">4938 NY-28<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075472678"">607-547-2678</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://redneckbarbque.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/4938+NY-28%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Rose & Kettle Restaurant</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">4 Lancaster Street<br/>Cherry Valley, NY 13320<br /></div><a class="link-phone" href="tel:6072643078"">607-264-3078</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://theroseandkettle.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/4+Lancaster+Street%2CCherry+Valley%2C+NY+13320" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Sal's Pizzeria and Restaurant</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">110 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075475721"">607-547-5721</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/110+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Sherman's Tavern</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">48 Pioneer Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075474000"">607-547-4000</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://hotelpratt.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/48+Pioneer+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Slices Pizzeria</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">46 Pioneer Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075441075"">607-544-1075</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/46+Pioneer+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Stagecoach Coffee</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">31 Pioneer Street #2<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075476229"">607-547-6229</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://stagecoachcoffee.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/31+Pioneer+Street+#2%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Stewart's Shops</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">108 Chestnut Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075477248"">607-547-7248</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.stewartsshops.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/108+Chestnut+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>SUBWAY<sup>&reg;</sup></h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">13 Commons Drive<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075470777"">607-547-0777</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.subway.com/en-us" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/13+Commons+Drive%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Sunflower Cafe</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">7629A NY-80<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:3159858096"">315-985-8096</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://sunflowerspringfield.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/7629A+NY-80%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>The Hartwick Restaurant</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">3496 NY-205<br/>Hartwick, NY 13348<br /></div><a class="link-phone" href="tel:6072933043"">607-293-3043</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/3496+NY-205%2CHartwick%2C+NY+13348" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>The Pit Under the Tunnicliff Inn</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">34 Pioneer Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075479611"">607-547-9611</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.tunnicliffinn.net/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/34+Pioneer+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>The Shack</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">4918 NY-28<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6072824483"">607-282-4483</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.google.com/maps/dir/4918+NY-28%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Toscana</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">64 Main Street<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6075472100"">607-547-2100</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="http://www.toscananorthernitaliangrill.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/64+Main+Street%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->
          <li class="col-xs-12 restaurants"><!--hr class="link-sep" /--><div class="col-xs-12 col-sm-12 area-link link-info"><div class="col-xs-12"><h4>Upstate Bar & Grill</h4></div><div class="col-xs-7 col-sm-6"><div class="link-addr">5418 NY-28<br/>Cooperstown, NY 13326<br /></div><a class="link-phone" href="tel:6072824525"">607-282-4525</a></div><div class="col-xs-5 col-sm-6 text-right"><a href="https://www.upstatebarandgrill.com/" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Website</a><a href="https://www.google.com/maps/dir/5418+NY-28%2CCooperstown%2C+NY+13326" class="btn btn-xs btn-info link-btn" rel="nofollow" target="_blank">Directions</a></div></div></li><!-------- /END Area Link -->



        </ul>
    

    </div><!--/row-->



</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" runat="Server">
    <script type="text/javascript" language="javascript">
      $(document).ready(function () {

        $('div#filter button').click(function () {
          $(this).css('outline', 'none');
          $('div#newfilter .current').removeClass('current');
          $(this).parent().addClass('current');

          var filterVal = $(this).text().toLowerCase().replace(' ', '-').replace(' ', '-').replace('\'', '');

          if (filterVal == 'all') {
            $('ul#portfolio li.hidden').fadeIn('slow').removeClass('hidden');
          } else {
            $('ul#portfolio li').each(function () {
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
