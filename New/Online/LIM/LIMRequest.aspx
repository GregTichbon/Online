<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LIMRequest.aspx.cs" Inherits="Online.LIM.LIMRequest" %>
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

 
            $("#pagehelp").colorbox({ href: "LIMRequestHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                ignore: [],
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
    <h1>Land Information Memorandum (LIM) Request
    </h1>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
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
            Identify the property on a map 
            <img src="../Images/questionsmall.png" title="You can, optionally, identify the property on a map.">
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
        <label class="control-label col-sm-4" for="dd_type">Type:</label>
        <div class="col-sm-8">
            <select id="dd_type" name="dd_type" class="form-control" required>
                <option></option>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(types, dd_type,"None") %>
            </select>
        </div>
    </div>

    
    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_wheredoifit">Urgent? <img src="../Images/questionsmall.png" title="Residential/Rural LIM requests should be proeccessed within 10 working days.  Urgent LIM requests should be processed with 3.5 working days.  There is an additional fee of $177.00." /></label>
        <div class="col-sm-1">
            <input id="cb_urgent" name="cb_urgent" class="form-control" type="checkbox" value="Yes" />
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
