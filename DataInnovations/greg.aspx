﻿<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="greg.aspx.cs" Inherits="SMSChecker.greg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <a href="http://private.incedo.org.nz">Incedo</a>
        <br />
        <a href="http://private.incedo.org.nz/prayer/send_dailytext.asp" onclick="return confirm('Are you sure you want to do this?');">Send Incedo Daily Prayer texts</a>
        <br />
        <br />
        <a href="SMS/Send/Form.aspx">Send text from form</a>
                <br />
        <br />
        <a href="http://webmail.datainn.co.nz">Data Innovations Webmail</a>
        <br />
        <br />
        <a href="raffles/raffles.aspx">Raffles</a>
        <br />
        <a href="raffles/communicatewinners.aspx">Communicate with winners</a>
        <br />
        <a href="raffles/spinner.aspx">Raffle Spinner</a>
        <br />
        <a href="raffles/UBC2019Avoucher.aspx">Raffle Voucher</a>
        <br />
        
        <br />
        <a href="../raffles/ubc2019a">UBC2019A Raffle menu</a>
        <br />
        <br />
        <a href="meetingscheduler/notify.aspx">Meeting Scheduler - Notify</a>
        <br />
        <br />
        <a href="sms/administration/group.aspx">SMS Groups and Send</a>
        <br />
        <a href="sms/log.aspx">SMS Log</a>
        <br />
        <a href="sms/data.asmx/SMSPhoneStatus">SMS Phone Status</a>
        <br />
        <br />
        <a href="http://office.datainn.co.nz/vehicles">Vehicle Reminders</a>
        <br />
        <br />
        <a href="log.aspx">Log</a>
                <br />
        <br />
        <a href="http://iti.ninja/tracker.aspx">Iti.ninja Tracker</a><br />
        <a href="http://iti.ninja/post.asmx">Iti.ninja Create Link</a><br />
        <br />
        <a href="accounts">Personal Accounts</a>
        <br />
        <a href="http://ubc.org.nz/people/signupList.aspx">Schools Learn to Row 2019</a>
        

    </form>
</body>

</html>
