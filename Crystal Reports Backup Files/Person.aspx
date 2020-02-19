<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Person.aspx.cs" Inherits="DataInnovations.StrengthFinders.Person" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    


    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>


    <script type="text/javascript">



        $(document).ready(function () {
            $("#tb_person").autocomplete({
                source: "data.asmx/PersonSelect",  //can pass querystring here
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    person = ui.item;
                    if (person) {
                        $("#tb_person").val(person.label);

                    } else {
                        alert('Not found');
                    }
                },
                open: function (event, ui) {
                    if (navigator.userAgent.match(/iPad/)) {
                        $('.autocomplete').off('menufocus hover mouseover');
                    }
                },

            })
            /*
        .autocomplete("instance")._renderItem = function (ul, item) {
            return $("<li>")
              .append("<a>" + item.label + "<br />" + item.xxxx + " " + item.xxxx + "</a>")
              .appendTo(ul);
        };
        */



        }); //document ready
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Person Maintenance
            </h1>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_person">Name</label>
                <div class="col-sm-8">
                    <input id="tb_person" name="tb_person" type="text" class="form-control" required />
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                </div>
                <asp:Button ID="btn_submit" runat="server" Text="Submit" class="btn btn-info" OnClick="btn_submit_Click1" />
            </div>


        </div>
    </form>
</body>
</html>
