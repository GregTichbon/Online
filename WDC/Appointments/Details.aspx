 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Online.Appointments.Details" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <!--<link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
    <!--1.11.4-->

    <link href="<%: ResolveUrl("~/Content/main.css")%>" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>

    <script type="text/javascript">
        //http://www.ryadel.com/en/using-jquery-ui-bootstrap-togheter-web-page
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        //$.widget.bridge('uitooltip', $.ui.tooltip);
        //$.widget.bridge('uibutton', $.ui.button);
        //$.fn.bstooltip = $.fn.tooltip;
        //$.fn.bsbutton = $.fn.button;
        $.fn.bsbutton = $.fn.button.noConflict();
        $.fn.bstooltip = $.fn.tooltip.noConflict();
    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!--1.11.4-->



    <script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>
    <script src="<%: ResolveUrl("~/Scripts/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/additional-methods.js")%>"></script>
    <!--additional-methods.min.js-->

    <script type="text/javascript" src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/Autosize/autosize.min.js")%>"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/MaxLength/MaxLength.js")%>"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/Numeric/numeric.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/wdc.js")%>"></script>

    <script type="text/javascript">

        var showmap = 0;

        $(document).ready(function () {
            $(document).tooltip({    //this is the ui tooltip
                content: function () {
                    return this.getAttribute("title");
                },
                position: {
                    my: "right center",
                    at: "left center"
                }
            });


            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');



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
                            if (showmap == '1') {
                                $("#propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                                $("#propertymap").show();
                            }
                        }
                    }
                });
            });

              <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>
        });

        function passproperty(line, label, value, area, legaldescription, assessment_no) {
            $("#tb_property").val(value + ' - ' + label);
        }

    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            $("#form1").validate({
                rules: {
                    clientsideonly_tb_emailconfirm: {
                        equalTo: '#tb_emailaddress'
                    }
                },
                messages: {
                    clientsideonly_tb_emailconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    }
                },
                submitHandler: function () {
                    $('#processing').show();
                    form.submit();
                }
            });



        });
    </script>
</head>
<body>
    <div id="processing" style="display:none">
            <img src="../content/processing.gif" class="centered" /></div>

    <div class="container" style="background-color: #FCF7EA">
        <form runat="server" id="form1" class="form-horizontal" role="form">
            <asp:FileUpload ID="fu_dummy" runat="server" Style="display: none" />
            <asp:HiddenField ID="hf_newreference" runat="server" />
            <asp:HiddenField ID="hf_startdatetime" runat="server" />
            <asp:HiddenField ID="hf_enddatetime" runat="server" />

            
            <!--Forces form to be rendered with enctype="multipart/form-data" -->
            <div>
                <h1>Appointment Details
                </h1>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_reference">Reference number:</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_appointment">Appointment time:</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="tb_appointment" name="tb_appointment" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>

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
            <label class="control-label col-sm-4" for="tb_propertynumber">Enter the property number: <img src="../Images/questionsmall.png" title="This is the number allocated to every property by the Whanganui District Council.  This can be found on all of the WDC correspondence relating to the property" /></label>
            <div class="col-sm-8">
                <input type="text" id="tb_propertynumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_assessmentnumber" style='display: none'>
            <label class="control-label col-sm-4" for="tb_assessmentnumber">Enter the property assessment: <img src="../Images/questionsmall.png" title="This is the reference provided by QV.  It will be in a form similar to 1327054401 or 1327054401A" /></label>
            <div class="col-sm-8">
                <input type="text" id="tb_assessmentnumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_address">
            <label class="control-label col-sm-4" for="tb_address">Please start typing the address: <img src="../Images/questionsmall.png" title="Please separate the address parts with spaces eg: Flat 4 77 C Whatever St.  Also use the abbreviated version of the road type eg: Ave, Rd, St, Tce etc." /></label>
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
                    <label class="control-label col-sm-4" for="tb_name"></label>
                    <div class="col-sm-8">
                        <input type="text" id="tb_property" name="tb_property" class="form-control" readonly="readonly" required="required" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_name">Name</label>
                    <div class="col-sm-8">
                        <input type="text" id="tb_name" name="tb_name" class="form-control" maxlength="100" required="required" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
                    <div class="col-sm-8">
                        <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control inhibitcutcopypaste" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
                    <div class="col-sm-8">
                        <input id="tb_emailconfirm" name="clientsideonly_tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste" required="required" autocomplete="off" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_contactphone">
                        Phone details
            <img src="../Images/questionsmall.png" title="Please provide us with your phone details so that we can contact you if need be." /></label>
                    <div class="col-sm-8">
                        <textarea id="tb_contactphone" name="tb_contactphone" class="form-control" rows="4" maxlength="500" required="required"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_information">
                        Other useful information
            <img src="../Images/questionsmall.png" title="Please provide with any information that might be useful for your meeting with us." /></label>
                    <div class="col-sm-8">
                        <textarea id="tb_information" name="tb_information" class="form-control" rows="4" maxlength="500"></textarea>
                    </div>
                </div>

                <!--
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_detail">
                        Attachments
            <img src="../Images/questionsmall.png" title="Please feel free to upload any attachments, documents, photos etc that may be useful." /></label>
                    <div class="col-sm-8">
                        <input id="fu_attachments" name="fu_attachments" type="file" multiple="multiple" />

                    </div>
                </div>
                -->

                <div class="form-group">
                    <div class="col-sm-4">
                    </div>
                    <div class="col-sm-8">
                        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
                    </div>
                </div>















            </div>
        </form>
    </div>
</body>
</html>
