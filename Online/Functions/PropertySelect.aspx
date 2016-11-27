<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PropertySelect.aspx.cs" Inherits="Online.data.PropertySelect" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Whanganui District Council Property Select</title>

    <link href="<%: ResolveUrl("~/Scripts/colorbox/colorbox.css")%>" rel="stylesheet" />

    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>
    <script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>
    <script src="<%: ResolveUrl("~/Scripts/colorbox/jquery.colorbox-min.js")%>"></script>



    <link href='../Scripts/ToolTipster/css/tooltipster.css' rel="stylesheet" />

    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

  <style>
        .ui-autocomplete-loading {
            background: white url("http://wdc.whanganui.govt.nz/online/images/processing_16x16.gif") right center no-repeat;
        }
        .ui-menu-item a {
            font-size:10px;
        }
  </style>

    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/jquery-2.1.4.min.js'></script>
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/wdc.js'></script>
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/ToolTipster/js/jquery.tooltipster.min.js'></script>
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/colorbox/jquery.colorbox-min.js'></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>


    <script type="text/javascript">
        var address;
        $(document).ready(function () {
            $('body').height(130);
            //alert($('body').height());

            $("#pagehelp").colorbox({ href: "defaulthelp.html", iframe: true, height: "400", width: "400", overlayClose: false, escKey: false });

            $("#ddl_searchby").change(function () {
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
                    $('body').height(600);
                }

            });

            /*
            $(function () {
                var availableTags = [
                  "ActionScript",
                  "AppleScript",
                  "Asp",
                  "BASIC",
                  "C",
                  "C++",
                  "Clojure",
                  "COBOL",
                  "ColdFusion",
                  "Erlang",
                  "Fortran",
                  "Groovy",
                  "Haskell",
                  "Java",
                  "JavaScript",
                  "Lisp",
                  "Perl",
                  "PHP",
                  "Python",
                  "Ruby",
                  "Scala",
                  "Scheme"
                ];
                $("#tb_address").autocomplete({
                    source: "data.asmx/Test"
                });
            });
            */


            $("#tb_address").autocomplete({
                source: "data.asmx/PropertySelect?mode=address",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    selectedproperty(ui.item ?
                        address.label + "<br>" + address.legaldescription + " " + address.area + "<br>" + "Property Number: " + address.value + "<br>Assessment Number: " + address.assessment_no :
                        "Nothing selected, input was " + this.value);
                }

            })
            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  .append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .appendTo(ul);
            };


            function selectedproperty(message) {
                $("#selectedproperty").html(message);
                $(".selectedproperty").show();
                //$("#btn_select").show();
            }

            $("#btn_search").click(function () {
                var mode = $("#ddl_searchby").val();
                if (mode == "Property Number") {
                    $('body').height(300);
                    var term = $("#tb_propertynumber").val();
                } else {
                    $('body').height(300);
                    var term = $("#assessmentnumber").val();
                }
                $.ajax({
                    url: "data.asmx/PropertySelect?mode=" + mode + "&term=" + term, success: function (result) {
                        property = $.parseJSON(result);
                        address = property[0];
                        selectedproperty(address.label + "<br>" + address.legaldescription + " " + address.area + "<br>" + "Property Number: " + address.value + "<br>Assessment Number: " + address.assessment_no);
                    }
                });
            });

            $("#btn_select").click(function () {
                $(".selectedproperty").hide();
                //$("#div_main").height(130);
                $('body').height(130);
                window.parent.passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no)
            });

        });
  </script>


</head>
<body style="align-content:center">
    <form id="form1" runat="server">
             <table class="table table-hover table-responsive">
                <tr>
                    <td class="col-md-4 text-right">Search by: </td>
                    <td>

                        <asp:DropDownList ID="ddl_searchby" runat="server">
                            <asp:ListItem>Property Number</asp:ListItem>
                            <asp:ListItem>Assessment Number</asp:ListItem>
                            <asp:ListItem>Property Address</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>

                <tr id="tr_propertynumber">
                    <td class="col-md-4 text-right">Enter the property number </td>
                    <td>
                        <asp:TextBox ID="tb_propertynumber" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr id="tr_assessmentnumber" style='display: none'>
                    <td class="col-md-4 text-right">Enter the assessment number </td>
                    <td>
                        <asp:TextBox ID="tb_assessmentnumber" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr id="tr_address" style='display: none'>
                    <td class="col-md-4 text-right">Address</td>
                    <td>
                            <asp:TextBox ID="tb_address" runat="server" ToolTip="Start typing the address"></asp:TextBox>
                    </td>
                </tr>
                <tr id="tr_search">
                    <td></td>
                    <td>
                        <input id="btn_search" value="Search" type="button" />
                    </td>
                </tr>


                 <tr class="selectedproperty">
                     <td></td>
                     <td id="selectedproperty">
                        

                     </td>
                 </tr>
                 <tr class="selectedproperty" style="display:none">
                     <td></td>
                     <td>
                         <input id="btn_select" value="Use this address" type="button" /></td>
                 </tr>
                 </table>

    </form>
    		<script type="text/javascript" src="../scripts/Iframeresizer/iframeResizer.contentWindow.min.js" defer="defer"></script>

</body>
</html>
