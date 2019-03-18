<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Online.Administration.ACO.Default" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <title>Animal Control Officers</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- Style Sheets -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
    <link href="ACO.css" rel="stylesheet" />

    <!--1.11.4-->

    <link href="../../Content/main.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>


    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!--1.11.4-->



    <script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>


    <script type="text/javascript">
        function tog(v) {
            //alert(1);
            return v ? 'addClass' : 'removeClass';
        }

        $(document).on('input focus', '.clearable', function () {
            //alert(2);
            $(this)[tog(this.value)]('x');
        }).on('mousemove', '.x', function (e) {
            $(this)[tog(this.offsetWidth - 18 < e.clientX - this.getBoundingClientRect().left)]('onX');
        }).on('click', '.onX', function () {
            $(this).removeClass('x onX').val('').change();
        });

        var mode = "";

        $(document).ready(function () {
            $('.a_menuoption').click(function () {
                mode = $(this).text().toLowerCase().replace(/\s/g, '');
                $('#div_menu').hide();
                $('#div_' + mode).show();
                //alert(mode);
                switch (mode) {
                    case "tag":
                        $(".tb_tag").focus();
                        break;
                    case "street":
                        $(".tb_street").focus();
                        break;
                    case "chip":
                        $(".tb_chip").focus();
                        break;
                    case "id":
                        $(".tb_id").focus();
                        break;
                    case "owner":
                        $(".tb_name").focus();
                        break;
                    case "animalame":
                        $(".tb_animalname").focus();
                        break;
                }

                //if (id == 'tag' || id == 'chip') {
                //    $('#div_submit').show();
                //}
            });
            $('body').on('click', '.a_menu', function () {
                $('.div_searchparams').hide();
                //$('#div_submit').hide();
                $('#div_result').hide();
                $('#div_history').hide();
                $('#div_poundhistory').hide();
                $('#div_menu').show();

            });
            $('body').on('click', '.a_table', function () {
                $('#div_menu').hide();
                mode = $(this).text().toLowerCase();
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=" + mode, success: function (result) {
                        $('#div_result').html(result);
                        $('#div_result').show();
                    }
                });
            });


            $(".tb_street").autocomplete({
                source: "data.asmx/streetsearch",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    $(".tb_street").val(ui.item ? ui.item.label : "Nothing selected, input was " + this.value);
                    $('.tb_street').data('id', ui.item.id)
                    $.ajax({
                        dataType: 'html', // what type of data do we expect back from the server
                        url: "data.aspx?mode=street&param1=" + ui.item.id, success: function (result) {
                            $('#div_result').html(result);
                            $('#div_result').show();
                        }
                    });
                }
            })
            $(".tb_animalname").autocomplete({
                source: "data.asmx/animalnamesearch",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    $(".tb_animalname").val(ui.item ? ui.item.label : "Nothing selected, input was " + this.value);
                    $.ajax({
                        dataType: 'html', // what type of data do we expect back from the server
                        url: "data.aspx?mode=animalname&param1=" + ui.item.label, success: function (result) {
                            $('#div_result').html(result);
                            $('#div_result').show();
                        }
                    });
                }
            })

            $(".tb_name").autocomplete({
                source: "data.asmx/ownersearch",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    $(".tb_name").val(ui.item ? ui.item.label : "Nothing selected, input was " + this.value);
                    $('.tb_name').data('id', ui.item.id)
                    $.ajax({
                        dataType: 'html', // what type of data do we expect back from the server
                        url: "data.aspx?mode=owner&param1=" + ui.item.id, success: function (result) {
                            $('#div_result').html(result);
                            $('#div_result').show();
                        }
                    });
                }
            })


            /*
                        .autocomplete("instance")._renderItem = function (ul, item) {
                            return $("<li>")
                                //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                                .append("<a>" + item.label + "</a>")
                                .appendTo(ul);
                        };
            */

            $('body').on('click', '.a_animal', function () {
                id = $(this).data("id");
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=animal&param1=" + id, success: function (result) {
                        $('#div_result').html(result);
                        $('#div_result').show();
                    }
                });
            });

            $('body').on('click', '.a_horse', function () {
                id = $(this).data("id");
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=horse&param1=" + id, success: function (result) {
                        $('#div_result').html(result);
                        $('#div_result').show();
                    }
                });
            });

            $('body').on('click', '.a_history', function () {
                //alert(($("#div_history").is(":visible")));
                if ($("#div_history").is(":visible") == true) {
                    $('#div_history').hide();
                } else {
                    id = $(this).data("id");
                    //alert(id);
                    $.ajax({
                        dataType: 'html', // what type of data do we expect back from the server
                        url: "data.aspx?mode=history&param1=" + id, success: function (result) {
                            $('#div_history').html(result);
                            $('#div_history').show();
                        }
                    });
                }
            });


            $('body').on('click', '.a_poundhistory', function () {
                //alert(($("#div_poundhistory").is(":visible")));
                if ($("#div_poundhistory").is(":visible") == true) {
                    $('#div_poundhistory').hide();
                } else {
                    id = $(this).data("id");
                    //alert(id);
                    $.ajax({
                        dataType: 'html', // what type of data do we expect back from the server
                        url: "data.aspx?mode=poundhistory&param1=" + id, success: function (result) {
                            $('#div_poundhistory').html(result);
                            $('#div_poundhistory').show();
                        }
                    });
                }
            });

            $('body').on('click', '.a_others', function () {
                type = $(this).data("type");
                id = $(this).data("id");
                //alert(type + "-" + id);
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=" + type + "&param1=" + id, success: function (result) {
                        $('#div_result').html(result);
                        $('#div_result').show();
                    }
                });
            });




            $('.btn_submit').click(function () {
                //alert(mode);
                switch (mode) {
                    case "tag":
                        $.ajax({
                            dataType: 'html', // what type of data do we expect back from the server
                            url: "data.aspx?mode=tag&param1=" + $('.tb_tag').val() + "&param2=" + $('.tb_year').val(), success: function (result) {
                                $('#div_result').html(result);
                                $('#div_result').show();
                            }
                        });
                        $(".tb_tag").focus();
                        break;
                    case "chip":
                        $.ajax({
                            dataType: 'html', // what type of data do we expect back from the server
                            url: "data.aspx?mode=chip&param1=" + $('.tb_chip').val(), success: function (result) {
                                $('#div_result').html(result);
                                $('#div_result').show();
                            }
                        });
                        $(".tb_chip").focus();
                        break;
                    case "id":
                        $.ajax({
                            dataType: 'html', // what type of data do we expect back from the server
                            url: "data.aspx?mode=animal&param1=" + $('.tb_id').val() , success: function (result) {
                                $('#div_result').html(result);
                                $('#div_result').show();
                            }
                        });
                        $(".tb_id").focus();
                        break;
                }

                
            })

            $('#a_refreshstreets').click(function () {
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=street&param1=" + $('.tb_street').data('id'), success: function (result) {
                        $('#div_result').html(result);
                        $('#div_result').show();
                    }
                });
            })

            $('#a_refreshanimalnames').click(function () {
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=animalname&param1=" + $('.tb_animalname').val(), success: function (result) {
                        $('#div_result').html(result);
                        $('#div_result').show();
                    }
                });
            })

            $('#a_refreshowners').click(function () {
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=owner&param1=" + $('.tb_name').data('id'), success: function (result) {
                        $('#div_result').html(result);
                        $('#div_result').show();
                    }
                });
            })


        }); //document.ready


    </script>

