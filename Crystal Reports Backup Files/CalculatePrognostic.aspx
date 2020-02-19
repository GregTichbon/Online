<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CalculatePrognostic.aspx.cs" Inherits="DataInnovations.Row.CalculatePrognostic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Prognostics</title>
    <!-- Style Sheets -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous" />

    <style>
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script src="../Dependencies/CascadingDropDown/jquery.cascadingdropdown.min.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {

            $('#div_prognostic').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#dd_discipline',
                        source: function (request, response) {
                            $.getJSON('data.asmx/discipline', function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    }
                                }));
                            })
                        },
                        onChange: function (event, value, requiredValues, requirementsMet) {
                            $('#html').html('');
                        }
                    },
                    {
                        selector: '#dd_boat',
                        requires: ['#dd_discipline'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('data.asmx/boat', request, function (data) {
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
                            $('#html').html('');
                        }
                    },
                    {
                        selector: '#dd_division',
                        requires: ['#dd_discipline', '#dd_boat'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('data.asmx/division', request, function (data) {
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
                            $('#html').html('');
                        }
                    },
                    {
                        selector: '#dd_gender',
                        requires: ['#dd_discipline', '#dd_boat', '#dd_division'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('data.asmx/gender', request, function (data) {
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
                            $('#html').html('');
                            if (!requirementsMet) {
                                //$("#btn_submit").prop('disabled', true);
                                //alert('Requirements not met');
                                return;
                            }
                            //alert('Requirements met');
                            //standardised.loading(true);
                            //$("#btn_submit").prop('disabled', false);
                            $.ajax({
                                url: "data.asmx/prognostic?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#dd_division').val() + "&gender=" + $('#dd_gender').val(), success: function (result) {
                                    jresult = $.parseJSON(result);
                                    record = jresult[0];
                                    prognostic_ctr = record.prognostic_ctr;
                                    description = record.description;
                                    code = record.code;
                                    seats = record.seats;
                                    coxed = record.coxed;
                                    prognostictime = record.prognostictime;

                                    if (seats != 1) {
                                        var divisionoptions = "";
                                        $.ajax({
                                            url: "data.asmx/division?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val(),
                                            dataType: 'json',
                                            async: false,
                                            success: function (data) {
                                                $.each(data, function (i, item) {
                                                    if ($('#dd_division').val() == item.value) {
                                                        selected = ' selected';
                                                    } else {
                                                        selected = '';
                                                    }
                                                    divisionoptions += '<option value="' + item.value + '"' + selected + '>' + item.label + '</option>';
                                                });
                                            }
                                        });


                                        //$.getJSON("data.asmx/division?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val(), function (data) {
                                        //    $.each(data, function (i, item) {
                                        //        if ($('#dd_division').val() == item.value) {
                                        //            selected = ' selected';
                                        //        } else {
                                        //            selected = '';
                                        //        }
                                        //        divisionoptions += '<option value="' + item.value + '">' + item.label + '</option>';
                                        //    });
                                        //});

                                        var genderoptions = "";
                                        $.ajax({
                                            url: "data.asmx/gender?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#dd_division').val(),
                                            dataType: 'json',
                                            async: false,
                                            success: function (data) {
                                                $.each(data, function (i, item) {
                                                    if ($('#dd_gender').val() == item.value) {
                                                        selected = ' selected';
                                                    } else {
                                                        selected = '';
                                                    }
                                                    genderoptions += '<option value="' + item.value + '"' + selected + '>' + item.label + '</option>';
                                                });
                                            }
                                        });

                                        //$.getJSON("data.asmx/gender?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#dd_division').val(), function (data) {
                                        //    $.each(data, function (i, item) {
                                        //        if ($('#dd_gender').val() == item.value) {
                                        //            selected = ' selected';
                                        //        } else {
                                        //            selected = '';
                                        //        }
                                        //        genderoptions += '<option value="' + item.value + '">' + item.label + '</option>';
                                        //    });
                                        //});
                                    }

                                    /*
                                    for (f1 = 0; f1 < seats; f1++) {
                                        if (seats > 1) {
                                            switch (f1) {
                                                case 0:
                                                    role = 'Stroke '
                                                    break;
                                                case seats - 1:
                                                    role = 'Bow '
                                                    break;
                                                default:
                                                    role = f1 + 1 + ' ';
                                            }
                                        }
                                        myhtml += role + 'Name: <input type="text" name="xxx" /><select>' + options + '</select><br />';
 
                                    }
                                    */
                                    myhtml = "";
                                    myhtml += 'Prognostic: <span id="span_prognostic">' + prognostictime + '</span><br />'; 
                                    for (f1 = 0; f1 < seats; f1++) {
                                        myhtml += 'Name: <input type="text" name="seatname_' + (f1 + 1) + '" />';
                                        if (seats != 1) {
                                            myhtml += '<select class="seatdivision" id="seatdivision_' + (f1 + 1) + '" name="seatdivision_' + (f1 + 1) + '">' + divisionoptions + '</select> <select class="seatgender" id="seatgender_' + (f1 + 1) + '" name="seatgender_' + (f1 + 1) + '">' + genderoptions + '</select>';
                                            myhtml += '<span id="span_prognostic_' + (f1 + 1) + '">' + prognostictime + '</span>';  
                                        }
                                        myhtml += '<br />';
                                    }

                                    if (coxed == 1) {
                                        myhtml += 'Cox: <input type="text" name="cox" /><br />';
                                    }
                                    $('#html').html(myhtml);
                                }
                            });
                        }
                    }
                ]
            });

            $('body').on('click', '.seatdivision, .seatgender', function () {
                id = $(this).attr('id').split('_')[1];

                if ($(this).attr('id').startsWith('seatdivision_')) {
                    var genderoptions = "";
                    $.ajax({
                        url: "data.asmx/gender?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#seatdivision_' + id).val(),
                        dataType: 'json',
                        async: false,
                        success: function (data) {
                            $.each(data, function (i, item) {
                                if ($('#dd_gender').val() == item.value) {
                                    selected = ' selected';
                                } else {
                                    selected = '';
                                }
                                genderoptions += '<option value="' + item.value + '"' + selected + '>' + item.label + '</option>';
                            });
                        }
                    });
                    $('#seatgender_' + id).empty().append(genderoptions);
                }


                $.ajax({
                    url: "data.asmx/prognostic?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#seatdivision_' + id).val() + "&gender=" + $('#seatgender_' + id).val(),
                    async: false,
                    success: function (result) {
                        jresult = $.parseJSON(result);
                        record = jresult[0];
                        prognostictime = record.prognostictime;
                        $('#span_prognostic_' + id).text(prognostictime);
                    }
                });
                sumprognostics = 0;
                for (f1 = 0; f1 < seats; f1++) {
                    sumprognostics += parseFloat($('#span_prognostic_' + (f1 + 1)).text());
                }
                prognostictime = sumprognostics / seats;
                //alert(prognostictime.toFixed(4));
                $('#span_prognostic').text(prognostictime.toFixed(4));

            });


        }); //document.ready
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="div_prognostic">

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_discipline">Discipline</label><div class="col-sm-8">
                    <select id="dd_discipline" name="discipline">
                        <option></option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_boat">Boat</label><div class="col-sm-8">
                    <select id="dd_boat" name="boat">
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
                <label class="control-label col-sm-4" for="dd_gender">Gender</label><div class="col-sm-8">
                    <select id="dd_gender" name="gender">
                        <option></option>
                    </select>
                </div>
            </div>

        </div>
        <div id="html"></div>

    </form>
</body>
</html>
