#!/usr/bin/python
import time
import sys  
import smtplib
import argparse
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
from email import encoders
 
fromaddr = "smithlink@gmail.com"
toaddr = "smithlink@gmail.com"
 
msg = MIMEMultipart()
 
msg['From'] = fromaddr
msg['To'] = toaddr
msg['Subject'] = "SUBJECT OF THE EMAIL"
 
body = "TEXT YOU WANT TO SEND"
 
msg.attach(MIMEText(body, 'plain'))

# get argument from command line
#
parser = argparse.ArgumentParser()
parser.add_argument('input_file', help='Input file')
args = parser.parse_args()
 
filename = args.input_file
attachment = open(args.input_file, 'rb')
 
part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())
encoders.encode_base64(part)
part.add_header('Content-Disposition', "attachment; filename= %s" % filename)
 
msg.attach(part)
 
server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()
server.login("smithlink@gmail.com", "3cwblunch4")
text = msg.as_string()
server.sendmail(fromaddr, toaddr, text)
server.quit()