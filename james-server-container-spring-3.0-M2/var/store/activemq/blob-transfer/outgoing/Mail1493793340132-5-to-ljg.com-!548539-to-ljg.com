Return-Path: <>
Date: Wed, 3 May 2017 16:40:41 +0800 (CST)
From: postmaster@abc.com
To: admin@ljg.com
Message-ID: <2107013673.1.1493800841304.JavaMail.zhou@DESKTOP-NOTN7SH>
In-Reply-To: <585701787.2.1493793340114.JavaMail.zhou@DESKTOP-NOTN7SH>
Subject: Re:test
MIME-Version: 1.0
Content-Type: multipart/report; 
	boundary="----=_Part_0_1570486456.1493800841217"; 
	report-type=delivery-status

------=_Part_0_1570486456.1493800841217
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi. This is the James mail server at DESKTOP-NOTN7SH.
I'm afraid I wasn't able to deliver your message to the following addresses.
This is a permanent error; I've given up. Sorry it didn't work out.  Below
I include the list of recipients and the reason why I was unable to deliver
your message.

Failed recipient(s):
user1@ljg.com

Error message:
Temporary problem looking up mail server for host: ljg.com.  I cannot determine where to send this message.


------=_Part_0_1570486456.1493800841217
Content-Type: message/delivery-status; name=status.dat
Content-Transfer-Encoding: 7bit
Content-Description: Delivery Status Notification
Content-Disposition: attachment; filename=status.dat

Reporting-MTA: dns; 10.108.115.130
Received-From-MTA: dns; 127.0.0.1

Final-Recipient: rfc822; user1@ljg.com
Action: failed
Status: Temporary problem looking up mail server for host: ljg.com.  I cannot determine where to send this message.
Diagnostic-Code: X-James; Temporary problem looking up mail server for host: ljg.com.  I cannot determine where to send this message.
Last-Attempt-Date: Wed, 3 May 2017 16:35:41 +0800 (CST)

------=_Part_0_1570486456.1493800841217
Content-Type: message/rfc822; name=test
Content-Disposition: Attachment; filename=test

Return-Path: <admin@ljg.com>
Received: from 127.0.0.1 ([127.0.0.1])
          by 10.108.115.130 (JAMES SMTP Server ) with ESMTP ID 674
          for <user1@ljg.com>;
          Wed, 3 May 2017 14:35:40 +0800 (CST)
Date: Wed, 3 May 2017 14:35:40 +0800 (CST)
From: admin <admin@ljg.com>
Sender: admin <admin@ljg.com>
To: user1@ljg.com
Message-ID: <585701787.2.1493793340114.JavaMail.zhou@DESKTOP-NOTN7SH>
Subject: test
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_0_1204503785.1493793340100"
X-Priority: 3

------=_Part_0_1204503785.1493793340100
Content-Type: text/html;charset=UTF-8
Content-Transfer-Encoding: 7bit

<p>test</p>
------=_Part_0_1204503785.1493793340100--

------=_Part_0_1570486456.1493800841217--
