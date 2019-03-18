<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Delimited.aspx.cs" Inherits="Online.Administration.Delimited" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('#cb_blanks').click(function () {
                $('#div_duplicates').toggle($('#cb_blanks').prop('checked'));
            });


            $('#btn_submit').click(function () {
                var input = $('#tb_input').val();

                var blanksremoved = 0;
                var array = input.split(String.fromCharCode(10));
                inputlength = array.length;

                if ($('#cb_blanks').prop('checked')) {
                    blankarray = $.grep(array, function (n) {
                        return n.replace(/\s/g, '') != '';
                    });
                    blanksremoved = inputlength - blankarray.length;
                    array = blankarray;
                };

                if ($('#cb_unique').prop('checked')) {
                    var uniquearray = [];
                    var duplicatearray = [];

                    $.each(array, function (i, value) {
                        if ($.inArray(value, uniquearray) === -1) {
                            uniquearray.push(value);
                        } else {
                            duplicatearray.push(value);
                        }
                    });

                    array = uniquearray;
                    //alert(array);
                    //alert(uniquearray);
                    $('#div_duplicatesdata').text(duplicatearray.join());
                };

                if ($('#tb_textqualifierF').val() != '' || $('#tb_textqualifierE').val() != '') {
                    $.each(array, function (i, value) {
                        array[i] = $('#tb_textqualifierF').val() + value + $('#tb_textqualifierE').val();
                    });
                }

                $('#tb_output').val(array);
                var outputlength = array.length;

                var fieldsarray = array.join().split(",");
                var fieldslength = fieldsarray.length;


                $('#div_result').text('Input items: ' + inputlength + ' Blanks removed: ' + blanksremoved + ' Output items: ' + outputlength + ' Actual fields: ' + fieldslength);


            })
            $('#btn_clear').click(function () {
                $('#tb_input').val('');
                $('#tb_output').val('');
                $('#div_result').text('');
                $('#div_duplicatesdata').text('');

            });

            $("#btn_copy").click(function () {
                $("#tb_output").select();
                document.execCommand('copy');
            });

        });//document ready
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1>Make a comma (,) delimited string</h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_input">
            Input
        </label>
        <div class="col-sm-8">
            <textarea id="tb_input" name="tb_input" class="form-control" rows="10" required></textarea>
        </div>
    </div>
        <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input id="btn_clear" type="button" class="btn btn-info" value="Clear" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_unique">
            Remove duplicates
        </label>
        <div class="col-sm-2">
            <input type="checkbox" checked="checked" id="cb_unique" />
        </div>
        <label class="control-label col-sm-4" for="cb_blanks">
            Remove blanks
        </label>
        <div class="col-sm-2">
            <input type="checkbox" checked="checked" id="cb_blanks" />
        </div>

    </div>



        <div class="form-group">
        <label class="control-label col-sm-4" for="tb_output">
            Add text qualifiers
        </label>
        <div class="col-sm-4">
            <input type="text" id="tb_textqualifierF" name="tb_textqualifierF" class="form-control" />
        </div>
        <div class="col-sm-4">
            <input type="text" id="tb_textqualifierE" name="tb_textqualifierE" class="form-control" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_output">
            Output
        </label>
        <div class="col-sm-8">
            <textarea id="tb_output" name="tb_output" class="form-control" rows="4"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_output">
            Result
        </label>
        <div class="col-sm-8" id="div_result">
        </div>
    </div>
    
    <div class="form-group" id="div_duplicates">
        <label class="control-label col-sm-4" for="tb_output">
            Duplicates removed
        </label>
        <div class="col-sm-8" id="div_duplicatesdata">
        </div>
    </div>


    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
            <input id="btn_submit" type="button" class="btn btn-info" value="Convert" />
        </div>
        <div class="col-sm-4">
            <input id="btn_copy" type="button" class="btn btn-info" value="Copy" />
        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
