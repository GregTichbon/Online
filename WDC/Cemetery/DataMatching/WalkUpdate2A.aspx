<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WalkUpdate2A.aspx.cs" Inherits="Online.Cemetery.DataMatching.WalkUpdate2A" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />


    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script> 

    <style>
        .form-horizontal .control-label {
            text-align: left;
        }
    </style>
    <script type="text/javascript" src="<%: ResolveUrl("~/scripts/CascadingDropdown/jquery.cascadingdropdown.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/scripts/webcamjs/webcam.min.js")%>"></script>

    <script type="text/javascript">
        var datamode = 'GIS';

        function take_snapshot() {
            Webcam.snap(function (data_uri) {
                document.getElementById('snapshot').innerHTML = '<img src="' + data_uri + '"/>';

                var raw_image_data = data_uri.replace(/^data\:image\/\w+\;base64\,/, '');
                document.getElementById('hf_snapshot').value = raw_image_data;
            });
        }

        $(document).ready(function () {
            //alert(parent.cemetery + ', ' + parent.area+ ', ' + parent.division);

            /*
            $("#std_area").change(function () {
                alert('area changed');
            });
            */

            $(document).keypress(function (event) {
                if (event.charCode == 13 && $('#btn_update').attr('disabled') != 'disabled') {
                    $('#btn_update').click();
                } else if (event.charCode == 96) {
                    //alert(1);
                    take_snapshot();
                }
            });

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
                        selector: '#std_division',
                        requires: ['#std_cemetery', '#std_area'],
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
                        requires: ['#std_cemetery', '#std_area', '#std_division'],
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
                parent.division = $("#std_division").prop('selectedIndex') - 1;
                parent.jQuery.colorbox.close();
            });

            $('#std_cemetery').focus();
        });

    </script>
</head>
<body>

    <div class="container" style="background-color: #FCF7EA">
        <form method="post" action="./WalkUpdate2.aspx?id=G42" id="form1" class="form-horizontal" role="form">
            
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
            <table style="width:100%">
                <tr>
                    <td style="width:50%">
                        <div id="camera" style="width: 320px; height: 240px;"></div>
                    </td>
                    <td style="width:50%">
                        <div id="snapshot"></div>
                    </td>
                </tr>
            </table>
            <script>
                Webcam.attach('#camera');

 
            </script>
            <a href="javascript:void(take_snapshot())">Take Snapshot</a>

            <div id="standardised">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="std_cemetery">Cemetery</label>
                    <label class="control-label col-sm-2" for="std_area">Area</label>
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
                        <input type="button" id="btn_update" value="Update" class="btn btn-info submit" disabled="disabled" />
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
