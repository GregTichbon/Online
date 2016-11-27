<%@ Page Title="Mobile Shop Licence Application - Whanganui District Council" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MobileShopLicence_13Sep2016.aspx.cs" Inherits="Online.MobileShopLicence.MobileShopLicence_13Sep2016" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var location_maxline = 0;
        var datesofuse_maxline = 0;
        var otherpremises_maxline = 0;

        $(document).ready(function () {
 
            $("#pagehelp").colorbox({ href: "MobileShopLicenceHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                ignore: [],
                rules: {
                    hidden_location: {
                        required: '#cb_district:unchecked',
                        items_exist: true
                    },
                    hidden_datesofuse: {
                        items_exist: true
                    },
                    hidden_vehicles: {
                        items_exist: true
                    },
                    tb_charityname: {
                        required: function (element) {
                            return $("#tb_charityreference").val() != "";
                        }
                    },
                    tb_charityreference: {
                        required: function(element) {
                            return $("#tb_charityname").val() != "";
                        }
                    }
                },
                messages: {
                    tb_products: "This field is required.",
                    tb_charityname: "A name is required, when you enter a charities number",
                    tb_charityreference: "A number is required, when you enter a charities name",
                    hidden_location: "Please either specify, whether your application is for the whole of the Whanganui District or specify the actual location(s)."
                },
                errorPlacement: function (error, element) {
                    var placement = $(element).data('errorplacement');
                    if (placement) {
                        $(placement).append(error)
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            $.validator.addMethod("items_exist", function (value, element) {
                if (value > 0) {
                    return true;
                } else {
                    return false;
                }
            }, "This field is required.");


            location_maxline = $("#table_location tr").length;
            datesofuse_maxline = $("#table_datesofuse tr").length;
            vehicles_maxline = $("#table_vehicles tr").length;
            vehicle_editline = 0;
            otherpremises_maxline = $("#table_otherpremises tr").length;
            otherpremises_editline = 0;


            $('body').on('click', '.action_location', function () {
                //$(".action_location").click(function () {   //The line above means dynamically created html will automatically have events attached :-)
                var action = $(this).text();
                var item_count = parseInt($('#hidden_location').val());
                if (action == "Delete") {
                    line = $(this).attr("data-line");
                    $('#table_location tr[data-line="' + line + '"]').remove();
                    $('#hidden_location').val(item_count - 1);
                } else {
                    if (action == 'Add') {
                        line = 0;
                        qs = "";
                        $('#hidden_location').val(item_count + 1);
                    } else {
                        //Edit
                        line = $(this).attr("data-line");
                        qs = "&p=" + $("input[id$='hf_locationcoords_" + line + "']").val() + "&location=" + $("input[id$='tb_location_" + line + "']").val();
                    }
                    $.colorbox({ href: "../mapping/GetLocation.aspx?line=" + line + qs, iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
                }
                $("#form1").validate().element("#hidden_location");
            });

            $('body').on('click', '.action_datesofuse', function () {
                var action = $(this).text();
                var item_count = parseInt($('#hidden_datesofuse').val());
                if (action == 'Add') {
                    datesofuse_maxline = datesofuse_maxline + 1;
                    input = '<input type="text" id="tb_datesofuse_' + datesofuse_maxline + '" name="tb_datesofuse_' + datesofuse_maxline + '" class="form_control col-sm-8" value="" /> ';
                    input = input + '<a class="action_datesofuse" data-line="' + datesofuse_maxline + '">Delete</a></td>';
                    $('#table_datesofuse tr:last').after('<tr data-line="' + datesofuse_maxline + '"><td>' + input + '</td></tr>');
                    $('#hidden_datesofuse').val(item_count + 1);
                } else if (action == 'Delete') {
                    line = $(this).attr("data-line");
                    $('#table_datesofuse tr[data-line="' + line + '"]').remove();
                    $('#hidden_datesofuse').val(item_count - 1);
                }
                $("#form1").validate().element("#hidden_datesofuse");
            });

            $('body').on('click', '.action_vehicles', function () {
                var action = $(this).text();
                var item_count = parseInt($('#hidden_vehicles').val());
                if (action == "Delete") {
                    line = $(this).attr("data-line");
                    $('#table_vehicles tr[data-line="' + line + '"]').remove();
                    $('#hidden_vehicles').val(item_count - 1);
                } else {
                    if (action == 'Add') {
                        vehicle_editline = 0;
                        $('#hidden_vehicles').val(item_count + 1);
                    } else {
                        line = $(this).attr("data-line");
                        vehicle_editline = line;
                        $('#tb_vehicleregistration').val($('#tb_vehicleregistration_' + line).val());
                        $('#tb_vehicledescription').val($('#tb_vehicledescription_' + line).val());
                    }
                    $.colorbox({ href: "#vehicles_content", inline: true });
                }
                $("#form1").validate().element("#hidden_vehicles");
            });

            $('#vehiclesave').click(function () {
                if ($('#tb_vehicleregistration').val() == '' || $('#tb_vehicledescription').val() == '') {
                    alert('You must enter both a registration number and description.')
                } else {
                    $.colorbox.close();
                    if (vehicle_editline == 0) {
                        vehicles_maxline = vehicles_maxline + 1;
                        //input = '<td><input type="text" id="tb_vehicleregistration_' + vehicles_maxline + '" name="tb_vehicleregistration_' + vehicles_maxline + '" value="' + $('#tb_vehicleregistration').val() + '" /></td>';
                        //input = input + '<td><input type="text" id="tb_vehicledescription_' + vehicles_maxline + '" name="tb_vehicledescription_' + vehicles_maxline + '" value="' + $('#tb_vehicledescription').val() + '" /></td>';
                        input = '<td><input readonly="readonly" id="tb_vehicleregistration_' + vehicles_maxline + '" name="tb_vehicleregistration_' + vehicles_maxline + '" value="' + $('#tb_vehicleregistration').val() + '" /></td>';
                        input = input + '<td><input readonly="readonly" id="tb_vehicledescription_' + vehicles_maxline + '" name="tb_vehicledescription_' + vehicles_maxline + '" value="' + $('#tb_vehicledescription').val() + '" /></td>';
                        input = input + '<td><a class="action_vehicles" data-line="' + vehicles_maxline + '">Edit</a> <a class="action_vehicles" data-line="' + vehicles_maxline + '">Delete</a></td></td>';
                        $('#table_vehicles tr:last').after('<tr data-line="' + vehicles_maxline + '">' + input + '</tr>');
                    } else {
                        $('#tb_vehicleregistration_' + vehicle_editline).val($('#tb_vehicleregistration').val());
                        $('#tb_vehicledescription_' + vehicle_editline).val($('#tb_vehicledescription').val());
                    }

                    $('#tb_vehicleregistration').val('');
                    $('#tb_vehicledescription').val('');
                }
            });

            $('#tb_vehicleregistration').on('keypress', function (event) {
                if (null !== String.fromCharCode(event.which).match(/[a-z]/g)) {
                    event.preventDefault();
                    $(this).val($(this).val() + String.fromCharCode(event.which).toUpperCase());
                }
            });


            $('#vehiclecancel').click(function () {
                $.colorbox.close();
                $('#tb_vehicleregistration').val('');
                $('#tb_vehicledescription').val('');
            });

            $('body').on('click', '.action_otherpremises', function () {
                var action = $(this).text();
                var item_count = parseInt($('#hidden_otherpremises').val());
                if (action == "Delete") {
                    line = $(this).attr("data-line");
                    $('#table_otherpremises tr[data-line="' + line + '"]').remove();
                    $('#hidden_otherpremises').val(item_count - 1);
                } else {
                    if (action == 'Add') {
                        otherpremises_editline = 0;
                        $('#hidden_otherpremises').val(item_count + 1);
                    } else {
                        line = $(this).attr("data-line");
                        otherpremises_editline = line;
                        $('#tb_otherpremises_business').val($('#tb_otherpremises_business_' + line).val());
                        $('#tb_otherpremises_owners').val($('#tb_otherpremises_owners_' + line).val());
                    }
                    $.colorbox({ href: "#otherpremises_content", inline: true });
                }
                $("#form1").validate().element("#hidden_otherpremises");
            });

            $('#otherpremisessave').click(function () {
                if ($('#tb_otherpremises_business').val() == '' || $('#tb_otherpremises_owners').val() == '' || $('#tb_otherpremises_phone').val() == '' || !($('#cb_otherpremises_permission').is(':checked'))) {
                    alert('You must enter the business name, owner(s), phone, and that permission has been given')
                } else {
                    $.colorbox.close();
                    if (otherpremises_editline == 0) {
                        otherpremises_maxline = otherpremises_maxline + 1;
                        input = '<td><input readonly="readonly" id="tb_otherpremises_business_' + otherpremises_maxline + '" name="tb_otherpremises_business_' + otherpremises_maxline + '" value="' + $('#tb_otherpremises_business').val() + '" /></td>';
                        input = input + '<td><input readonly="readonly" id="tb_otherpremises_owners_' + otherpremises_maxline + '" name="tb_otherpremises_owners_' + otherpremises_maxline + '" value="' + $('#tb_otherpremises_owners').val() + '" /></td>';
                        input = input + '<td><input readonly="readonly" id="tb_otherpremises_phone_' + otherpremises_maxline + '" name="tb_otherpremises_phone_' + otherpremises_maxline + '" value="' + $('#tb_otherpremises_phone').val() + '" /></td>';
                        input = input + '<td><input readonly="readonly" id="cb_otherpremises_permission_' + otherpremises_maxline + '" name="cb_otherpremises_permission_' + otherpremises_maxline + '" value="' + $('#cb_otherpremises_permission:checked').val() + '" /></td>';
                        input = input + '<td><a class="action_otherpremises" data-line="' + otherpremises_maxline + '">Edit</a> <a class="action_otherpremises" data-line="' + otherpremises_maxline + '">Delete</a></td></td>';
                        $('#table_otherpremises tr:last').after('<tr data-line="' + otherpremises_maxline + '">' + input + '</tr>');
                    } else {
                        $('#tb_otherpremises_business_' + otherpremises_editline).val($('#tb_otherpremises_business').val());
                        $('#tb_otherpremises_owners_' + otherpremises_editline).val($('#tb_otherpremises_owners').val());
                        $('#tb_otherpremises_phone_' + otherpremises_editline).val($('#tb_otherpremises_phone').val());
                        $('#cb_otherpremises_permission_' + otherpremises_editline).val($('#cb_otherpremises_permission').val());
                    }
                    $('#tb_otherpremises_business').val('');
                    $('#tb_otherpremises_owners').val('');
                    $('#tb_otherpremises_phone').val('');
                    $('#cb_otherpremises_permission').prop('checked', false);
                }
            });


            $('#otherpremisescancel').click(function () {
                $.colorbox.close();
                $('#tb_otherpremises_business').val('');
                $('#tb_otherpremises_owners').val('');
                $('#tb_otherpremises_phone').val('');
                $('#cb_otherpremises_permission').prop('checked', false);
            });

        });

        function passlocation(line, location, coords) {
            $.colorbox.close();
            if (line == 0) {
                location_maxline = location_maxline + 1;

                input = '<input readonly="readonly" type="text" id="tb_location_' + location_maxline + '" name="tb_location_' + location_maxline + '" class="form_control col-sm-8" value="' + location + '" />';
                input = input + '<input id="hf_locationcoords_' + location_maxline + '" name="hf_locationcoords_' + location_maxline + '" type="hidden" value="' + coords + '" />';
                input = input + ' <a class="action_location" data-line="' + location_maxline + '">Edit</a> <a class="action_location" data-line="' + location_maxline + '">Delete</a>';

                $('#table_location tr:last').after('<tr data-line="' + location_maxline + '"><td>' + input + '</td></tr>');
            } else {
                $("input[id$='tb_location_" + line + "']").val(location);
                $("input[id$='hf_locationcoords_" + line + "']").val(coords);
            }
        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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
        <label class="control-label col-sm-4" for="cb_district">Do you intend to operate within the whole of the Whanganui District? <img src="../Images/questionsmall.png" title="If you intend to operate within the whole of the Whanganui District, you must still obtain permission from the property/premise owner(s) you intend to operate outside of." /></label>
        <div class="col-sm-1">
            <input id="cb_district" name="cb_district" class="form-control" type="checkbox" value="Whole District" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Specific
            Location(s) <img src="../Images/questionsmall.png" title="Location(s) must be specified if you are not intending to operate within the whole of the Whanganui District.  If you are intending to operate within the whole of the Whanganui District and intend to operate at specific locations please also add them here." /><br /><a class="action_location">Add</a>
        </label>
        <div class="col-sm-8">
             <input id="hidden_location" name="hidden_location" type="hidden" value="0" />
           <table id="table_location" style="width: 100%;">
                <tr style="display: <%: none%>">
                    <td></td>
                </tr>
            </table>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Other property/premise(s) permission obtained <img src="../Images/questionsmall.png" title="If you will be operating in front of a property/premise, permission from the property/premise owner is required for the period that the application is being applied for.  Your application will be declined should the declaration that permission has been obtained from the owner(s) is false" /><br /><a class="action_otherpremises">Add</a>
        </label>
        <div class="col-sm-8">
           <input id="hidden_otherpremises" name="hidden_otherpremises" type="hidden" value="0" /> 
           <table id="table_otherpremises" style="width: 100%;">
                <tr>
                    <td class="text-muted">Business</td>
                    <td class="text-muted">Owner(s)</td>
                    <td class="text-muted">Phone Number</td>
                    <td class="text-muted">Permission obtained</td>
                    <td class="text-muted">Action</td>
                </tr>
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
        <label class="control-label col-sm-4" for="xxxxx">
            Date(s) of use <img src="../Images/questionsmall.png" title="Specify the specific date, a range of dates, or describe it in some other way: eg: Every second Saturday between 3 July and 17 August 2015" /><br /><a class="action_datesofuse">Add</a></label>
        <div class="col-sm-8">
            <input id="hidden_datesofuse" name="hidden_datesofuse" type="hidden" value="0" />
            <table id="table_datesofuse" style="width: 100%;">
                <tr style="display: <%: none%>">
                    <td colspan="2"></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_products">Source and range of products <img src="../Images/questionsmall.png" title="Describe where you sourced your goods from e.g. Pak n Save, Mad Butchers, Mr Chips, my garden etc. and the range of product you will sell e.g. Hamburgers, Hot Chips, Sandwiches, Potatoes, Pumpkin, Stone fired pizzas, etc. Give as much detail as possible." /></label>
        <div class="col-sm-8">
            <textarea id="tb_products" name="tb_products" class="form-control" maxlength="200" rows="3" required><%: tb_products %></textarea>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Vehicle registration number(s) and description(s)<br /><a class="action_vehicles">Add</a>
        </label>
        <div class="col-sm-8">
           <input id="hidden_vehicles" name="hidden_vehicles" type="hidden" value="0" /> 
           <table id="table_vehicles" style="width: 100%;">
                <tr>
                    <td class="text-muted">Registration</td>
                    <td class="text-muted">Description</td>
                    <td class="text-muted">Action</td>
                </tr>
            </table>
        </div>
    </div>
        <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charityname">Charities Name <img src="../Images/questionsmall.png" title="Provide a valid charity name that is registered with Charities Service (www.charities.govt.nz)." /></label>
        <div class="col-sm-8">
            <input type="text" id="tb_charityname" name="tb_charityname" class="form-control" maxlength="100" value="<%: tb_charityname %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charityreference">Charities Number <img src="../Images/questionsmall.png"  title="Providing a valid charity number may entitle your charity to be exempt from paying an application fee."/></label>
        <div class="col-sm-8">
            <input type="text" id="tb_charityreference" name="tb_charityreference" class="form-control" maxlength="20" value="<%: tb_charityreference %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_othercouncil">If you hold either; a current food premise registration with another Teritorial Authority, or MAF registration, please upload a copy of your certificate:</label>
        <div class="col-sm-8">
            <asp:FileUpload ID="fu_othercouncil" runat="server" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_otherinformation">Other relevant information <img src="../Images/questionsmall.png" title="Provide additional information such as e.g. Vintage Weekend, Festival of Cultures, Fundraising for Relay for Life etc." /></label>
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


    <!-- This contains the hidden content for inline calls -->
    <div style='display: <%: none%>'>
        <div id='vehicles_content' style='padding: 10px; background: #ffffff;'>
            <table class="table table-hover table-responsive" style="margin: auto;">
                <tr>
                    <td colspan="2" style="text-align: center">Vehicles
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="control-label col-sm-4" for="tb_vehicleregistration">
                            Registration</label></td>
                    <td>
                        <input type="text" id="tb_vehicleregistration" maxlength="6" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="control-label col-sm-4" for="tb_vehicledescription">
                            Description</label></td>
                    <td>

                        <input type="text" id="tb_vehicledescription" maxlength="100" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%">
                <tr>
                    <td style="text-align: left">
                        <input id="vehiclecancel" value="Cancel" type="button" style="width: 100%" />
                    </td>
                    <td style="text-align: right">
                        <input id="vehiclesave" value="Save" type="button" style="width: 100%" />
                    </td>
                </tr>
            </table>
        </div>

        <div id='otherpremises_content' style='padding: 10px; background: #ffffff;'>
            <table class="table table-hover table-responsive" style="margin: auto;">
                <tr>
                    <td colspan="2" style="text-align: center">Other Premises
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="control-label col-sm-4" for="tb_otherpremises_business">
                            Business Name</label></td>
                    <td>
                        <input type="text" id="tb_otherpremises_business" maxlength="100" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="control-label col-sm-4" for="tb_otherpremises_owners">
                            Owner(s)</label>
                    <td>

                        <input type="text" id="tb_otherpremises_owners" maxlength="100" />
                    </td>
                </tr>
                 <tr>
                    <td>
                        <label class="control-label col-sm-4" for="tb_otherpremises_phone">
                            Phone Number</label>
                    <td>

                        <input type="text" id="tb_otherpremises_phone" maxlength="20" />
                    </td>
                </tr>               <tr>
                    <td>
                        <label class="control-label col-sm-4" for="cb_otherpremises_permission">
                            Permission obtained</label></td>
                    <td>
                        <input id="cb_otherpremises_permission" name="cb_otherpremises_permission" type="checkbox" value="Yes" /></td>
                </tr>
            </table>
            <br />
            <table style="width: 100%">
                <tr>
                    <td style="text-align: left">
                        <input id="otherpremisescancel" value="Cancel" type="button" style="width: 100%" />
                    </td>
                    <td style="text-align: right">
                        <input id="otherpremisessave" value="Save" type="button" style="width: 100%" />
                    </td>
                </tr>
            </table>
        </div>


    </div>

</asp:Content>
