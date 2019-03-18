<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM.aspx.cs" Inherits="Online.Administration.ACO.CRM" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <title>Animal Control Officers</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">


    <!--1.11.4-->

    <!--<link href="../../Content/main.css" rel="stylesheet" />-->

    <style>
        .take {
            color: red;
        }

        .return {
            color: green;
        }

        .Followup {
            background-color: lightyellow;
        }

        .InProgress {
            background-color: lightcyan;
        }

        .animal_id {
            color: blue;
        }
    </style>


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>


    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!--1.11.4-->



    <!--<script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>-->


    <script type="text/javascript">
        var timerId;


        $(document).ready(function () {

            starttimer();

            $(".take").click(function () {
                takeCRM(this);
            });


            $(".return").click(function () {
                returnCRM(this);
            });

            $(".description").click(function () {
                ramid_tr = $(this).closest('tr');
                ramid_td = $(ramid_tr).find('.ramid');
                RAM_PROCESS_CTR = $(ramid_td).data('id');
                $('#hf_ramprocessctr').val(RAM_PROCESS_CTR);
                if (!($(ramid_td).hasClass('take'))) {
                    window.clearTimeout(timerId);

                    $("#itemmaint").dialog({
                        modal: true,
                        width: 800,
                        title: $(ramid_td).text(),
                        buttons: [{
                            text: "Cancel",
                            click: function () {
                                $(this).dialog("close");
                            },
                        }, {
                            text: "Update",
                            click: function () {
                                if ($('#cb_resolve').prop("checked")) {
                                    $(ramid_tr).remove();
                                }

                                var arForm = $('.submit').serializeArray();

                                //console.log(arForm);

                                var formData = JSON.stringify({ formVars: arForm });
                                //console.log(formData);

                                $.ajax({
                                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                    contentType: "application/json; charset=utf-8",
                                    url: 'posts.asmx/updatecrm', // the url where we want to POST
                                    data: formData,
                                    dataType: 'json', // what type of data do we expect back from the server
                                    //success: function (result) {
                                    //    window.location.href = 'default.aspx';
                                    //},
                                    error: function (xhr, status) {
                                        alert("An error occurred: " + status);
                                    }
                                });

                                //alert("This isn't actually doing anything in the background yet");
                                $(this).dialog("close");
                            },
                        }],
                        close: function (event, ui) {
                            starttimer();
                        }
                    });

                }
            });

            $("#div_lookup").append($("<iframe />").attr({
                "src": "Search.aspx",
                "width": "550px",
                "height": "400px",
                "frameborder": 0
            }));

            $



            $('#btn_search').click(function () {
                $("#div_lookup").dialog({
                    modal: true,
                    width: 600
                });
                /*
                $("#div_lookup").dialog({
                    modal: true
                });
                */
            })
            

            $("#btn_refresh").click(function () {
                window.location.reload(1);
            });
            $('#cb_resolve').change(function () {
                if ($(this).prop("checked")) {
                    $('#span_correspondence').show();
                } else {
                    $('#span_correspondence').hide();
                }
            })

        }); //document.ready

        function starttimer() {
            timerId = setTimeout(function () {
                window.location.reload(1);
            }, 60000);
        }

        function takeCRM(this_td) {
            officer_td = $(this_td).closest('tr').find('.officer');
            RAM_PROCESS_CTR = $(this_td).data('id');
            $.get("data.asmx/updateOfficer?RAM_PROCESS_CTR=" + RAM_PROCESS_CTR + "&RESP_USER_ID=<%:RESP_USER_ID%>&Override=0", function (data) {
                if (data.indexOf("This has already been assigned to:") != -1) {
                    if (confirm(data + "\n\n   'OK' to take it for yourself,\n   'Cancel' to leave it as is.")) {
                        //alert('Do it again with override');
                        $.get("data.asmx/updateOfficer?RAM_PROCESS_CTR=" + RAM_PROCESS_CTR + "&RESP_USER_ID=<%:RESP_USER_ID%>&Override=1", function (data) {
                            $(officer_td).html('<b>' + data + '</b>');
                            $(this_td).unbind("click")
                            $(this_td).removeClass('take');

                            $(officer_td).addClass('return');
                            $(officer_td).bind("click", function () {
                                returnCRM(this);
                            });
                        });
                    }
   


                    //$(this_td).closest('tr').remove();
                } else {
                        $(officer_td).html('<b>' + data + '</b>');
                        $(this_td).unbind("click")
                        $(this_td).removeClass('take');

                        $(officer_td).addClass('return');
                        $(officer_td).bind("click", function () {
                            returnCRM(this);
                        });
                    }
                });
        }

        function returnCRM(this_td) {
            ramid_td = $(this_td).closest('tr').find('.ramid');
            RAM_PROCESS_CTR = $(ramid_td).data('id');
            $.get("data.asmx/updateOfficer?RAM_PROCESS_CTR=" + RAM_PROCESS_CTR + "&RESP_USER_ID=ANI_CRM&override=0", function (data) {
                $(this_td).text(data);
                $(this_td).unbind("click")
                $(this_td).removeClass('return');

                $(ramid_td).addClass('take');
                $(ramid_td).bind("click", function () {
                    takeCRM(this);
                });
            });
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <input id="btn_refresh" type="button" value="Refresh" />

        Click on the RAM ID to take a job, Click on your name to put the job back into the pool.&nbsp; Click on the description (of your jobs) to add notes and optionally close.&nbsp; This list will refresh ever 1 minute.

        <div class="table-responsive">
            <table class="table-bordered">
                <asp:Literal ID="lit_html" runat="server"></asp:Literal>
            </table>
        </div>

        <div id="itemmaint" title="Item Maintenance" style="display: none">
            <input type="hidden" id="hf_ramprocessctr" name="hf_ramprocessctr" class="submit" />
            <b>Notes</b><br />
            <textarea id="tb_notes" name="tb_notes" style="width: 100%" class="submit"></textarea><br />
            <br />
            <!--
            <b>Animals</b><br />
            <textarea id="tb_animals" name="tb_animals" style="width: 100%" class="submit"></textarea><br />
            <br />
            -->
            <b>Dog No. </b><input type="text" id="tb_dog" name="tb_dog" /><button type="button" id="btn_search">Search</button><br /><br />
            <input id="cb_resolve" name="cb_resolve" type="checkbox" value="1" class="submit" />
            <b>Resolve</b><span id="span_correspondence" style="display: none; position: relative; float: right;"><b>Followup correspondence required</b>
                <input id="cb_correspondence" name="cb_correspondence" type="checkbox" value="1" class="submit" />
            </span>
        </div>


         <div id="div_lookup" title="Dog Lookup" style="display: none">
        </div>



    </form>


</body>
</html>
