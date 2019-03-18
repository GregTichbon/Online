<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlotEntry.aspx.cs" Inherits="Online.Cemetery.Sexton.PlotEntry" %>

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
                            $.getJSON('../data.asmx/Areas?datamode=GIS', request, function (data) {
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
                        selector: '#dd_block',
                        requires: ['#dd_cemetery', '#dd_area'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Blocks?datamode=GIS', request, function (data) {
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
                        requires: ['#dd_cemetery', '#dd_area', '#dd_block'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Divisions?datamode=GIS', request, function (data) {
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
                        requires: ['#dd_cemetery', '#dd_area', '#dd_block', '#dd_division'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Plots?datamode=GIS', request, function (data) {
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
                        }
                    }
                ]
            });

            $("#form1").validate();

        }); //document ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_plotid">Plot ID</label>
        <div class="col-sm-8">
            <input id="tb_plotid" name="tb_plotid" type="text" class="form-control" />
        </div>
    </div>

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
            <label class="control-label col-sm-4" for="dd_block">Block</label><div class="col-sm-8">
                <select id="dd_block" name="block">
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
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_modifier">Modifier</label><div class="col-sm-8">
            <select id="dd_modifier" name="modifier">
                <option></option>
                <option>In space to the left</option>
                <option>In space to the right</option>
                <option>Scattered near</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_remarks">Remarks</label><div class="col-sm-8">
            <textarea id="tb_remarks" name="tb_remarks" class="form-control" rows="4" maxlength="500" required></textarea>
        </div>
    </div>
     <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input id="btn_submit" type="button" value="Search" class="btn btn-info submit" />
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
