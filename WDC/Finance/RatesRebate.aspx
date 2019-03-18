<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RatesRebate.aspx.cs" Inherits="Online.Finance.RatesRebate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        var showmap = 0;
        var this_year = 2019;
        var rates = 0;
        var horizonsrates = 0;
        var property;

        $(document).ready(function () {

            <%= Online.WDCFunctions.WDCFunctions.testaccess() %>

            $("#pagehelp").colorbox({ href: "RatesRebateHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $(".money").numeric({ negative: false, decimalPlaces: 2 });
            $(".int").numeric({ negative: false, decimal: false });

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

                        getrates();

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

                            getrates();

                            if (showmap == '1') {
                                $("#propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                                $("#propertymap").show();
                            }
                        }
                    }
                });
            });

            $('#btn_calculate').click(function () {

                startingrates = (rates - 160) * 2 / 3;
                //alert('startingrates = ' + startingrates);

                allowedincome = 25180 + (500 * $('#tb_dependants').val());
                //alert('allowedincome = ' + allowedincome);

                deduction = ($('#tb_grossincome').val() - allowedincome) / 8;
                //alert('deduction = ' + deduction);

                rebate = startingrates - deduction;

                if (rebate < 0) {
                    rebate = 0;
                } else if (rebate > 630) {
                    rebate = 630
                }

                $('#tb_rebate').val('$' + rebate.toFixed(2));

            });
              <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document ready

        function passproperty(line, label, value, area, legaldescription, assessment_no) {
            $("#tb_property").val(value + ' - ' + label);
            property = value;
        }

        function getrates() {
            $.ajax({
                url: "../functions/data.asmx/GetAnnualRates?property=" + property + '&year=' + this_year,
                async: false,
                success: function (result) {
                    rates = parseFloat((parseFloat(result) * .975).toFixed(2));
                }
            });
            $('#tb_rates').val('$' + rates.toFixed(2));

            $.ajax({
                url: "../functions/data.asmx/GetAnnualHorizonsRates?property=" + property,
                async: false,
                success: function (result) {
                    if (result == 'Not Found') {
                        $('#tb_horizonsrates').val(result);
                    } else {
                        horizonsrates = parseFloat((parseFloat(result) * .97).toFixed(2));
                        rates = rates + horizonsrates;
                        $('#tb_horizonsrates').val('$' + horizonsrates.toFixed(2));
                    }
                }
            });

            $('#tb_combinedrates').val('$' + rates.toFixed(2));

        }

    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Rates Rebate</h1>
    <h2>Estimate Calculator</h2>

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
            <label class="control-label col-sm-4" for="tb_propertynumber">
                Enter the property number:
                <img src="../Images/questionsmall.png" title="This is the number allocated to every property by the Whanganui District Council.  This can be found on all of the WDC correspondence relating to the property" /></label>
            <div class="col-sm-8">
                <input type="text" id="tb_propertynumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_assessmentnumber" style='display: none'>
            <label class="control-label col-sm-4" for="tb_assessmentnumber">
                Enter the property assessment:
                <img src="../Images/questionsmall.png" title="This is the reference provided by QV.  It will be in a form similar to 1327054401 or 1327054401A" /></label>
            <div class="col-sm-8">
                <input type="text" id="tb_assessmentnumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_address">
            <label class="control-label col-sm-4" for="tb_address">
                Please start typing the address:
                <img src="../Images/questionsmall.png" title="Please separate the address parts with spaces eg: Flat 4 77 C Whatever St.  Also use the abbreviated version of the road type eg: Ave, Rd, St, Tce etc." /></label>
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
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_property"></label>
        <div class="col-sm-8">
            <input type="text" id="tb_property" name="tb_property" class="form-control" readonly="readonly" required="required" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_rates">Whanganui District Council Rates</label>
        <div class="col-sm-8">
            <input type="text" id="tb_rates" name="tb_rates" class="form-control" readonly="readonly" required="required" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_rates">Horizon's Rates</label>
        <div class="col-sm-8">
            <input type="text" id="tb_horizonsrates" name="tb_horizonsrates " class="form-control" readonly="readonly" required="required" />
        </div>
    </div>
        <div class="form-group">
        <label class="control-label col-sm-4" for="tb_rates">Combined Rates</label>
        <div class="col-sm-8">
            <input type="text" id="tb_combinedrates" name="tb_combinedrates " class="form-control" readonly="readonly" required="required" />
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_grossincome">Total Gross Income</label>
        <div class="col-sm-8">
            <input id="tb_grossincome" name="tb_grossincome" class="form-control numericX money" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dependants">Number of Dependants</label>
        <div class="col-sm-8">
            <input id="tb_dependants" name="tb_dependants" class="form-control numericX int" required />
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <button id="btn_calculate" type="button" class="btn btn-info">Calculate</button>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_rebate">You may qualify for an estimated rebate of </label>
        <div class="col-sm-8">
            <input type="text" id="tb_rebate" name="tb_rebate" class="form-control" readonly="readonly" required="required" />
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
