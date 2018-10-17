<%@ Page Title="Photos of the Cooperstown Area, Special Moments" Language="VB" MasterPageFile="~/MasterLeftCol.master" AutoEventWireup="false" CodeFile="Photos.aspx.vb" Inherits="Photos" MetaDescription="To help you get excited about your big trip to Cooperstown, we've provided you with some pictures of the Cooperstown area, Cooperstown Dreams Park, past Hall of Fame inductions, and more. Enjoy!" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/cooperstown-photos" />
  <title>Photos of Cooperstown, Dreams Park, Baseball Hall of Fame | Cooperstown Stay</title>
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />

    <style type="text/css">
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

        <!--[if lt IE 7]>
        ul#portfolio li { margin-right: 5px; }
        <![endif]-->
    
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" Runat="Server">
        <asp:Literal ID="litPhotos_Description" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" Runat="Server">

    <div class="row haspad-sides" style="padding-top:30px;">


        <div id="filter" class="btn-group" role="group" aria-label="...">
          <button type="button" class="btn btn-default">All</button>
          <button type="button" class="btn btn-default">Dreams Park</button>
          <button type="button" class="btn btn-default">Cooperstown</button>
          <button type="button" class="btn btn-default">Hall of Fame</button>
          <button type="button" class="btn btn-default">Off Season</button>
          <button type="button" class="btn btn-default">Farmers' Museum</button>
        </div>

        <ul id="portfolio">
          <li class="col-xs-12 hall-of-fame"><div class="heading">Hall of Fame Induction Weekend</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-jane.jpg" alt="" class="responsive"/><div class="photo-caption">Jane Clark</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-ripkin-gwinn.jpg" alt="" class="responsive"/><div class="photo-caption">Gwynn &amp; Ripkin 2007</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-ripkin-plus.jpg" alt="" class="responsive"/><div class="photo-caption">Ripkin, Weaver &amp; Robinson</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-ripkin.jpg" alt="" class="responsive"/><div class="photo-caption">Cal Ripkin, Jr.</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-gwinn-crowd.jpg" alt="" class="responsive"/><div class="photo-caption">Tony's Fans</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-berra.jpg" alt="" class="responsive"/><div class="photo-caption">Berra, Robinson, Koufax</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-hof-induct.jpg" alt="" class="responsive"/><div class="photo-caption">Fans</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-travolta.jpg" alt="" class="responsive"/><div class="photo-caption">John Travolta</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-rich-gere.jpg" alt="" class="responsive"/><div class="photo-caption">Richard Gere</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-selig.jpg" alt="" class="responsive"/><div class="photo-caption">Bud Selig</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-ripkin-wife.jpg" alt="" class="responsive"/><div class="photo-caption">Kelly Ripkin</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 hall-of-fame"><img src="/photos/cstay-pto-gwinn-family.jpg" alt="" class="responsive"/><div class="photo-caption">Gwynn Family</div></li>
           
          <li class="col-xs-12 cooperstown"><div class="heading">Cooperstown, New York</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-induction1.jpg" alt="" class="responsive"/><div class="photo-caption">Hall of Fame Induction</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-hof-ent.jpg" alt="" class="responsive"/><div class="photo-caption">Hall of Fame Entrance</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-landscape.jpg" alt="" class="responsive"/><div class="photo-caption">Valley View</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-lake.jpg" alt="" class="responsive"/><div class="photo-caption">The Lake</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-canoe.jpg" alt="" class="responsive"/><div class="photo-caption">Canoe Race</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-hay-bales.jpg" alt="" class="responsive"/><div class="photo-caption">Clark Gym</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-court-hse.jpg" alt="" class="responsive"/><div class="photo-caption">County Courthouse</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-otesaga.jpg" alt="" class="responsive"/><div class="photo-caption">Otesaga Flowers</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-lake-fog%20.jpg" alt="" class="responsive"/><div class="photo-caption">Morning Glimmerglass </div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-peterose.jpg" alt="" class="responsive"/><div class="photo-caption">Pete</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-reggie.jpg" alt="" class="responsive"/><div class="photo-caption">Reggie</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-snider.jpg" alt="" class="responsive"/><div class="photo-caption">Duke</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-hunter3.jpg" alt="" class="responsive"/><div class="photo-caption">Deerslayer</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-otesaga3.JPG" alt="" class="responsive"/><div class="photo-caption">Otesaga Hotel Verandah</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-hof-crowd.jpg" alt="" class="responsive"/><div class="photo-caption">HOF Induction Crowd</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-satchel-paige.jpg" alt="" class="responsive"/><div class="photo-caption">Satchel Paige</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-woman-at-bat.jpg" alt="" class="responsive"/><div class="photo-caption">Woman at Bat</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-campenella.jpg" alt="" class="responsive"/><div class="photo-caption">Roy Campenella</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-channel-2-crew.jpg" alt="" class="responsive"/><div class="photo-caption">Channel 2 News crew</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-espn-crew2.jpg" alt="" class="responsive"/><div class="photo-caption">ESPN crew</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-espn-cameramn.jpg" alt="" class="responsive"/><div class="photo-caption">ESPN cameraman</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-williams.jpg" alt="" class="responsive"/><div class="photo-caption">Ted Williams</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-sand-Lot.jpg" alt="" class="responsive"/><div class="photo-caption">The Sandlot Kid</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-ruth.jpg" alt="" class="responsive"/><div class="photo-caption">Babe Ruth</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-hof2.jpg" alt="" class="responsive"/><div class="photo-caption">The Hall of Fame</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-hof-bb-standings.jpg" alt="" class="responsive"/><div class="photo-caption">HOF Scoreboard</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-hof-library.jpg" alt="" class="responsive"/><div class="photo-caption">HOF Library</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-hof-induction.jpg" alt="" class="responsive"/><div class="photo-caption">HOF Induction Site</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-vw2.jpg" alt="" class="responsive"/><div class="photo-caption">Beetle Ball</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-ctwn3.jpg" alt="" class="responsive"/><div class="photo-caption">Doubleday Field</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-bridge.jpg" alt="" class="responsive"/><div class="photo-caption">Stone Bridge</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-bud-wagon.jpg" alt="" class="responsive"/><div class="photo-caption">Budweiser Wagon</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-bb-fence.jpg" alt="" class="responsive"/><div class="photo-caption">Hall of Fame Entrance</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-ls-offices.jpg" alt="" class="responsive"/><div class="photo-caption">Leatherstocking Offices</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-james-f-coop.jpg" alt="" class="responsive"/><div class="photo-caption">James Fenimore Cooper</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-library.jpg" alt="" class="responsive"/><div class="photo-caption">Village Offices</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-main-st6.jpg" alt="" class="responsive"/><div class="photo-caption">Wax Museum</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-main-st-merchants.jpg" alt="" class="responsive"/><div class="photo-caption">Main St. Merchants</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-main-st3.jpg" alt="" class="responsive"/><div class="photo-caption">Main St. Induction Wknd.</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-mickey-plc.jpg" alt="" class="responsive"/><div class="photo-caption">Mickey's Place</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-main-st7.jpg" alt="" class="responsive"/><div class="photo-caption">Main St. Induction Wknd.</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-pioneer-st.jpg" alt="" class="responsive"/><div class="photo-caption">Pioneer Street</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-trolley.jpg" alt="" class="responsive"/><div class="photo-caption">Cooperstown Trolley</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-main-st4.jpg" alt="" class="responsive"/><div class="photo-caption">Danney's Market</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-main-st5.jpg" alt="" class="responsive"/><div class="photo-caption">Main Street</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-pumpkin3.jpg" alt="" class="responsive"/><div class="photo-caption">Pumpkin Fest</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-pumpkin2.jpg" alt="" class="responsive"/><div class="photo-caption">Make a Pumpkin Boat </div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-pumpkin1.jpg" alt="" class="responsive"/><div class="photo-caption">Race a Pumpkin Boat</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-farmland.jpg" alt="" class="responsive"/><div class="photo-caption">Farmland by te Lake</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-fenimore.jpg" alt="" class="responsive"/><div class="photo-caption">Fenimore Art Museum</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 cooperstown"><img src="/photos/cstay-pto-glimmerglass-opera.jpg" alt="" class="responsive"/><div class="photo-caption">Glimmerglass Opera</div></li>
      
          <li class="col-xs-12 off-season"><div class="heading">&quot;Off Season&quot; in Cooperstown</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 off-season"><img src="/photos/cstay-pto-hof-snow.jpg" alt="" class="responsive"/><div class="photo-caption">Baseball Hall of Fame</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 off-season"><img src="/photos/cstay-pto-santas-hse.jpg" alt="" class="responsive"/><div class="photo-caption">Santa's Cottage</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 off-season"><img src="/photos/cstay-pto-coopers-inn.jpg" alt="" class="responsive"/><div class="photo-caption">The Cooper Inn</div></li>

          <li class="col-xs-12 dreams-park"><div class="heading">Cooperstown Dreams Park</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dreams-park10.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dreams-park3.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dreams-park5.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dreams-park4.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dreams-park9.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dreams-park6.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dpark4.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dreams-park7.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-dreams-park8.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-ready.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-skills-coach.jpg" alt="" class="responsive"></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 dreams-park"><img src="/photos/cstay-pto-bb-pond%20.jpg" alt="" class="responsive"></li>

          <li class="col-xs-12 farmers-museum"><div class="heading">Farmers' Museum, Cooperstown, New York</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-entrance.jpg" alt="" class="responsive"/><div class="photo-caption">Entrance Barn</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-eat-corn.jpg" alt="" class="responsive"/><div class="photo-caption">Corn on the Cob</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-church.jpg" alt="" class="responsive"/><div class="photo-caption">Church</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-amimal-parade.jpg" alt="" class="responsive"/><div class="photo-caption">Animal Parade</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-blacksmith.jpg" alt="" class="responsive"/><div class="photo-caption">Blacksmith</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-blksm-shop.jpg" alt="" class="responsive"/><div class="photo-caption">Blacksmith Shop</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-bump.jpg" alt="" class="responsive"/><div class="photo-caption">Bump Tavern</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-bump-music.jpg" alt="" class="responsive"/><div class="photo-caption">Bump Tavern Tunes</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-calf.jpg" alt="" class="responsive"/><div class="photo-caption">Young Ox</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-soldier.jpg" alt="" class="responsive"/><div class="photo-caption">Village Entrance</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-fair.jpg" alt="" class="responsive"/><div class="photo-caption">Fair on the Green</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-carousel.jpg" alt="" class="responsive"/><div class="photo-caption">Carousel</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-pharmacy.jpg" alt="" class="responsive"/><div class="photo-caption">Pharmacy</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-oxen.jpg" alt="" class="responsive"/><div class="photo-caption">Young Team</div></li>
          <li class="col-xs-6 col-sm-4 col-lg-4 farmers-museum"><img src="/photos/cstay-pto-fm-gen-store.jpg" alt="" class="responsive"/><div class="photo-caption">Todd General Store</div></li>

        </ul>
    
        <div class="photo-credit">Farmers' Museum photos courtesy of B&amp;V Artworks</div>

    </div><!--/row-->
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" Runat="Server">
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

