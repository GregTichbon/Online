<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Neo1.aspx.cs" Inherits="DataInnovations.TestandPlay.Neo1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        img {
            width:1200px;
        }

        .neo {
            width:400px;
            border-style:solid;
            border-color:red;
        }
        h1 {
            color:yellow;
        }

    </style>
    
</head>
<body>
    <form id="form1" runat="server">
     
        <p>Neo was here</p>

               <h1>Neo was here</h1>
        <img style="width:100px" src="../Dependencies/Freeze_Table_Columns_Rows/Ejemplo3.png" />

        <img  src="../Dependencies/Freeze_Table_Columns_Rows/Ejemplo3.png" />

        <img class="neo"  src="../Dependencies/Freeze_Table_Columns_Rows/Ejemplo3.png" />

        <div class="neo">
            <img  src="../Dependencies/Freeze_Table_Columns_Rows/Ejemplo3.png" />
        </div>


    </form>
</body>
</html>
