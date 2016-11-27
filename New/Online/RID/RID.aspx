<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RID.aspx.cs" Inherits="Online.RID.RID" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">



        var next_year = ''; // = '1-July-2016';
        var property_number;

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "RIDHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $('body').on('click', '#a_property', function () {
                //not using line at this stage
                $.colorbox({ href: "../functions/PropertySelect.aspx", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
            });
        }); //document.ready

        function passproperty(line, label, value, area, legaldescription, assessment_no) {
            $("#tb_property").val(label);
            //$("#hf_property").val(value);
            $.colorbox.close();

            $('#results').empty();

            $.ajax({
                async: false,
                url: "../functions/data.asmx/RIDHeader?property_no=" + value + '&next_year=0', success: function (result) {
                    headerrecord = $.parseJSON(result);
                    Show_next_year = headerrecord[0]['Show_next_year'];
                    Show_amounts = headerrecord[0]['Show_amounts'];

                    $('#results').append('<table id="headertable" class="table table-hover table-responsive"></table>');
                    table = $("#headertable");
                    var flds = ["Assessment_number", "Address", "Legal_description", "Area", "Certificates_of_title", "Land_value", "Capital_value"]
                    for (var key in flds) {
                        //alert(key + ', ' + headerrecord[i][key]);
                        buildheaderrecords(table, flds[key], headerrecord[0][flds[key]]);
                    }
                    $.ajax({
                        async: false,
                        url: "../functions/data.asmx/RIDCharges?property_no=" + value + '&next_year=0', success: function (result) {
                            $('#results').append('<table id="chargestable" class="table table-hover table-responsive"></table>');
                            chargesrecord = $.parseJSON(result);
                            for (var i = 0, len = chargesrecord.length; i < len; ++i) {
                                $("#chargestable").append('<tr id="chargestable' + i + '"></tr>');
                                row = $("#chargestable" + i);
                                for (var key in chargesrecord[i]) {
                                    //alert(key);
                                    buildchargesrecords(row, key, chargesrecord[i][key]);
                                }
                            }
                        }
                    });
                    if (Show_next_year == 1) {
                        $.ajax({
                            async: false,
                            url: "../functions/data.asmx/RIDHeader?property_no=" + value + '&next_year=1', success: function (result) {
                                headerrecord = $.parseJSON(result);
                                Show_amounts = headerrecord[0]['Show_amounts'];

                                $('#results').append('<table id="headertableNY" class="table table-hover table-responsive"></table>');
                                table = $("#headertableNY");
                                var flds = ["Land_value", "Capital_value"]
                                for (var key in flds) {
                                    //alert(key + ', ' + headerrecord[i][key]);
                                    buildheaderrecords(table, flds[key], headerrecord[0][flds[key]]);
                                }
                                $.ajax({
                                    async: false,
                                    url: "../functions/data.asmx/RIDCharges?property_no=" + value + "&next_year=1", success: function (result) {
                                        $('#results').append('<table id="chargestableNY" class="table table-striped table-responsive"></table>');
                                        chargesrecord = $.parseJSON(result);
                                        for (var i = 0, len = chargesrecord.length; i < len; ++i) {
                                            $("#chargestableNY").append('<tr id="chargestableNY' + i + '"></tr>');
                                            row = $("#chargestableNY" + i);
                                            for (var key in chargesrecord[i]) {
                                                //alert(key);
                                                buildchargesrecords(row, key, chargesrecord[i][key]);
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                }
            });
        }


        function buildheaderrecords(table, label, value) {
            if (value != '') {
                table.append('<tr><td class="col-md-4 text-right">' + label.replace(/_/g, ' ') + '</td><td>' + value + "</td></tr>");
            }
        }
        function buildchargesrecords(row, label, value) {
            if (value != '') {
                row.append('<td>' + value + "</td>");
            }
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Rating Information Database (RID) 
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_premiselocation">Property:</label>
        <div class="col-sm-6">
            <input type="text" id="tb_property" name="tb_property" readonly="readonly" class="form-control" required />
            <input id="hf_property" name="hf_property" type="hidden" value="" />
        </div>
        <div class="col-sm-2">
            <a id="a_property">Select</a>
        </div>
    </div>


    <div id="results"></div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
