<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cascadingdropdown3.aspx.cs" Inherits="Online.TestAndPlay.Cascadingdropdown3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="<%: ResolveUrl("~/scripts/CascadingDropdown/jquery.cascadingdropdown.min.js")%>"></script>
    <script type="text/javascript">
        var datamode = 'GIS';

        $(document).ready(function () {


            $('#standardised').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#std_cemetery',
                        source: function (request, response) {
                            $.getJSON('../cemetery/data.asmx/Cemeteries', function (data) {
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
                        selector: '#std_area',
                        requires: ['#std_cemetery'],
                        source: function (request, response) {
                            request.datamode = datamode;
                            $.getJSON('../cemetery/data.asmx/Areas', request, function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#std_block',
                        requires: ['#std_cemetery', '#std_area'],
                        requireAll: true,
                        source: function (request, response) {
                            request.datamode = datamode;
                            $.getJSON('../cemetery/data.asmx/Blocks', request, function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    };
                                }));
                            });
                        }
                    },
                    /*
                    {
                        selector: '#std_division',
                        requires: ['#std_cemetery', '#std_area', '#std_block'],
                        requireAll: true,
                        source: function (request, response) {
                            request.datamode = datamode;
                            $.getJSON('../cemetery/data.asmx/Divisions', request, function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    };
                                }));
                            });
                        }
                    },
                    */
                    {
                        selector: '#std_plot',
                        requires: ['#std_cemetery', '#std_area', '#std_block', '#std_divison'],
                        requireAll: true,
                        source: function (request, response) {
                            alert(1);
                            request.datamode = datamode;
                            $.getJSON('../data.asmx/cemetery/Divisions', request, function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    };
                                }));
                            });
                        }
                    }
                ]
            });



        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="standardised">
        <div class="form-group">
            <label class="control-label col-sm-4" for="std_cemetery">Cemetery</label>
            <div class="col-sm-8">
                <select id="std_cemetery" name="cemetery" class="form-control">
                    <option></option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="std_area">Area</label>
            <div class="col-sm-8">
                <select id="std_area" name="area" class="form-control">
                    <option></option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="std_block">Block</label>
            <div class="col-sm-8">
                <select id="std_block" name="block" class="form-control">
                    <option></option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="std_division">Division</label>
            <div class="col-sm-8">
                <select id="std_division" name="division" class="form-control">
                    <option></option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="std_plot">Plot</label>
            <div class="col-sm-8">
                <select id="std_plot" name="plot" class="form-control">
                    <option></option>
                </select>
            </div>
        </div>

      </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>


