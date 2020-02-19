<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entry3.aspx.cs" Inherits="DataInnovations.Row.Entry3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Entry</title>
    <!-- Style Sheets -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous" />
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <style>
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <!--<script src="../Dependencies/CascadingDropDown/jquery.cascadingdropdown.min.js"></script>-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <script type="text/javascript">


        $(document).ready(function () {

            $("#discipline").change(function () {
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=BuildBoats&Discipline=" + $(this).val(), success: function (result) {
                        $("#boat").empty().append(result);
                    }
                });
            });

            $("#boat").change(function () {
                source: "data.asmx/code_autocomplete?discipline=1",
                    minLength: 2,
                        select: function (event, ui) {
                            //event.preventDefault();
                            selected = ui.item;
                            /*
                            $("#category").val(selected ?
                                selected.label : "Nothing selected, input was " + this.value);
                                */
                            var myhtml = '';
                            //$("#category").val(selected.label);
                            $("#prognostic").text(selected.PrognosticTime);
                            for (i = 0; i < selected.Seats; i++) {
                                myhtml += 'Seat:' + (i + 1);
                                myhtml += ' <input style="width:40%" id="s' + (i + 1) + '" type="text" />';
                                myhtml += ' <input style="width:50%" id="c' + (i + 1) + '" class="c" type="text" value="' + selected.label + '" />';
                                myhtml += '<input type="hidden" id="p' + (i + 1) + '" value="' + selected.PrognosticTime + '"><br />';
                            }
                            for (i = 0; i < selected.HaveCox; i++) {
                                myhtml += 'Cox:' + ' <input style="width:40%" id="cox' + (i + 1) + '" type="text" /><br />';
                            }


                            $("#html").html(myhtml);
                            $("#dialogcompetitors").dialog({
                                width: 800,
                                modal: true,
                                buttons: {
                                    "OK": function () {
                                        seats = "";
                                        delim = "";
                                        for (i = 0; i < selected.Seats; i++) {
                                            seats = seats + delim + $('#s' + (i + 1)).val();
                                            delim = ", ";
                                        }
                                        for (i = 0; i < selected.HaveCox; i++) {
                                            seats = seats + delim + $('#cox' + (i + 1)).val() + ' (Cox)';
                                        }
                                        $('#competitors').text(seats);
                                        $(this).dialog("close");
                                    }
                                }
                            });

                        }
            });


            $("#category").autocomplete({
                
            })


            $(document).on('keydown.autocomplete', ".c", function () {
                $(this).autocomplete({
                    source: "data.asmx/code_autocomplete?discipline=1",
                    minLength: 2,
                    select: function (event, ui) {
                        selected2 = ui.item;
                        $("this").val(selected2.label)
                        line = $(this).attr('id').substring(1);
                        $('#p' + line).val(selected2.PrognosticTime);
                        tot = 0
                        for (i = 0; i < selected.Seats; i++) {
                            tot = tot + parseFloat($('#p' + (i + 1)).val());
                        }
                        $("#prognostic").text(tot / selected.Seats);
                    }
                });
            });
            $(document).on('click', ".c", function () {
                $(this).val('');
            });


        }); //document.ready
    </script>

</head>
<body>
    <p style="display: none">
        Enter the highest level (ie: greatest prognostic as the "Base" entry and then make modifications for lower prognostics<br />
        Can check this in code<br />
        X means Scull
    </p>

    <form id="form1" runat="server">

        <div class="form-group">
            <label class="control-label col-sm-4" for="clubschool">Club/School</label>
            <div class="col-sm-8">
                <select id="clubschool" name="clubschool" class="form-control">
                    <option>xxx</option>
                </select>
            </div>
        </div>

        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th style="width: 10%">Discipline</th>
                    <th style="width: 20%">Boat</th>
                    <th style="width: 70%">Competitor(s)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <select id="discipline" name="discipline" class="form-control">
                            <option></option>
                            <option value="1">Rowing</option>
                            <option value="2">Something else</option>
                        </select></td>
                    <td>
                        <select id="boat" name="boat" class="form-control">
                       
                        </select></td>
                    <td id="competitors"></td>

                </tr>
            </tbody>
        </table>


        <div id="dialogcompetitors" title="Competitors" style="display: none">
            <div id="html"></div>
        </div>



    </form>

</body>
</html>
