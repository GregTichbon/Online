<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Online.Administration.ACO.Search" %>

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



    <!--<script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>-->
    <style>
        html, tr, td ,th, input {
            font-size:small;
        }
    </style>


    <script type="text/javascript">
        $(document).ready(function () {
            $(".tb_street").autocomplete({
                source: "data.asmx/streetsearch",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    $(".tb_street").val(ui.item ? ui.item.label : "Nothing selected, input was " + this.value);
                    $('.tb_street').data('id', ui.item.id)
                }
            })
            $(".tb_animalname").autocomplete({
                source: "data.asmx/animalnamesearch",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    $(".tb_animalname").val(ui.item ? ui.item.label : "Nothing selected, input was " + this.value);
                  }
            })

            $(".tb_name").autocomplete({
                source: "data.asmx/ownersearch",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    $(".tb_name").val(ui.item ? ui.item.label : "Nothing selected, input was " + this.value);
                    $('.tb_name').data('id', ui.item.id)
                 }
            })

            $('.btn_submit').click(function () {
                search();
            })
            $(document).on('click','.tr_pick',function(){
                id = $(this).attr("id").substring(4);
                parent.$("#tb_dog").val(id);
                parent.$("#div_lookup").dialog('close');
            })
        }); //document.ready

        function search() {
            tagnumber = $('.tb_tag').val();
            tagyear = $('.tb_year').val();
            street = $('.tb_street').val();
            animalname = $('.tb_animalname').val();
            ownername = $('.tb_ownername').val();
            chipnumber = $('.tb_chip').val();
            id = $('.tb_id').val();
            colour = $('.tb_colour').val();
            breed = $('.tb_breed').val();
            $('#response').text('loading...');
            $.ajax({
                dataType: 'html', // what type of data do we expect back from the server
                url: "data.aspx?mode=full&tagnumber=" + tagnumber
                    + "&tagyear=" + tagyear
                    + "&street=" + street
                    + "&animalname=" + animalname
                    + "&ownername=" + ownername
                    + "&chipnumber=" + chipnumber
                    + "&id=" + id
                    + "&colour=" + colour
                    + "&breed=" + breed,
                success: function (result) {
                    $('#div_result').html(result);
                    $('#response').text('');
                }
            });
            var position = $($('#div_result')).offset().top;
            $("body, html").animate({
                scrollTop: position
            } /* speed */);
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="hf_mode" name="hf_mode" value="tag" />
        <table style="width:100%">
            <tr>
                <td>
                    <div align="right">Number</div>
                </td>
                <td style="width: 10%">
                    <asp:TextBox ID="tb_tag" class="tb_tag clearable" runat="server" MaxLength="5"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <div align="right">Year</div>
                </td>
                <td style="width: 10%">
                    <div align="left">
                        <asp:TextBox ID="tb_year" class="tb_year clearable" runat="server" MaxLength="2">19</asp:TextBox>
                    </div>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr>
                <td>
                    <div align="right">Street</div>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_street" class="tb_street clearable" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr>
                <td>
                    <div align="right">Animal Name</div>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_animalname" class="tb_animalname clearable" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr>
                <td>
                    <div align="right">Owner Name(s)</div>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_ownername" class="tb_ownername clearable" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr>
                <td>
                    <div align="right">Chip Number</div>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_chip" class="tb_chip clearable" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr>
                <td>
                    <div align="right">ID</div>
                </td>
                <td style="width: 15%">
                    <asp:TextBox ID="tb_id" class="tb_id clearable" runat="server" MaxLength="8"></asp:TextBox>
                </td>
            </tr>
        </table>
                <table style="width: 100%">
            <tr>
                <td>
                    <div align="right">Colour</div>
                </td>
                <td style="width: 15%">
                    <asp:TextBox ID="tb_colour" class="tb_colour clearable" runat="server" MaxLength="8"></asp:TextBox>
                </td>
            </tr>
        </table>

                <table style="width: 100%">
            <tr>
                <td>
                    <div align="right">Breed</div>
                </td>
                <td style="width: 15%">
                    <asp:TextBox ID="tb_breed" class="tb_breed clearable" runat="server" MaxLength="8"></asp:TextBox>
                </td>
            </tr>
        </table>

         <input type="button" class="btn_submit" value="Search" />
        <span id="response"></span>

        <div id="div_result" style="text-align: center"></div>

    </form>


</body>
</html>
