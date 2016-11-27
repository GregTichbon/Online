<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FoodBusinessRegistrationORIG.aspx.cs" Inherits="Online.FCP.FoodBusinessRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .cardhead {
            text-indent: 0px;
        }
    </style>


    <script type="text/javascript">
        $(document).ready(function () {


            $("#pagehelp").colorbox({ href: "FoodBusinessRegistration.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $('.selectcards').change(function () {
                thisid = this.id;
                switch (thisid) {
                    case 'cb_retailfood':
                        if (this.checked) {
                            $("#card2").show();
                        } else {
                            $("#card2").hide();
                        }
                        break;
                    case 'cb_grow':
                        if (this.checked) {
                            $("#card3").show();
                        } else {
                            $("#card3").hide();
                        } break;
                    case 'cb_foodservice':
                        if (this.checked) {
                            $("#card4").show();
                        } else {
                            $("#card4").hide();
                        } break;
                    case 'cb_transport':
                        if (this.checked) {
                            $("#card5").show();
                        } else {
                            $("#card5").hide();
                        } break;
                    case 'cb_manufacture':
                        if (this.checked) {
                            $("#card6").show();
                        } else {
                            $("#card6").hide();
                        } break;
                    case 'cb_preschool':
                        if (this.checked) {
                            $("#card7").show();
                        } else {
                            $("#card7").hide();
                        } break;
                    case 'cb_extracts':
                        //alert(thisid);
                        break;
                    case 'cb_exempt':
                        //alert(thisid);
                        break;
                }



            });
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string selected;
        string none = "none";
    %>
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Food Business Registration
    </h1>


    <!-- Card 1 -->

    <!-- Accordian header start -->

    <div class="panel-group">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" href="#collapse_card1">Card 1 - Trading Operations</a>
                </h4>
            </div>
            <div id="collapse_card1" class="panel-collapse collapse">
                <div class="panel-body">

                    <!-- Accordian header end -->

                    <div class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse_card1a">1. Trading Operations – how you source and supply your products / services</a>
                                </h4>
                            </div>
                            <div id="collapse_card1a" class="panel-collapse collapse">
                                <div class="panel-body">

                                    <!-- Accordian header end -->

                                    <div class="form-group">

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <h3>
                                                    <input name="cb_1.1" type="checkbox" />
                                                    Caterer</h3>
                                                <p class="cardhead">
                                                    Provides food, supplies and services for a social occasion or function or within an education or other facility.
                                                </p>
                                            </div>

                                            <div class="col-sm-6">
                                                <h3>
                                                    <input name="cb_1.1" type="checkbox" />
                                                    Eat-in premises
                                                </h3>
                                                <p class="cardhead">
                                                    Examples: Restaurant, café, residential care early childhood education (ECE) centres and kōhanga reo.
                                                </p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <h3>
                                                    <input name="cb_1.1" type="checkbox" />Export</h3>
                                                </div>
 
                                         <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Home delivery</h3>
                                                    <p class="cardhead">
                                                        Examples: Pizza delivery, meals-on-wheels and grocery delivery.
                                                    </p>
                    </div>
                                        </div>






                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Import</h3>
                                                    <p class="cardhead">
                                                        Either as a registered food importer or through an agent who is a registered importer.
                                                    </p>
                                                </div>

                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Internet</h3>
                                                    <p class="cardhead">
                                                        On-line selling of food products.
                                                    </p>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Market</h3>
                                                    <p class="cardhead">
                                                        Example: Stall at farmers’ or other market.
                                                    </p>
                                                </div>

                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Mobile</h3>
                                                    <p class="cardhead">
                                                        Example: Food truck.
                                                    </p>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Retail</h3>
                                                    <p class="cardhead">
                                                        Examples: Supermarket, dairy or other premises selling direct to the consumer.
                                                    </p>
                                                </div>

                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        On-licence</h3>
                                                    <p class="cardhead">
                                                        Eat-in premises that sell alcohol for consumption at the same location.
                                                    </p>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Storage provider</h3>
                                                    <p class="cardhead">
                                                        Examples: Cold stores and warehouses.
                                                    </p>
                                                </div>

                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Takeaway</h3>
                                                    <p class="cardhead">
                                                        Ready-to-eat meals sold for immediate consumption at another location.
                                                    </p>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Transport provider</h3>
                                                    <p class="cardhead">
                                                        Ambient or temperature-controlled transport.
                                                    </p>
                                                </div>

                                                <div class="col-sm-6">
                                                    <h3>
                                                        <input name="cb_1.1" type="checkbox" />
                                                        Wholesale</h3>
                                                    <p class="cardhead">
                                                        Premises selling to retailer.
                                                    </p>
                                                </div>





                                            </div>
                                            <!-- Accordian footer start -->
    </div>
    </div>
                                </div>
                            </div>
                            <!-- Accordian footer end -->


                            <!-- Accordian footer start -->
                        </div>
                    </div>
                </div>
                <!-- Accordian footer end -->
            </div>
    <div class="row">
            <div class="col-sm-6">
                <h3>
                    <input id="cb_retailfood" name="cb_cards" class="selectcards" type="checkbox" />
                    Retail food</h3>
                <p class="cardhead">Sells food or drink directly to customers in a retail store or shop. Examples: Bakeries, dairies, fishmongers, retail butchers, and supermarkets that have an on-site butchery, bakery, or delicatessen.</p>
            </div>
            <div class="col-sm-6">
                <h3>
                    <input id="cb_grow" name="cb_cards" class="selectcards" type="checkbox" />
                    Grow and / or pack fresh fruit or vegetables</h3>
                <p>
                    Businesses that grow, harvest, and/or minimally process horticultural produce following harvest. Examples: Drying of nuts in their shells, or wholesale of horticultural produce that was grown by others.
                </p>
            </div>

        </div>
        <div class="row">
            <div class="col-sm-6">
                <h3>
                    <input id="cb_foodservice" name="cb_cards" class="selectcards" type="checkbox" />
                    Food service – serves / sells food directly to customers to be eaten straight away
                </h3>
                <p>
                    Examples: Cafés, restaurants / hospitals / takeaway shops, pubs that prepare food.
                </p>

            </div>
            <div class="col-sm-6">
                <h3>
                    <input id="cb_transport" name="cb_cards" class="selectcards" type="checkbox" />
                    Transport, distribute or warehouse food
                </h3>
                <p>Where these are the only / main activities of your food business.</p>
            </div>

        </div>
        <div class="row">
            <div class="col-sm-6">
                <h3>
                    <input id="cb_manufacture" name="cb_cards" class="selectcards" type="checkbox" />
                    Manufacture, bake or process food
                </h3>
                <p>
                    Food not for direct sale to consumers.
                </p>

            </div>
            <div class="col-sm-6">
                <h3>
                    <input id="cb_preschool" name="cb_cards" class="selectcards" type="checkbox" />
                    Provide food to pre-school children
                </h3>
                <p>
                    Businesses proving food as part of paid service in a centre-based service settings. Examples: Early childhood education (ECE) centres and kohanga reo.
                </p>
            </div>

        </div>
        <div class="row">
            <div class="col-sm-6">
                <h3>&nbsp;Extracts and packs honey
                </h3>
                <p>
                    Only Card 1 needs to be completed.
                </p>

            </div>
            <div class="col-sm-6">
                <h3>&nbsp;Exempt</h3>
                <p>
                    Part of my business is exempt from registration as referenced in Schedule 3 of the Food Act 2014. (Only Card 1 needs to be completed.)
                </p>
            </div>

        </div>



        <!-- Card 2 -->

        <!-- Accordian header start -->

        <div class="panel-group" id="card2" style="display: <%: none%>">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse_card2">
                            <h3>Card 2 - Retail - Sell food or drink to customers in a retail store or shop</h3>
                        </a>
                    </h4>
                </div>
                <div id="collapse_card2" class="panel-collapse collapse">
                    <p>
                        Retail — Sell food or drink to customers in a retail store or shop
Step 1. Tick the boxes beside each of the section titles (1-5) to show what your business sells.
Step 2. For each section you have selected tick the products that you sell, or make and sell. If the food products
don’t seem to be those you make or sell then re-consider whether this section is relevant or not as there could be a
better match.
                    </p>
                    <div class="panel-body">

                        <!-- Accordian header end -->

                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse_card2a">Card 2A - xxxxxxxxxxxxx</a>
                                    </h4>
                                </div>
                                <div id="collapse_card2a" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <!-- Accordian header end -->

                                        <div class="form-group">
                                            <label class="control-label col-sm-4" for="cb_2.1.1a">xxxxxxxxxxx</label>
                                            <div class="col-sm-8">

                                                <input id="cb_2.1.1a" name="cb_1.1" type="checkbox" />




                                            </div>
                                        </div>
                                        <!-- Accordian footer start -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Accordian footer end -->


                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
            <!-- Accordian footer end -->
        </div>

        <!-- Card 3 -->

        <!-- Accordian header start -->

        <div class="panel-group" id="card3" style="display: <%: none%>">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse_card3">Card 3 - Serve / sell food directly to customers to be eaten straight away</a>
                    </h4>

                </div>
                <div id="collapse_card3" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->

                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse_card3a">Card 3A - xxxxxxxxxxxxx</a>
                                    </h4>
                                </div>
                                <div id="collapse_card3a" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <!-- Accordian header end -->

                                        <div class="form-group">
                                            <label class="control-label col-sm-4" for="cb_3.1.1a">xxxxxxxxxxx</label>
                                            <div class="col-sm-8">

                                                <input id="cb_3.1.1a" name="cb_1.1" type="checkbox" />

                                            </div>
                                        </div>
                                        <!-- Accordian footer start -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Accordian footer end -->


                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
            <!-- Accordian footer end -->
        </div>

        <!-- Card 4 -->

        <!-- Accordian header start -->

        <div class="panel-group" id="card4" style="display: <%: none%>">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse_card4">Card 4 - Manufacture, bake or process food</a>
                    </h4>
                </div>
                <div id="collapse_card4" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->

                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse_card4a">Card 4A - xxxxxxxxxxxxx</a>
                                    </h4>
                                </div>
                                <div id="collapse_card4a" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <!-- Accordian header end -->

                                        <div class="form-group">
                                            <label class="control-label col-sm-4" for="cb_4.1.1a">xxxxxxxxxxx</label>
                                            <div class="col-sm-8">

                                                <input id="cb_4.1.1a" name="cb_1.1" type="checkbox" />

                                            </div>
                                        </div>
                                        <!-- Accordian footer start -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Accordian footer end -->


                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
            <!-- Accordian footer end -->
        </div>

        <!-- Card 5 -->

        <!-- Accordian header start -->

        <div class="panel-group" id="card5" style="display: <%: none%>">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse_card5">Card 5 - Grow and / or pack fresh fruit or vegetables</a>
                    </h4>
                </div>
                <div id="collapse_card5" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->

                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse_card5a">Card 5A - xxxxxxxxxxxxx</a>
                                    </h4>
                                </div>
                                <div id="collapse_card5a" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <!-- Accordian header end -->

                                        <div class="form-group">
                                            <label class="control-label col-sm-4" for="cb_5.1.1a">xxxxxxxxxxx</label>
                                            <div class="col-sm-8">

                                                <input id="cb_5.1.1a" name="cb_5.1" type="checkbox" />

                                            </div>
                                        </div>
                                        <!-- Accordian footer start -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Accordian footer end -->


                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
            <!-- Accordian footer end -->
        </div>

        <!-- Card 6 -->

        <!-- Accordian header start -->

        <div class="panel-group" id="card6" style="display: <%: none%>">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse_card6">Card 6 - Transport and distribute or warehouse food</a>
                    </h4>
                </div>
                <div id="collapse_card6" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->

                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse_card6a">Card 6A - xxxxxxxxxxxxx</a>
                                    </h4>
                                </div>
                                <div id="collapse_card6a" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <!-- Accordian header end -->

                                        <div class="form-group">
                                            <label class="control-label col-sm-4" for="cb_6.1.1a">xxxxxxxxxxx</label>
                                            <div class="col-sm-8">

                                                <input id="cb_6.1.1a" name="cb_1.1" type="checkbox" />

                                            </div>
                                        </div>
                                        <!-- Accordian footer start -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Accordian footer end -->


                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
            <!-- Accordian footer end -->
        </div>

        <!-- Card 7 -->

        <!-- Accordian header start -->

        <div class="panel-group" id="card7" style="display: <%: none%>">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse_card7">Card 7 - Provides food to pre-school children</a>
                    </h4>
                </div>
                <div id="collapse_card7" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->

                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse_card7a">Card 7A - xxxxxxxxxxxxx</a>
                                    </h4>
                                </div>
                                <div id="collapse_card7a" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <!-- Accordian header end -->

                                        <div class="form-group">
                                            <label class="control-label col-sm-4" for="cb_7.1.1a">xxxxxxxxxxx</label>
                                            <div class="col-sm-8">

                                                <input id="cb_7.1.1a" name="cb_7.1" type="checkbox" />

                                            </div>
                                        </div>
                                        <!-- Accordian footer start -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Accordian footer end -->


                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
            <!-- Accordian footer end -->
        </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
