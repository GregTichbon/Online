<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maint.aspx.cs" Inherits="UBC.People.Maint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>
    <!--additional-methods.min.js-->


    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var x = $(event.target).text();         // active tab
                var y = $(event.relatedTarget).text();  // previous tab
                $(".act span").text(x);
                $(".prev span").text(y);
            });

            $("#form1").validate();

            $(".numeric").keydown(function (event) {
                if (event.shiftKey == true) {
                    event.preventDefault();
                }

                if ((event.keyCode >= 48 && event.keyCode <= 57) ||
                    (event.keyCode >= 96 && event.keyCode <= 105) ||
                    event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
                    event.keyCode == 39 || event.keyCode == 46 || (event.keyCode == 190 && 1 == 2)) {
                } else {
                    event.preventDefault();
                }

                if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
                    event.preventDefault();
                //if a decimal has been added, disable the "."-button

            });

            $('.send_text').click(function () {
                alert('This will ask for a text message and then send it to: ' + $('td:first', $(this).parents('tr')).text());
            })
           $('.send_email_system').click(function () {
                alert('This will ask for a the subject and body and then send it to: ' + $('td:first', $(this).parents('tr')).text());
            })

            $('.send_email_local').click(function () {
                email = $('td:first', $(this).parents('tr')).text();
                firstname = $('#tb_firstname').val();
                knownas = $('#tb_knownas').val();
                if (knownas == "") {
                    knownas = firstname;
                }
                $(this).attr("href", "mailto:" + email + "?subject=Union Boat Club&body=Hi " + knownas);
            })



            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');
        });

    </script>
</head>
<body>
    <div class="container" style="background-color: #FCF7EA">
        <form id="form1" runat="server" class="form-horizontal" role="form">
            <input id="hf_guid" name="hf_guid" type="hidden" value="<%:hf_guid%>" />


            <h1>Union Boat Club - Person Maintenance
            </h1>





            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_firstname">First name</label>
                <div class="col-sm-8">
                    <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" maxlength="20" required />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_knownas">Known as</label>
                <div class="col-sm-8">
                    <input id="tb_knownas" name="tb_knownas" type="text" class="form-control" value="<%:tb_knownas%>" maxlength="20" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
                <div class="col-sm-8">
                    <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" maxlength="20" required />
                </div>
            </div>


            <ul class="nav nav-tabs">
                <li class="active"><a href="#div_basic">Basic</a></li>
                <li><a href="#div_attendance">Attendance</a></li>
                <li><a href="#div_finance">Finance</a></li>
                <li><a href="#div_phone">Phone</a></li>
                <li><a href="#div_email">Email</a></li>
            </ul>
            <div class="tab-content">
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_basic" class="tab-pane fade in active">
                    <h3>Basic</h3>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_gender">Gender</label>
                        <div class="col-sm-8">
                            <select id="dd_gender" name="dd_gender" class="form-control" required>
                                <%= Generic.Functions.populateselect(gender, dd_gender,"None") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_birthdate">Birthdate</label>
                        <div class="col-sm-8">
                            <input id="tb_birthdate" name="tb_birthdate" type="text" class="form-control" value="<%:tb_birthdate%>" maxlength="20" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_medical">Medical</label>
                        <div class="col-sm-8">
                            <textarea id="tb_medical" name="tb_medical" class="form-control"><%: tb_medical %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_dietry">Dietry requirements</label>
                        <div class="col-sm-8">
                            <textarea id="tb_dietry" name="tb_dietry" class="form-control"><%: tb_dietry %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_category">Category</label>
                        <div class="col-sm-8">
                            <select id="dd_category" name="dd_category" class="form-control">
                                <%= Generic.Functions.populateselect(category, dd_category,"") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_school">School</label>
                        <div class="col-sm-8">
                            <select id="dd_school" name="dd_school" class="form-control" required>
                                <%= Generic.Functions.populateselect(school, dd_school,"") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_schoolyear">School year</label>
                        <div class="col-sm-8">
                            <input id="tb_schoolyear" name="tb_schoolyear" type="text" class="form-control numeric" value="<%:tb_schoolyear%>" required maxlength="2" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_notes">Notes</label>
                        <div class="col-sm-8">
                            <textarea id="tb_notes" name="tb_notes" class="form-control"><%: tb_notes %></textarea>
                        </div>
                    </div>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_attendance" class="tab-pane fade in">
                    <h3>Attendance</h3>
                    <table class="table">
                        <asp:Literal ID="Lit_attendance" runat="server"></asp:Literal>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_finance" class="tab-pane fade in">
                    <h3>Finance</h3>
                    <table class="table">
                        <asp:Literal ID="Lit_finance" runat="server"></asp:Literal>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_phone" class="tab-pane fade in">
                    <h3>Phone</h3>
                    <table class="table">
                        <asp:Literal ID="Lit_phone" runat="server"></asp:Literal>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_email" class="tab-pane fade in">
                    <h3>Email</h3>
                    <table class="table">
                        <asp:Literal ID="Lit_email" runat="server"></asp:Literal>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
            </div>
            <!-- tabs -->
            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>
