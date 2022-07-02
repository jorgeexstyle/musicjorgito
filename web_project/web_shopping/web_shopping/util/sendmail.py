from re import U
import smtplib, os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from pathlib import Path
from django.db.utils import IntegrityError
from django.contrib.auth.models import User 
# import environ
from rest_framework.authtoken.models import Token
from web_shopping.util.autogenerate import generate


def build_and_send(to_list, user_mail, password_mail, smtp_host_mail, smtp_port_mail, subject, body_mail):
    try:
        #Set mail paremeters
        mimemsg = MIMEMultipart()
        mimemsg['From'] = user_mail
        mimemsg['To'] = to_list
        mimemsg['Subject'] = subject
        mimemsg.attach(MIMEText(body_mail, 'html'))
        connection = smtplib.SMTP(host=smtp_host_mail, port=smtp_port_mail)
        connection.starttls()
        connection.login(user_mail,password_mail)
        #Load img
        base_dir = Path(__file__).resolve().parent.parent
        img_path = os.path.join(base_dir, 'static', 'img', 'icon', 'shopping-bag.png')
        print('img_path: ', img_path)
        with open(img_path, 'rb') as f:
            img_data = f.read()
        image = MIMEImage(img_data, 'jpeg')
        image.add_header('Content-Id', '<shoppingbag>')
        mimemsg.attach(image)
        #Send mail
        connection.send_message(mimemsg)
        connection.quit()
    except Exception as e:
        print(e)

def load_email_sender():
    # Initialise environment variables
    #env = environ.Env()
    #environ.Env.read_env()    
    user_mail = env.str('USER_MAIL')
    password_mail = env.str('PASSWORD_MAIL') 
    smtp_host_mail = env.str('SMTP_HOST_MAIL')
    smtp_port_mail = env.str('SMTP_PORT_MAIL')
    print('user_mail: ', user_mail)
    print('password_mail: ', password_mail)
    print('smtp_host_mail: ', smtp_host_mail)
    print('smtp_port_mail: ', smtp_port_mail)
    return user_mail, password_mail, smtp_host_mail, smtp_port_mail        

def create_token(user):
    print('create_token')
    try:
        print('new token')
        token = Token.objects.create(user=user)
        print('token -> {0}'.format(token))
        return token.key
    except IntegrityError as e:
        print('delete token')
        token = Token.objects.get(user=user)
        token.delete()
        print('new token')
        token = Token.objects.create(user=user)
        return token.key  

def build_token_recovery_pass(username, recovery_url):
    try:
        print('username: ', username)
        user = User.objects.get(username=username)
        email = user.email
        print('email: ', email)
        #Create Token
        token = create_token(user)
        print('token: ', token)
        #Load html template mail
        base_dir = Path(__file__).resolve().parent.parent
        mail_path = os.path.join(base_dir, 'template', 'mail', 'token-recovery-pass.html')
        print('mail_path: ', mail_path)
        txt_file = open(mail_path)
        mail_body = txt_file.read()
        #Replace template
        recovery_url = recovery_url + '?username='+username + '&token='+token         
        mail_body = mail_body.replace('#TOKEN_LINK', recovery_url)
        #Load email data web_shopping
        user_mail, password_mail, smtp_host_mail, smtp_port_mail = load_email_sender()
        subject = 'Recovery Password'
        #Send Mail
        build_and_send(email, user_mail, password_mail, smtp_host_mail, smtp_port_mail, subject, mail_body)
        return 'Sended mail', True
    except Exception as e:
        print(e)
        return 'User not exists', False

def build_user_pass(username, token):
    try:
        user = User.objects.get(username=username)
        email = user.email
        token = Token.objects.get(user=user)
        new_pass = generate(32)
        print('new_pass: ', new_pass)
        user.set_password(new_pass)
        user.save(force_update=True)
        #Load html template mail
        base_dir = Path(__file__).resolve().parent.parent
        mail_path = os.path.join(base_dir, 'template', 'mail', 'new-pass.html')
        print('mail_path: ', mail_path)
        txt_file = open(mail_path)
        mail_body = txt_file.read()
        #Replace template
        mail_body = mail_body.replace('#USERNAME', username)
        mail_body = mail_body.replace('#PASSWORD', new_pass)        
        #Load email data web_shopping
        user_mail, password_mail, smtp_host_mail, smtp_port_mail = load_email_sender()
        subject = 'Update Password'
        #Send Mail
        build_and_send(email, user_mail, password_mail, smtp_host_mail, smtp_port_mail, subject, mail_body)
        return 'Sended mail', True
    except Exception as e:
        print(e)
        return 'User not exists', False            
