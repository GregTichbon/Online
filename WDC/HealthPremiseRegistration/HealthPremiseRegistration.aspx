<%@ Page Title="Health Premises" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HealthPremiseRegistration.aspx.cs" Inherits="Online.HealthPremiseRegistration.HealthPremiseRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var location_maxline = 0;

        $(document).ready(function () {



            $('body').on('click', '#a_propertyaddress', function () {
                //not using line at this stage
                $.colorbox({ href: "../functions/PropertySelect.aspx", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
            });

            $('body').on('click', '.a_location', function () {
                var action = $(this).text();
                if (action == "Delete") {
                    line = 0;
                    $('#tbl_location tr[data-line="' + line + '"]').remove();
                } else {
                    line = 0;
                    qs = "";
                    //line = 1;
                    //qs = "&p=" + $("input[id$='hf_locationcoords_" + line + "']").val() + "&location=" + $("input[id$='tb_location_" + line + "']").val();
                    $.colorbox({ href: "../mapping/GetLocation.aspx?line=" + line + qs, iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
                }
            });

           

            $("#pagehelp").colorbox({ href: "HealthPremiseRegistrationHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                ignore: [],
                rules: {
                    tb_existinglicence: {
                        ApplicationSelect: true
                    }
                }
            });

            $.validator.addMethod("ApplicationSelect", function (value, element) {
                if ($("#tb_existinglicence").val() == "") {
                    return true;
                }
                $.ajax({
                    url: "../functions/data.asmx/ApplicationSelect?term=" + $("#tb_existinglicence").val(), async: false, success: function (result) {
                        application = $.parseJSON(result);
                        applicationsfound = application.length;
                        if (applicationsfound > 0) {
                            $("#span_existinglicence").html("Description: " + application[0].description + "<br>Type: " + application[0].type + "<br>Address: " + application[0].propertyaddress + "<br>Business: " + application[0].businessname);
                        } else {
                            $("#span_existinglicence").html("");
                        }
                    }
                });
                if (applicationsfound > 0) {
                    return true;
                } else {
                    return false;
                }
            }, "A valid licence number is required.");



            $('body').on('focus', ".date", function () {
                $(this).datetimepicker({
                    format: 'D MMM YYYY',
                    extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                    showClear: true,
                    viewDate: false,
                    minDate: moment().add(1, 'day'),
                    maxDate: moment().add(10, 'year'),
                    useCurrent: false,
                    useStrict: true
                });
            });

            var addressname = 'premiseaddress';
            $('#cb_' + addressname + 'format').click(function () {
                if ($('#span_' + addressname + 'format').text() == 'Address lookup mode (preferred)') {
                    $('#span_' + addressname + 'format').text('Free format address mode (not preferred)');
                    $('#tb_' + addressname).autocomplete("disable");
                } else {
                    $('#span_' + addressname + 'format').text('Address lookup mode (preferred)');
                    $('#tb_' + addressname).autocomplete("enable");
                }
            })
            $('#tb_' + addressname).autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $('#tb_' + addressname).val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

        }); //document.ready

        function passproperty(line, label, value, area, legaldescription, assessment_no) {
            $("#tb_propertyaddress").val(label);
            $("#hf_propertyaddress").val(value);
            $.colorbox.close();
        }
        function passlocation(line, location, coords) {
            $.colorbox.close();
            $("input[id$='tb_location_" + line + "']").val(location);
            $("input[id$='hf_locationcoords_" + line + "']").val(coords);
            $("#div_location").html(location);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Health Premise Registration
    </h1>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_existinglicence">Existing licence:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_existinglicence" name="tb_existinglicence" class="form-control" maxlength="100" value="<%: tb_existinglicence %>" /><span id="span_existinglicence"></span>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_premisename">Premise (trading) name:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_premisename" name="tb_premisename" class="form-control" maxlength="100" value="<%: tb_premisename %>" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_premiselocation">Property address:</label>
        <div class="col-sm-6">
            <input type="text" id="tb_propertyaddress" name="tb_propertyaddress" readonly="readonly" class="form-control" required value="<%:tb_propertyaddress%>">
            <input id="hf_propertyaddress" name="hf_propertyaddress" type="hidden" value="" />
        </div>
        <div class="col-sm-2">
            <a id="a_propertyaddress">Select</a>
        </div>
    </div>


     <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Specific
            location <img src="../Images/questionsmall.png" title="To do">
        </label>

         <div class="col-sm-6">
             <input type="text" id="tb_location_0" name="tb_location_0" readonly="readonly" class="form-control" value="">
             <input id="hf_locationcoords_0" name="hf_locationcoords_0" type="hidden" value="" />
         </div>
         <div class="col-sm-2">
             <a class="a_location">Identify</a>
         </div>
    </div>






    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_premiseaddress">Premise address:</label>
        <div class="col-sm-8">
            <span id="span_premiseaddressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_premiseaddress">Change</a>
            <textarea id="tb_premiseaddress" name="tb_premiseaddress" class="form-control" rows="4" required><%:tb_premiseaddress%></textarea>
        </div>
    </div>





    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_premiselocation">Premise location:</label>
        <div class="col-sm-8">
            <textarea id="tb_premiselocation" name="tb_premiselocation" maxlength="500" class="form-control" required><%:tb_premiselocation%></textarea>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_activity">Activity:</label>
        <div class="col-sm-8">
            <select id="dd_activity" name="dd_activity" class="form-control" required>
                <option></option>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(activities, dd_activity,"") %>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_description">Description of activities:</label>
        <div class="col-sm-8">
            <textarea id="tb_description" name="tb_description" maxlength="500" class="form-control" required><%:tb_description%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_commencementdate">Proposed date for the commencement of trading:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_commencementdate" name="tb_commencementdate" class="form-control date" value="<%: tb_commencementdate %>" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_otherinformation">Other relevant information:</label>
        <div class="col-sm-8">
            <textarea id="tb_otherinformation" name="tb_otherinformation" maxlength="500" class="form-control"><%:tb_otherinformation%></textarea>
        </div>
    </div>



    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
