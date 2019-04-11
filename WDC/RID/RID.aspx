<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RID.aspx.cs" Inherits="Online.RID.RID" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/disableAutoFill.min.js"></script>
        <script type="text/javascript">


        //As the RID develops please use/adjust/modfiy the parameters below.  At some stage it would be good to take these out of the code and into a database

        var this_year_start = 2018;
        var do_nextyear = 1; //0 or 1
        var revaluation_year = false; //true
        var this_year_amounts = 1;
        var next_year_amounts = 1; //0 or 1
        var this_year_run_ctr = 0;  //0 = none
        var next_year_run_ctr = 52; //50;  //0 = none
        var showotherpropertyinformation = 0;







        var this_year = '01-July-' + this_year_start
        var this_year_range = this_year_start + '/' + (this_year_start + 1);
        var next_year_start = this_year_start + 1;
        var next_year = '01-July-' + next_year_start;
        var end_of_next_year = next_year_start + 1;
        var next_year_range = next_year_start + '/' + (next_year_start + 1);

        var total = 0;

        // SP GET_RID_Header needs to manually maintained for dates

        var showmap = GetQueryStringParams("showmap");

        $(document).ready(function () {
            //$("#pagehelp").colorbox({ href: "RIDHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $('#form1').disableAutoFill();   //this is to stop Google Chrome doing it's autofill

            id = GetQueryStringParams("id");
            if (id != "") {
                $.ajax({
                    url: "../functions/data.asmx/PropertySelect?mode=Property Number&term=" + id, success: function (result) {
                        property = $.parseJSON(result);
                        address = property[0];
                        passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no);
                        if (showmap === '1') {
                            $("#propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                            $("#propertymap").show();
                        }
                        search = GetQueryStringParams("search");
                        if (search == '0') {
                            $('#div_search').hide();
                        }
                    }
                });
            }

            $("#ddl_searchby").change(function () {
                if (showmap === '1') {
                    $("#propertymap").hide();
                }
                $('#results').empty();
                $('#links').hide();
                $('#revaluation').empty();
                var option = $(this).val();
                if (option == 'Property Number') {
                    $("#tr_propertynumber").show();
                    $("#tr_assessmentnumber").hide();
                    $("#tr_address").hide();
                    $("#tr_search").show();
                    //$('body').height(300);
                } else if (option == 'Assessment Number') {
                    $("#tr_propertynumber").hide();
                    $("#tr_assessmentnumber").show();
                    $("#tr_address").hide();
                    $("#tr_search").show();
                    //$('body').height(300);
                } else {
                    $("#tr_propertynumber").hide();
                    $("#tr_assessmentnumber").hide();
                    $("#tr_address").show();
                    $("#tr_search").hide();
                    //$("#div_main").height(600);
                    //$('body').height(600);
                }

            });


            $("#tb_address").autocomplete({
                source: "../functions/data.asmx/PropertySelect?mode=address",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    if (address) {
                        $("#tb_address").val(address.label);
                        passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no);
                        if(showmap == '1') {
                            $("#propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                            $("#propertymap").show();
                        }
                    } else {
                        alert('Not found');
                    }
                    //selectedproperty(ui.item ?
                    // passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no) :
                    // "Nothing selected, input was " + this.value);
                },
                open: function (event, ui) {
                    if (navigator.userAgent.match(/iPad/)) {
                        // alert(1);
                        $('.autocomplete').off('menufocus hover mouseover');
                    }
                },

            })
            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  .append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .appendTo(ul);
            };

            /*
            function selectedproperty(message) {
                $("#selectedproperty").html(message);
                $(".selectedproperty").show();
                //$("#btn_select").show();
            }
            */

            $("#btn_search").click(function () {
                if (showmap == '1') {
                    $("#propertymap").hide();
                }
                $('#results').empty();
                $('#links').hide();
                $('#revaluation').empty();
                var mode = $("#ddl_searchby").val();
                if (mode == "Property Number") {
                    //$('body').height(300);
                    var term = $("#tb_propertynumber").val();
                } else {
                    //$('body').height(300);
                    var term = $("#tb_assessmentnumber").val();
                }
                $.ajax({
                    url: "../functions/data.asmx/PropertySelect?mode=" + mode + "&term=" + term, success: function (result) {
                        property = $.parseJSON(result);
                        if (property.length == 0) {
                            $('#search_result').html('Not found');
                        } else {
                            address = property[0];
                            //selectedproperty(address.label + "<br>" + address.legaldescription + " " + address.area + "<br>" + "Property Number: " + address.value + "<br>Assessment Number: " + address.assessment_no);
                            passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no)
                            if (showmap == '1') {
                                $("#propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                                $("#propertymap").show();
                            }
                        }
                    }
                });
            });

            $("#href_propertyinformation").click(function () {
                window.open("../general/propertyinformation.aspx?id=" + address.value, "_blank");
            });
            /*
            $("#btn_select").click(function () {
                $(".selectedproperty").hide();
                //$("#div_main").height(130);
                $('body').height(130);
                window.parent.passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no)
            });
            */


            /*
                        $('body').on('click', '#a_property', function () {
                            //not using line at this stage
                            $.colorbox({ href: "../functions/PropertySelect.aspx", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
                        });
                        */

                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready

        function passproperty(line, label, value, area, legaldescription, assessment_no) {
            $('#search_result').html('');
            //$("#tb_property").val(label);
            //$("#hf_property").val(value);
            //$.colorbox.close();

            if (showmap == '1') {
                $("#propertymap").hide();
            }
            $('#results').empty();
            $('#links').hide();
            $('#revaluation').empty();

            $('#revaluation').append('<hr style="color: #f00;background-color:black;height: 3px;" />');


            if (revaluation_year) {
                $('#revaluation').append('<h3>Revaluation of the Whanganui District</h3>');
                $('#revaluation').append('<p>The Valuation Rolls for Whanganui District Council have been revised by Quotable Value Limited (as the Council\'s valuation service provider).</p>');
                $('#revaluation').append('<p>The revised Rating Values are effective as at 1 September 2016 and the new notices of valuation will be posted to owners and ratepayers from 12 December 2016.</p>');
                $('#revaluation').append('<p>Objections to the revised valuation must be lodged, in writing or online at www.qv.co.nz no later than 27 January 2017.</p>');
                $('#revaluation').append('<p>The revised rating valuations will become effective for rating purposes on 1 July ' + this_year_start + '.</p>');
            }

            $('#results').append('<h3>' + this_year_range + ' (01 Jul ' + this_year_start + ' - 30 Jun ' + next_year_start + ')</h3>');
            //$('#results').append('<p>The information below contains valuation changes since 01 Sep 2013. If the property has had major development or subdivision resulting in a revaluation, that information will also be shown.</p>');

            $.ajax({
                async: false,
                url: "../functions/data.asmx/RIDHeader?property_no=" + value, success: function (result) {
                    headerrecord = $.parseJSON(result);
                    //Show_next_year = headerrecord[0]['Show_next_year'];
                    //Show_amounts = headerrecord[0]['Show_amounts'];



                    $('#results').append('<table id="headertable" class="table table-striped table-responsive"><tbody></tbody></table>');
                    table = $("#headertable");
                    buildheaderrecords(table, 'Property number', value);
                    var flds = ["Assessment_number", "Address", "Legal_description", "Area", "Certificates_of_title", "Land_value", "Capital_value"];
                    for (var key in flds) {
                        //alert(key + ', ' + headerrecord[i][key]);
                        buildheaderrecords(table, flds[key], headerrecord[0][flds[key]]);
                    }
                    currentlv = headerrecord[0]['Land_value'];
                    currentcv = headerrecord[0]['Capital_value'];
                    newlv = headerrecord[0]['New_Land_value'];
                    newcv = headerrecord[0]['New_Capital_value'];
                    if (currentlv !== newlv || currentcv !== newcv) {
                        table.append('<tr><td colspan="2"><b>A revaluation of the district is undertaken every 3 years.<br />The rating valuations recorded on the Council\'s Rating Information Database are as at 1 Sep 2016.<br />If there have been changes to a valuation since 1 July 2018, the effective date for rating purposes will be 1 July 2019.</b></td></tr>');
                    }
                    buildheaderrecords(table, 'New_Land_value', newlv);
                    buildheaderrecords(table, 'New_Capital_value', newcv);


                    if (revaluation_year) {
                        $('#revaluation').append('<table id="newheadertable" class="table table-striped table-responsive"><tbody></tbody></table>');
                        table = $("#newheadertable");
                        var flds = ["New_Land_value", "New_Capital_value"];
                        for (var key in flds) {
                            buildheaderrecords(table, flds[key], headerrecord[0][flds[key]]);
                        }
                        $('#revaluation').append('<p>Use this <a target="_blank" href="http://whanganui.govt.nz/our-services/property-and-rates/rating-and-valuations/Documents/QV_Objection%20Form_103446%2003%20Print%20SPOT%20072%20no%20bleed.pdf">form</a> if you would like to lodge an objection to your rating valuation.</p>');

                        $('#revaluation').append('<hr style="color: #f00;background-color:black;height: 3px;" />');
                    }

                    $.ajax({
                        async: false,
                        url: '../functions/data.asmx/RIDCharges?property_no=' + value + '&year=' + this_year + '&showamounts=' + this_year_amounts + '&run_ctr=' + this_year_run_ctr, success: function (result) {
                            $('#results').append('<h4>Rating Factors</h4>');
                            $('#results').append('<table id="chargestable" class="table table-striped table-responsive"><tbody></tbody></table>');
                            $("#chargestable").append('<tr><th>Code</th><th>Description</th><th>Method</th><th style="text-align:right">Units</th><th style="text-align:right">Rate</th><th style="text-align:right">Amount</th></tr>');
                            chargesrecord = $.parseJSON(result);
                            total = 0;
                            for (var i = 0, len = chargesrecord.length; i < len; ++i) {
                                //alert(chargesrecord[i]["amount"]);
                                if (chargesrecord[i]["amount"] != "$0.00") {
                                    $("#chargestable").append('<tr id="chargestable' + i + '"></tr>');
                                    row = $("#chargestable" + i);
                                    for (var key in chargesrecord[i]) {
                                        //alert(key);
                                        buildchargesrecords(row, key, chargesrecord[i][key]);
                                    }
                                }
                            }
                            $("#chargestable").append('<tr><td colspan="4">&nbsp;</td><td style="text-align:right"><b>Total</b></td><td style="text-align:right"><b>$' + total.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</b></td></tr>');
                        }
                    });
                    if (do_nextyear == 1) {
                        $('#results').append('<hr style="color: #f00;background-color:black;height: 3px;" />');

                        $('#results').append('<h3>' + next_year_range + ' (01 Jul ' + next_year_start + ' - 30 Jun ' + end_of_next_year + ')</h3>');
                        //$('#results').append('<p>The Rating Information Database contains a record of all information required for setting and assessing rates and allows for the calculation of rates liability for each rating unit. The information below contains valuation changes since 01 Sep 2013. If the property has had major development or subdivision resulting in a revaluation, that information will also be shown.</p>');

                        if (next_year_amounts == 1) {
                            //$('#results').append('<p>Rates for ' + next_year_range + ' are indicative only at this stage and will be finalised in July ' + next_year_start + ' after the ' + next_year_range + ' Annual Plan has been adopted by Council. Rates have been calculated based on valuations held at 23 February 2017 and have not yet been recalculated for valuation changes made through the objection process with QVNZ.</p>');
                            $('#results').append('<p>Rates for ' + next_year_range + ' are indicative only at this stage and will be finalised in July ' + next_year_start + ' after the 2019-20 Annual Plan has been adopted by Council. Rates have been calculated based on valuations held at March 2019. If the property has had major development or subdivision resulting in a revaluation this will be incorporated in the final rates calculation at 1 July 2019.</p>');
                        }
                            /*
                                                $.ajax({
                                                    async: false,
                                                    url: "../functions/data.asmx/RIDHeader?property_no=" + value + '&next_year=1', success: function (result) {
                                                        headerrecord = $.parseJSON(result);
                                                        Show_amounts = headerrecord[0]['Show_amounts'];
                        
                                                        $('#results').append('<table id="headertableNY" class="table table-striped table-responsive"><tbody></tbody></table>');
                                                        table = $("#headertableNY");
                                                        var flds = ["Land_value", "Capital_value"]
                                                        for (var key in flds) {
                                                            //alert(key + ', ' + headerrecord[i][key]);
                                                            buildheaderrecords(table, flds[key], headerrecord[0][flds[key]]);
                                                        }
                        */
                        $.ajax({
                            async: false,
                            url: '../functions/data.asmx/RIDCharges?property_no=' + value + '&year=' + next_year + '&showamounts=' + next_year_amounts + '&run_ctr=' + next_year_run_ctr, success: function (result) {
                                $('#results').append('<h4>Rating Factors</h4>');
                                $('#results').append('<table id="chargestableNY" class="table table-striped table-responsive"><tbody></tbody></table>');
                                chargeheadingNY = '<tr><th>Code</th><th>Description</th><th>Method</th><th style="text-align:right">Units</th>';
                                if (next_year_amounts == 1) {
                                    chargeheadingNY += '<th style="text-align:right">Rate</th><th style="text-align:right">Amount</th>';
                                    //chargeheadingNY += '<th style="text-align:right">Amount</th>';
                                }
                                chargeheadingNY += '</tr>'
                                $("#chargestableNY").append(chargeheadingNY);
                                chargesrecord = $.parseJSON(result);
                                total = 0;
                                for (var i = 0, len = chargesrecord.length; i < len; ++i) {
                                    //if (chargesrecord[i]["amount"] != "$0.00") {
                                    if (chargesrecord[i]["charge_type"] != "CF") {
                                            $("#chargestableNY").append('<tr id="chargestableNY' + i + '"></tr>');
                                        row = $("#chargestableNY" + i);
                                        for (var key in chargesrecord[i]) {
                                            //alert(key);
                                            //buildchargesrecords(row, key, chargesrecord[i][key]);
                                            label = key;
                                            value = chargesrecord[i][key];
                                            if (next_year_amounts == 1 || (next_year_amounts != 1 && label != 'rate' && label != 'amount')) {
                                                // if (label != 'rate') {   //TEMP TEMP TEMP
                                                if (value != '') {
                                                    if (label == 'units' || label == 'rate' || label == 'amount') {
                                                        align = ' style="text-align:right"';
                                                    } else {
                                                        align = '';
                                                    }
                                                    row.append('<td' + align + '>' + value + "</td>");
                                                    if (label == 'amount') {
                                                        total += parseFloat(value.replace('$', '').replace(/,/g, ''));

                                                    }
                                                }
                                                //}
                                            }
                                        }
                                    }
                                }
                                if (next_year_amounts == 1) {
                                    $("#chargestableNY").append('<tr><td colspan="4">&nbsp;</td><td style="text-align:right"><b>Total</b></td><td style="text-align:right"><b>$' + total.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</b></td></tr>');
                                    //$("#chargestableNY").append('<tr><td colspan="3">&nbsp;</td><td style="text-align:right"><b>Total</b></td><td style="text-align:right"><b>$' + total.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</b></td></tr>');
                                }
                            }
                        });
                        /*
                            }
                        });
                        */
                    }

                }
            });
            if (showotherpropertyinformation == 1) {
                $('#links').show();
            }
        }


        function buildheaderrecords(table, label, value) {
            if (value != '') {
                table.append('<tr><td class="col-md-4 text-right"><b>' + label.replace(/_/g, ' ') + '</b></td><td>' + value + "</td></tr>");
            }
        }
        function buildchargesrecords(row, label, value) {
            if (value != '') {
                if (label == 'units' || label == 'rate' || label == 'amount') {
                    align = ' style="text-align:right"';
                } else {
                    align = '';
                }
                row.append('<td' + align + '>' + value + "</td>");
                if (label == 'amount') {
                    total += parseFloat(value.replace('$', '').replace(/,/g, ''));
                }
            }
        }


        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--<a id="pagehelp">
       <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>-->
    <h1>Rating Information Database (RID) 
    </h1>
    <div id="div_search">
        <div class="form-group">
            <label class="control-label col-sm-4" for="ddl_searchby">Search by: </label>
            <div class="col-sm-8">
                <select id="ddl_searchby" class="form-control">
                    <option>Property Address</option>
                    <option>Property Number</option>
                    <option>Assessment Number</option>
                </select>
            </div>
        </div>

        <div class="form-group" id="tr_propertynumber" style='display: none'>
            <label class="control-label col-sm-4" for="tb_propertynumber">Enter the property number: <img src="../Images/questionsmall.png" title="This is the number allocated to every property by the Whanganui District Council.  This can be found on all of the WDC correspondence relating to the property"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_propertynumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_assessmentnumber" style='display: none'>
            <label class="control-label col-sm-4" for="tb_assessmentnumber">Enter the property assessment: <img src="../Images/questionsmall.png" title="This is the reference provided by QV.  It will be in a form similar to 1327054401 or 1327054401A"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_assessmentnumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_address">
            <label class="control-label col-sm-4" for="tb_address">Please start typing the address: <img src="../Images/questionsmall.png" title="Please separate the address parts with spaces eg: Flat 4 77 C Whatever St.  Also use the abbreviated version of the road type eg: Ave, Rd, St, Tce etc."></label>
            <div class="col-sm-8">
                <input type="text" id="tb_address" class="form-control" /> 
            </div>
        </div>

        <div class="form-group" id="tr_search" style="display:none">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input id="btn_search" value="Search" type="button" class="btn btn-info" />
                <span id="search_result"></span>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
    <iframe id="propertymap" style="width:400px;height:400px;display:none;" src=""></iframe>
        </div>
    </div>



    <div id="revaluation"></div>

    <div id="results">
    </div>
    <div id="links" style="display: none">
        <hr style="color: #f00; background-color: black; height: 3px;" />
        <div class="col-sm-12 text-center">
            <a id="href_propertyinformation" class="btn btn-info nophonetooltip" href="javascript:void(0);" title="There may be other information available for this property.">Other Property Information</a>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>