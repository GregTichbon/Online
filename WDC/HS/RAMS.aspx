<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RAMS.aspx.cs" Inherits="Online.HS.RAMS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "RAMS.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                ignore: [],
            });

            var repeaternames = ['risk'];
            var repeatercounters = [0];
            for (var i = 0, len = repeaternames.length; i < len; i++) {
                repeatername = repeaternames[i];
                $('.add' + repeatername).click(function () {
                    repeatername = $(this).attr("id").substring(3);
                    var cloned = $('#tr_' + repeatername + '_').clone(true)
                    var i = repeaternames.indexOf(repeatername);
                    repeatercounters[i]++;
                    cloned = cloned.repeater_changer(repeatercounters[i]);
                    var place = $('#table_' + repeatername + ' tr:last');
                    if ($(this).data('footer') >= 1) {
                        cloned.insertBefore(place);
                    } else {
                        cloned.insertAfter(place);
                    }
                    return false;
                });

                $('body').on('click', '.delete' + repeatername, function () {
                    repeatername = $(this).attr("id").substring(11);
                    trid = 'tr_' + repeatername;
                    $('#' + trid).remove();
                    var xx = repeatername.split("_");
                    switch (xx[0]) {
                        case 'risk':
                            break;
                            //default:
                            //alert('*' + xx[0] + '*');
                    }
                });

                $('body').on('click', '.edit' + repeatername, function () {
                    repeatername = $(this).attr("id").substring(14);
                    $('#dd_category').val($('#repeat_risk_dd_category_' + repeatername).val());
                    $('#tb_risk').val($('#repeat_risk_tb_risk_' + repeatername).val());
                    $('#tb_hazard').val($('#repeat_risk_tb_hazard_' + repeatername).val());
                    $('#tb_control').val($('#repeat_risk_tb_control_' + repeatername).val());
                    $('#dd_em').val($('#repeat_risk_dd_em_' + repeatername).val());
                    $('#dd_rate').val($('#repeat_risk_dd_rate_' + repeatername).val());
                    $('#tb_responsible').val($('#repeat_risk_tb_responsible_' + repeatername).val());
                    $("#dialog-form").dialog("open");
                });
            }

            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 400,
                width: 600,
                modal: true,
                buttons: {
                    Cancel: function () {
                        dialog.dialog("close");
                    }
                },
                close: function () {
                    //form[0].reset();
                    //allFields.removeClass("ui-state-error");
                }
            });
        });




    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Health and Safety RAMS
    </h1>



    <div class="form-group">
        <label class="control-label col-sm-12" for="xxxxxx">xxxxxxxxxxxxxxxxxxxxxx</label>
        <div class="col-sm-12">


            <a href="javascript:void(0);" class="addrisk" id="addrisk" data-footer="1">Add</a>
            <div class="table-responsive table-bordered">
                <table class="table" id="table_risk">
                    <thead>
                        <tr>
                            <th class="col-md-1">Category</th>
                            <th class="col-md-2">Risk</th>
                            <th class="col-md-2">Hazards</th>
                            <th class="col-md-2">Control</th>
                            <th class="col-md-1">E/M</th>
                            <th class="col-md-1">Rate</th>
                            <th class="col-md-2">Responsible</th>
                            <th class="col-md-1">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="3" id="riskapplied" style="text-align: right"></td>
                            <td id="riskgranted" style="text-align: right"></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>



    <!-- REPEATER SECTION-->
    <div style="display: <%:none%>">
        <table>
            <tr id="tr_risk_">
                <td>
                    <select id="repeat_risk_dd_category_" name="repeat_risk_dd_category_" class="form-control" required>
                        <%= Online.WDCFunctions.WDCFunctions.populateselect(category, "","") %>
                    </select>
                </td>
                <td>
                    <textarea id="repeat_risk_tb_risk_" name="repeat_risk_tb_risk_" class="form-control" required></textarea>
                </td>
                <td>
                    <textarea id="repeat_risk_tb_hazard_" name="repeat_risk_tb_hazard_" class="form-control" required></textarea>
                </td>
                <td>
                    <textarea id="repeat_risk_tb_control_" name="repeat_risk_tb_control_" class="form-control" required></textarea>
                </td>

                <td>
                    <select id="repeat_risk_dd_em_" name="repeat_risk_dd_em_" class="form-control" required>
                        <%= Online.WDCFunctions.WDCFunctions.populateselect(em, "","") %>
                    </select>
                </td>

                <td>
                    <select id="repeat_risk_dd_rate_" name="repeat_risk_dd_rate_" class="form-control" required>
                        <%= Online.WDCFunctions.WDCFunctions.populateselect(rate, "","") %>
                    </select>
                </td>

                <td>
                    <textarea id="repeat_risk_tb_responsible_" name="repeat_risk_tb_responsible_" class="form-control" required></textarea>
                </td>
                <td><a href="javascript:void(0)" id="href_deleterisk_" class="deleterisk repeatupdateid">Delete</a> / <a href="javascript:void(0)" id="href_editrisk_" class="editrisk repeatupdateid">Edit</a></td>
            </tr>
        </table>
    </div>
    <!-- END OF REPEATER SECTION -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div id="dialog-form" title="Edit item">

        <form>
            <select id="dd_category" name="dd_category" class="form-control" required>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(category, "","") %>
            </select>
            <textarea id="tb_risk" name="tb_risk" class="form-control" required></textarea>
            <textarea id="tb_hazard" name="tb_hazard" class="form-control" required></textarea>
            <textarea id="tb_control" name="tb_control" class="form-control" required></textarea>
            <select id="dd_em" name="dd_em" class="form-control" required>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(em, "","") %>
            </select>
            <select id="dd_rate" name="dd_rate" class="form-control" required>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(rate, "","") %>
            </select>
            <textarea id="tb_responsible" name="tb_responsible" class="form-control" required></textarea>
            <!-- Allow form submission with keyboard without duplicating the dialog button -->
            <input type="submit" tabindex="-1" style="position: absolute; top: -1000px">
        </form>
    </div>
</asp:Content>
