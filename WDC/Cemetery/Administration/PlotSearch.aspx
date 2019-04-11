<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlotSearch.aspx.cs" Inherits="Online.Cemetery.Administration.PlotSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="<%: ResolveUrl("~/scripts/CascadingDropdown/jquery.cascadingdropdown.min.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('#div_plot').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#dd_cemetery',
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Cemeteries', function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    }
                                }));
                            })
                        }
                    },
                    {
                        selector: '#dd_area',
                        requires: ['#dd_cemetery'],
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Areas', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#dd_division',
                        requires: ['#dd_cemetery', '#dd_area'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Divisions', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },

                    {
                        selector: '#dd_plot',
                        requires: ['#dd_cemetery', '#dd_area', '#dd_division'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Plots', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        },


                        onChange: function (event, value, requiredValues, requirementsMet) {

                            if (!requirementsMet) {
                                $("#btn_submit").prop('disabled', true);
                                return;
                            }
                            //standardised.loading(true);
                            $("#btn_submit").prop('disabled', false);
                            $.ajax({
                                url: "../data.asmx/Plot?plotid=" + value, success: function (result) {
                                    jresult = $.parseJSON(result);
                                    record = jresult[0];
                                    $('#hf_key').val(value);
                                    $('#tb_remarks').val(record.remarks);
                                    $('#div_used').html(record.person);
                                    $('#div_gis').html(record.gis);
                                    $('#div_returned').show();
                                }
                            });
                        }
                    }
                ]
            });

 
        }); //document ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <h1>Cemetery - Plot Selection</h1>

        <div id="div_plot">
            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_cemetery">Cemetery</label><div class="col-sm-8">
                    <select id="dd_cemetery" name="cemetery">
                        <option></option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_area">Area</label><div class="col-sm-8">
                    <select id="dd_area" name="area">
                        <option></option>
                    </select>
                </div>
            </div>



            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_division">Division</label><div class="col-sm-8">
                    <select id="dd_division" name="division">
                        <option></option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_plot">Plot</label><div class="col-sm-8">
                    <select id="dd_plot" name="plot">
                        <option></option>
                    </select>
                </div>
            </div>

            <input type="hidden" id="hf_key" value="" />

            <div id="div_returned" style="display: none">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_remarks">Remarks</label><div class="col-sm-8">
                        <textarea id="tb_remarks" class="form-control" rows="4"></textarea>
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-sm-4" for="div_gis">Plotted</label><div class="col-sm-8">

                        <span id="div_gis"></span>

                    </div>

                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="div_used">Used</label><div class="col-sm-8">
                        <table class="table table-striped">
                            <tr><th>Client</th><th>Type</th><th>Date</th><th>Detail</th><th>Remarks</th><th>Status</th></tr>
                            <tr>
                                <td id="div_used"></td>
                                <td>To DO</td>
                                <td>To DO</td>
                                <td>To DO</td>
                                <td>To DO</td>
                                <td>To DO</td>
                            </tr>
                        </table>
                    </div>
                </div>

            </div>
        </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
