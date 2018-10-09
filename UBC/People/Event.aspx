<%@ Page Title="Union Boat Club - Event" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Event.aspx.cs" Inherits="UBC.People.Event" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />


    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>


    <script>
        $(document).ready(function () {

            $('#dd_categories').select2();

            $('#cb_allday').change(function () {
                if ($(this).is(":checked")) {
                    $('.usetime').text('');
                } else {
                    $('.usetime').text('/time');
                }
            });

            $('#dd_show').change(function () {
                option = $(this).val();

                switch (option) {
                    case "Only noted":
                        $('#tbl_attendance tr[id^=tr_]').each(function () {
                            personid = $(this).attr("id").substring(3);
                            if ($("#dd_attendance_" + personid).val() == 'No' && $("#tb_note_" + personid).val() == '') {
                                $(this).hide();
                            } else {
                                $(this).show();
                            }
                        });
                        break;
                    case "All":
                        $('#tbl_attendance tr[id^=tr_]').show()
                        break;
                    case "Not noted":
                        $('#tbl_attendance tr[id^=tr_]').each(function () {
                            personid = $(this).attr("id").substring(3);
                            if ($("#dd_attendance_" + personid).val() == 'No' && $("#tb_note_" + personid).val() == '') {
                                $(this).show();
                            }
                            else {
                                $(this).hide();
                            }
                        });
                        break;
                }
            });
            
            counteach();



            $('#btn_refresh').click(function () {
                alert('Get data from server for categories: ' + $('#dd_categories').val());
                counteach();
            })

        });

        function counteach() {
            var items = {}, key;
            $('[id^=dd_attendance_]').each(function () {
                id = $(this).attr('id').substring(14);
                key = $(this).val();

                if (key == 'No' && $('#tb_note_' + id).val() != '') {
                    key = key + ' with notes';
                }
                if (!items[key]) {
                    items[key] = 0;
                }
                items[key] += 1;
            });
            mydiv = "";
            mydelim = "";
            $.each(items, function (key, val) {
                //alert([key, val]);
                mydiv += mydelim + [key, val];
                mydelim = " | ";
            });
            $('#div_count').text(mydiv);

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color:#FCF7EA">
     
        <h1>Union Boat Club - Event
        </h1>

        
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_title">Title</label>
            <div class="col-sm-8">
                <input id="tb_title" name="tb_title" type="text" class="form-control" value="<%: title %>" maxlength="20" />
            </div>
        </div>

       <div class="form-group">
            <label class="control-label col-sm-4" for="cb_allday">All day</label>
            <div class="col-sm-8">
                <input id="cb_allday" name="cb_allday" type="checkbox" style="width:auto" value="Yes" <%:allday_checked %>class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_startdatetime">Start date<span class="usetime"><%:datetime %></span></label>
            <div class="col-sm-8">
                <input id="tb_startdatetime" name="tb_startdatetime" type="text" class="form-control" value="<%: startdatetime %>" maxlength="20" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_enddatetime">End date<span class="usetime"><%:datetime %></span></label>
            <div class="col-sm-8">
                <input id="tb_enddatetime" name="tb_enddatetime" type="text" class="form-control" value="<%: enddatetime %>" maxlength="20" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_description">Description</label>
            <div class="col-sm-8">
                <textarea id="tb_description" name="tb_description" class="form-control"><%: description %></textarea>
            </div>
        </div>





        <asp:Literal ID="Lit_html" runat="server"></asp:Literal>


        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>
    </div>


</asp:Content>
