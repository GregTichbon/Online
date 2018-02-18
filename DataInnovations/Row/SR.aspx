<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SR.aspx.cs" Inherits="DataInnovations.Row.SR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rowing Strok Rate</title>
    <script>
var cnt = 0;
var s;
//var lasttime;
var times = [];

function myFunction() {
    d = new Date();
    t = d.getTime();

    if(cnt == 0) {
        s = t;
        elapsedtime = 0
        fromstart = 0;
        current = 0;
        last5 = 0;
    }
    else {
        elapsed = t - s;
        elapsedtime = totimer(elapsed / 1000);
        fromstart = parseInt( 60 / elapsed * cnt * 1000);
        current = parseInt( 60 / (t - times[cnt - 1]) * 1000);
        if(cnt > 5) {
            last5 = parseInt( 60 / (t - times[cnt - 5]) * 5 * 1000);
        } else {
            last5 = '';
        }
     
    }

    times.push(t);
   
    document.getElementById("rate").innerHTML = "Time: " + elapsedtime + "<br />Strokes: " + cnt + "<br />From start: " + fromstart + "<br />Current: " + current + "<br />Last 5: " + last5;
    cnt ++;

}

function totimer(elapsed) {
//alert("elapsed=" + elapsed);
    var fullseconds = Math.floor(elapsed);
    var milliseconds = (elapsed - fullseconds).toFixed(3);
    var minutes = Math.floor(elapsed / 60);
    var seconds = fullseconds - (minutes * 60);
    //milliseconds = milliseconds + '.' + seconds;
//alert("fullseconds=" + fullseconds);
//alert("minutes=" + minutes);
//alert("seconds=" + seconds);
//alert("milliseconds=" + milliseconds);
    
    return minutes + ':' + ('0' + seconds).substr(-2) + '.' + ('000' + milliseconds).substr(-3); // + '<br />' + minutes + '-' + seconds + '-' + milliseconds;
    //return minutes + ':' + seconds.toFixed(2) + '.' + milliseconds + '<br />' + minutes + '-' + seconds + '-' + milliseconds;
}
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <button type="button" onclick="myFunction()">Click</button>

        <p id="rate"></p>
    </form>
</body>
</html>
