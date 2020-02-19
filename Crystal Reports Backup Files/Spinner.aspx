<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Spinner.aspx.cs" Inherits="DataInnovations.Raffles.Spinner" %>


<!doctype html>
<html>
<head>
    <title></title>
    <style>
        iframe {
            width: 800px;
            height: 800px;
            margin: 0 auto;
            background-color: #777;
            display: block;
            border:none;
        }
        body {
            background-color: #777;
        }
    </style>


</head>
<body>
    <p></p>
    <iframe src="https://wheeldecide.com/e.php?<%=numbers%>&time=5"></iframe>
</body>
</html>
