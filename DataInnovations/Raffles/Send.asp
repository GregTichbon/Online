<%
dim P(100)
P(1) = "02102569467"
P(2) = "0210416596"
P(3) = "0210420136"
P(4) = "0211127942"
P(5) = "0211592359"
P(6) = "0211709030"
P(7) = "0212420585"
P(8) = "021649599"
P(9) = "0211611202"
P(10) = "0221083162"
P(11) = "0224243829"
P(12) = "0272165643"
P(13) = "0272291307"
P(14) = "0272433561"
P(15) = "0272433561"
P(16) = "0272495088"
P(17) = "0272495088"
P(18) = "0272495088"
P(19) = "0272511611"
P(20) = "0272554517"
P(21) = "0272554517"
P(22) = "0272570903"
P(23) = "0272636605"
P(24) = "0272733442"
P(25) = "0272763016"
P(26) = "0272839089"
P(27) = "0272888105"
P(28) = "0273143467"
P(29) = "0273699189"
P(30) = "0274230980"
P(31) = "0274235786"
P(32) = "0274333767"
P(33) = "0274444847"
P(34) = "0274465351"
P(35) = "0274539813"
P(36) = "0275225411"
P(37) = "0275625456"
P(38) = "0276081052"
P(39) = "0274705166"
P(40) = "0276352389"
P(41) = "0276618399"
P(42) = "0276639491"
P(43) = "0276756772"
P(44) = "0276769944"
P(45) = "0277743876"
P(46) = "0277871122"
P(47) = "0277878181"
P(48) = "0279150458"
P(49) = "0279626711"
P(50) = "0272495088"
P(51) = "0274266494"




    Set objXMLHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    msg = "Thanks for supporting our Maadi Rowers.  The first meat raffle draw has been made and the winner is...... Drum roll ..... Ticket number 14 .... Tara Waara.  Congrats Tara.  I'll be in contact to sort out your prize.  To all the rest, better luck next week.  -Greg"

    if 1=1 then
        'mobile = "0272495088"
        for f1=43 to 51
            mobile = P(f1)
            response.write mobile & "<br />"
            NewURLBase = "http://office.datainn.co.nz/?P=" & mobile & "&M="
            NewURL = NewURLBase & msg
            'response.write "<br>" & NEWURL						
            objXMLHTTP.Open "GET", replace(NewURL," ","%20"), False
            objXMLHTTP.Send
        next
    end if

%>