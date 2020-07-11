<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="communicatewinners.aspx.cs" Inherits="DataInnovations.Raffles.UBC2019B.communicatewinners" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        html, body {
            width: 100%;
        }

        table {
            margin: 0 auto;
        }

        th, td {
            border: solid;
            border-width: thin;
            border-collapse: collapse;
            padding: 5px;
            text-wrap: none;
        }

        th {
            text-align: left;
        }
    </style>

    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>

    <script>
        $(document).ready(function () {
            $('#cb_toggleall').click(function (event) {
                if (this.checked) {
                    // Iterate each checkbox
                    $('.checkbox').each(function () {
                        this.checked = true;
                    });
                } else {
                    $('.checkbox').each(function () {
                        this.checked = false;
                    });
                }
            });
            $('.statusfilter').change(function () {
                //console.log(selected);
                /*
                $('tbody tr').each(function () {

                    thisstatus = $(this).find('td').eq(8).text();
                    if (selected.indexOf(thisstatus) != -1) {
                        $(this).show();
                    }
                    else {
                        $(this).hide();
                    }

                });
                */
                filter();
            });
            $('#date').change(function () {
                /*
                var date = $(this).val();
                $('tbody tr').each(function () {
                    if ($(this).find('td').eq(0).text().endsWith(date)) {
                        $(this).show();
                    }
                    else {
                        $(this).hide();
                    }
                });
                */
                filter();
            });


            function filter() {
                var date = $('#date').val();
                var selected = [];
                $('.statusfilter:checked').each(function () {
                    selected.push($(this).val());
                });
                $('tbody tr').each(function () {
                    thisstatus = $(this).find('td').eq(8).text();
                    if (
                        (date == "" || $(this).find('td').eq(0).text().endsWith(date))
                        && (selected.indexOf(thisstatus) != -1)
                    ) {
                        $(this).show();
                    }
                    else {
                        $(this).hide();
                    }
                    
                });
            }

            /*
            $('.itininja').click(function () {
                cell = $(this)
                itininjaid = $(cell).text();
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "http://iti.ninja/data.aspx?mode=Track_link&link=" + itininjaid, success: function (result) {
                        $(cell).html(result);
                        $(cell).unbind( "click" );
                    }
                });
            });
            */
        });
    </script>


</head>
<body>

    <form id="form1" runat="server">
        <br />
        ||greeting|| 
                             <br />
        ||ticketnumber||<br />
        ||guid||<br />
        ||identifier||<br />
        ||voucher||<br />
        <br />
        &nbsp;<asp:TextBox ID="tb_message" runat="server" Height="134px" TextMode="MultiLine" Width="874px" OnTextChanged="tb_message_TextChanged">Hi ||greeting||
Your ticket, ||identifier||/||ticketnumber||, is a winner in the Union Boat Club's Chef's Choice rowing raffle.
You can collect your voucher from: Health 2000, 58 Victoria Ave. Who, though are not involved in the raffle, have kindly offered to be the pickup point.
Thanks for your support, please contact Greg (0272495088) if you have any queries.
    
 
        </asp:TextBox>
        <!--   Hi ||greeting||
Your ticket, ||identifier||/||ticketnumber||, is a winner in the Maadi rowing raffle.
Please go to: ||voucher|| to view/download your Chef's Choice Voucher.
Thanks for your support.
Please contact Greg (0272495088) if you need assistance.
            -->
        <table style="width: 100%">
            <%=html %>
        </table>
        <asp:Button ID="btn_submit" runat="server" Text="Send" OnClick="btn_submit_Click" />
    </form>
</body>
</html>

