<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaxLength1.aspx.cs" Inherits="Online.TestAndPlay.MaxLength1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">




    <script type="text/javascript">
        $(document).ready(function () {
            $("#overlaidLength").maxlength({ feedbackText: '{c}/{m}' });
            $("#tb_projectdescription").maxlength({ feedbackText: '{c}/{m}' });

            //$(function () {
            //    $("textarea[maxlength]").bind('input propertychange', function () {
            //        alert(1);
            //        var maxLength = $(this).attr('maxlength');
            //        if ($(this).val().length > maxLength) {
            //            $(this).val($(this).val().substring(0, maxLength));
            //        }
            //    })
            //});

            $('#btn').click(function () {
                alert($('#tb_projectdescription').val().length);
            })

        });





    </script>

    <style>
        .maxlength-feedback {
            font-size:10px;
        }


        #overlaidLength {
            padding-top: 0.5em;
        }

            #overlaidLength + .maxlength-feedback {
                position: relative;
                left: -5.25em;
                top: 1px;
                width: 4em;
                padding-right: 0.25em;
                color: #fff;
                background-color: #3c8243;
                text-align: right;
            }
    </style>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_projectdescription">Describe the project / activity</label><div class="col-sm-8">
            <textarea id="tb_projectdescription" name="tb_projectdescription" maxlength="1000" data-maxlength="max:1000" class="form-control" required></textarea>
        </div>
    </div>


    <p><span>Overlaid feedback:</span>
			<textarea id="overlaidLength" rows="3" cols="60"></textarea></p>

    <a id="btn" href="#">Test</a>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
