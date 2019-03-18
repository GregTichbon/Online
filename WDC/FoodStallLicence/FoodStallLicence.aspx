<%@ Page Title="Food Stall Licence Application" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FoodStallLicence.aspx.cs" Inherits="Online.FoodStallLicence.FoodStallLicence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* http://css3buttongenerator.com/ */
        .suggestion {
            background: #3498db;
            background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
            background-image: -moz-linear-gradient(top, #3498db, #2980b9);
            background-image: -ms-linear-gradient(top, #3498db, #2980b9);
            background-image: -o-linear-gradient(top, #3498db, #2980b9);
            background-image: linear-gradient(to bottom, #3498db, #2980b9);
            -webkit-border-radius: 28;
            -moz-border-radius: 28;
            border-radius: 28px;
            color: #ffffff;
            font-size: 12px;
            padding: 5px 10px 5px 10px;
            text-decoration: none;
        }

            .suggestion:hover {
                background: #3cb0fd;
                background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
                background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
                background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
                background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
                background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
                text-decoration: none;
            }
    </style>
    <script type="text/javascript">
        var locations_maxline = 0;
        var location_userepeatname = "repeat_locations_";

        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "FoodStallLicenceHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            validator = $("#form1").validate({
                ignore: []
            });

            datestimes_ctr = 1;

            //getting this code from wmc\bookingenquiry.aspx
            $('.adddatesofuse').click(function () {
                var cloned = $('#tr_datesofuse_').clone()
                datestimes_ctr++;
                cloned = cloned.repeater_changer(datestimes_ctr);
                var place = $('#table_datesofuse tr:last');
                cloned.insertAfter(place);
                return false;
            });

            $('body').on('click', '.deletedatesofuse', function () {
                trid = this.id;
                trid = 'tr_datesofuse' + trid.substring(11);
                //alert(trid);
                $('#' + trid).remove();
            });

            $('#dd_fundraiser').change(function () {
                fundraiser = $(this).val();
                org = $('#dd_registered').val();
                if (fundraiser == 'Charitable organisation' || fundraiser == 'Community group' || org == 'Whanganui District Council' || org == 'Another territorial authority' || org == 'MPI') {
                    $('#div_notregistered').hide();
                } else {
                    $('#div_notregistered').show();
                }

                if (fundraiser == 'Charitable organisation' || fundraiser == 'Community group') {
                    $('#div_fundraiser').show();
                } else {
                    $('#div_fundraiser').hide();
                }

                if ($(this).val() == 'Charitable organisation') {
                    $("#tb_charityreference").rules("add", "required")
                    $("#tb_charityreference").toggleClass('required');
                    $('#div_charityreference').show();
                } else {
                    $("#tb_charityreference").rules("remove", "required")
                    $("#tb_charityreference").toggleClass('required');
                    $('#div_charityreference').hide();
                }
            });

            $('#dd_registered').change(function () {
                fundraiser = $(this).val();
                org = $('#dd_registered').val();
                if (fundraiser == 'Charitable organisation' || fundraiser == 'Community group' || org == 'Whanganui District Council' || org == 'Another territorial authority' || org == 'MPI') {
                    $('#div_notregistered').hide();
                } else {
                    $('#div_notregistered').show();
                }
                switch (org) {
                    case "Whanganui District Council":
                        $('#div_anotherterritory').hide();
                        $('#div_mpi').hide();
                        $('#div_wgn').show();
                        break;
                    case "Another territorial authority":
                        $('#div_mpi').hide();
                        $('#div_wgn').hide();
                        $('#div_anotherterritory').show();
                        break;
                    case "MPI":
                        $('#div_wgn').hide();
                        $('#div_anotherterritory').hide();
                        $('#div_mpi').show();
                        break;
                    case "Not registered":
                        $('#div_wgn').hide();
                        $('#div_anotherterritory').hide();
                        $('#div_mpi').hide();
                        break;
                }

            });

            $('#dd_prepackaged').change(function () {
                if ($(this).val() == 'Yes') {
                    $('#div_notprepackaged').hide();
                }
                else {
                    $('#div_notprepackaged').show();
                }
            });

            $('.suggestion').click(function () {
                //alert($(this).text());
                //alert($(this).next('.form-control').prop('id'));
                //x = $(this).find('.form-control').val();
                //x = $(".quantity:first").val('xxxxx');
                //console.log(x);
                $(this).closest('div').find('.form-control').insertAtCaret($(this).text());


                // $(this).next('.form-control').insertAtCaret($(this).text());
            })

            $('.suggestionhelp').each(function (index) {
                $(this).attr('title', 'Please provide a detailed answer to this question.  Click on the suggested items to include in your detail.');
            });




            $.fn.extend({
                insertAtCaret: function (myValue) {
                    return this.each(function (i) {
                        myValue = ' ' + myValue + ' ';
                        if (document.selection) {
                            //For browsers like Internet Explorer
                            this.focus();
                            var sel = document.selection.createRange();
                            sel.text = myValue;
                            this.focus();
                        }
                        else if (this.selectionStart || this.selectionStart == '0') {
                            //For browsers like Firefox and Webkit based
                            var startPos = this.selectionStart;
                            var endPos = this.selectionEnd;
                            var scrollTop = this.scrollTop;
                            this.value = this.value.substring(0, startPos) + myValue + this.value.substring(endPos, this.value.length);
                            this.focus();
                            this.selectionStart = startPos + myValue.length;
                            this.selectionEnd = startPos + myValue.length;
                            this.scrollTop = scrollTop;
                        } else {
                            this.value += myValue;
                            this.focus();
                        }
                    });
                }
            });


            locations_maxline = $("#table_location tr").length;

            $('body').on('click', '.action_location', function () {
                //$(".action_location").click(function () {   //The line above means dynamically created html will automatically have events attached :-)
                var action = $(this).text();
                var item_count = parseInt($('#clientsideonly_hf_location').val());
                if (action == "Delete") {
                    line = $(this).attr("data-line");
                    $('#table_location tr[data-line="' + line + '"]').remove();
                    $('#clientsideonly_hf_location').val(item_count - 1);
                } else {
                    if (action == 'Add') {
                        line = 0;
                        qs = "";
                        $('#clientsideonly_hf_location').val(item_count + 1);
                    } else {
                        //Edit
                        line = $(this).attr("data-line");
                        qs = "&p=" + $("input[id$='" + location_userepeatname + "hf_locationcoords_" + line + "']").val() + "&location=" + $("input[id$='" + location_userepeatname + "tb_location_" + line + "']").val();
                    }
                    $.colorbox({ href: "../mapping/GetLocation.aspx?line=" + line + qs, iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
                }
                $("#form1").validate().element("#clientsideonly_hf_location");
            });

        });

        function passlocation(line, location, coords) {
            $.colorbox.close();
            if (line == 0) {
                locations_maxline = locations_maxline + 1;
                input = '<input readonly="readonly" style="width:80%" type="text" id="' + location_userepeatname + 'tb_location_' + locations_maxline + '" name="' + location_userepeatname + 'tb_location_' + locations_maxline + '" class="form_control col-sm-8" value="' + location + '" />';
                input = input + '<input id="' + location_userepeatname + 'hf_locationcoords_' + locations_maxline + '" name="' + location_userepeatname + 'hf_locationcoords_' + locations_maxline + '" type="hidden" value="' + coords + '" />';
                input = input + '&nbsp;<a class="action_location" data-line="' + locations_maxline + '">Edit</a>&nbsp;<a class="action_location" data-line="' + locations_maxline + '">Delete</a>';
                $('#table_location tr:last').after('<tr data-line="' + locations_maxline + '"><td>' + input + '</td></tr>');
            } else {
                $("input[id$='" + location_userepeatname + "tb_location_" + line + "']").val(location);
                $("input[id$='" + location_userepeatname + "hf_locationcoords_" + line + "']").val(coords);
            }
        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FileUpload ID="fu_dummy" runat="server" Style="display: none" />
    <!--Forces form to be rendered with enctype="multipart/form-data" -->
    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <asp:Literal ID="lit_user" runat="server"></asp:Literal>
    <h1>Food Stall Licence
    </h1>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label><div class="col-sm-8">
            <input id="tb_reference" name="tb_reference" type="text" ReadOnly="readonly" value="<%:tb_reference %>"/>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_organisationname">Name of Business / Organisation</label>
        <div class="col-sm-8">
            <input id="tb_organisationname" name="tb_organisationname" type="text" class="form-control" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Specific
            Location(s)
            <br />
            <a class="action_location">Add</a>
        </label>
        <div class="col-sm-8">
            <input id="clientsideonly_hf_location" name="clientsideonly_hf_location" type="hidden" value="0" />
            <table id="table_location" style="width: 100%;">
                <tr style="display: <%: none%>">
                    <td></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_privateland">If the location(s) specified are on private land, has permission been granted to you or the organisation hosting the event?</label>
        <div class="col-sm-8">
            <select id="dd_privateland" name="dd_privateland" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(yesna_values, dd_privateland, "None")%>
            </select>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_councilland">If the location(s) specified are on council land, has an application for "Use of Parks or Open Spaces" been made by you or the organisation hosting the event?</label>
        <div class="col-sm-8">
            <select id="dd_councilland" name="dd_councilland" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(yesna_values, dd_councilland, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_fundraiser">Is this a fundraiser?  If so what type of organisation are you?</label><div class="col-sm-8">

            <select id="dd_fundraiser" name="dd_fundraiser" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(dd_fundraiser_values, dd_fundraiser, "None")%>
            </select>

        </div>
    </div>

    <div class="panel panel-danger" id="div_fundraiser" style="display: none">
        <div class="panel-heading">Food Hygiene</div>
        <div class="panel-body">
            <p>
                A community group may run up to 20 fundraisers per year. 
            </p>
            <p>
                Fundraisers are not required to provide all the detailed information for an application but we would encourage you to visit the Ministry for Primary Industries website at <a href="http://www.mpi.govt.nz" target="_blank">www.mpi.govt.nz</a> to ensure you are providing food in the safest manner possible.
            </p>
            <p>The information on <a href="http://www.mpi.govt.nz/dmsdocument/3714-hot-tips-for-a-safe-and-successful-sausage-sizzle" target="_blank">Sausage sizzles</a>     and <a href="http://www.mpi.govt.nz/dmsdocument/3721-food-safety-tips-for-selling-food-at-occasional-events" target="_blank">Selling food at occasional events</a> maybe particularly useful. </p>
        </div>
    </div>

    <div class="form-group dependantdisplay" id="div_charityreference" style="display: <%:none%>">
        <label class="control-label col-sm-4" for="tb_products">Charity reference</label><div class="col-sm-8">
            <input id="tb_charityreference" name="tb_charityreference" type="text" class="form-control" maxlength="20" />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_fullyear">Is this an application for specific dates only or for the whole year?</label><div class="col-sm-8">

            <select id="dd_fullyear" name="dd_fullyear" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(dd_fullyear_values, dd_fullyear, "None")%>
            </select>

        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">Date(s) and time(s) of use</label>
        <div class="col-sm-8">


            <a href="javascript:void(0);" class="adddatesofuse" id="adddatesofuse">Add</a>
            <div class="table-responsive table-bordered">

                <table class="table" id="table_datesofuse">
                    <thead>
                        <tr>
                            <th class="col-md-2">Date(s) and Time(s) of use</th>
                            <th class="col-md-1">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <input id="repeat_datesofuse_tb_dateofuse_1" name="repeat_datesofuse_tb_dateofuse_1" type="text" class="form-control" required />
                            </td>
                            <td>Required</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_registered">What food business registration do you hold?</label><div class="col-sm-8">

            <select id="dd_registered" name="dd_registered" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(dd_registered_values, dd_registered, "None")%>
            </select>

        </div>
    </div>





    <div class="form-group dependantdisplay" id="div_wgn" style="display: none">
        <label class="control-label col-sm-4" for="tb_wgn">
            Please enter your "WGN" number
            <img src="../Images/questionsmall.png" title="This number is on the Notice of Registration under Registration details." /></label>
        <div class="col-sm-8">
            <input id="tb_wgn" name="tb_wgn" type="text" class="form-control" required />
        </div>
    </div>





    <div class="form-group dependantdisplay" id="div_anotherterritory" style="display: none">
        <label class="control-label col-sm-4" for="othercouncil">Please upload a copy of your current certificate</label><div class="col-sm-8">
            <!--<asp:FileUpload ID="fu_othercouncil" runat="server" />-->
            <input id="fu_othercouncil" name="fu_othercouncil" type="file" />
            <asp:Label ID="lbl_othercouncil" runat="server" Text=""></asp:Label>
        </div>
    </div>




    <div class="form-group dependantdisplay" id="div_mpi" style="display: none">
        <label class="control-label col-sm-4" for="mpi">Please upload a copy of your current MPI certificate</label><div class="col-sm-8">
            <!-- <asp:FileUpload ID="fu_mpi" runat="server" AllowMultiple="False" />-->
            <input id="fu_mpi" name="fu_mpi" type="file" />
            <asp:Label ID="lbl_mpi" runat="server" Text=""></asp:Label>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_fooddetails">Please provide details of food to be supplied</label><div class="col-sm-8">
            <textarea id="tb_fooddetails" name="tb_fooddetails" class="form-control" rows="4" maxlength="500" required></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_handwashing">What facilities will be available for handwashing?</label><div class="col-sm-8">
            <p>
                <img src="../Images/questionsmall.png" class="suggestionhelp" />
                Suggestions: <span class="suggestion">Portable water container with a tap</span> <span class="suggestion">Available on site</span></p>
            <textarea id="tb_handwashing" name="tb_handwashing" class="form-control" rows="4" maxlength="500" required></textarea>
        </div>
    </div>

    <div id="div_notregistered" class="dependantdisplay" style="display: none">
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_cooler">How will you ensure chilled food is kept cold (Under 5&deg;C)?</label>
            <div class="col-sm-8">
                <p>
                    <img src="../Images/questionsmall.png" class="suggestionhelp" />
                    Suggestions: <span class="suggestion">Refrigerator</span> <span class="suggestion">Chilly bin(s) with ice packs</span></p>
                <textarea id="tb_cooler" name="tb_cooler" class="form-control" rows="4" maxlength="500" required></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_warmer">How will you ensure hot food is kept hot (above 60&deg;C)?</label><div class="col-sm-8">
                <p>
                    <img src="../Images/questionsmall.png" class="suggestionhelp" />
                    Suggestions: <span class="suggestion">Pan/Pot</span> <span class="suggestion">Oven</span> <span class="suggestion">Pie warmer</span></p>
                <textarea id="tb_warmer" name="tb_warmer" class="form-control" rows="4" maxlength="500" required></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_cookedreheated">How will you ensure high risk food is cooked or reheated adequately (&gt; 75&deg;C)?</label><div class="col-sm-8">
                <p>
                    <img src="../Images/questionsmall.png" class="suggestionhelp" />
                    Suggestions: <span class="suggestion">Microwave</span> <span class="suggestion">Deep fryer</span> <span class="suggestion">Pan/Pot</span> <span class="suggestion">Oven</span></p>
                <textarea id="tb_cookedreheated" name="tb_cookedreheated" class="form-control" rows="4" maxlength="500" required></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_rawreadytoeat">How will raw and ready to eat food be kept separate?</label><div class="col-sm-8">
                <p>
                    <img src="../Images/questionsmall.png" class="suggestionhelp" />
                    Suggestions: <span class="suggestion">Seperate storage containers</span> <span class="suggestion">Seperate areas</span></p>
                <textarea id="tb_rawreadytoeat" name="tb_rawreadytoeat" class="form-control" rows="4" maxlength="500" required></textarea>
            </div>
        </div>

                <div class="form-group">
            <label class="control-label col-sm-4" for="dd_allergens">Do you know what ingredients are in the food being sold?<img src="../Images/questionsmall.png" title="This is important for people with allergies ....." /></label>
            <div class="col-sm-8">
                <select id="dd_allergens" name="dd_allergens" class="form-control" required>
                    <option></option>
                    <%=Online.WDCFunctions.WDCFunctions.populateselect(yesno_values, dd_allergens, "None")%>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_prepackaged">
                Will all food provided be sold in a pre-packages/wrapped form?
                <img src="../Images/questionsmall.png" title="Pre-packaged/Wrapped means ....." /></label>
            <div class="col-sm-8">
                <select id="dd_prepackaged" name="dd_prepackaged" class="form-control" required>
                    <option></option>
                    <%=Online.WDCFunctions.WDCFunctions.populateselect(yesno_values, dd_prepackaged, "None")%>
                </select>
            </div>
        </div>



        



        <!--            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_purchasedfrom">Where will ingredients / food be purchase from?</label>
                <div class="col-sm-8">
                    <textarea id="tb_purchasedfrom" name="tb_purchasedfrom" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>




            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_transported">How will food be transported to the site?</label><div class="col-sm-8">
                    <textarea id="tb_transported" name="tb_transported" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_onsitepreperation">What food preperation will be done on site?</label>
                <div class="col-sm-8">
                    <textarea id="tb_onsitepreperation" name="tb_onsitepreperation" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_preperationsites">Will food be prepared anywhere else?</label>
                <div class="col-sm-8">
                    <textarea id="tb_preperationsites" name="tb_preperationsites" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>

                    <div class="form-group">
            <label class="control-label col-sm-4" for="tb_storage">How will food be stored at the site?</label>
            <div class="col-sm-8">
                <textarea id="tb_storage" name="tb_storage" class="form-control" rows="4" maxlength="500" required></textarea>
            </div>
        </div>
            -->


        <div id="div_notprepackaged" class="dependantdisplay" style="display: none">

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_water">How will running water be provided for hand washing?</label><div class="col-sm-8">
                    <p>
                        <img src="../Images/questionsmall.png" class="suggestionhelp" />
                        Suggestions: <span class="suggestion">Portable water container with tap</span> <span class="suggestion">Avaialable on-site</span></p>
                    <textarea id="tb_water" name="tb_water" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_pumpsoap">Please confirm that pump soap will be available</label>
                <div class="col-sm-8">
                    <select id="dd_pumpsoap" name="dd_pumpsoap" class="form-control" required>
                        <option></option>
                        <%=Online.WDCFunctions.WDCFunctions.populateselect(yes_values, dd_pumpsoap, "None")%>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_handdrying">What will you provide to dry hands with?</label><div class="col-sm-8">
                    <p>
                        <img src="../Images/questionsmall.png" class="suggestionhelp" />
                        Suggestions: <span class="suggestion">Single use paper towels</span> <span class="suggestion">Single use cloth towels</span></p>
                    <textarea id="tb_handdrying" name="tb_handdrying" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_firstaid">What first aid equipment is available at the stall (or elsewhere at the site)?</label>
                <div class="col-sm-8">
                    <p>
                        <img src="../Images/questionsmall.png" class="suggestionhelp" />
                        Suggestions: <span class="suggestion">Plasters and gloves</span> <span class="suggestion">Full first aid kit containing plasters and gloves</span></p>
                    <textarea id="tb_firstaid" name="tb_firstaid" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>


            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_protectiveclothing">What protective clothing will food handlers wear?</label>
                <div class="col-sm-8">
                    <p>
                        <img src="../Images/questionsmall.png" class="suggestionhelp" />
                        Suggestions: <span class="suggestion">Aprons</span> <span class="suggestion">Hat or hair restraint</span> <span class="suggestion">Gloves</span></p>
                    <textarea id="tb_protectiveclothing" name="tb_protectiveclothing" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>




            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_utensilwashing">What facilities will be available to wash utensils and equipment?</label>
                <div class="col-sm-8">
                    <p>
                        <img src="../Images/questionsmall.png" class="suggestionhelp" />
                        Suggestions: <span class="suggestion">Available on site</span> <span class="suggestion">Taken off site</span> <span class="suggestion">Equipment brought to site: ____________</span></p>

                    <textarea id="tb_utensilwashing" name="tb_utensilwashing" class="form-control" rows="4" maxlength="500" required></textarea>
                </div>
            </div>


        </div>
        <!--id="div_notprepackaged"-->

    </div>
    <div class="form-group">
            <label class="control-label col-sm-4" for="tb_rubbish">What rubbish and waste-water disposal facilities will be available?</label><div class="col-sm-8">
                <p>
                    <img src="../Images/questionsmall.png" class="suggestionhelp" />
                    Suggestions: <span class="suggestion">Removed from site</span> <span class="suggestion">On-site</span></p>
                <textarea id="tb_rubbish" name="tb_rubbish" class="form-control" rows="4" maxlength="500" required></textarea>
            </div>
        </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_generalinformation">
            General information
            <img src="../Images/questionsmall.png" title="Please let us know any other information that the Council should consider in this application." /></label><div class="col-sm-8">
                <textarea id="tb_generalinformation" name="tb_generalinformation" class="form-control" rows="4" maxlength="500" required></textarea>
            </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_sick">Please confirm that you are aware that nobody that has had vomiting or diarrhoea upto 48 hours prior to the event will help with food</label>
        <div class="col-sm-8">
            <select id="dd_sick" name="dd_sick" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(yes_values, dd_sick, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_confirm">Please confirm that you will take all necessary steps to ensure safe food</label><div class="col-sm-8">
            <select id="dd_confirm" name="dd_confirm" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(yes_values, dd_confirm, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>

    <!-- REPEATER SECTION-->

    <div style="display: <%:none%>">
        <table>
            <tr id="tr_datesofuse_">
                <td>
                    <input id="repeat_datesofuse_tb_dateofuse_" type="text" class="form-control datetime" /></td>
                <td><a href="javascript:void(0)" id="href_delete_" class="deletedatesofuse repeatupdateid">Delete</a></td>
            </tr>
        </table>
        <!-- END OF REPEATER SECTION -->
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
