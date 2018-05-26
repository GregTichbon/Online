<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entry.aspx.cs" Inherits="DataInnovations.Row.Entry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Meeting Scheduler</title>
    <!-- Style Sheets -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">

    <style>
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script src="../Dependencies/CascadingDropDown/jquery.cascadingdropdown.min.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {

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
                        selector: '#division',
                        requires: ['#discipline'],
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
                        requires: ['#discipline', '#division'],
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
                        selector: '#category',
                        requires: ['#discipline', '#division', '#gender'],
                        requireAll: true,
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
                        selector: '#subcategory',
                        requires: ['#discipline', '#division', '#gender', '#category'],
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
                            //alert('Get_subcategorydetails for subcategory_ctr - to get Category_CTR, Seats,	haveCox, PrognosticTime');
                            //alert('Get_subcategoryotherprognostics for Category_CTR and PrognosticTime - to get Code + subcategory, PrognosticTime');

                            var myhtml = '';
                            var category_ctr;
                            var prognostictime;
                            /*
                            $.getJSON("data.asmx/subcategorydetails?subcategory=9", function (data) {
                                $.each(data, function (i, item) {
                                    alert('category_ctr=' + item.category_ctr + ', seats=' + item.seats + ', havecox=' + item.havecox + ', prognostictime=' + item.prognostictime);
                                    myhtml = myhtml + 'category_ctr=' + item.category_ctr + ', seats=' + item.seats + ', havecox=' + item.havecox + ', prognostictime=' + item.prognostictime;

                                });
                            });
                            */

                            $.ajax({
                                dataType: "json",
                                async: false,
                                url: "data.asmx/subcategorydetails?subcategory=" + $('#subcategory').val(),
                                success: function (data) {
                                    jQuery.each(data, function (i, item) {
                                        category_ctr = item.category_ctr;
                                        prognostictime = item.prognostictime;
                                        //alert('category_ctr=' + item.category_ctr + ', seats=' + item.seats + ', havecox=' + item.havecox + ', prognostictime=' + item.prognostictime);
                                        myhtml = myhtml + 'category_ctr=' + item.category_ctr + ', seats=' + item.seats + ', havecox=' + item.havecox + ', prognostictime=' + item.prognostictime;
                                    });
                                }
                            });

                            myhtml = myhtml + "<br />Other prognostics";
                            /*
                            $.getJSON("data.asmx/subcategoryotherprognostics?category=" + category_ctr + "&prognostictime=" + prognostictime, function (data) {
                                $.each(data, function (i, item) {
                                    myhtml = myhtml + "<br />" + item.label;
                                    alert('label=' + item.label);
                                });
                            });
                            */


                            $.ajax({
                                dataType: "json",
                                async: false,
                                url: "data.asmx/subcategoryotherprognostics?category=" + category_ctr + "&prognostictime=" + prognostictime,
                                success: function (data) {
                                    jQuery.each(data, function (i, item) {
                                        myhtml = myhtml + "<br />" + item.label;
                                    });
                                }
                            });

                            //alert(myhtml);
                            $('#html').html(myhtml);

                            $("#btn_update").attr('disabled', false);
                        }
                    }
                ]
            });

        }); //document.ready
    </script>

</head>
<body>
    Enter the highest level (ie: greatest prognostic as the "Base" entry and then make modifications for lower prognostics<br />Can check this in code

    <form id="form1" runat="server">

        <div class="form-group">
                <label class="control-label col-sm-4" for="clubschool">Club/School</label>
                <div class="col-sm-8">
                    <select id="clubschool" name="clubschool" class="form-control">
                        <option></option>
                    </select>
                </div>
            </div>


        <div id="entry">
            <div class="form-group">
                <label class="control-label col-sm-4" for="discipline">Discipline</label>
                <div class="col-sm-8">
                    <select id="discipline" name="discipline" class="form-control">
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
                <label class="control-label col-sm-4" for="category">Category</label>
                <div class="col-sm-8">
                    <select id="category" name="category" class="form-control">
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

        </div>
        <div id="html"></div>
    </form>
</body>
</html>
