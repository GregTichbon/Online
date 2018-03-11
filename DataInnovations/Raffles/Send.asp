<%
dim P(100)
dim N(100)
P(1) = "027 9626711"
N(1) = "Kushla"
P(2) = "021 1127942"
N(2) = "Aimee "
P(3) = "027 9150458"
N(3) = "Sharon"
P(4) = "027 6769944"
N(4) = "Pip"
P(5) = "027 4465351"
N(5) = "Therese"
P(6) = "027 2636605"
N(6) = "Sandra"
P(7) = "022 1083162"
N(7) = "Barry"
P(8) = "027 2839089"
N(8) = "Lauren"
P(9) = ""
N(9) = "Jean"
P(10) = "027 3699189"
N(10) = "Warrick"
P(11) = "027 7878181"
N(11) = "Dallas"
P(12) = "027 5225411"
N(12) = "Jordi"
P(13) = "027 4356900"
N(13) = "Phyllis"
P(14) = "022 4243829"
N(14) = "Darryl"
P(15) = ""
N(15) = "Grace"
P(16) = "027 2888105"
N(16) = "Steve"
P(17) = "027 6081052, 027 4705166"
N(17) = "Denise"
P(18) = "027 4705166"
N(18) = "Fiona"
P(19) = "027 4539813"
N(19) = "Jo"
P(20) = "027 6352389"
N(20) = "Louise"
P(21) = "027 6618399"
N(21) = "Tracy"
P(22) = "021 1592359"
N(22) = "Alison"
P(23) = "027 7871122"
N(23) = "Jo"
P(24) = "027 4333767"
N(24) = "David"
P(25) = "027 7743876"
N(25) = "Nikki"
P(26) = "027 3143467"
N(26) = "Michael"
P(27) = "021 1611202"
N(27) = "Dion"
P(28) = "021 649599"
N(28) = "Mike"
P(29) = "027 4444847"
N(29) = "Bernie"
P(30) = "021 2420585"
N(30) = "Sarita"
P(31) = "022 0270018"
N(31) = "Sam & Pauline"
P(32) = "021 0416596"
N(32) = "Michelle"
P(33) = "027 2763016"
N(33) = "Garry"
P(34) = "027 2511611"
N(34) = "Sue"
P(35) = ""
N(35) = "Elaine"
P(36) = "021 02569467"
N(36) = "Marty"
P(37) = "027 2291307"
N(37) = "Chris"
P(38) = "027 6639491"
N(38) = "Noeline"
P(39) = "027 2570903"
N(39) = "Shorty & Sharyn"
P(40) = "027 2165643"
N(40) = "Marianne"
P(41) = "027 2733442"
N(41) = "Abby"
P(42) = "021 0420136 "
N(42) = "Jennifer"
P(43) = "027 4230980"
N(43) = "Chrissy"
P(44) = "027 5625456"
N(44) = "Roanna"
P(45) = "021 1709030"
N(45) = "Kim"
P(46) = "027 6756772"
N(46) = "Carl"
P(47) = ""
N(47) = "George"
P(48) = "027 4235786"
N(48) = "Doug"
P(49) = "027 2554517"
N(49) = "Tara"
P(50) = "027 2433561"
N(50) = "Mahanga"

P(51) = "027 2495088"
N(51) = "Greg"
P(52) = "027 4266494"
N(52) = "Judy"






    Set objXMLHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    'msg = "Thanks for supporting our Maadi Rowers.  The first meat raffle draw has been made and the winner is...... Drum roll ..... Ticket number 14 .... Tara Waara.  Congrats Tara.  I'll be in contact to sort out your prize.  To all the rest, better luck next week.  -Greg"
    'msg = "The 2nd draw for the $50 meat pack has been made and the winner is 44 - Jennifer Anderson from WDC.  Congrats, I'll be in touch.  Neo won the Under 17 single at the Whanganui champs last weekend and is off to Karapiro for the North Island School Champs this weekend.  Thanks for your support.  -Greg"
    msg = "Another meat raffle draw, and the winner is xx - xxxxxxxx.  We are at North Island Secondary School Champs.  Cullinane and Girls' College are loving the experience and doing well.  Neo will be racing a B Final of the U16 single this afternoon.  He had the 7th fastest time in the semis so should do well.  Check out rowit.nz if you're interested :-) -Greg"
    
    if 1=1 then
        for f1=51 to 52
            mobile = replace(P(f1)," ","")
            if mobile <> "" then
                mobile = "+64" & mobile
                message = "Hi " & N(f1) '& ", " & msg
                response.write mobile & "   " & message & "<br />"
                if 1 = 2 then
                    NewURLBase = "http://office.datainn.co.nz/?P=" & mobile & "&M="
                    NewURL = NewURLBase & message
                    'response.write "<br>" & NEWURL						
                    objXMLHTTP.Open "GET", replace(NewURL," ","%20"), False
                    objXMLHTTP.Send
                else
                    Dim iClick 
				    Dim res
				    Dim txtmessage
						
				    Set iClick = Server.Createobject("M4USMS.SMS2")
				    iclick.ServerMode = false
				    res = iClick.SMSConnect("YouthForChris001","0244981")
	
				    If res <> 0 Then
					    textresponse = "A. Error no. " & res & " while trying to connect."
				    else
					    iClick.IDMode = 1 'userIDs: 1=System assigned, 2=User assigned
					    valid = 168 '2 days
					    'AddMessageEx([Number As String], [MsgText As String], [Delay As Long = -1], [Id As Long = -1], [Valid As Byte = Empty], [Report As Boolean = False]) As Long
					    res = iClick.AddMessageEx(cstr(mobile),cstr(message),0)		
					    If res <> 0 Then
						    textresponse = "C. Error no. " & res & " while trying to add a message."
					    else
						    res = iClick.SendMessages
						    If res <> 0 Then
							    textresponse = "D. Error no. " & res & " while trying to send a message."
						    else
							    textresponse = "Message sent to: " & mobile
						    end if
					    end if
				    end if
                    response.write textresponse & "<br>"
			    end if
            end if
        next
    end if

%>