<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MarketFoodStallLicence.aspx.cs" Inherits="Online.MarketFoodStallLicence.MarketFoodStallLicence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var location_maxline = 0;
        var location_userepeatname = "repeat_location_";

        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "MarketFoodStallLicenceHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


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

            location_maxline = $("#table_location tr").length;

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
                location_maxline = location_maxline + 1;

                input = '<input readonly="readonly" type="text" id="' + location_userepeatname + 'tb_location_' + location_maxline + '" name="' + location_userepeatname + 'tb_location_' + location_maxline + '" class="form_control col-sm-8" value="' + location + '" />';
                input = input + '<input id="' + location_userepeatname + 'hf_locationcoords_' + location_maxline + '" name="' + location_userepeatname + 'hf_locationcoords_' + location_maxline + '" type="hidden" value="' + coords + '" />';
                input = input + ' <a class="action_location" data-line="' + location_maxline + '">Edit</a> <a class="action_location" data-line="' + location_maxline + '">Delete</a>';

                $('#table_location tr:last').after('<tr data-line="' + location_maxline + '"><td>' + input + '</td></tr>');
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
    <h1>Market Food Stall Licence
    </h1>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label><div class="col-sm-8">
            <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
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
        <label class="control-label col-sm-4" for="dd_fundraiser">Is this a fundraiser?  If so what type of organisation are you?</label><div class="col-sm-8">

            <select id="dd_fundraiser" name="dd_fundraiser" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(dd_fundraiser_values, dd_fundraiser, "None")%>
            </select>

        </div>
    </div>

    <div class="form-group" id="div_charityreference" style="display: <%:none%>">
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
                                <input id="repeat_datesofuse_tb_datesofuse_1" name="repeat_datesofuse_tb_datesofuse_1" type="text" class="form-control" required />
                            </td>
                            <td>Required</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_products">Source and range of products</label><div class="col-sm-8">
            <textarea id="tb_products" name="tb_products" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="othercouncil">If you have registered with another Teritorial Authority, please upload a copy of your certificate</label><div class="col-sm-8">
            <!--<asp:FileUpload ID="fu_othercouncil" runat="server" />-->
            <input id="fu_othercouncil" name="fu_othercouncil" type="file" />
            <asp:Label ID="lbl_othercouncil" runat="server" Text=""></asp:Label>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="MAF">If you have registered with MAF please upload a copy of your certificate</label><div class="col-sm-8">
            <!-- <asp:FileUpload ID="fu_MAF" runat="server" AllowMultiple="False" />-->
            <input id="fu_MAF" name="fu_MAF" type="file" />
            <asp:Label ID="lbl_MAF" runat="server" Text=""></asp:Label>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_fooddetails">Please provide details of food to be supplied</label><div class="col-sm-8">
            <textarea id="tb_fooddetails" name="tb_fooddetails" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_purchasedfrom">Where will ingredients / food be purchase from?</label><div class="col-sm-8">
            <textarea id="tb_purchasedfrom" name="tb_purchasedfrom" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_water">What water will be available in the stall?</label><div class="col-sm-8">
            <textarea id="tb_water" name="tb_water" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_handwashing">What facilities will be available for handwashing?</label><div class="col-sm-8">
            <textarea id="tb_handwashing" name="tb_handwashing" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_utensilwashing">What facilities will be available for washing food utensils / equipment?</label><div class="col-sm-8">
            <textarea id="tb_utensilwashing" name="tb_utensilwashing" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_rubbish">What rubbish and waste-water disposal facilities will be available?</label><div class="col-sm-8">
            <textarea id="tb_rubbish" name="tb_rubbish" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_firstaid">What first aid equipment is available at the stall (or elsewhere at the site)?</label><div class="col-sm-8">
            <textarea id="tb_firstaid" name="tb_firstaid" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_cooler">How will you ensure cold food is kept cold (1 - 4&deg;C)?</label><div class="col-sm-8">
            <textarea id="tb_cooler" name="tb_cooler" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_warmer">How will you ensure hot food is kept hot (above 60&deg;C)?</label><div class="col-sm-8">
            <textarea id="tb_warmer" name="tb_warmer" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_cookedreheated">How will you ensure high risk food is cooked or reheated adequately (&gt; 75&deg;C)?</label><div class="col-sm-8">
            <textarea id="tb_cookedreheated" name="tb_cookedreheated" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_transported">How will food be transported to the site?</label><div class="col-sm-8">
            <textarea id="tb_transported" name="tb_transported" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_onsitepreperation">What food preperation will be done on site?</label><div class="col-sm-8">
            <textarea id="tb_onsitepreperation" name="tb_onsitepreperation" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_preperationsites">Will food be prepared anywhere else?</label><div class="col-sm-8">
            <textarea id="tb_preperationsites" name="tb_preperationsites" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_storage">How will food be stored at the site?</label><div class="col-sm-8">
            <textarea id="tb_storage" name="tb_storage" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_rawreadytoeat">How will raw and ready to eat food be kept separate?</label><div class="col-sm-8">
            <textarea id="tb_rawreadytoeat" name="tb_rawreadytoeat" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_protectiveclothing">What protective clothing will food handlers be wearing?</label><div class="col-sm-8">
            <textarea id="tb_protectiveclothing" name="tb_protectiveclothing" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_otherinformation">Other relevant information</label><div class="col-sm-8">
            <textarea id="tb_otherinformation" name="tb_otherinformation" class="form-control autoaddress" rows="4" maxlength="500" required></textarea>
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
                    <input id="repeat_datesofuse_tb_datesofuse_" type="text" class="form-control datetime" /></td>
                <td><a href="javascript:void(0)" id="href_delete_" class="deletedatesofuse repeatupdateid">Delete</a></td>
            </tr>
        </table>
        <!-- END OF REPEATER SECTION -->
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
