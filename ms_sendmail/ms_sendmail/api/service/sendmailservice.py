import smtplib, os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from pathlib import Path
from ms_sendmail.api.util.properties import load_properties

#Load Properties
BASE_DIR = Path(__file__).resolve().parent.parent.parent
print('BASE_DIR: {0}'.format(BASE_DIR))
properties = load_properties(BASE_DIR)

def build_and_send(toList):
    try:
        #Load mail properties
        username = properties['EmailSection']['mail.smtp.user']
        password = properties['EmailSection']['mail.smtp.password']
        smtp_host = properties['EmailSection']['mail.smtp.host']
        smtp_port = properties['EmailSection']['mail.smtp.port']
        subject = "POC SEND SUCCESS MAIL"
        mail_body = ""
        # Read template html
        txt_file = open(os.path.join(BASE_DIR, 'sources', 'template', 'mail', 'success-mail.html'))
        mail_body = txt_file.read()
        txt_file.close()
        #print("mail_body: {0}".format(mail_body))
        # Override template html
        mail_body = mail_body.replace('#PERSON_NAME', 'John W.')
        array = ["element 1", "element 2", "element 3", "element 4"]
        list_a = ""
        for e in array:
            data = "<tr><td>{0}</td></tr>".format(e)
            list_a = list_a + data
        mail_body = mail_body.replace('#LIST', list_a)
        #print("mail_body: {0}".format(mail_body))
        #Set mail paremeters
        mimemsg = MIMEMultipart()
        mimemsg['From'] = username
        mimemsg['To'] = toList
        mimemsg['Subject'] = subject
        mimemsg.attach(MIMEText(mail_body, 'html'))
        connection = smtplib.SMTP(host=smtp_host, port=smtp_port)
        connection.starttls()
        connection.login(username,password)
        #Send mail
        connection.send_message(mimemsg)
        connection.quit()
    except Exception as e:
        print(e)        