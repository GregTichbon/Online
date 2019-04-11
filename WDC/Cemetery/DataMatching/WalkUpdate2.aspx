<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WalkUpdate2.aspx.cs" Inherits="Online.Cemetery.DataMatching.WalkUpdate2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <style>
        .form-horizontal .control-label{
            text-align: left;
        }
    </style>
    <script type="text/javascript" src="<%: ResolveUrl("~/scripts/CascadingDropdown/jquery.cascadingdropdown.min.js")%>"></script>

    <script src="../../scripts/webcamjs/webcam.min.js"></script>


    <script type="text/javascript">
        var datamode = 'GIS';



        $(document).ready(function () {
            //alert(parent.cemetery + ', ' + parent.area + ', ' + parent.block + ', ' + parent.division);

            /*
            $("#std_area").change(function () {
                alert('area changed');
            });
            */

            //There is a small issue, where a dropdown is changed by the user, the dependant dropdowns still use the parent values when they should really be set to -1
            //The problem is trying to identify that it was a human that changed it rather than the parent values

            $('#standardised').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#std_cemetery',
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Cemeteries', function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value,
                                        selected: index == parent.cemetery
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
                            $.getJSON('../data.asmx/Areas', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value,
                                        selected: index == parent.area
                                        //selected: index == 0 //selectOnlyOption
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
                            $.getJSON('../data.asmx/Blocks', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value,
                                        selected: index == parent.block
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },

                    {
                        selector: '#std_division',
                        requires: ['#std_cemetery', '#std_area', '#std_block'],
                        requireAll: true,
                        source: function (request, response) {
                            request.datamode = datamode;
                            $.getJSON('../data.asmx/Divisions', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value,
                                        selected: index == parent.division
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },

                    {
                        selector: '#std_plot',
                        requires: ['#std_cemetery', '#std_area', '#std_block', '#std_division'],
                        requireAll: true,
                        source: function (request, response) {
                            request.datamode = datamode;
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
                                $("#btn_update").prop('disabled', true);
                                return;
                            }
                            //standardised.loading(true);
                            $("#btn_update").prop('disabled', false);
                        }
                    }
                ]
            });

            $("#btn_update").click(function () {
                var arForm = $("#form1")
                    .find("#hf_plotid, #std_plot, #hf_snapshot")
                    .serializeArray();

                //console.log(arForm);

                var formData = JSON.stringify({ formVars: arForm });
                //console.log(formData);

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    url: '../posts.asmx/walkupdate', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        //alert(result);
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }

                })
                //alert('See: community contracts posts.asmx applicationupload')
                parent.cemetery = $("#std_cemetery").prop('selectedIndex') - 1;
                parent.area = $("#std_area").prop('selectedIndex') - 1;
                parent.block = $("#std_block").prop('selectedIndex') - 1;
                parent.division = $("#std_division").prop('selectedIndex') - 1;
                parent.jQuery.colorbox.close();
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Plot Identification</h3>
    <input id="hf_snapshot" type="hidden" name="hf_snapshot" value="" />
    <input id="hf_plotid" type="hidden" name="hf_plotid" value="<%: plot_id%>" />
    <% if (1 == 2)
        { %>
    $.ajax({
                            url: "../data.asmx/Update_PlotLocation?plotid=" + '<%: plot_id%>' + "&GISID=" + $('#std_plot').val(), success: function (result) {
                                response = $.parseJSON(result);
                            }
                        });
    <%} %>
    <asp:Literal ID="lit_GIS" runat="server"></asp:Literal><br />

    <div id="camera" style="width: 320px; height: 240px;"></div>
    <div id="snapshot"></div>
    <script>
        Webcam.attach('#camera');

        function take_snapshot() {
            Webcam.snap(function (data_uri) {
                document.getElementById('snapshot').innerHTML = '<img src="' + data_uri + '"/>';

                var raw_image_data = data_uri.replace(/^data\:image\/\w+\;base64\,/, '');
                document.getElementById('hf_snapshot').value = raw_image_data;
            });
        }
    </script>
    <a href="javascript:void(take_snapshot())">Take Snapshot</a>

    <div id="standardised">
        <div class="form-group">
            <label class="control-label col-sm-3" for="std_cemetery">Cemetery</label>
            <label class="control-label col-sm-2" for="std_area">Area</label>
            <label class="control-label col-sm-2" for="std_block">Block</label>
            <label class="control-label col-sm-2" for="std_division">Division</label>
            <label class="control-label col-sm-2" for="std_plot">Plot</label>
        </div>
        <div class="form-group">
            <div class="col-sm-3">
                <select id="std_cemetery" name="cemetery" class="form-control">
                    <option></option>
                </select>
            </div>

            <div class="col-sm-2">
                <select id="std_area" name="area" class="form-control">
                    <option></option>
                </select>
            </div>

            <div class="col-sm-2">
                <select id="std_block" name="block" class="form-control">
                    <option></option>
                </select>
            </div>

            <div class="col-sm-2">
                <select id="std_division" name="division" class="form-control">
                    <option></option>
                </select>
            </div>

            <div class="col-sm-2">
                <select id="std_plot" name="plot" class="form-control">
                    <option></option>
                </select>
            </div>

            <div class="col-sm-1">
                <input type="button" id="btn_update" value="Update" disabled />
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
