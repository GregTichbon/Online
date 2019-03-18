<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CodeBuilder.aspx.cs" Inherits="Online.Administration.CodeBuilder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        var lineid = 0; 
        var lineids = [<%:lineids%>];


        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "CodeBuilder.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
            var validator = $("#form1").validate();

            $('#hf_lineids').val(lineids);
            $("[id^=controltype_]").change(function () {
                //alert( this.id );
                controltype = this.value;
                id = this.id.substring(12);
                showhide(controltype, id);

            });
            /*
            $(".characters").maxlength();
            $(".characters").bind("updatex.maxlength", function (event, element, lastLength, length, maxLength, left) {
                console.log(event, element, lastLength, length, maxLength, left);
            });
            */
            $("#addline").click(function () {
                //alert( this.id );
                //var $sequence = $('<input/>').attr({ type: 'text', name:'text', value:'text'}).addClass("text");
                var $line = "";
                lineid = lineid + 1;
                lineids.push('x_' + lineid);
                $('#hf_lineids').val(lineids);

                //SEQUENCE
                var $sequence = '<td><input name="sequence_x_' + lineid + '" type="text" id="sequence_x_' + lineid + '" size="5" maxlength="3" value="999"></td>'
                $line = $line + $sequence

                //TITLE
                var $title = '<td><input name="title_x_' + lineid + '" type="text" id="title_x_' + lineid + '"></td>'
                $line = $line + $title

                //FIELD NAME
                var $field_name = '<td><input name="field_name_x_' + lineid + '" type="text" id="field_name_x_' + lineid + '"></td>'
                $line = $line + $field_name

                //TYPE
                var $type = '<td><select name="type_x_' + lineid + '" size="1" id="type_x_' + lineid + '">';
                $type = $type + '<% = populateselect(c_type, "","")  %>';
                $type = $type + '</select></td>';
                $line = $line + $type

                //FIELD TYPE
                var $fieldtype = '<td><select name="fieldtype_x_' + lineid + '" size="1" id="fieldtype_x_' + lineid + '">';
                $fieldtype = $fieldtype + '<% = populateselect(c_fieldtype, "","")  %>';
                $fieldtype = $fieldtype + '</select></td>';
                $line = $line + $fieldtype

                //DB NAME
                var $db_name = '<td><input name="db_name_x_' + lineid + '" type="text" id="db_name_x_' + lineid + '"></td>'
                $line = $line + $db_name

                //CONTROL TYPE
                var $controltype = '<td><select name="controltype_x_' + lineid + '" size="1" id="controltype_x_' + lineid + '">';
                $controltype = $controltype + '<% = populateselect(c_controltype, "","")  %>';
                $controltype = $controltype + '</select></td>';
                $line = $line + $controltype

                //SQL DATA TYPE
                var $sql_datatype = '<td><input name="sql_datatype_x_' + lineid + '" type="text" id="sql_datatype_x_' + lineid + '">';
                $line = $line + $sql_datatype

                //SP DATA TYPE
                var $sp_datatype = '<td><select name="sp_datatype_x_' + lineid + '" size="1" id="sp_datatype_x_' + lineid + '">';
                $sp_datatype = $sp_datatype + '<% = populateselect(c_sp_datatype, "","")  %>';
                $sp_datatype = $sp_datatype + '</select></td>';
                $line = $line + $sp_datatype

                /*


                //DESCRIPTION
                var $description = '<td><textarea name="description_x_' + lineid + '" id="description_x_' + lineid + '" maxlength="200" class="characters"></textarea></td>'
                $line = $line + $description

                //REQUIRED
                var $required = '<td><input name="required_x_' + lineid + '" type="checkbox" id="required_x_' + lineid + '" value="-1"></td>'
                $line = $line + $required

                //MAXIMUM LENGTH
                var $maxlength = '<td><input name="maxlength_x_' + lineid + '" type="text" id="maxlength_x_' + lineid + '" size="4" maxlength="4" value=""></td>'
                $line = $line + $maxlength

                //BOOTSTRAP
                var $bootstrapxs = '<td><input class="bswidth_x_' + lineid + '" name="bootstrap-xs_x_' + lineid + '" type="text" id="bootstrap-xs_x_' + lineid + '" size="2" maxlength="2" value=""></td>'
                var $bootstrapsm = '<td><input class="bswidth_x_' + lineid + '" name="bootstrap-sm_x_' + lineid + '" type="text" id="bootstrap-sm_x_' + lineid + '" size="2" maxlength="2" value=""></td>'
                var $bootstrapmd = '<td><input class="bswidth_x_' + lineid + '" name="bootstrap-md_x_' + lineid + '" type="text" id="bootstrap-md_x_' + lineid + '" size="2" maxlength="2" value=""></td>'
                var $bootstraplg = '<td><input class="bswidth_x_' + lineid + '" name="bootstrap-lg_x_' + lineid + '" type="text" id="bootstrap-lg_x_' + lineid + '" size="2" maxlength="2" value=""></td>'
                $line = $line + $bootstrapxs + $bootstrapsm + $bootstrapmd + $bootstraplg

                //CHARACTERS LEFT
                var $charactersleft = '<td><input name="charactersleft_x_' + lineid + '" type="checkbox" id="charactersleft_x_' + lineid + '" value="-1"></td>'
                $line = $line + $charactersleft

                //NOTES
                var $notes = '<td><textarea name="notes_x_' + lineid + '" id="notes_x_' + lineid + '"></textarea></td>'
                $line = $line + $notes

                //DELETED
                var $deleted = '<td><input name="deleted_x_' + lineid + '" type="checkbox" id="deleted_x_' + lineid + '" value="-1"></td>'
                $line = $line + $deleted
                */

                $('#maintable').append('<tr>' + $line + '</tr>');
                //$("#holder").append($ctrl);			

                /*
                $("#controltype_x").change(function () {
                    //alert( this.id );
                    controltype = this.value;
                    id = this.id.substring(12);
                    showhide(controltype, id);
                });
                */
            });

        })

        function showhide(controltype, id) {
            //alert(controltype + ', ' + id);
            if (controltype == "TextBox") {
                $("#dropdownvalues_" + id).hide();
                $("#required_" + id).show();
                $("#maxlength_" + id).show();
                $("#charactersleft_" + id).show();
                $("#multiline_" + id).show();
                $(".bswidth_" + id).show();
            }
            else if (controltype == "Dropdown") {
                $("#dropdownvalues_" + id).show();
                $("#required_" + id).show();
                $("#maxlength_" + id).hide();
                $("#charactersleft_" + id).hide();
                $("#multiline_" + id).hide();
                $(".bswidth_" + id).hide();
            }
            else if (controltype == "Checkbox") {
                $("#dropdownvalues_" + id).hide();
                $("#required_" + id).hide();
                $("#maxlength_" + id).hide();
                $("#charactersleft_" + id).hide();
                $("#multiline_" + id).hide();
                $(".bswidth_" + id).hide();
            }

        }
    </script>

    <link href="CodeBuilder.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Code Builder
    </h1>
    <input type="button" id="addline" />
    <input type="hidden" id="hf_lineids" name="hf_lineids" />
    <asp:Label ID="lbl_html" runat="server" Text=""></asp:Label>


    <!-- Submit -->
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>






</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
