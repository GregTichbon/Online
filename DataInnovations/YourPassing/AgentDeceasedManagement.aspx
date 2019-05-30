<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="AgentDeceasedManagement.aspx.cs" Inherits="DataInnovations.YourPassing.AgentDeceasedManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>

    <link href="_Includes/jquery-ui-themes-1.12.1/jquery-ui.min.css" rel="stylesheet" />


    <script>
        agent_ctr = "<%= Session["K4U_Agent_CTR"] %>";
        $(document).ready(function () {

         
            $('[data-id="btn_maintain"]').click(function () {
                mode = $(this).attr('data-mode');
                if (mode == 'edit') {
                    alert('need to load in id and data');
                }
                $('#dialog_deceased').dialog({
                    modal: true,
                    width: $(window).width() * .5,
                    height: 600,
                    position: { my: "top", at: "centre top" }
                });


                var dialog_deceased_Buttons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        //othertransaction_id = $('#dd_othertransactions_transaction_id').val();
                        $(this).dialog("close");
                        firstname = $('[data-id="tb_firstname"]').val();
                        lastname = $('[data-id="tb_lastname"]').val();
                  
                        var arForm = [{ "name": "firstname", "value": firstname }, { "name": "lastname", "value": lastname }, { "name": "agent_ctr", "value": agent_ctr }];
                        var formData = JSON.stringify({ formVars: arForm });
                        $.ajax({
                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                            contentType: "application/json; charset=utf-8",
                            url: 'posts.asmx/update_deceased', // the url where we want to POST
                            data: formData,
                            dataType: 'json', // what type of data do we expect back from the server
                            success: function (result) {
                                if (mode == 'Add') {
                                    //$('#div_othertransactions > table > tbody').append('<tr><td></td><td class="number"></td><td class="othertransaction">Edit</td></tr>');
                                    //tr = $('#div_othertransactions > table > tbody tr:last')
                                    //$(tr).attr('id', 'othertransaction_' + result.d.id);

                                }
                                //$(tr).attr('event_id', event_id);
                                //$(tr).find('td').eq(0).text(code);
                                //$(tr).find('td').eq(2).text('Edit');
                                location.reload();
                            },
                            error: function (xhr, status) {
                                alert("An error occurred: " + status);
                            }
                        });
                    }
                }

                if (mode != 'Add') {
                    dialog_deceased_Buttons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this record?")) {
                            $(this).dialog("close");
                            /*
                            othertransaction_id = $('#dd_othertransactions_transaction_id').val();
                            var arForm = [{ "name": "othertransaction_id", "value": othertransaction_id }];
                            var formData = JSON.stringify({ formVars: arForm });
                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/delete_othertransaction', // the url where we want to POST
                                data: formData,
                                dataType: 'json', // what type of data do we expect back from the server
                                success: function (result) {
                                    $(tr).remove();
                                    total_transactions();
                                },
                                error: function (xhr, status) {
                                    alert("An error occurred: " + status);
                                }
                            });
                            */
                        }
                    }
                }
                $("#dialog_deceased").dialog('option', 'buttons', dialog_deceased_Buttons);

            });

        }); //$(document).ready
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html %>
    <button data-id="btn_maintain" data-mode="add" type="button">Register a deceased person</button><br />
    <div id="dialog_deceased" title="Please enter the deceased's details" style="display: none">
        First name:
        <asp:TextBox ID="tb_firstname" data-id="tb_firstname" runat="server"></asp:TextBox><br />
        Last name:
        <asp:TextBox ID="tb_lastname" data-id="tb_lastname" runat="server"></asp:TextBox><br />
        Known as<br />
        Gender<br />
        Date of birth<br />
        Date of death<br />
        Place of death<br />
        Last residence<br />
        Obituary<br />
        Funeral Director<br />
        Funeral Arrangements<br />
        Photos<br />
        Option: Koha to: Funeral Director / Agent / Both<br />
        Authorised by Funeral Director<br />
        Date for Donations from<br />
        Date for Donations to<br />
        Date for Comments from<br />
        Date for Comments to<br />
        Allow photos<br />

    </div>


</asp:Content>
