<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlotSelection.aspx.cs" Inherits="Online.Cemetery.Sexton.PlotSelection" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />


    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
    <!--1.11.4-->

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>


    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>


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
                            $.ajax({
                                url: "../data.asmx/Plot?key=" + value, success: function (result) {
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

            $('#btn_select').click(function () {
                key = $('#hf_key').val();
                label = $('#dd_cemetery option:selected').text() + " " + $('#dd_area option:selected').text() + " " + $('#dd_block option:selected').text() + " " + $('#dd_plot option:selected').text();


                parent.$("#tb_internment_plot").val(key + ':' + label);
                //console.log(parent.jQuery("#dialog"));
                parent.$('#dialog').dialog("close");

            });


        }); //document ready
    </script>
</head>
<body>
    <div class="container" style="background-color: #FCF7EA; width:700px">
        <form runat="server" id="form1" class="form-horizontal" role="form">
  
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
                        ADD
                    </div>
                </div>

      

                <input type="hidden" id="hf_key" value="" />

                <div id="div_returned" style="display: none">
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_remarks">Remarks</label><div class="col-sm-8">
                            <textarea id="tb_remarks" class="form-control" rows="4" readonly="readonly"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="div_used">Used</label><div class="col-sm-8">
                            <span id="div_used"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="div_gis">Plotted</label><div class="col-sm-8">
                            <span id="div_gis"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-8">
                            <input id="btn_select" type="button" value="Select" class="btn btn-info submit" />
                        </div>
                    </div>

                </div>
            </div>
        </form>
    </div>
</body>
</html>
