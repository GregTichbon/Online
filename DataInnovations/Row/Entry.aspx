<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entry.aspx.cs" Inherits="DataInnovations.Row.Entry" %>

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
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="crossorigin="anonymous"></script>
    <script src="../Dependencies/CascadingDropDown/jquery.cascadingdropdown.min.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {

            //$("#dialogcompetitors").dialog();

            //There is a small issue, where a dropdown is changed by the user, the dependant dropdowns still use the parent values when they should really be set to -1
            //The problem is trying to identify that it was a human that changed it rather than the parent values

            $('#entry').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#discipline',
                        source: function (request, response) {
                            $.getJSON('data.asmx/discipline', function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value,
                                        selected: index == parent.discipline
                                    }
                                }));
                            })
                        }
                    },
                    {
                        selector: '#category',
                        requires: ['#discipline'],
                        source: function (request, response) {
                            //request.datamode = datamode;
                            $.getJSON('data.asmx/category', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value,
                                        selected: index == parent.category
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#division',
                        requires: ['#discipline', '#category'],
                        requireAll: true,
                        source: function (request, response) {
                            //request.datamode = datamode;
                            $.getJSON('data.asmx/division', request, function (data) {
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
                        selector: '#gender',
                        requires: ['#discipline', '#category', '#division'],
                        requireAll: true,
                        source: function (request, response) {
                            //request.datamode = datamode;
                            $.getJSON('data.asmx/gender', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value,
                                        selected: index == parent.gender
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },

                    {
                        selector: '#subcategory',
                        requires: ['#discipline', '#category', '#division', '#gender'],
                        requireAll: true,
                        source: function (request, response) {
                            //request.datamode = datamode;
                            $.getJSON('data.asmx/subcategory', request, function (data) {
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
                                $("#btn_update").attr('disabled', true);
                                return;
                            }
                            //entry.loading(true);

                            var myhtml = '';
                            var category_ctr;
                            var prognostictime;
                            var seats;
                            var havecox;
                            var options = '';

                            $.getJSON("data.asmx/subcategorydetails?subcategory=" + $('#subcategory').val(), function (data) {
                                category_ctr = data[0].category_ctr;
                                prognostictime = data[0].prognostictime;
                                seats = data[0].seats;
                                havecox = data[0].havecox;
                                

                                $.getJSON("data.asmx/subcategoryotherprognostics?category=" + category_ctr + "&prognostictime=" + prognostictime, function (data) {
                                    $.each(data, function (i, item) {
                                        if ($('#subcategory').val() == item.value) {
                                            selected = ' selected';
                                        } else {
                                            selected = '';
                                        }
                                        options += '<option' + selected + '>' + item.label + '</option>';
                                    });
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
                                    if (havecox == 1) {
                                        myhtml += 'Cox: <input type="text" name="cox" /><br />';
                                    }

                                    $('#html').html(myhtml);
                                    $("#dialogcompetitors").dialog({ width: 800 });
                                });
                            });
                        }
                    }
                ]
            });


        }); //document.ready
    </script>

</head>
<body>
    <p style="display:none">
    Enter the highest level (ie: greatest prognostic as the "Base" entry and then make modifications for lower prognostics<br />
    Can check this in code<br />
    X means Scull</p>

    <form id="form1" runat="server">

        <div class="form-group">
            <label class="control-label col-sm-4" for="clubschool">Club/School</label>
            <div class="col-sm-8">
                <select id="clubschool" name="clubschool" class="form-control">
                    <option></option>
                </select>
            </div>
        </div>


        <div class="form-row">
            <div class="col">
                Discipline
            </div>
            <div class="col">
                Category
            </div>
            <div class="col">
                Division
            </div>
            <div class="col">
                Gender
            </div>
            <div class="col">
                Event
            </div>

            <div class="col">
                Competitor(s)
            </div>
        </div>

        <div id="entry">
            <div class="form-row">
                <div class="col">
                    <select id="discipline" name="discipline" class="form-control">
                        <option></option>
                    </select>
                </div>
                <div class="col">
                    <select id="category" name="category" class="form-control">
                        <option></option>
                    </select>
                </div>
                <div class="col">
                    <select id="division" name="division" class="form-control">
                        <option></option>
                    </select>
                </div>
                <div class="col">
                    <select id="gender" name="gender" class="form-control">
                        <option></option>
                    </select>
                </div>
                <div class="col">
                    <select id="subcategory" name="subcategory" class="form-control">
                        <option></option>
                    </select>
                </div>
                <div class="col">
                    <textarea id="competitor" name="competitor"></textarea>
                </div>
            </div>

            <!--
            <div class="form-group">
                <label class="control-label col-sm-4" for="discipline">Discipline</label>
                <div class="col-sm-8">
                    <select id="discipline" name="discipline" class="form-control">
                        <option></option>
                    </select>
                </div>
            </div>

                        <div class="form-group">
                <label class="control-label col-sm-4" for="category">Category</label>
                <div class="col-sm-8">
                    <select id="category" name="category" class="form-control">
                        <option></option>
                    </select>
                </div>
            </div>

 

            <div class="form-group">
                <label class="control-label col-sm-4" for="division">Division</label>
                <div class="col-sm-8">
                    <select id="division" name="division" class="form-control">
                        <option></option>
                    </select>
                </div>
            </div>


                       <div class="form-group">
                <label class="control-label col-sm-4" for="gender">Gender</label>
                <div class="col-sm-8">
                    <select id="gender" name="gender" class="form-control">
                        <option></option>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <label class="control-label col-sm-4" for="subcategory">Event</label>
                <div class="col-sm-8">
                    <select id="subcategory" name="subcategory" class="form-control">
                        <option></option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="btn_update"></label>
                <div class="col-sm-8">
                    <input type="button" id="btn_update" value="Update" disabled="disabled" />
                </div>

            </div>
                    -->
        </div>

            <div id="dialogcompetitors" title="Competitors" style="display:none">
                <div id="html"></div>
    </div>


        
    </form>
</body>
</html>
