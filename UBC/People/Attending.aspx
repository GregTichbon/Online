<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Attending.aspx.cs" Inherits="UBC.People.Attending" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <style>
        #div_head { 
            text-align:center;
            font-size:xx-large;
        }
    </style>

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>

    <script>

        var currentevent = <%=currentevent%>;
        var events = [<%=events%>];
        var eventscount = events.length;
        $(document).ready(function () {

            getevent(currentevent);

            $('#previous').click(function () {
                currentevent--;
                if (currentevent == 0) {
                    currentevent == 1;
                    alert('There are no previous events');
                } else {
                    getevent(currentevent);
                }
            })
            $('#next').click(function () {
                currentevent++;
                if (currentevent == eventscount) {
                    currentevent = eventscount;
                    alert('There are no more events');
                } else {
                    getevent(currentevent);
                }
            })
            $('body').on('click', '.attendance', function () {
                alert('to do: allow update');
                val = $(this).text();
                $(this).html('<select><option>No</option><option>Yes</option><option>Partial</option><option>Maybe</option><option>Expected</option><option>Going</option><option>Not Going</option><option>Will be late</option></select>');
                $(this).val(val);
            })

            $('body').on('click', '.selectperson', function () {
                window.open("maint.aspx?id=" + $(this).parent().attr('id').substring(3), "_blank");
                //window.location.href = "maint.aspx?id=" + $(this).attr('id').substring(3);
            });

            /*

            event_id = $(tr).prop('id').substring(6);
            var arForm = [{ "name": "event_id", "value": event_id }, { "name": "person_id", "value": "xxx" }, { "name": "attendance", "value": $('#attendance').val() }, { "name": "personnote", "value": $('#personnote').val() }];
            var formData = JSON.stringify({ formVars: arForm });

            $.ajax({
                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                contentType: "application/json; charset=utf-8",
                url: 'posts.asmx/updateattendance', // the url where we want to POST
                data: formData,
                dataType: 'json', // what type of data do we expect back from the server
                success: function (result) {

                },
                error: function (xhr, status) {
                    alert('error');

                }
            });
            */

            $('#login').click(function () {
                window.location.href = "<%: ResolveUrl("security/login.aspx")%>";
            })
            $('#menu').click(function () {
                window.location.href = "<%: ResolveUrl("default.aspx")%>";
            })

        }) //document.ready

        function getevent(passevent) {
            event_id = events[passevent];
            //alert(passevent + "," + event_id);
         
            //var arForm = [{ "name": "event_id", "value": event_id }];
            //var formData = JSON.stringify({ formVars: arForm });
            arForm = { event_id: event_id };

            $.ajax({
                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                //contentType: "application/json; charset=utf-8",
                url: 'data.aspx/?mode=get_event_and_attendance', // the url where we want to POST
                data: arForm,
                dataType: 'html', // what type of data do we expect back from the server
                success: function (result) {
                    $('#html').html(result);
                },
                error: function (xhr, status) {
                    alert('error');

                }
            });

        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="toprighticon">
        <%=html_button %>
    </div>
    <div class="container" style="background-color: #FCF7EA">
        <input style="float:left" type="button" id="previous" value="Previous" class="btn btn-info" /> <input style="float:right" type="button" id="next" value="Next" class="btn btn-info" />
        <div id="html"></div>
       
    </div>
</asp:Content>