</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="hf_mode" name="hf_mode" value="tag" />

        <div id="div_menu" class="menu" style="text-align:center"">
            <table style="width: 100%">
                <tr><th colspan="3">Search by</th></tr>
                <tr>
                    <td style="width:33%"><a href="javascript:void(0)" class="a_menuoption">Tag</a></td>
                    <td style="width:34%"><a href="javascript:void(0)" class="a_menuoption">Street</a></td>
                    <td style="width:33%"><a href="javascript:void(0)" class="a_menuoption">Owner</a></td>
                </tr>
                <tr>
                    <td><a href="javascript:void(0)" class="a_menuoption">Chip</a></td>
                    <td><a href="javascript:void(0)" class="a_menuoption">ID</a></td>
                    <td><a href="javascript:void(0)" class="a_menuoption">Animal Name</a></td>
                </tr>
            </table>
            <br />
            <table style="width: 100%">
                 <tr><th colspan="2">Registers</th></tr>
                <tr>
                    <td style="width:50%"><a href="javascript:void(0)" class="a_table">Pound</a></td>
                    <td style="width:50%"><a href="javascript:void(0)" class="a_table">Horse Register</a></td>
                </tr>
            </table>
        </div>


        <div id="div_tag" class="div_searchparams" style="text-align:center;display:none">
           <table style="width: 100%">
                <tr>
                    <td>
                        <div align="right">Number</div>
                    </td>

                    <td style="width:10%">
                        <asp:TextBox ID="tb_tag" class="tb_tag clearable" runat="server" MaxLength="5"></asp:TextBox>
                    </td>
                    <td rowspan="2">
                        <input type="button" class="btn_submit" value="Submit" /></td>
                    <td rowspan="2"><a class="a_menu">Menu</a></td>
                </tr>
                <tr>
                    <td>
                        <div align="right">Year</div>
                    </td>
                   <td style="width:10%">
                        <div align="left">
                            <asp:TextBox ID="tb_year" class="tb_year clearable" runat="server" MaxLength="2">19</asp:TextBox>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div id="div_street" class="div_searchparams" style="text-align:center;display:none">
            <table style="width:100%">
                <tr>
                    <td>
                        <div align="right">Street</div>
                    </td>
                                <td style="width:30%">
                        <asp:TextBox ID="tb_street" class="tb_street clearable" runat="server"></asp:TextBox>
                    </td>
                    <td><a href="javascript:void(0)" id="a_refreshstreets">Refresh</a></td>
                    <td><a href="javascript:void(0)" class="a_menu">Menu</a></td>

                </tr>

            </table>
        </div>

        <div id="div_animalname" class="div_searchparams" style="text-align:center;display:none">
            <table style="width:100%">
                <tr>
                    <td>
                        <div align="right">Animal Name</div>
                    </td>
                                <td style="width:30%">
                        <asp:TextBox ID="tb_animalname" class="tb_animalname clearable" runat="server"></asp:TextBox>
                    </td>
                    <td><a href="javascript:void(0)" id="a_refreshanimalnames">Refresh</a></td>
                    <td><a href="javascript:void(0)" class="a_menu">Menu</a></td>

                </tr>

            </table>
        </div>

       <div id="div_owner" class="div_searchparams" style="text-align:center;display:none">
            <table style="width:100%">
                <tr>
                    <td>
                        <div align="right">Name(s)</div>
                    </td>
                                <td style="width:30%">
                        <asp:TextBox ID="tb_name" class="tb_name clearable" runat="server"></asp:TextBox>
                    </td>
                    <td><a href="javascript:void(0)" id="a_refreshowners">Refresh</a></td>
                    <td><a href="javascript:void(0)" class="a_menu">Menu</a></td>

                </tr>

            </table>
        </div>

        <div id="div_chip" class="div_searchparams" style="text-align:center;display:none">
             <table style="width: 100%">
                <tr>
                    <td>

                        <div align="right">Chip Number</div>
                    </td>
                            <td style="width:30%">
                        <asp:TextBox ID="tb_chip" class="tb_chip clearable" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <input type="button" class="btn_submit" value="Submit" /></td>
 
                    
                    <td><a href="javascript:void(0)" class="a_menu">Menu</a></td>
                </tr>
            </table>
        </div>

        <div id="div_id" class="div_searchparams" style="text-align:center;display:none">
             <table style="width: 100%">
                <tr>
                    <td>
                        <div align="right">ID</div>
                    </td>
                        <td style="width:15%">
                        <asp:TextBox ID="tb_id" class="tb_id clearable" runat="server" MaxLength="8"></asp:TextBox>
                    </td>
                     <td>
                        <input type="button" class="btn_submit" value="Submit" /></td>
                    <td><a href="javascript:void(0)" class="a_menu">Menu</a></td>
                </tr>
            </table>
        </div>





        <div id="div_result" style="text-align:center;display:none"></div>
 
        <asp:Literal ID="lit_results" runat="server"></asp:Literal>


    </form>

 
</body>
</html>
