<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Validation1.aspx.cs" Inherits="Online.TestAndPlay.Validation1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title></title>

    <script type="text/javascript">


        $(document).ready(function () {

            $(document).uitooltip({
                position: {
                    my: "left bottom",
                    at: "left top"
                }
            });


            $("#form1").validate({
                ignore: [],
                rules: {
                    tb_businessname: {
                        required: true
                    },
                    hidden1: {
                        greg: true
                    }
                },
                errorPlacement: function (error, element) {
                    var placement = $(element).data('errorplacement');
                    if (placement) {
                        $(placement).append(error)
                    } else {
                        error.insertAfter(element);
                    }
                }
            });


            $.validator.addMethod("greg", function (value, element) {

                alert(3);
                // ORIGINAL LINE: return this.optional(element) || /^-?\d+$/.test(value);  
                return false;


            }, "Location(s) are required");

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_businessname">Name of Business:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_businessname" name="tb_businessname" class="form-control" maxlength="100" required data-errorplacement="#errTest1" title="What is the name of the bisiness" />
        </div>
    </div>
    <input id="hidden1" name="hidden1" type="hidden" />
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            <input id="Button1" type="submit" value="button" />
        </div>
    </div>

    Error 1:<span id="errTest1"></span>
    Error 2:<span id="errTest2"></span>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
