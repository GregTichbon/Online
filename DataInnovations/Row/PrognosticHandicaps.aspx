<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrognosticHandicaps.aspx.cs" Inherits="DataInnovations.Row.PrognosticHandicaps" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Prognostics</title>
    <!-- Style Sheets -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous" />

    <style>
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script type="text/javascript">


        $(document).ready(function () {

          $(".autocomplete").autocomplete({
                source: "../data.asmx/person_name_autocomplete",
                minLength: 2,
                select: function (event, ui) {
                    //event.preventDefault();
                    selected = ui.item;
                    //alert(selected.guid);
                    window.open("maint.aspx?id=" + selected.guid + "&returnto=search", "_self");
                    /*
                    $("#category").val(selected ?
                        selected.label : "Nothing selected, input was " + this.value);
                        */
                   
                }
            })  


        }); //document.ready
    </script>

</head>
<body>
    <form id="form1" runat="server">
        

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_distance">Distance</label><div class="col-sm-8">
                    <input type="text" id="tb_distance" name="tb_distance" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_boat_1">Boat</label><div class="col-sm-8">
                    <input class="autocomplete" type="text" id="tb_boat_1" name="tb_boat_1" />
                </div>
            </div>

           <div class="form-group">
                <input type="button" value="Calculate" />
            </div>
        

    </form>
</body>
</html>
