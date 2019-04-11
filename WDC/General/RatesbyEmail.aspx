<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RatesbyEmail.aspx.cs" Inherits="Online.General.RatesbyEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var showmap = "0"; //GetQueryStringParams("showmap");

        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "RatesbyEmailHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            id = GetQueryStringParams("id")
            if (id != "") {
                showmap = "0";
                $.ajax({
                    url: "../functions/data.asmx/PropertySelect?mode=Property Number&term=" + id, success: function (result) {
                        property = $.parseJSON(result);
                        address = property[0];
                        passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no);
                        if (showmap == '1') {
                            $("#propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                            //$("#div_propertymap").show();
                        }
                        search = GetQueryStringParams("search");
                        if (search == '0') {
                            $('#div_search').hide();
                        }
                    }
                });
            }

            window.onbeforeunload = function () {
                if ($("#pagehelp").css("display") == "block") {
                    return 'Check unload';
                }
            };

            $("#form1").validate({
                rules: {
                    tb_emailconfirm: {
                        equalTo: '#tb_emailaddress'
                    }
                },
                messages: {
                    tb_emailconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    }
                }
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

            $("#ddl_searchby").change(function () {
                if (showmap == '1') {
                    $("#propertymap").hide();
                }
                $('#results').empty();
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
                        if (showmap == '1') {
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

            $("#btn_search").click(function () {
                if (showmap == '1') {
                    $("#propertymap").hide();
                }
                $('#results').empty();
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

            $("#form1").validate({
                ignore: [],
            });

                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready

        function passproperty(line, label, value, area, legaldescription, assessment_no) {
            $('#search_result').html('');

            $('#Property_number').html(value);
            $('#hf_property_number').val(value);
            $('#Assessment_number').html(assessment_no);
            $('#hf_assessment_number').val(assessment_no);
            $('#Property_address').html(label);
            $('#hf_property_address').val(label);
            $('#Legal_description').html(legaldescription);
            $('#hf_legal_description').val(legaldescription);

            $('#property_result').show();

            //$("#tb_property").val(label);
            //$("#hf_property").val(value);
            //$.colorbox.close();

            if (showmap == '1') {
                $("#propertymap").hide();
            }
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
    <asp:TextBox ID="tb_reference" runat="server" Visible="False"></asp:TextBox>
    <!-- <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>-->
    <h1>Rates by Email
    </h1>

    <div id="div_searchrates">
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
            <label class="control-label col-sm-4" for="tb_propertynumber">
                Enter the property number:
                <img src="../Images/questionsmall.png" title="This is the number allocated to every property by the Whanganui District Council.  This can be found on all of the WDC correspondence relating to the property"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_propertynumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_assessmentnumber" style='display: none'>
            <label class="control-label col-sm-4" for="tb_assessmentnumber">
                Enter the property assessment:
                <img src="../Images/questionsmall.png" title="This is the reference provided by QV.  It will be in a form similar to 1327054401 or 1327054401A"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_assessmentnumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_address">
            <label class="control-label col-sm-4" for="tb_address">
                Please start typing the address:
                <img src="../Images/questionsmall.png" title="Please separate the address parts with spaces eg: Flat 4 77 C Whatever St.  Also use the abbreviated version of the road type eg: Ave, Rd, St"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_address" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_search" style="display: none">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input id="btn_search" value="Search" type="button" class="btn btn-info" />
                <span id="search_result"></span>
            </div>
        </div>
        <!--
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
        -->
    </div>

    <div id="property_result" style="display: none">
        <hr style="color: #f00; background-color: black; height: 3px;" />
        <div class="form-group">
            <label class="control-label col-sm-4">
                Property number:
            </label>
            <div class=" col-sm-8" id="Property_number"></div>
            <input type="hidden" id="hf_property_number" name="hf_property_number" />
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4">
                Assessment number:
            </label>
            <div class="col-sm-8" id="Assessment_number"></div>
            <input type="hidden" id="hf_assessment_number" name="hf_assessment_number" />
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4">
                Property address:
            </label>
            <div class="col-sm-8" id="Property_address"></div>
            <input type="hidden" id="hf_property_address" name="hf_property_address" />

        </div>

        <div class="form-group">
            <label class="control-label col-sm-4">
                Legal description:
            </label>
            <div class="col-sm-8" id="Legal_description"></div>
            <input type="hidden" id="hf_legal_description" name="hf_legal_description" />

        </div>

        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <iframe id="propertymap" style="width: 400px; height: 400px; display: none;" src=""></iframe>
            </div>
        </div>

        <hr style="color: #f00; background-color: black; height: 3px;" />

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_name">Your name:</label>
            <div class="col-sm-8">
                <input type="text" id="tb_name" name="tb_name" class="form-control" required>
            </div>
        </div>
        <!--
                  <div class="form-group">
            <label class="control-label col-sm-4" for="tb_phonedetails">Contact phone detail(s):</label>
            <div class="col-sm-8">
                <textarea id="tb_phonedetails" name="tb_phonedetails" maxlength="500" class="form-control" required></textarea>
            </div>
        </div>
        -->

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
            <div class="col-sm-8">
                <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control" value="" required />
            </div>
        </div>
        <div class="form-group" id="div_emailconfirm">
            <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
            <div class="col-sm-8">
                <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste required" autocomplete="off" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
