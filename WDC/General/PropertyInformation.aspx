<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PropertyInformation.aspx.cs" Inherits="Online.General.PropertyInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/disableAutoFill.min.js"></script>

<!--    <script src="https://unpkg.com/tippy.js@2.5.0/dist/tippy.all.min.js"></script>-->

    <script type="text/javascript">

        var showmap = '0'; //GetQueryStringParams("showmap");
        var propdetail = '';
        var propnumber = '';

        $(document).ready(function () {

            //$(document).tooltip("destroy");
          
            //tippy('[title]');

            $('#form1').disableAutoFill();   //this is to stop Google Chrome doing it's autofill

            //alert(navigator.userAgent);

            if (showmap == '1') {
                $("#div_propertymapcontainer").show();
            }
            var colorboxwidth = $(window).width() * .9;
            if (colorboxwidth > 810) {
                colorboxwidth = 810;
            }
            var colorboxheight = $(window).height() * .9;

            //$("#pagehelp").colorbox({ href: "PropertyInformationHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
            $("#href_feedback").click(function () {
                //$(".ui-tooltip-content").parents('div').remove();
                $.colorbox({ href: "PropertyInformationFeedback.aspx?property=" + propdetail, title: "", iframe: true, height: colorboxheight, width: colorboxwidth, overlayClose: false, escKey: false });
            });
            $("#href_rid").click(function () {
                //$(".ui-tooltip-content").parents('div').remove();
                window.open("../rid/rid.aspx?id=" + propnumber, "_blank");
                //return false;
            });

            id = GetQueryStringParams("id")
            if (id != "") {
                $.ajax({
                    url: "../functions/data.asmx/PropertySelect?mode=Property Number&term=" + id, success: function (result) {
                        property = $.parseJSON(result);
                        address = property[0];
                        passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no);
                        if (showmap == '1') {
                            //$("#iframe_propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                            $("#iframe_propertymap").attr('src', 'http://mangomap.com/wdc/maps/f6a747f2-378d-11e8-9596-06765ea3034e/Property-Location-Map?field=prop_no&value=' + address.value + '&layer=848c4eb2-3790-11e8-b3ce-06765ea3034e&preview=true');
                            alert($("#iframe_propertymap").attr('src'));
                            $("#div_propertymap").show();
                        }
                        search = GetQueryStringParams("search");
                        if (search == '0') {
                            $('#div_search').hide();
                        }
                    }
                });
            }

            $("#ddl_searchby").change(function () {
                if (showmap == '1') {
                    $("#div_propertymap").hide();
                }
                $('#results').empty();
                $('#disclaimer').hide();
                $('#links').hide();
                $('#hr_seperator').hide();
                

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

            $('.searchcriteria').keyup(function () {
                if (showmap == '1') {
                    $("#div_propertymap").hide();
                }
                $('#results').empty();
                $('#disclaimer').hide();
                $('#hr_seperator').hide();
                $('#links').hide();
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
                        if (showmap == '1') {
                            $('#btn_map').val('Hide map');
                            $("#div_propertymap").show();  //I've got a record - show the button
                            $("#div_propertymapiframe").show();
                            //$("#iframe_propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                            $("#iframe_propertymap").attr('src', 'http://mangomap.com/wdc/maps/f6a747f2-378d-11e8-9596-06765ea3034e/Property-Location-Map?field=prop_no&value=' + address.value + '&layer=848c4eb2-3790-11e8-b3ce-06765ea3034e&preview=true');
                            alert($("#iframe_propertymap").attr('src'));
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


            $("#btn_search").click(function () {
                if (showmap == '1') {
                    $("#div_propertymap").hide();
                }
                $('#results').empty();
                $('#disclaimer').hide();
                $('#hr_seperator').hide();
                $('#links').hide();

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
                            passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no)
                            if (showmap == '1') {
                                $('#btn_map').val('Hide map');
                                $("#div_propertymap").show();  //I've got a record - show the button
                                $("#div_propertymapiframe").show();
                                //$("#iframe_propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                                $("#iframe_propertymap").attr('src', 'http://mangomap.com/wdc/maps/f6a747f2-378d-11e8-9596-06765ea3034e/Property-Location-Map?field=prop_no&value=' + address.value + '&layer=848c4eb2-3790-11e8-b3ce-06765ea3034e&preview=true');
                                alert($("#iframe_propertymap").attr('src'));
                            }
                        }
                    }
                });
            });

            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

            $('#btn_map').click(function () {
                //if ($(this).val() == "Hide map") {
                if ($('#div_propertymapiframe').is(':visible')) {
                    $('#div_propertymapiframe').hide();
                    $(this).val('Show map');
                } else {
                    $(this).val('Hide map');
                    $('#div_propertymapiframe').show();
                }
            });

        }); //document.ready

        function passproperty(line, label, value, area, legaldescription, assessment_no) {
            ChangeUrl("", "propertyInformation.aspx?id=" + value);
            $('#search_result').html('');

            if (showmap == '1') {
                $("#div_propertymap").hide();
            }
            $('#results').empty();
            $('#disclaimer').show();
            $('#hr_seperator').show();


            $('#results').append('<h3>General</h3>');

            $.ajax({
                async: false,
                url: "../functions/data.asmx/RIDHeader?property_no=" + value, success: function (result) {
                    headerrecord = $.parseJSON(result);

                    $('#results').append('<table id="headertable" class="table table-striped table-responsive"><tbody></tbody></table>');
                    table = $("#headertable");
                    buildheaderrecords(table, 'Property number', value);
                    var flds = ["Assessment_number", "Address", "Legal_description", "Area", "Certificates_of_title", "Land_value", "Capital_value"]
                    for (var key in flds) {
                        //alert(key + ', ' + headerrecord[i][key]);
                        buildheaderrecords(table, flds[key], headerrecord[0][flds[key]]);
                    }
                    propdetail = value + " - " + headerrecord[0]["Address"];
                    propnumber = value;
                }
            });

            $('#results').append('<h3>Consents</h3>');

            $.ajax({
                async: false,
                url: '../functions/data.asmx/Consents?property_no=' + value, success: function (result) {
                    $('#results').append('<table id="consentstable" class="table table-striped table-responsive"><tbody></tbody></table>');
                    $("#consentstable").append('<tr><th>Year</th><th>Application No.</th><th>Category</th><th>Description</th><th>Decision</th></tr>');
                    consentrecord = $.parseJSON(result);
                    total = 0;
                    for (var i = 0, len = consentrecord.length; i < len; ++i) {
                        //alert(chargesrecord[i]["amount"]);
                        $("#consentstable").append('<tr id="consentstable' + i + '"></tr>');
                        row = $("#consentstable" + i);
                        for (var key in consentrecord[i]) {
                            //alert(key);
                            buildconsentrecords(row, key, consentrecord[i][key]);
                        }
                    }
                }
            });

            /*
            //$('#results').append('<a href="http://wdc.whanganui.govt.nz/onlinetest/rid/rid.aspx?id=' + value + '" target="_blank">View the RID<br />(Rating Information Database)</a>');
            $('#results').append('<a href="http://wdc.whanganui.govt.nz/onlinetest/rid/rid.aspx?id=' + value + '" target="_blank"><input id="btn_map" value="View RID" type="button" class="btn btn-info" /></a>');
            $('#results').append('<a href="http://wdc.whanganui.govt.nz/onlinetest/rid/rid.aspx?id=' + value + '" target="_blank"><button id="btn_documents" class="btn btn-info">Request an electronic copy<br />of consent documents</button></a>');
            $('#results').append('<a href="http://wdc.whanganui.govt.nz/onlinetest/rid/rid.aspx?id=' + value + '" target="_blank"><button id="btn_LIM" class="btn btn-info">Request a LIM</button></a>');
            $('#results').append('<a href="http://wdc.whanganui.govt.nz/onlinetest/rid/rid.aspx?id=' + value + '" target="_blank"><button id="btn_correction" class="btn btn-info">Something does not look right<br />Let us know</button></a>');
            */
            $('#links').show();

            

        }

        function buildheaderrecords(table, label, value) {
            if (value != '') {
                table.append('<tr><td class="col-md-4 text-right"><b>' + label.replace(/_/g, ' ') + '</b></td><td>' + value + "</td></tr>");
            }
        }

        function buildconsentrecords(row, label, value) {
            //if (value != '') {
                //if (label == 'xxxxx') {
                //    align = ' style="text-align:right"';
                //} else {
                    align = '';
                //}
            //if (label == "?") {
              //  value = "Pre Building Act"
            //}
                row.append('<td' + align + '>' + value + "</td>");
                //if (label == 'estimated_cost') {
                //    total += parseFloat(value.replace('$', '').replace(/,/g, ''));
                //}
            //}
        }

        function ChangeUrl(page, url) {
            if (typeof (history.pushState) != "undefined") {
                var obj = { Page: page, Url: url };
                history.pushState(obj, obj.Page, obj.Url);
            } else {
                alert("Browser does not support HTML5.");
            }
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <!--<a id="pagehelp">
       <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>-->
    <h1>Property Information
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
                <input type="text" id="tb_propertynumber" class="form-control searchcriteria" />
            </div>
        </div>

        <div class="form-group" id="tr_assessmentnumber" style='display: none'>
            <label class="control-label col-sm-4" for="tb_assessmentnumber">Enter the property assessment: <img src="../Images/questionsmall.png" title="This is the reference provided by QV.  It will be in a form similar to 1327054401 or 1327054401A"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_assessmentnumber" class="form-control searchcriteria" />
            </div>
        </div>

        <div class="form-group" id="tr_address">
            <label class="control-label col-sm-4" for="tb_address">Please start typing the address: <img src="../Images/questionsmall.png" title="Please separate the address parts with spaces eg: Flat 4 77 C Whatever St.  Also use the abbreviated version of the road type eg: Ave, Rd, St, Tce etc."></label>
            <div class="col-sm-8">
                <input type="text" id="tb_address" class="form-control searchcriteria"  /> 
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

    <hr id="hr_seperator" style="color: #f00;background-color:black;height: 3px; display:none" />

         <div id="disclaimer" class="panel panel-danger" style="display:none">
        <div class="panel-heading">Disclaimer</div>
        <div class="panel-body">
            <p>You will be requesting that the information be provided under the Local Government Official Information and Meetings Act 1987 (LGOIMA). Council is protected from liability for having provided this information by s41 of the LGOIMA. Council is not liable for any inaccuracies or errors in the information provided.
The information provided does not constitute a Land Information Memorandum or any similar document.</p>
        </div>
    </div>

    <div id="div_propertymapcontainer" style="display: none;">
        <div id="div_propertymap" class="form-group" style="display: none;">
            <div class="col-sm-4">
                <input id="btn_map" value="Hide map" type="button" class="btn btn-info" />
            </div>
            <div class="col-sm-8">
                <div id="div_propertymapiframe">
                    <iframe id="iframe_propertymap" style="width: 400px; height: 400px" src=""></iframe>
                </div>
            </div>
        </div>
    </div>




    <div id="results">
       
    </div>

    <div id="links" style="display: none">
        <hr style="color: #f00;background-color:black;height: 3px;" />
            <!--
            <div class="col-sm-3 text-center">
                <a class="btn btn-info" href="../rid/rid.aspx?id=2710" title="The RID (Rating Information Database) gives information on valuations, rating factors, and charges that are levied against this property." target="_blank">View RID<br />(Rating Information Database)&nbsp;</a>
            </div>
            <div class="col-sm-3 text-center">
                <a class="btn btn-info" href="../rid/rid.aspx?id=2710" title="The Council will provide you with a link to the documents that they have for the building consents list above in an electronic format.<br />There will be a $30.00 fee for this service." target="_blank">Request an electronic copy<br />
                    of consent documents</a>
            </div>
            <div class="col-sm-3 text-center">
                <a class="btn btn-info" href="../LIM/limrequest.aspx?id=2710" title="A LIM report is a copy of all the information that The Council holds in regards to a property.<br />There are fees that apply to the creation of a LIM report" target="_blank">Request a LIM report<br />&nbsp;</a>
            </div>
            <div class="col-sm-3 text-center">
                <a id="href_feedback" class="btn btn-info" href="javascript:void(0);" title="Council appreciates your feedback so as to ensure we hold and able to provide full and accurate information.<br />We will get back to you as soon as we can." > Something does not look right<br />
                    Let us know</a>
            </div>
            -->

            <div class="col-sm-6 text-center">
                <a id="href_rid" class="btn btn-info nophonetooltip" href="javascript:void(0);" title="The RID (Rating Information Database) gives information on valuations, rating factors, and charges that are levied against this property.">View RID<br />(Rating Information Database)</a>
            </div>
            <div class="col-sm-6 text-center">
                <a id="href_feedback" class="btn btn-info nophonetooltip" href="javascript:void(0);" title="Council appreciates your feedback so as to ensure we hold and able to provide full and accurate information.<br />We will get back to you as soon as we can." > Does something not look right?<br />
                    Let us know</a>
            </div>
    </div>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>