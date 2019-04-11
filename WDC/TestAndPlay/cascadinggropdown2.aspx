<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="cascadinggropdown2.aspx.cs" Inherits="Online.TestAndPlay.cascadinggropdown2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../scripts/CascadingDropdown/jquery.cascadingdropdown.min.js"></script>
    <script type="text/javascript">
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
                        selector: '.step2',
                        requires: ['#std_cemetery'],
                        source: function (request, response) {
                            $.getJSON('../cemetery/data.asmx/Areas', request, function (data) {
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
                        selector: '.step3',
                        requires: ['#std_cemetery', '.step2'],
                        source: function (request, response) {
                            $.getJSON('../cemetery/data.asmx/Blocks', request, function (data) {
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
                        selector: '.step4',
                        requires: ['#std_cemetery', '.step2', '.step3'],
                        source: function (request, response) {
                            $.getJSON('../cemetery/data.asmx/Divisions', request, function (data) {
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
                        selector: '.step5',
                        requires: ['#std_cemetery', '.step2', '.step3', '.step4'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('../cemetery/data.asmx/Plots', request, function (data) {
                                var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0
                                    };
                                }));
                            });
                        },
                        onChange: function (event, value, requiredValues, requirementsMet) {
                            //alert(requirementsMet);
                            if (!requirementsMet) return;
                            //alert('here');

                            //standardised.loading(true);

                            var ajaxData = requiredValues;
                            ajaxData[this.el.attr('name')] = value;
                            alert(value);
                            $.getJSON('../cemetery/data.asmx/xxxx', ajaxData, function (data) {

                                alert(data);
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


        <select id="std_cemetery" name="cemetery">
            <option></option>
        </select>
        <select class="step2" name="area">
            <option></option>
        </select>
        <select class="step3" name="block">
            <option></option>
        </select>
        <select class="step4" name="division">
            <option></option>
        </select>
        <select class="step5" name="plots">
            <option></option>
        </select>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
