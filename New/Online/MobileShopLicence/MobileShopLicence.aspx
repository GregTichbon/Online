<%@ Page Title="Mobile Shop Licence Application - Whanganui District Council" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MobileShopLicence.aspx.cs" Inherits="Online.MobileShopLicence.MobileShopLicence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var location_maxline = 0;
        var location_userepeatname = "repeat_location_";

        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "MobileShopLicenceHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                ignore: '.novalidation input',
                rules: {
                    clientsideonly_hf_location: {
                        validate_location: true
                    },
                    tb_charityname: {
                        required: function (element) {
                            return $("#tb_charityreference").val() != "";
                        }
                    },
                    tb_charityreference: {
                        required: function (element) {
                            return $("#tb_charityname").val() != "";
                        }
                    }
                },
                messages: {
                    tb_products: "This field is required.",
                    tb_charityname: "A name is required, when you enter a charities number",
                    tb_charityreference: "A number is required, when you enter a charities name",
                    clientsideonly_hf_location: "Please either specify, whether your application is for the whole of the Whanganui District or specify the actual location(s)."
                },
                errorPlacement: function (error, element) {
                    //alert(error[0].id);
                    var placement = $(element).data('errorplacement');
                    if (placement) {
                        $(placement).append(error)
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            $.validator.addMethod("validate_location", function (value, element) {
                if (value > 0 || $('#dd_district').val() == 'Yes') {
                    return true;
                } else {
                    return false;
                }
            }, "This field is required.");

            datestimes_ctr = 1;
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
                trid = 'tr_datesofuse' + trid.substring(22);
                $('#' + trid).remove();
            });

            vehicle_ctr = 0;
            $('#addvehicle').click(function () {
                var cloned = $('#tr_vehicle_').clone()
                vehicle_ctr++;
                cloned = cloned.repeater_changer(vehicle_ctr);
                var place = $('#table_vehicle tr:last');
                cloned.insertAfter(place);
                return false;
            });

            $('body').on('click', '.deletevehicle', function () {
                trid = this.id;
                trid = 'tr_vehicle_' + trid.substring(20);
                $('#' + trid).remove();
            });

            $('body').on('keypress', '.vehicleregistration', function (event) {
                if (null !== String.fromCharCode(event.which).match(/[a-zA-Z0-9 ]/g) || '08'.indexOf(event.which) !== -1) {
                    if (null !== String.fromCharCode(event.which).match(/[a-z]/g)) {
                        event.preventDefault();
                        $(this).val($(this).val() + String.fromCharCode(event.which).toUpperCase());
                    }
                } else {
                    event.preventDefault();
                }
            });

            otherpremises_ctr = 0;
            $('#addotherpremises').click(function () {
                var cloned = $('#tr_otherpremises_').clone()
                otherpremises_ctr++;
                cloned = cloned.repeater_changer(otherpremises_ctr);
                var place = $('#table_otherpremises tr:last');
                cloned.insertAfter(place);
                return false;
            });

            $('body').on('click', '.deleteotherpremises', function () {
                trid = this.id;
                trid = 'tr_otherpremises_' + trid.substring(26);
                $('#' + trid).remove();
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
          <asp:FileUpload ID="fu_dummy" runat="server" style="display:none" /> <!--Forces form to be rendered with enctype="multipart/form-data" -->

    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Mobile Shop Licence Application
    </h1>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_businessname">Name of Business:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_businessname" name="tb_businessname" class="form-control" maxlength="100" value="<%: tb_businessname %>" required />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_district">Do you intend to operate within the whole of the Whanganui District?
            <img src="../Images/questionsmall.png" title="If you intend to operate within the whole of the Whanganui District, you must still obtain permission from the property/premise owner(s) you intend to operate outside of." /></label>
        <div class="col-sm-1">
            <select id="dd_district" name="dd_district" class="form-control" required>
                    <option></option>
                    <%= Online.WDCFunctions.WDCFunctions.populateselect(yesno_values, "","None") %>
                </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Specific
            Location(s)
            <img src="../Images/questionsmall.png" title="Location(s) must be specified if you are not intending to operate within the whole of the Whanganui District.  If you are intending to operate within the whole of the Whanganui District and intend to operate at specific locations please also add them here." /><br />
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
        <label class="control-label col-sm-4" for="xxxxx">
            Other properties / premises<br />
            <a href="javascript:void(0);" id="addotherpremises">Add</a>
        </label>
        <div class="table-responsive table-bordered">
            <table class="table" id="table_otherpremises">
                <thead>
                    <tr>
                        <th class="col-md-2">Business</th>
                        <th class="col-md-2">Owner(s)</th>
                       <th class="col-md-2">Phone Number(s)</th>
                       <th class="col-md-1">Permission obtained</th>
                        <th class="col-md-1">Delete</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_datetype">Is this an application for specific dates only or for the whole year:</label>
        <div class="col-sm-8">
            <select id="dd_datetype" name="dd_datetype" class="form-control" required>
                <option></option>
                <option>Specific dates only</option>
                <option>The whole year</option>
            </select>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">
            Date(s) of use
            <img src="../Images/questionsmall.png" title="Specify the specific date, a range of dates, or describe it in some other way: eg: Every second Saturday between 3 July and 17 August 2015" />
            <a href="javascript:void(0);" class="adddatesofuse" id="adddatesofuse">Add</a>
        </label>
        <div class="col-sm-8">
            <div class="table-responsive table-bordered">
                <table class="table" id="table_datesofuse">
                    <thead>
                        <tr>
                            <th class="col-md-2">Date(s) of use</th>
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
        <label class="control-label col-sm-4" for="tb_products">Source and range of products
            <img src="../Images/questionsmall.png" title="Describe where you sourced your goods from e.g. Pak n Save, Mad Butchers, Mr Chips, my garden etc. and the range of product you will sell e.g. Hamburgers, Hot Chips, Sandwiches, Potatoes, Pumpkin, Stone fired pizzas, etc. Give as much detail as possible." /></label>
        <div class="col-sm-8">
            <textarea id="tb_products" name="tb_products" class="form-control" maxlength="200" rows="3" required><%: tb_products %></textarea>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Vehicle registration number(s) and description(s)<br />
            <a href="javascript:void(0);" id="addvehicle">Add</a>
        </label>
        <div class="table-responsive table-bordered">
            <table class="table" id="table_vehicle">
                <thead>
                    <tr>
                        <th class="col-md-2">Registration</th>
                        <th class="col-md-2">Description</th>
                        <th class="col-md-1">Delete</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charityname">Charities Name
            <img src="../Images/questionsmall.png" title="Provide a valid charity name that is registered with Charities Service (www.charities.govt.nz)." /></label>
        <div class="col-sm-8">
            <input type="text" id="tb_charityname" name="tb_charityname" class="form-control" maxlength="100" value="<%: tb_charityname %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charityreference">Charities Number
            <img src="../Images/questionsmall.png" title="Providing a valid charity number may entitle your charity to be exempt from paying an application fee." /></label>
        <div class="col-sm-8">
            <input type="text" id="tb_charityreference" name="tb_charityreference" class="form-control" maxlength="20" value="<%: tb_charityreference %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_othercouncil">If you hold either; a current food premise registration with another Teritorial Authority, or MAF registration, please upload a copy of your certificate:</label>
            <input id="fu_othercouncil" name="fu_othercouncil" type="file" multiple="multiple" />
            <asp:Label ID="lbl_othercouncil" runat="server" Text=""></asp:Label>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_otherinformation">Other relevant information
            <img src="../Images/questionsmall.png" title="Provide additional information such as e.g. Vintage Weekend, Festival of Cultures, Fundraising for Relay for Life etc." /></label>
        <div class="col-sm-8">
            <textarea id="tb_otherinformation" class="form-control" name="tb_otherinformation" maxlength="500" rows="3"><%: tb_otherinformation %></textarea>
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

    <div style="display: <%:none%>" class="novalidation">
        <table>
            <tr id="tr_datesofuse_" class="repeatupdateid">
                <td>
                    <input id="repeat_datesofuse_tb_datesofuse_" type="text" class="form-control" required /></td>
                <td><a href="javascript:void(0)" id="href_datesofuse_delete_" class="deletedatesofuse repeatupdateid">Delete</a></td>
            </tr>
        </table>

        <table>
            <tr id="tr_vehicle_" class="repeatupdateid">
                <td>
                    <input id="repeat_vehicle_tb_vehicleregistration_" type="text" class="form-control vehicleregistration" maxlength="6" required /></td>
                <td>
                    <input id="repeat_vehicle_tb_vehicledescription_" type="text" class="form-control" required /></td>

                <td><a href="javascript:void(0)" id="href_vehicle_delete_" class="deletevehicle repeatupdateid">Delete</a></td>
            </tr>
        </table>

        <table>
             <tr id="tr_otherpremises_" class="repeatupdateid">
               <td>
                    <input id="repeat_otherpremises_tb_otherpremises_business_" type="text" class="form-control" required />
                </td>
                <td>
                    <input id="repeat_otherpremises_tb_otherpremises_owners_" type="text" class="form-control" required />
                </td>
                <td>
                    <input id="repeat_otherpremises_tb_otherpremises_phone_" type="text" class="form-control" required /></td>
                <td>
                    <input id="repeat_otherpremises_cb_otherpremises_permission_" type="checkbox" value="Yes" required /></td>
                <td><a href="javascript:void(0)" id="href_otherpremises_delete_" class="deleteotherpremises repeatupdateid">Delete</a></td>
            </tr>
        </table>

        <!-- END OF REPEATER SECTION -->
    </div>

</asp:Content>
